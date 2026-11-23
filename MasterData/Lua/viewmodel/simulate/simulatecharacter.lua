require("ViewModel/Simulate/Simulate_OtherBufferItem")
require("ViewModel/Simulate/Simulate_OtherMsgItem")
SimulateCharacter = {};

SimulateCharacter.__index = SimulateCharacter;

SimulateCharacter.New = function(container)
    local self = {};
    setmetatable(self, SimulateCharacter);
    self.gameObject =UnityEngine.GameObject("");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.character = nil;
    self.id = "";
    self.characterId = "";
    self.msgList = nil;
    self.lineText = "";
    self.characterConfig = nil;
    self.tweener=nil;
    self.lastPosX=nil;
    self.bufferVM=nil;
    self.isPlayAnimation=false;
    self.msgTF=nil;
    self.tableIndex=nil;
    return self;
end


function SimulateCharacter:SetData(id, characterId, skinId,pos,msg)
    self.id = id;
    self.characterId = characterId;
    self.gameObject.name = id;
    self.msgList={};
    if msg~=nil then
        self.msgList=NumTool.split(msg,"_");
    end
    self.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, skinId, self.transform);
    if (self.character ~= nil) then

        self.character:SetShadow(true);
        self.character:SetDistortZIntensity(true);
        self.characterConfig = ConfigMgr.Config.FoundationCharacterMap[characterId];
        self.character:SetRotation(45, 45, 0);
        self.character:Play(self.characterConfig.Idle, 1, true, nil);
        self.transform.localScale=Vector3(1,1,1);
        if pos~=nil then
            self.transform.localPosition=pos;
        end
    else

    end
end

function SimulateCharacter:SetBuffer(tf,type,callBack)
    self.bufferVM=Simulate_OtherBufferItem.New(tf);
    local pos=RectTransformTool.ToContainer(self.transform, tf)
    self.bufferVM:SetData(type,pos,callBack)
end

function SimulateCharacter:SetMsgBuffer()
    self.isCallbackFirst=nil;
    if self.msgVM==nil then
        self.msgVM=Simulate_OtherMsgItem.New(self.msgTF);
    end
    if #self.msgList>0 then
        local randomIndex=RandomNum(1,#self.msgList)
        local curMsg=self.msgList[randomIndex];
        local pos=RectTransformTool.ToContainer(self.transform, self.msgTF)
        self.msgVM:SetMsg(curMsg,pos,function()
            if self.isCallbackFirst==nil then
                self.isCallbackFirst=true;
                self:DelaySetMsgBuffer(10,20,true);
            end
        end)
    end
end

function SimulateCharacter:UpdateMsgBufferPosition()
    if self.msgVM~=nil and self.transform~=nil and self.msgTF~=nil and self.msgVM.gameObject.activeSelf then
        local pos=RectTransformTool.ToContainer(self.transform, self.msgTF)
        self.msgVM:SetPosition(pos)
    end
end

function SimulateCharacter:SetPath(index,lines,time,loop,tf)
    if (self.character == nil) then
        return
    end
    self.tableIndex=index
    self.character:Play(self.characterConfig.Move, 1, true, nil);
    self.tweener=self.transform:DOPath(lines,time,PathType.CatmullRom);
    self.tweener:SetEase(Ease.Linear)
    self.tweener:SetLoops(loop and -1 or 1)
    self.msgTF=tf;
    self.tweener.onComplete=function()
        SimulateSceneMgr.RemoveWalkNPC(self.tableIndex);
        self:Clear();
    end
    self:DelaySetMsgBuffer(2,10);
end

function SimulateCharacter:DelaySetMsgBuffer(startNum,endNum,isSecond)
    local delayTime=math.random(startNum,endNum)
    if isSecond and delayTime%2==0then
       return 
    end
    NumTool.DelayHandler(function()
        if self~=nil and self.gameObject~=nil then
            self:SetMsgBuffer();
        end
    end,delayTime)
end


function SimulateCharacter:DoIdle(callBack)
    if self.tweener~=nil then
        self.tweener:Pause();
        self.character:Play(self.characterConfig.Idle, 1, true, function()
            self.character:Play(self.characterConfig.Move, 1, true, nil);
            self.tweener:Play();
            if callBack~=nil then
                callBack();
            end
        end);
       
    end
end

function SimulateCharacter:DoShow(callBack)
    if self.tweener~=nil then
        self.tweener:Pause();
        self.character:Play(self.characterConfig.Action, 1, true, function()
            self.character:Play(self.characterConfig.Move, 1, true, nil);
            self.tweener:Play();
            if callBack~=nil then
                callBack();
            end
        end);
    end
end

function SimulateCharacter:OnPause()
    if self.tweener~=nil then
        self.tweener:Pause();
    end
end

function SimulateCharacter:OnPlay()
    if self.tweener~=nil then
        self.tweener:Play();
    end
end


function SimulateCharacter:Update()
    if (self.gameObject == nil or LuaMgr.IsObjectNull(self.gameObject)) then return end;
    if (self.character == nil or LuaMgr.IsObjectNull(self.character)) then return end;
    if self.lastPosX~=nil and self.lastPosZ~=nil  then
        local dirX=self.transform.localPosition.x-self.lastPosX;
        local dirZ=self.transform.localPosition.z-self.lastPosZ;







        self:CheckPlayRandomAnimation(dirX>0,dirZ>0);
    end
    self.lastPosX=self.transform.localPosition.x;
    self.lastPosZ=self.transform.localPosition.z;
    self:UpdateMsgBufferPosition();
end

function SimulateCharacter:CheckPlayRandomAnimation(dirX,dirZ)
    if self.isPlayAnimation then return end;
    if self.lastDirX~=nil  then
        if self.lastDirX~=dirX then
            local index=RandomNum(1,2)
            self.isPlayAnimation=true;
            local callBack=function()

                    self.character:SetRotation(45, 45, 0);
                    self.character.transform.localScale=Vector3(dirX and 1 or -1,1,1);




                LuaMgr.NextFrame(function()
                    self.isPlayAnimation=false;
                end,10)
            end
            if index==1 then
                self:DoShow(callBack);
            else
                self:DoIdle(callBack);
            end
        end
    end
    self.lastDirX=dirX;
    self.lastDirZ=dirZ;
end

function SimulateCharacter:Clear()
    if (self.character ~= nil) then
        self.character:Clear();
        self.character = nil;
    end
    if self.bufferVM~=nil then
        self.bufferVM:Destroy();
    end
    if self.msgVM~=nil then
        self.msgVM:Destroy();
    end
    self.tweener=nil;
    self.lastPosX=nil;
    self.index=nil;
    self.characterConfig = nil;
    self.tableIndex=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.transform = nil;
    self.gameObject = nil;
end


