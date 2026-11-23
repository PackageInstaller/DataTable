FoundationCharacterMgr = {};

local this = {
    roomId = "",
    camera = nil,
    characterTF = nil,
    uiContainer = nil,
    characterList = {},
    moveGrids = {},
    flyTextList = {},

};


FoundationCharacterMgr.Init = function(roomId, camera, characterTF)
    this.roomId = roomId;
    this.camera = camera;
    this.characterTF = characterTF;
    local roomConfig = ConfigMgr.Config.roomMap[roomId];
    if (roomConfig ~= nil) then
        local styleConfig = ConfigMgr.Config.RoomStyleMap[roomConfig.RoomStyleId];
        if (styleConfig ~= nil) then
            local roomPosConfig = ConfigMgr.Config.roomPosMap[styleConfig.Ground];
            if (roomPosConfig ~= nil) then
                local areaX = roomPosConfig.Area[2];
                local areaY = roomPosConfig.Area[1];
                this.InitMoveGrids(areaX, areaY);


            end
        end
    end
end


FoundationCharacterMgr.Clear = function()
    this.RemoveCharacters();
    this.RemoveFlyTexts();
    this.camera = nil;
    this.characterTF = nil;
    this.moveGrids = {};
end


FoundationCharacterMgr.SetUIContainer = function(container)
    this.uiContainer = container;
end


FoundationCharacterMgr.SetCharacters = function(building, characters)
    local len = #characters;
    if (len > 0) then
        for i = 1, len do
            FoundationCharacterMgr.AddCharacter(building, characters[i]);
        end
    end
end


FoundationCharacterMgr.AddCharacter = function(building, data)
    local character = FoundationCharacter.New(this.characterTF);
    local cid = FoundationMgr.GetCharacterId();
    character:SetData(tostring(cid), data.characterId, data.skinId, building.id, data.data, true);
    character:RoomRotation(this.roomId);
    local current, moves = this.GetBuildingMoves(building.bid, building.x, building.y);
    character:SetAI(FoundationBuildingCharacterAI.New(), current, moves);
    table.insert(this.characterList, character);
    return character;
end


this.GetBuildingMoves = function(bid, x, y)
    local config = FoundationMgr.GetBuildingConfig(bid);
    if (config ~= nil) then
        local pos;
        local grid;
        local current;
        local list;
        local index;
        local gx, gy;
        local moves = {};
        local len = #config.moves;
        for i = 1, len do
            pos = config.moves[i];
            grid = {x = x + pos.x, y = y + pos.y};
            list = moves[grid.y];
            if (list == nil) then
                list = {};
                moves[grid.y] = list;
            end
            list[grid.x] = grid;
        end
        local count = 0
        while (current == nil) do
            index = math.random(1, len);
            pos = config.moves[index];
            gx = x + pos.x;
            gy = y + pos.y;
            if (FoundationCharacterMgr.IsMoveGrid(gx, gy)) then
                current = moves[gy][gx];
            end
            count = count + 1
            if count > 50 then
                break
            end
        end
        return current, moves;
    end
    return nil, nil;
end


FoundationCharacterMgr.AddSurpriseCharacter = function(roomId)
    FoundationCharacterMgr.RemoveBuildingCharacters("surprise");
    if (LuaMgr.IsGuide()) then return nil end
    
    local eggs = DataMgr.Player.surpriseEggs.Eggs;
    if (eggs == nil or #eggs <= 0) then return nil end

    local eggId = eggs[1];
    local surpriseEgg = ConfigMgr.Config.SurpriseEggsMap[eggId];
    if (surpriseEgg == nil or surpriseEgg.Room ~= roomId) then return nil end
    
    local screenRatio = UnityEngine.Screen.width / UnityEngine.Screen.height;
    if (screenRatio < ConfigMgr.Config.constants.FoundationScreenAdaptation) then
        local replaceSurpriseEgg = ConfigMgr.Config.SurpriseEggsMap[surpriseEgg.Replace];
        if (replaceSurpriseEgg ~= nil) then
            surpriseEgg = replaceSurpriseEgg;
        end
    end
    local character = FoundationCharacter.New(this.characterTF);
    local cid = FoundationMgr.GetCharacterId();
    local characterId = surpriseEgg.Modelid;
    local skinId = surpriseEgg.Modelid;
    local pos = Vector3(surpriseEgg.Start[1], surpriseEgg.Start[2], surpriseEgg.Start[3]);
    character:SetData(tostring(cid), characterId, skinId, "surprise", eggId, true);
    character:RoomRotation(roomId);
    character:SetAI(FoundationSurpriseCharacterAI.New(), pos, nil, surpriseEgg);
    table.insert(this.characterList, character);
    return character;
end


FoundationCharacterMgr.AddAllSurpriseCharacter = function(roomId)
    local surpriseEggsMap = ConfigMgr.Config.SurpriseEggsMap;
    for k, v in pairs(surpriseEggsMap) do
        if (v.Room == roomId) then
            local character = FoundationCharacter.New(this.characterTF);
            local characterId = v.Modelid;
            local skinId = v.Modelid;
            local pos = Vector3(v.Start[1], v.Start[2], v.Start[3]);
            character:SetData("surprise" .. k, characterId, skinId, "surprise", v, true);
            character:RoomRotation(roomId);
            character:SetAI(FoundationSurpriseCharacterAI.New(), pos, nil, v);
            table.insert(this.characterList, character);
        end
    end
end


FoundationCharacterMgr.AddUAVCharacter = function()
    local character = FoundationCharacter.New(this.characterTF);
    local cid = FoundationMgr.GetCharacterId();
    local characterId = "CA01001";
    local skinId = "CA01001";
    local package = FoundationBuildingMgr.GetBuildingByType(11);
    local moves = {{x=-16,y=0.9,z=2.6},{x=-10.8,y=0.9,z=2.6},{x=-10.8,y=0.9,z=3.6},{x=-10.8,y=0.1,z=3.6}};
    character:SetData(tostring(cid), characterId, skinId, "uav", nil, false);
    character:SetAI(FoundationUAVCharacterAI.New(), moves[1], moves, package);
    table.insert(this.characterList, character);
    return character;
end


FoundationCharacterMgr.GetCharacterList = function()
    return this.characterList;
end


FoundationCharacterMgr.GetCharacterIds = function()
    local list = {};
    local len = #this.characterList;
    if (len > 0) then
        for i = 1, len do
            table.insert(list, this.characterList[i].characterId);
        end
    end
    return list;
end


FoundationCharacterMgr.SetCharacterTalk = function(character)
    character:SetTalk(FoundationCharacterTalk.New(this.uiContainer, this.camera));
end


FoundationCharacterMgr.SetCharacterMsg = function(character, content, time)
    local msg = character.msg;
    if (msg == nil) then
        msg = FoundationCharacterMsg.New(this.uiContainer, this.camera);
    end
    character:SetMsg(msg, content, time);
end


FoundationCharacterMgr.GetCharacter = function(id)
    local len = #this.characterList;
    if (len > 0) then
        local character;
        for i = 1, len do
            character = this.characterList[i];
            if (character.id == id) then
                return character;
            end
        end
    end
    return nil;
end


FoundationCharacterMgr.GetCharacterByCid = function(characterId)
    local len = #this.characterList;
    if (len > 0) then
        local character;
        for i = 1, len do
            character = this.characterList[i];
            if (character.characterId == characterId) then
                return character;
            end
        end
    end
    return nil;
end


FoundationCharacterMgr.GetCharacterByInteractionid = function(interactionId)
    local interactions = DataMgr.Player.interactions
    if interactions == nil then
        return {}
    end
    local characterIDs = {}
    for k, v in pairs(interactions) do
        local interactionConfig = ConfigFoundationMgr.GetInteractionById(k)
        if interactionConfig ~= nil and interactionConfig.Room == this.roomId and not IsNull(v.Characters) then
            if interactionId == nil or interactionConfig.Id == interactionId then
                local len = #v.Characters
                for i = 1, len do
                    local characterId = v.Characters[i]
                    table.insert(characterIDs, characterId)
                end
            end
        end
    end
    return characterIDs
end


this.RemoveCharacters = function()
    local len = #this.characterList;
    if (len > 0) then
        for i = 1, len do
            this.characterList[i]:Clear();
        end
        this.characterList = {};
    end
end


FoundationCharacterMgr.RemoveBuildingCharacters = function(buildingId)
    local character;
    local index = 1;
    local len = #this.characterList;
    while (index <= len) do
        character = this.characterList[index];
        if (character.buildingId == buildingId) then
            table.remove(this.characterList, index);
            len = len - 1;
            character:Clear();
            character = nil;
        else
            index = index + 1;
        end
    end
end

FoundationCharacterMgr.CheckTwOrThTalk = function()
   local InterestedNum = 0
    if type(DataMgr.Player.hightea.AnswerRight) == "function" then
        return InterestedNum
    end
    for key, value in pairs(DataMgr.Player.hightea.AnswerRight) do
        if value then
            InterestedNum = InterestedNum + 1
        end
    end
    
    return InterestedNum
end




FoundationCharacterMgr.CreatQSpine = function(netdata)
    local characters = {}
    local len = #DataMgr.Player.hightea.Characters
    len = len > 5 and 5 or len
    for i = 1, len do
        local characterId = DataMgr.Player.hightea.Characters[i]
        local obj = {}
        obj.characterId = characterId
        obj.skinId = HeroManager.GetCharacterSkin(characterId);
        obj.weaponId = ""
        obj.job = ConfigMgr.Config.characterTable[characterId].job
        obj.data = i;
        table.insert(characters, obj)
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.AddTeaCharacter, characters, netdata);
end


FoundationCharacterMgr.MorningAndNight = function()
    local os_time = os.time
    local str = os.date("%Y-%m-%d", LuaMgr.Timestamp())
    local early_morning = { hour = 0, min = 0, sec = 0 }
    local midnight = { hour = 23, min = 59, sec = 59 }
    string.gsub(
            str,
            "(%d+)-(%d+)-(%d+)",
            function(year, month, day)
                midnight["year"] = year
                early_morning["year"] = year
                midnight["month"] = month
                early_morning["month"] = month
                midnight["day"] = day
                early_morning["day"] = day
            end
    )
    return os_time(early_morning), os_time(midnight)
end




FoundationCharacterMgr.SayingPlayVoice = function(isOn, characterId, linetype)
    if (isOn) then
        local skinID = CS.Laigu.ViewModel.Hero.HeroManager.GetCharacterSkin(characterId);;
        local cfgCharacterLines = ConfigMgr.Config.characterLines[skinID];
        if (cfgCharacterLines == nil) then
            skinID = characterId .. "001";
        end
        local audioPath = LuaMgr.GetCharacterLineTypeAudioPatn(characterId)
        local audioName = "character_" .. linetype .. "_" .. skinID;
        local path = Path.Character_PATH..characterId.."/"..audioPath.."/"..audioName..".mp3";
        local audioSource=AudioMgr.Singleton:PlayVoice(path)
        if audioSource==nil then
            skinID = characterId .. "001";
            audioName = "character_" .. linetype .. "_" .. skinID;
            path = Path.Character_PATH..characterId.."/"..audioPath.."/"..audioName..".mp3";
            AudioMgr.Singleton:PlayVoice(path)
        end
    else
        AudioMgr.Singleton:StopVoice();
    end
end


FoundationCharacterMgr.CheckHeroAllprestige = function(ID)
    local CharacterMessage = DataMgr.Player.characters[ID]
    local heroPrestige
    if CharacterMessage ~= nil then
        heroPrestige = CharacterMessage.prestige
    else
        heroPrestige = DataMgr.Player.prestigeStore[ID] ~= nil and DataMgr.Player.prestigeStore[ID] or 0
    end
    local friendshipLevelUp = ConfigMgr.Config.friendshipLevelUp
    local Totol = 0
    for key, value in pairs(friendshipLevelUp) do
        Totol = Totol + 1
    end
    local MaxPrestige = friendshipLevelUp[tostring(Totol)]
    local Strtag = LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[tostring(Totol)].descriptionLan)
    return tonumber(heroPrestige) >= tonumber(MaxPrestige), Strtag
end


FoundationCharacterMgr.RemoveBuildingCharacter = function(buildingId, characterId)
    local character;
    local len = #this.characterList;
    for i = 1, len do
        character = this.characterList[i];
        if (character.buildingId == buildingId and character.characterId == characterId) then
            table.remove(this.characterList, i);
            character:Clear();
            character = nil;
            break;
        end
    end
end


FoundationCharacterMgr.RemoveNotBuildingCharacter = function(buildingId, characterId)
    local character;
    local len = #this.characterList;
    for i = 1, len do
        character = this.characterList[i];
        if (character.buildingId ~= buildingId and character.characterId == characterId) then
            table.remove(this.characterList, i);
            character:Clear();
            character = nil;
            break;
        end
    end
end


FoundationCharacterMgr.UpdateBuildingCharacters = function(buildingId, newBuildingId)
    local character;
    local len = #this.characterList;
    for i = 1, len do
        character = this.characterList[i];
        if (character.buildingId == buildingId) then
            character.buildingId = newBuildingId;
        end
    end
end


FoundationCharacterMgr.CheckCharacters = function()
    local len = #this.characterList;
    if (len > 0) then
        local character;
        local index = 1;
        while (index <= len) do
            character = this.characterList[index];
            character:Update();
            if (character.live) then
                index = index + 1;
            else
                table.remove(this.characterList, index);
                len = len - 1;
                character:Clear();
                character = nil;
            end
        end
    end
end


FoundationCharacterMgr.CalcAnimationDirection = function(x, z)
    local isB = false;
    local scaleX = 1;
    if (x > 0 and z > 0) then
        scaleX = 1;

    elseif (x > 0 and z <= 0) then
        scaleX = 1;
    elseif (x < 0 and z > 0) then
        scaleX = -1;

    elseif (x < 0 and z <= 0) then
        scaleX = -1;
    end
    return isB, scaleX;
end


this.InitMoveGrids = function(areaX, areaY)
    local list;
    for i = 1, areaY do
        list = {};
        this.moveGrids[i] = list;
        for j = 1, areaX do
            list[j] = {x = j - 1, y = i - 1, type = 0};
        end
    end
end


FoundationCharacterMgr.SetMoveGrid = function(x, y, type)
    local list = this.moveGrids[y + 1];
    if (list ~= nil) then
        local obj = list[x + 1];
        if (obj ~= nil) then
            obj.type = type;


        end
    end
end


FoundationCharacterMgr.IsMoveGrid = function(x, y)
    local list = this.moveGrids[y + 1];
    if (list ~= nil) then
        local obj = list[x + 1];
        if (obj ~= nil) then
            return obj.type == 0;
        end
    end
    return false;
end


FoundationCharacterMgr.AddFlyText = function(characterId, content)
    local character = FoundationCharacterMgr.GetCharacterByCid(characterId);
    if (character ~= nil) then
        character:HideFriendly();
        character:Click();
        local flyText = FoundationCharacterFlyText.New(this.uiContainer, this.camera);
        flyText:SetData(character, content);
        table.insert(this.flyTextList, flyText);
    end
end


FoundationCharacterMgr.CheckFlyTexts = function()
    local len = #this.flyTextList;
    if (len > 0) then
        local flyText;
        local index = 1;
        while (index <= len) do
            flyText = this.flyTextList[index];
            if (flyText:Update()) then
                index = index + 1;
            else
                table.remove(this.flyTextList, index);
                len = len - 1;
                flyText:Clear();
                flyText = nil;
            end
        end
    end
end


this.RemoveFlyTexts = function()
    local len = #this.flyTextList;
    if (len > 0) then
        for i = 1, len do
            this.flyTextList[i]:Clear();
        end
        this.flyTextList = {};
    end
end


FoundationCharacterMgr.CheckFriendlys = function(interactionId)
    local interactions = DataMgr.Player.interactions;
    if (interactions == nil) then return end

    local interactionConfig;
    local len;
    local characterId;
    local friendlyValue;
    for k, v in pairs(interactions) do
        interactionConfig = ConfigFoundationMgr.GetInteractionById(k);
        if (interactionConfig ~= nil and interactionConfig.Room == this.roomId) then
            if (not IsNull(v.Characters)) then
                if (interactionId == nil or interactionConfig.Id == interactionId) then
                    len = #v.Characters;
                    for i = 1, len do
                        characterId = v.Characters[i];
                        friendlyValue = PlayerFoundationMgr.GetFriendlyValue(characterId);
                        this.SetCharacterFriendly(characterId, friendlyValue);
                    end
                end
            end
        end
    end
end


FoundationCharacterMgr.CheckCharacterRotation=function(characterId,skinId,animName)
    if ConfigMgr.Config.FoundationCharacterMap[characterId]==nil then
        return false;
    end
    local cfgFunCh=ConfigMgr.Config.FoundationCharacterMap[characterId];
    if IsNull(cfgFunCh.NoRotation) or #cfgFunCh.NoRotation==0 then
        return false
    end
    for i,v in ipairs(cfgFunCh.NoRotation) do
        if v[1]==skinId and v[2]==animName then
            return true;
        end
    end
    return false;
end


this.SetCharacterFriendly = function(characterId, friendlyValue)
    local character = FoundationCharacterMgr.GetCharacterByCid(characterId);
    if (character == nil) then return end

    if (friendlyValue == -1) then
        local friendFull = character.friendFull;
        if (friendFull == nil) then
            friendFull = FoundationCharacterFriendFull.New(this.uiContainer, this.camera);
        end
        character:SetFriendFull(friendFull);
    end
    local friendly = character.friendly;
    if (friendlyValue > 0) then
        if (friendly == nil) then
            friendly = FoundationCharacterFriendly.New(this.uiContainer, this.camera);
        end
        character:SetFriendly(friendly);
    else
        if (friendly ~= nil) then
            character:HideFriendly();
        end
    end
end