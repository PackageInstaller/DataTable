
Block_PlayerAI = {};

Block_PlayerAI.__index = Block_PlayerAI;

local objs = {
    tfSpine = { path = "root/spine", type = "Transform" },

};
function Block_PlayerAI.New(transform)
    local self = {};
    setmetatable(self, Block_PlayerAI);
    self.transform=transform;
    self.off=1;
    UITool.Parse(self.transform.gameObject, self, objs);
    return self;
end

function Block_PlayerAI:SetData(gridId,uiSpineCharacter,characterId)
    if self.transform==nil or LuaMgr.IsObjectNull(self.transform) then
        self.isClear=true;
        return;
    end
    self.gridIndex=tonumber(gridId);
    self.uiSpine=uiSpineCharacter
    self.characterId=characterId;
    self.nextTime=self:GetNextTime(false);
    self.isClear=false;
    self.randomAroundIndex=0;
    self.offVector=Vector2(0,0);
    self.curPosition=nil;
    self.transform.anchoredPosition=Vector2.zero;
    self.Update=function()
        if self.isClear or self.transform==nil or LuaMgr.IsObjectNull(self.transform) then
            LuaMgr.RemoveUpdate(self.Update)
            return;
        end
        if UnityEngine.Time.realtimeSinceStartup-self.nextTime>=0 then
            if self:CheckTrigger() then
                self:Start();
                self.nextTime=self:GetNextTime(true);
            elseif self:CheckTriggerShow() then
                self:PlayShow();
                self.nextTime=self:GetNextTime(false);
            else
                self.nextTime=self:GetNextTime(false);
            end
        end
    end
    LuaMgr.AddUpdate(self.Update)
end


function Block_PlayerAI:IsValid()
    return not self.isClear and self.transform~=nil and not LuaMgr.IsObjectNull(self.transform);
end

function Block_PlayerAI:GetNextTime(isTrigger)
    local index=nil;
    if isTrigger then
         index=RandomNum2(SeasonSLGMapMgr.Constants().SeasonalMoveRange[1]*2,SeasonSLGMapMgr.Constants().SeasonalMoveRange[2]*2)
    end
     index=RandomNum2(SeasonSLGMapMgr.Constants().SeasonalMoveRange[1],SeasonSLGMapMgr.Constants().SeasonalMoveRange[2])
    return UnityEngine.Time.realtimeSinceStartup+index;
end

function Block_PlayerAI:CheckTrigger()
    local index=RandomNum2(1,10000)
    return index<=SeasonSLGMapMgr.Constants().SeasonalMoveTrigger;
end

function Block_PlayerAI:CheckTriggerShow()
    local index=RandomNum2(1,2)
    return index<2;
end

function Block_PlayerAI:Start()
    if self.curPosition==nil then
        self.curPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.gridIndex)
    end
    local aroundList=SeasonSLGMapMgr.GetAroundBlockListByIndex(self.gridIndex,self.off)
    if #aroundList==0 then
        return;
    end

    local randomIndex=0;
    local tryCount=0;
    while tryCount<10 do
        randomIndex=RandomNum2(1,#aroundList)
        tryCount=tryCount+1;
        if self.randomAroundIndex~=randomIndex then
            break;
        end
    end
    self.randomAroundIndex=randomIndex;
    local tarIndex=aroundList[self.randomAroundIndex];
    self.tarPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(tarIndex);
    local moveToPosition=(self.tarPosition-self.curPosition)/SeasonSLGMapMgr.gridScale+self.offVector;
    self.curPosition=self.tarPosition;
    self.offVector=moveToPosition;
    self:PlayMove(moveToPosition);
end

function Block_PlayerAI:PlayMove(tarPosition)
    if not self:IsValid() or tarPosition==nil then
        return;
    end
    if Vector2.Distance(self.transform.anchoredPosition,tarPosition)<30 then
        return;
    end
    self:Stop()
    if tarPosition.x-self.transform.anchoredPosition.x>0 then
        self:RotateRight();
    else
        self:RotateLeft();
    end
    if string.match(self.characterId,"SCJ") then
        self.uiSpine:Play("walk", true, nil)
    else
        self.uiSpine:Play("house_move", true, nil)
    end
    local moveTime=SeasonSLGMapMgr.Constants().SeasonalMoveTime==SeasonSLGMapMgr.Constants().SeasonalMoveRange[1] and
            SeasonSLGMapMgr.Constants().SeasonalMoveRange[1]-0.5 or SeasonSLGMapMgr.Constants().SeasonalMoveTime;
    self.moveTween=DOTWeen.To(function() return self.transform.anchoredPosition  end,function(vector)
        self.transform.anchoredPosition=vector;
    end,tarPosition,moveTime):SetEase(Ease.Linear)
    self.moveTween.onComplete=function()
        self:PlayIdle();
    end
end

function Block_PlayerAI:RotateLeft()
    self.tfSpine.localScale=Vector3(1,1,1)
end

function Block_PlayerAI:Rotate()
    self.tfSpine.localScale=Vector3(-self.tfSpine.localScale.x,1,1)
end

function Block_PlayerAI:RotateRight()
    self.tfSpine.localScale=Vector3(-1,1,1)
end
function Block_PlayerAI:PlayIdle()
    self:Stop()
    self.uiSpine:Play("idle", true, nil)
end

function Block_PlayerAI:PlayShow()
    self:Stop()
    self.uiSpine:Play("house_show", false, function()
        self:PlayIdle()
    end)
end


function Block_PlayerAI:Stop()
    if self.moveTween~=nil then
        self.moveTween:Kill();
    end
end

function Block_PlayerAI:Clear()
    self.isClear=true;
    self.curPosition=nil;
    LuaMgr.RemoveUpdate(self.Update)
    self:Stop();
end

function Block_PlayerAI:Destroy()
    self.isClear=true;
    LuaMgr.RemoveUpdate(self.Update)
    self:Stop();
    self.transform=nil;
    self.tfSpine=nil;
    self.uiSpine=nil;
    self.moveTween=nil;
end