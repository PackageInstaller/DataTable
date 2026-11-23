CharacterHighSkin = {};

CharacterHighSkin.__index = CharacterHighSkin;
local objs = {
   
}

function CharacterHighSkin.New(transform)
    local self = {};
    setmetatable(self, CharacterHighSkin);
    self.transformRoot=transform;
    self.skinId=nil;
    self.characterId=nil;
    self.transform=nil;
    self.bubbleSpineDic={};
    self.fxObjDic={};
    return self;
end

function CharacterHighSkin:Init()







end

function CharacterHighSkin:SetData(characterId,skinId)
    if self.skinId==nil or self.skinId~=skinId then
        self:Clear();
        self.transform=self.transformRoot:Find(skinId);
        if self.transform==nil then
            LuaDebug.error("find skinId tranform is error")
            return;
        end
        self.uiSpineCharacterBG=self.transform:GetComponent("UISpineCharacter");
        self.uiSpineCharacterBody=self.transform:Find("Spine"):GetComponent("UISpineCharacter");
        if self.uiSpineCharacterBG~=nil then
            self.skeletonGraphicBG=self.uiSpineCharacterBG.transform:GetComponent("SkeletonGraphic");
        end
        if self.uiSpineCharacterBody~=nil then
            self.skeletonGraphicBody=self.uiSpineCharacterBody.transform:GetComponent("SkeletonGraphic");
        end
        self.bubbleTransform=self.transform:Find("bubble");
        self.skinConfig=ConfigMgr.Config.CharacterHighSkinMap[skinId];
    end
    self.characterId=characterId;
    self.skinId=skinId;
end

function CharacterHighSkin:PlayIdle()
    if self.skinConfig==nil then return end;
    if self.uiSpineCharacterBG~=nil and not IsNull(self.skinConfig.bg) and #self.skinConfig.bg>0 then
        self.uiSpineCharacterBG:PlayAnimation("idle",true,nil);
    end
    if self.uiSpineCharacterBody~=nil and not IsNull(self.skinConfig.poke) and #self.skinConfig.poke>0then
        self.uiSpineCharacterBody:PlayAnimation("idle",true,nil);
    end
end


function CharacterHighSkin:PlayAnimation(callBack)
    math.randomseed(LuaMgr.Timestamp());
    if self.skinConfig==nil then return end;
    if not IsNullOrEmpty(self.skinConfig.Sound) then
        local path=Path.audio_PATH.."Sound/"..self.skinConfig.Sound..".mp3"
        AudioMgr.Singleton:PlayUISFX(path)
    end
    if self.uiSpineCharacterBG~=nil and not IsNull(self.skinConfig.bg) and #self.skinConfig.bg>0 then
        if self.skeletonGraphicBG~=nil and self.skeletonGraphicBG.AnimationState~=nil  then

            self.skeletonGraphicBG.AnimationState:ClearTracks();
        end
        LuaMgr.NextFrame(function()
            self.uiSpineCharacterBG:PlayAnimation(self.skinConfig.bg[1],false,function()
                if self.uiSpineCharacterBG~=nil then
                    self.uiSpineCharacterBG:PlayAnimation("idle",true,nil);
                end
            end);
        end)



    end
    if self.uiSpineCharacterBody~=nil and not IsNull(self.skinConfig.poke) and #self.skinConfig.poke>0then
        if self.skeletonGraphicBody~=nil and self.skeletonGraphicBody.AnimationState~=nil then

            self.skeletonGraphicBody.AnimationState:ClearTracks();
        end
        LuaMgr.NextFrame(function()
            self.uiSpineCharacterBody:PlayAnimation(self.skinConfig.poke[1],false,function()
                if self.uiSpineCharacterBody~=nil then
                    self.uiSpineCharacterBody:PlayAnimation("idle",true,nil);
                    if callBack~=nil then
                        callBack();
                    end
                end
            end)
        end)






        if not IsNull(self.skinConfig.bubblespine) and #self.skinConfig.bubblespine>0 then
            local len=#self.skinConfig.bubblespine;
            local bubbleSpineIndex=math.random(1,len)
            self:PlayBubble(bubbleSpineIndex);
        else

            self:PlayFXSingle();
        end
    end
end


function CharacterHighSkin:PlayBubble(bubbleSpineIndex)
    local spineInfo=self.skinConfig.bubblespine[bubbleSpineIndex];
    if spineInfo==nil then return end;
    if self.bubbleSpineDic[spineInfo[1]]==nil then
        self:CreateBubbleSpine(spineInfo);
    end
    local bubbleSpine=self.bubbleSpineDic[spineInfo[1]];
    local bubbleAniIndex=nil;
    if not IsNull(self.skinConfig.bubbleani) and #self.skinConfig.bubbleani>=bubbleSpineIndex then

        local aniNameArray=self.skinConfig.bubbleani[bubbleSpineIndex];
        if #aniNameArray>0 then
            bubbleAniIndex=math.random(1,#aniNameArray)
            local aniName=aniNameArray[bubbleAniIndex];
            bubbleSpine:PlayAnimation(aniName,false,nil);
        end
    end
    self:PlayFXByBubbleSpine(bubbleSpineIndex,bubbleAniIndex)
end

function CharacterHighSkin:PlayFXByBubbleSpine(bubbleSpineIndex,bubbleAniIndex)
    if not IsNull(self.skinConfig.bubblespineplot) and #self.skinConfig.bubblespineplot>0  then
        if bubbleSpineIndex~=nil and bubbleSpineIndex<=#self.skinConfig.bubblespineplot then
            local fxArray=self.skinConfig.bubblespineplot[bubbleSpineIndex];
            local fxPath=nil;
            if bubbleAniIndex~=nil and bubbleAniIndex<=#fxArray then

                fxPath=fxArray[bubbleAniIndex];
            elseif #fxArray>0 then
                fxPath=fxArray[1];
            end
            if IsNullOrEmpty(fxPath) then return end;
            local fxPathList=NumTool.split(fxPath,"_")
            for i,v in ipairs(fxPathList) do
                if not IsNullOrEmpty(v) then
                    if  self.fxObjDic[v]==nil then
                        self:FindChildFXObj(v);
                    end
                    if self.fxObjDic[v]~=nil then
                        self.fxObjDic[v].active=true
                        SetActive(self.fxObjDic[v].obj,false)
                        SetActive(self.fxObjDic[v].obj,true)
                    end
                end
            end









        end
    end
end
function CharacterHighSkin:PlayFXSingle()
    if not IsNull(self.skinConfig.bubblespineplot) and #self.skinConfig.bubblespineplot>0  then
        local fxArray=self.skinConfig.bubblespineplot[1];
        local fxPlotIndex=math.random(1,#fxArray)
        local fxPath=fxArray[fxPlotIndex];
        if IsNullOrEmpty(fxPath) then return end;
        local fxPathList=NumTool.split(fxPath,"_")
        for i,v in ipairs(fxPathList) do
            if not IsNullOrEmpty(v) then
                if  self.fxObjDic[v]==nil then
                    self:FindChildFXObj(v);
                end
                if self.fxObjDic[v]~=nil then
                    self.fxObjDic[v].active=true
                    SetActive(self.fxObjDic[v].obj,false)
                    SetActive(self.fxObjDic[v].obj,true)
                end
            end
        end










    end
end

function CharacterHighSkin:CreateBubbleSpine(spineInfo)
    local bubbleName=spineInfo[1];
    if self.bubbleTransform==nil then
        LuaDebug.error("bubble root is nil")
        return;
    end
    local bubblePath=string.format("Assets/_BundleResources/Character/%s/DrawingSpine/%s.prefab",self.characterId,bubbleName);
    local bubbleObj = LuaMgr.GetPrefab(bubblePath);
    bubbleObj.transform:SetParent(self.bubbleTransform, false);
    bubbleObj.transform.anchoredPosition = Vector2(tonumber(spineInfo[2]),tonumber(spineInfo[3]));
    bubbleObj.transform.localEulerAngles = Vector3(0, 0,0);
    bubbleObj.transform.localScale=Vector3.one*tonumber(spineInfo[4]);
    local bubbleSpineCharacter=bubbleObj:AddComponent(typeof(CS.Laigu.ViewModel.Hero.UISpineCharacter))
    self.bubbleSpineDic[bubbleName]=bubbleSpineCharacter;
end
    

function CharacterHighSkin:FindChildFXObj(path)
    local fxTF=self.transform:Find(path);
    if fxTF==nil then return end;
    local fxObj=self.transform:Find(path).gameObject
    SetActive(fxObj,false);
    self.fxObjDic[path]={obj=fxObj,active=false};
end
    


function CharacterHighSkin:Clear()
    self.skinId = nil;
    self.bubbleSpineDic={};
    self.fxObjDic={};
    
end

function CharacterHighSkin:Destroy()
    self.bubbleSpineDic=nil;
    self.fxObjDic=nil;
end

    