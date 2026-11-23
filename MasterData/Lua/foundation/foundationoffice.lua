FoundationOffice = {};

local this = {
    gameObject = nil,
    transform = nil,
    container = nil,
    camera = nil,
    buildingTF = nil,
    characterTF = nil,
    roomId = "103",
    video = nil,
    reward = nil,
};

FoundationOffice.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.Office);
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.camera = this.transform:Find("Camera/Main Camera"):GetComponent("Camera");
    this.buildingTF = this.transform:Find("Container/Building");
    this.characterTF = this.transform:Find("Container/Character");
    this.video = this.transform:Find("Video"):GetComponent("UIVideoPlayer");
end

FoundationOffice.Show = function(isGoto)
    FoundationMgr.SetCamera(this.camera);
    this.transform.localPosition = Vector3.zero;
    this.gameObject:SetActive(true);
    FoundationBuildingMgr.Init(this.roomId, this.container, this.buildingTF, this.camera);
    FoundationCharacterMgr.Init(this.roomId, this.camera, this.characterTF);
    FoundationBuildingMgr.SetBuildings();
    FoundationBuildingMgr.SetBuildingsInfo();
    FoundationCharacterMgr.CheckFriendlys();
    if (not isGoto) then
        LuaMgr.ShowLuaPanel(UIName.OfficeViewModel);
    end
    
    this.SetDefaultCharacterList()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    LuaMgr.AddTimer(TimerConst.FundationPlayVoice, this.CharacterIdelPlayVoiceTimer, 1, -1, false)

    LuaMgr.AddUpdate(this.OnUpdate);
    LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
    LuaMgr.AddUIEventListener(UIEventConst.FoundationVendingBuy, this.OnVendingBuy);
    LuaMgr.AddUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);
    LuaMgr.AddTimer(TimerConst.FoundationOfficeVideoDelay, this.PlayVideo, 1, 1, false);
end

FoundationOffice.Hide = function()
    this.gameObject:SetActive(false);
end

FoundationOffice.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.RemoveTimer(TimerConst.FoundationOfficeVideoDelay);
    FoundationCharacterMgr.Clear();
    FoundationBuildingMgr.Clear();
    LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
    LuaMgr.RemoveUIEventListener(UIEventConst.FoundationVendingBuy, this.OnVendingBuy);
    LuaMgr.RemoveUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);
    LuaMgr.RemoveTimer(TimerConst.FundationPlayVoice)
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
    this.video:Stop();
end

FoundationOffice.Destroy = function()
    this.gameObject = nil;
    this.transform = nil;
    this.container = nil;
    this.camera = nil;
end

FoundationOffice.GetThis = function()
    return this;
end


this.PlayVideo = function()
    local pv = ConfigMgr.Config.constants.FoundationOfficePV;
    if (IsNullOrEmpty(pv)) then return end
    
    this.video:SetVolume(0);
    this.video:Load(pv);
end


this.OnHeroChoice = function(args)
    local interactionId = args[0];
    FoundationBuildingMgr.SetCharacters(interactionId);
    this.OnChooseNewCharacter()
end


this.OnVendingBuy = function(args)
    local building = FoundationBuildingMgr.GetBuildingByType(4);
    if (building ~= nil) then
        local type = args[0];
        this.reward = args[1];
        if (building.effect ~= nil) then
            building.effect:Play({type = type, callback = this.OnShowReward});
        else
            this.OnShowReward();
        end
        LuaMgr.HidePanel(UIName.FoundationVendingMachineViewModel);
    end
end


this.OnShowReward = function()
    if (this.reward ~= nil) then
        LuaMgr.ShowItemRewared(this.reward);
        this.reward = nil;
    end
end


this.OnGuideClickFoundation = function(args)
    if (args.Length > 0) then
        this.ClickBuilding(args[0]);
    end
end


this.OnUpdate = function()
    FoundationBuildingMgr.Update();
    FoundationCharacterMgr.CheckCharacters();
    FoundationCharacterMgr.CheckFlyTexts();
    this.CheckClick();
end


this.ClickBuilding = function(obj)
    local building = FoundationBuildingMgr.GetBuildingById(obj.name);
    if (building ~= nil) then
        FoundationMgr.ClickSound();
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuideClick, obj);
        FoundationBuildingMgr.ClickBuilding(building, this.camera);
        return true;
    end
    return false;
end


this.CheckClick = function()
    if (RaycastTool.GetMouseButtonUp(0)) then
        if (FoundationMgr.IsEnterRoom()) then return end
        if (LuaMgr.OutOfScreen()) then return end
        if (FoundationSceneMgr.IsMove()) then return end
        if (not LuaMgr.HasNormalStack(UIName.OfficeViewModel)) then return end
        if (RaycastTool.IsPointerOverGameObject() and not LuaMgr.IsGuide()) then return end
        
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "Character");
        if (obj ~= nil) then
            local character = FoundationCharacterMgr.GetCharacter(obj.name);
            if (character ~= nil and character.buildingId == "surprise" and character.ai.isClick) then
                PlayerFoundationMgr.GetEggsRewards(character.data);
                return;
            end
        end
        obj = FoundationSceneMgr.Click(this.camera, 100, "SceneDynamic");
        if (obj ~= nil) then
            if (this.ClickBuilding(obj)) then
                return;
            end
        end
        obj = RaycastTool.GetClickInfo(this.camera, 100, "Character");
        if (obj ~= nil) then
            local character = FoundationCharacterMgr.GetCharacter(obj.name);
            if (character ~= nil and character.buildingId ~= "surprise") then
                character:Click();
                this.lastPlayVoiceTime = LuaMgr.Timestamp()
                return;
            end
        end
        obj = RaycastTool.GetClickInfo(this.camera, 100, "Effect");
        if (obj ~= nil) then
            local animator = obj:GetComponent("ModelAnimator");
            if (animator ~= nil) then
                FoundationMgr.ClickSound();
                animator:Play();
            end
        end
        LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
    end
end


this.SetDefaultCharacterList = function()
    this.defaultCharacterIds = FoundationCharacterMgr.GetCharacterIds()
end

this.OnChooseNewCharacter = function()
    local newCharacters = FoundationCharacterMgr.GetCharacterIds()
    local deltaCharacters = {}
    if this.defaultCharacterIds == nil or #this.defaultCharacterIds == 0 then
        deltaCharacters = newCharacters
    else
        local tempOldCharacterIDDic = {}
        for i = 1, #this.defaultCharacterIds do
            local characterID = this.defaultCharacterIds[i]
            tempOldCharacterIDDic[characterID] = characterID
        end
        for j = 1, #newCharacters do
            local newCharacterID = newCharacters[j]
            if tempOldCharacterIDDic[newCharacterID] == nil then
                table.insert(deltaCharacters, newCharacterID)
            end
        end
    end
    this.SetDefaultCharacterList()
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Enter, deltaCharacters)
end

this.CharacterIdelPlayVoiceTimer = function()
    if this.lastPlayVoiceTime == nil then
        return
    end
    local curTime = LuaMgr.Timestamp()
    local intervalTime = ConfigMgr.Config.constants.CompanyVoiceTime or 5
    if curTime - this.lastPlayVoiceTime > intervalTime then
        this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
        this.lastPlayVoiceTime = curTime
    end
end




this.CharacterPlayVoice = function(type, characterIDs)
    if characterIDs == nil then
        characterIDs = FoundationCharacterMgr.GetCharacterIds()
    end
    if #characterIDs == 0 then
        return
    end
    local randomIndex = math.random(1, #characterIDs)
    local characterID = characterIDs[randomIndex]
    local character = FoundationCharacterMgr.GetCharacterByCid(characterID)
    if character == nil then
        return
    end
    character:PlayVoiceByType(type)
end

