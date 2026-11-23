FoundationWorking = {};

local this = {
    gameObject = nil,
    transform = nil,
    container = nil,
    camera = nil,
    buildingTF = nil,
    characterTF = nil,
    roomId = "102",
    bird = nil,
};

FoundationWorking.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.Working);
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.camera = this.transform:Find("Camera/Main Camera"):GetComponent("Camera");
    this.buildingTF = this.transform:Find("Container/Building");
    this.characterTF = this.transform:Find("Container/Character");
    this.bird = FoundationBirdAI.New(this.transform:Find("Animator/Bird").gameObject);
end

FoundationWorking.Show = function(isGoto)
    FoundationMgr.SetCamera(this.camera);
    this.transform.localPosition = Vector3.zero;
    this.gameObject:SetActive(true);
    FoundationBuildingMgr.Init(this.roomId, this.container, this.buildingTF, this.camera);
    FoundationCharacterMgr.Init(this.roomId, this.camera, this.characterTF);
    FoundationBuildingMgr.SetBuildings();
    FoundationBuildingMgr.SetBuildingsInfo();
    FoundationCharacterMgr.CheckFriendlys();
    if (not isGoto) then
        LuaMgr.ShowLuaPanel(UIName.WorkingViewModel);
    end
    
    this.SetDefaultCharacterList()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    LuaMgr.AddTimer(TimerConst.FundationPlayVoice, this.CharacterIdelPlayVoiceTimer, 1, -1, false)

    LuaMgr.AddUpdate(this.OnUpdate);
    LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
    LuaMgr.AddUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);

end

FoundationWorking.Hide = function()
    this.gameObject:SetActive(false);
end

FoundationWorking.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
    LuaMgr.RemoveUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);
    LuaMgr.RemoveTimer(TimerConst.FundationPlayVoice)
    FoundationCharacterMgr.Clear();
    FoundationBuildingMgr.Clear();
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
end

FoundationWorking.Destroy = function()
    this.RemoveBird();
    this.gameObject = nil;
    this.transform = nil;
    this.container = nil;
    this.camera = nil;
    
end

FoundationWorking.GetThis = function()
    return this;
end


this.CheckPackage = function()
    local package = FoundationBuildingMgr.GetBuildingByType(11);
    if (package ~= nil) then
        package.transform.localPosition = Vector3(1000, 0, 0);
        LuaMgr.AddTimer(0, function()
            FoundationCharacterMgr.AddUAVCharacter();
        end, 3, 1, false);
    end
end


this.OnHeroChoice = function(args)
    local interactionId = args[0];
    FoundationBuildingMgr.SetCharacters(interactionId);
    this.OnChooseNewCharacter()
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
    this.CheckBird();
end


this.CheckBird = function()
    if (this.bird ~= nil) then
        this.bird:Update();
    end
end


this.RemoveBird = function()
    if (this.bird ~= nil) then
        this.bird:Clear();
        this.bird = nil;
    end
end


this.ClickBuilding = function(obj)
    local building = FoundationBuildingMgr.GetBuildingById(obj.name);
    if (building ~= nil) then
        FoundationMgr.ClickSound();
        LuaMgr.InvokeUIEventListeners(UIEventConst.GuideClick, obj);
        if (building.config.Type == 11) then
            FoundationCharacterMgr.AddUAVCharacter();
        else
            if (PlayerFoundationMgr.IsStopWork(building.config.Id)) then
                FoundationBuildingMgr.ClickBuilding(building, this.camera);
            else
                if (PlayerFoundationMgr.IsDrawItemById(building.config.Id)) then
                    PlayerFoundationMgr.Draw(building.config.Id);
                else
                    FoundationBuildingMgr.ClickBuilding(building, this.camera);
                end
            end
        end
        return true;
    end
    return false;
end


this.CheckClick = function()
    if (RaycastTool.GetMouseButtonUp(0)) then
        if (FoundationMgr.IsEnterRoom()) then return end
        if (LuaMgr.OutOfScreen()) then return end
        if (FoundationSceneMgr.IsMove()) then return end
        if (not LuaMgr.HasNormalStack(UIName.WorkingViewModel)) then return end
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
            if (character ~= nil and character.buildingId ~= "surprise" and character.buildingId ~= "uav") then
                this.lastPlayVoiceTime = LuaMgr.Timestamp()
                character:Click();
                return;
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

