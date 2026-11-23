Rogue_ExploreItem2 = {};

Rogue_ExploreItem2.__index = Rogue_ExploreItem2;

local objs = {
    iconBtn = { path = "root/nor/icon", type = "Button" },
    norObj={ path = "root/nor", type = "GameObject" },
    norIconImg = { path = "root/nor/icon", type = "Image" },
    norTag={ path = "root/nor/tag", type = "Image" },
    norCanvasGroup={ path = "root/nor", type = "CanvasGroup" },
    norNameText={ path = "root/nor/nameBg/Text", type = "Text" },
    norNameObj={ path = "root/nor/nameBg", type = "GameObject" },
    norUIGray={ path = "root/nor", type = "UIGray" },
    bgUIGray={ path = "root/bg", type = "UIGray" },
    curFXObj={ path = "root/curFX", type = "GameObject" },
    lockFXObj={ path = "root/lockFX", type = "GameObject" },
    doneObj={ path = "root/done", type = "GameObject" },
    animator={ path = "", type = "Animator" },
    rootCanvasGroup={ path = "root", type = "CanvasGroup" },
    rootTF={ path = "root", type = "Transform" },
    lineListTF={ path = "root/lineList", type = "Transform" },
};

function Rogue_ExploreItem2.New()
    local self = {};
    setmetatable(self, Rogue_ExploreItem2);
    return self;
end

function Rogue_ExploreItem2:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isDone then
            return;
        end
        if not self.data.isUnlock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("Rogue_ExploreItem2_0"))
            return;
        end
        if (self.data.id~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.id)
        end
    end
    LuaMgr.AddClick(self.iconBtn, self.OnClickItem);
    self.grayRenderList={};
    self.highRenderList={}
    self.activeRenderList={};
end


function Rogue_ExploreItem2:SetData(data)
    self.data = data.data;
    self.transform.anchoredPosition=self.data.pos;
    self:SetBuildingState(self.data.isAnima);
    if not self.data.isAnima then
        self.rootCanvasGroup.alpha=1.0;
        self.rootTF.localScale=Vector3.one;
    else

        self.animator:Play("ani_RogueExplorePanel_exploreItem",0,0)
    end
end


function Rogue_ExploreItem2:SetBuildingState(isAnimaRender)
    if self.data.isDone then
        SetActive(self.doneObj,true);
        SetActive(self.curFXObj,false);
        SetActive(self.lockFXObj,false);
        SetActive(self.norObj,false);
        self.bgUIGray.IsGray=false;
    else
        SetActive(self.doneObj,false);
        SetActive(self.norObj,true);
        SetActive(self.norJQObj,self.data.isJQ);
        SetActive(self.norZDObj,self.data.isZD);
        SetActive(self.norNameObj,not IsNullOrEmpty(self.data.name))
        self.norNameText.text=self.data.name;
        self.norIconImg.sprite=LuaMgr.GetSprite("Rogue",self.data.bigIcon);
        if self.norIconImg.sprite==nil then
            self.norIconImg.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_gq_ggd_xz01");
        end
        if IsNullOrEmpty(self.data.smallIcon) then
            SetActive(self.norTag.gameObject,false)
        else
            SetActive(self.norTag.gameObject,true)
            self.norTag.sprite=LuaMgr.GetSprite("Rogue",self.data.smallIcon)
        end
        self:SetUnLock(self.data.isUnlock,self.data.isUnlockAnima);
    end
    self:ClearLineRenderer();
    self:SetRenderPoints(isAnimaRender);
end


function Rogue_ExploreItem2:SetRenderPoints(isAnima)
    if self.data.points==nil or #self.data.points==0 then return end;

    for i,v in ipairs(self.data.points) do
        local isGray=v.lock;
        if v.lock and v.isActive and self.data.isUnlock then
            isGray=false;
        end
        local render=self:GetLineRenderer(isGray);
        SetActive(render.gameObject,true);
        local renderAnimator=render.gameObject:GetComponent("Animator")
        if isAnima then
            local name=v.lock and "ui_RogueExplorePanel_renderItemGray" or "ui_RogueExplorePanel_renderItemHigh"
            renderAnimator:Play(name,0,0)
        end
        render.positionCount=2;
        local vector=v.endPoint-v.startPoint;
        local activeOff,otherOff=68,44;
        local beginPos=self.data.isUnlock and not self.data.isDone and Vector3.zero+vector.normalized*activeOff or Vector3.zero+vector.normalized*otherOff;
        local endPos=(v.lock and v.isActive) and vector-vector.normalized*activeOff or vector-vector.normalized*otherOff;
        render:SetPositions({beginPos,endPos});
        if not isGray then
            render.startColor=self.data.isDone and UnityEngine.Color(31/255,96/255,147/255) or  UnityEngine.Color(140/255,255/255,255/255);
            render.endColor=(v.lock and v.isActive) and UnityEngine.Color(140/255,255/255,255/255) or UnityEngine.Color(31/255,96/255,147/255);
        end
        render:SetWidth(0.06,0.06);
        table.insert(self.activeRenderList,{lock=isGray,render=render});
    end
end

function Rogue_ExploreItem2:ClearLineRenderer()
    for i,v in ipairs(self.activeRenderList) do
        SetActive(v.render.gameObject,false);
        if v.lock then
            table.insert(self.grayRenderList,v.render);
        else
            table.insert(self.highRenderList,v.render);
        end
    end
    self.activeRenderList={};
end

function Rogue_ExploreItem2:GetLineRenderer(lock)
    local render=nil;
    if lock then
        if #self.grayRenderList==0 then
            render=self:CreateRenderItem(true);
        else
            render=self.grayRenderList[1];
            table.remove(self.grayRenderList,1);
        end
    else
        if #self.highRenderList==0 then
            render=self:CreateRenderItem(false);
        else
            render=self.highRenderList[1];
            table.remove(self.highRenderList,1);
        end
    end
    return render;
end

function Rogue_ExploreItem2:CreateRenderItem(lock)
    local obj=lock and self.data.grayObj or self.data.highObj;
    local gameObject = LuaMgr.InstantiateGO(obj, self.lineListTF, false)
    gameObject.transform.anchoredPosition = Vector2.zero
    gameObject.transform.localScale=Vector3.one;
    return gameObject:GetComponent("LineRenderer");
end

function Rogue_ExploreItem2:SetUnLock(isOn,isUnlockAnima)
    self.norUIGray.IsGray=not isOn;
    self.bgUIGray.IsGray=not isOn;
    self.norCanvasGroup.alpha=not isOn and 0.5 or 1.0
    SetActive(self.curFXObj, isOn);
    if not isOn then
        SetActive(self.lockFXObj,self.data.isFog);
    else
        if isUnlockAnima and self.data.isFog then
            SetActive(self.lockFXObj,true);
            self.animator:Play("ani_RogueExplorePanel_exploreItem_lockFX",0,0)
            coroutine_runner.start(function()
                coroutine_runner.wait(1.2)
                if self.lockFXObj~=nil then
                    SetActive(self.lockFXObj,false);
                end
            end)
        else
            SetActive(self.lockFXObj,false);
        end
    end
end

function Rogue_ExploreItem2:UpdateData(unlockInfo)
    if not unlockInfo.isUnlock then return end;

    self.data.isDone=unlockInfo.isDone;
    self.data.isUnlock=unlockInfo.isUnlock;
    self.data.points=unlockInfo.points;
    self.data.isUnlockAnima=unlockInfo.isUnlockAnima;
    self:SetBuildingState(false)
end

function Rogue_ExploreItem2:Clear()
    self:ClearLineRenderer();
    self.data = nil;
end

function Rogue_ExploreItem2:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end