FoundationTeaRoom = {};

local this = {
    gameObject = nil;
    transform = nil;
    container = nil;
    camera = nil;
    buildingTF = nil;
    characterTF = nil;
    roomId = "104";
    isShow = false,
    isTeaCharacter = false;
    isTeaMain = false;
};

FoundationTeaRoom.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.TeaRoom);
    this.transform = this.gameObject.transform;
    this.container = this.transform:Find("Container");
    this.camera = this.transform:Find("Camera/Main Camera"):GetComponent("Camera");
    this.buildingTF = this.transform:Find("Container/Building");
    this.characterTF = this.transform:Find("Container/Character");
end

FoundationTeaRoom.Show = function()
    FoundationMgr.SetCamera(this.camera);
    this.transform.localPosition = Vector3.zero;
    this.gameObject:SetActive(true);
    this.isShow = true;
    FoundationBuildingMgr.Init(this.roomId, this.container, this.buildingTF, this.camera);
    FoundationCharacterMgr.Init(this.roomId, this.camera, this.characterTF, nil);
    FoundationBuildingMgr.SetBuildings();
    FoundationBuildingMgr.SetBuildingsInfo();
    
    this.SetDefaultCharacterList()
    this.CharacterPlayVoice(FoundationCharacter.VoiceType.Idle)
    this.lastPlayVoiceTime = LuaMgr.Timestamp()
    LuaMgr.AddTimer(TimerConst.FundationPlayVoice, this.CharacterIdelPlayVoiceTimer, 1, -1, false)
    
    LuaMgr.AddUIEventListener(UIEventConst.AddTeaCharacter, this.SetTeaCharacters);
    LuaMgr.AddUIEventListener(UIEventConst.RemoveTeaCharacter, this.OnRemoveTeaCharacter);
    LuaMgr.AddUIEventListener(UIEventConst.FoundationTeaRoomTeaMain, this.OnTeaMain);
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationHideRoot);
    LuaMgr.ShowLuaPanel(UIName.TeaTastSipViewModel);
    LuaMgr.AddUpdate(this.OnUpdate);
end

FoundationTeaRoom.Hide = function()
    this.gameObject:SetActive(false);
end

FoundationTeaRoom.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.RemoveUIEventListener(UIEventConst.AddTeaCharacter, this.SetTeaCharacters);
    LuaMgr.RemoveUIEventListener(UIEventConst.RemoveTeaCharacter, this.OnRemoveTeaCharacter);
    LuaMgr.RemoveUIEventListener(UIEventConst.FoundationTeaRoomTeaMain, this.OnTeaMain);
    LuaMgr.RemoveTimer(TimerConst.FundationPlayVoice)
    this.RemoveTeaCharacters();
    FoundationCharacterMgr.Clear();
    FoundationBuildingMgr.Clear();
    this.isTeaMain = false;
end

FoundationTeaRoom.Destroy = function()
    this.gameObject = nil;
    this.transform = nil;
    this.container = nil;
    this.camera = nil;
end

FoundationTeaRoom.GetThis = function()
    return this;
end


this.OnRemoveTeaCharacter = function()
    this.isShow = true;
end


this.SetTeaCharacters = function(args)
    local characters = args[0];
    if (#characters > 0) then
        this.isTeaCharacter = args[1];
        local building = FoundationBuildingMgr.GetBuildingByType(3);
        if (building ~= nil) then
            local characterId;
            local len = #characters;
            local characterIds = FoundationCharacterMgr.GetCharacterIds();
            local clen = #characterIds;
            if (clen > 0) then
                for i = 1, len do
                    characterId = characters[i].characterId;
                    for j = 1, clen do
                        if (characterId == characterIds[j]) then
                            table.remove(characterIds, j);
                            clen = clen - 1;
                            break;
                        end
                    end
                end
                for i = 1, clen do
                    FoundationCharacterMgr.RemoveBuildingCharacter(building.id, characterIds[i]);
                end
            end
            local obj;
            local character;
            len = #characters;
            for i = 1, len do
                obj = characters[i];
                character = FoundationCharacterMgr.GetCharacterByCid(obj.characterId);
                if (character ~= nil) then
                    character.data = obj.data;
                else
                    character = FoundationCharacterMgr.AddCharacter(building, obj);
                end
                if (this.isTeaCharacter) then
                    FoundationCharacterMgr.SetCharacterTalk(character);
                else
                    character:RemoveTalk();
                end
            end
        end
    end
    this.OnChooseNewCharacter()
end


this.RemoveTeaCharacters = function()
    this.isTeaCharacter = false;
    local building = FoundationBuildingMgr.GetBuildingByType(3);
    if (building ~= nil and building.config ~= nil) then
        FoundationCharacterMgr.RemoveBuildingCharacters(building.id);
    end
end


this.OnTeaMain = function(args)
    this.isTeaMain = args[0];
    if args[1] ~= nil then
        this.isTeaCharacter = args[1]
    end
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
end


this.OnUpdate = function()
    FoundationBuildingMgr.Update();
    FoundationCharacterMgr.CheckCharacters();
    this.CheckClick();
end


this.CheckClick = function()
    if (RaycastTool.GetMouseButtonUp(0)) then
        if (this.isShow) then
            this.isShow = false;
            return;
        end
        if (LuaMgr.IsNovelRunning()) then return end
        if (this.isTeaMain) then return end
        local clickObject = RaycastTool.CurrentSelectedGameObject();
        if not IsObjectNull(clickObject) and clickObject.name == "MaksSureSelectHero" then
            return
        end

        if (RaycastTool.IsPointerOverGameObject() and not LuaMgr.IsGuide()) then return end


        if LuaMgr.IsPanelOpen(UIName.ConnectFourViewModel)
         or  LuaMgr.IsPanelOpen(UIName.TeaMainPanel) 
         or LuaMgr.IsPanelOpen(UIName.TeaBeforSelectPanel)
         or LuaMgr.IsPanelOpen(UIName.TurnTableMainPageViewModel)
         or LuaMgr.IsPanelOpen(UIName.TurnTableViewModel) 
         or LuaMgr.IsPanelOpen(UIName.MiniGame2048ViewModel) 
         or LuaMgr.IsPanelOpen(UIName.SawPuzzleSelectViewModel)
         or LuaMgr.IsPanelOpen(UIName.BalatroLaunchPanel)
         or LuaMgr.IsPanelOpen(UIName.BalatroMainViewModel) then
            return
        end  
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "Character");
        if (obj ~= nil) then
            local character = FoundationCharacterMgr.GetCharacter(obj.name);
            if (character ~= nil) then
                if (character.buildingId == "surprise") then
                    if (character.ai.isClick) then
                        PlayerFoundationMgr.GetEggsRewards(character.data);
                    end
                    return;
                end
                if (character.talk ~= nil) then
                    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomCharacterClick, character.data);
                else
                    character:Click();
                    this.lastPlayVoiceTime = LuaMgr.Timestamp()
                end
                return;
            end
        end
        if (this.isTeaCharacter) then return end
        obj = FoundationSceneMgr.Click(this.camera, 100, "SceneDynamic");
        if (obj ~= nil) then
            local building = FoundationBuildingMgr.GetBuildingById(obj.name);
            if (building ~= nil) then
                FoundationMgr.ClickSound();
                FoundationBuildingMgr.ClickBuilding(building, this.camera);
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
    if LuaMgr.IsPanelOpen(UIName.TeaTastTaskPanel) == false then
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

