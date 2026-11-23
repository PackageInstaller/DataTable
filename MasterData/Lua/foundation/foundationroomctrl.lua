FoundationRoomCtrl = {}

local this = nil;
local aniState = "";
local isPlayAni = false;
local characterList = {};
local characterMap = {};
local camera = nil;
local uiContainer = nil;
local comfortTime = 0;
local flyTextList = {};

FoundationRoomCtrl.Init = function(_camera)
    this = FoundationRoom.GetThis();
    characterList = {};
    characterMap = {};
    flyTextList = {};
    camera = _camera;
end

FoundationRoomCtrl.Clear = function()
    this = nil;
    aniState = "";
    isPlayAni = false;
    FoundationRoomCtrl.RemoveFlyTexts();
    FoundationRoomCtrl.RemoveCharacters();
    camera = nil;
end


FoundationRoomCtrl.IsInRoom = function()
    return this ~= nil;
end


FoundationRoomCtrl.EnterEdit = function()
    if (FoundationMgr.IsActivityRoom()) then
        isPlayAni = true;
        this.activityAnimator:Play("ani_FoundationRoom_ActivityEdit", false, FoundationRoomCtrl.OnEnterEdit);
    else
        aniState = "normal";
        isPlayAni = true;
        this.animator:Play("enter_"..aniState, "ani_FoundationRoom_Normal", FoundationRoomCtrl.OnEnterEdit);
    end
    this.StopVideos();
end


FoundationRoomCtrl.OnEnterEdit = function()
    this.isEdit = true;
    isPlayAni = false;
end


FoundationRoomCtrl.ExitEdit = function()
    if (FoundationMgr.IsActivityRoom()) then
        isPlayAni = true;
        this.activityAnimator:Play("ani_FoundationRoom_ActivityEdit2", false, FoundationRoomCtrl.OnExitEdit);
    else
        isPlayAni = true;
        this.animator:Play(aniState.."_enter", "ani_FoundationRoom_Enter", FoundationRoomCtrl.OnExitEdit);
        aniState = "";
        this.grids:Hide();
    end
    this.isEdit = false;
    this.SetBuildViewPos(10000, 0);
end


FoundationRoomCtrl.OnExitEdit = function()
    this.grids:Hide();
    isPlayAni = false;
    this.PlayVideos();
end


FoundationRoomCtrl.OnPlayFinished = function()
    isPlayAni = false;
    if (this.building ~= nil) then
        this.grids:Show();
        this.CalcBuildViewPos(this.building);
    end
end


FoundationRoomCtrl.IsPlayAni = function()
    return isPlayAni;
end


FoundationRoomCtrl.CheckAniState = function(furnitureType)
    if (aniState == "") then return end
    
    local state;
    local aniName;
    if (furnitureType == 1 or furnitureType == 2) then
        state = "ground";
        aniName = "ani_FoundationRoom_Ground";
    elseif (furnitureType == 3) then
        state = "wall";
        aniName = "ani_FoundationRoom_Wall";
    else
        state = "normal";
        aniName = "ani_FoundationRoom_Normal";
    end
    if (state ~= aniState) then
        isPlayAni = true;
        this.animator:Play(aniState.."_"..state, aniName, FoundationRoomCtrl.OnPlayFinished);
        aniState = state;
        return true;
    end
    return false;
end


FoundationRoomCtrl.AddCharacter = function(characterId, skinId)
    local grid = FoundationRoomCtrl.GetCharacterGrid();
    if (grid ~= nil) then
        local character = FoundationCharacter.New(this.characterTF);
        local cid = FoundationMgr.GetCharacterId();
        character:SetData(tostring(cid), characterId, skinId, nil, nil, true);
        local roomId = FoundationMgr.GetRoomId();
        character:RoomRotation(roomId);
        local data = {
            isTrigger = FoundationRoomSeat.IsTrigger,
            sitEnd = FoundationRoomSeat.SitEnd
        };
        local ai;
        if (FoundationMgr.IsActivityRoom()) then
            ai = FoundationActivityCharacterAI.New();
            data.isInteract = this.IsBuildingInteract;
            data.interactTime = 0;
            character.character:SetRotation(0, -130, 0);
        else
            ai = FoundationCharacterAI.New();
        end
        character:SetAI(ai, grid, this.groundOccupy.moveGrids, data);
        table.insert(characterList, character);
        characterMap[characterId] = character;
    end
end


FoundationRoomCtrl.GetAddCharacters = function(characters)
    local result = {};
    if (IsNull(characters)) then
        FoundationRoomCtrl.RemoveCharacters();
        return result;
    end
    local originMap = {};
    for k, _ in pairs(characterMap) do
        originMap[k] = true;
    end
    local characterId;
    local len = #characters;
    for i = 1, len do
        characterId = characters[i];
        if (characterMap[characterId] ~= nil) then
            originMap[characterId] = nil;
        else
            table.insert(result, characterId);
        end
    end
    for k, _ in pairs(originMap) do
        FoundationRoomCtrl.RemoveCharacter(k);
    end
    return result;
end


FoundationRoomCtrl.GetCharacterGrid = function()
    if this==nil then return nil end ;
    local grid;
    local areaX = this.groundConfig.Area[2];
    local areaY = this.groundConfig.Area[1];
    local gridList = {};
    for i = 1, areaY do
        for j = 1, areaX do
            grid = this.groundOccupy.moveGrids[i][j];
            if (grid.type == 0) then
                table.insert(gridList, grid);
            end
        end
    end
    local len = #gridList;
    if (len > 0) then
        local index = math.random(1, len);
        return gridList[index];
    end
    return nil;
end


FoundationRoomCtrl.GetCharacter = function(id)
    local len = #characterList;
    if (len > 0) then
        local character;
        for i = 1, len do
            character = characterList[i];
            if (character.id == id) then
                return character;
            end
        end
    end
    return nil;
end

FoundationRoomCtrl.GetAllCharacter = function()
    local list = {};
    local len = #characterList;
    if (len > 0) then
        for i = 1, len do
            table.insert(list, characterList[i].characterId);
        end
    end
    return list;
end


FoundationRoomCtrl.GetCharacterByCid = function(characterId)
    local len = #characterList;
    if (len > 0) then
        local character;
        for i = 1, len do
            character = characterList[i];
            if (character.characterId == characterId) then
                return character;
            end
        end
    end
    return nil;
end


FoundationRoomCtrl.RemoveCharacter = function(characterId)
    local len = #characterList;
    if (len > 0) then
        local character;
        for i = 1, len do
            character = characterList[i];
            if (character.characterId == characterId) then
                table.remove(characterList, i);
                characterMap[characterId] = nil;
                character:Clear();
                break;
            end
        end
    end
end


FoundationRoomCtrl.RemoveCharacters = function()
    local len = #characterList;
    if (len > 0) then
        for i = 1, len do
            characterList[i]:Clear();
        end
        characterList = {};
        characterMap = {};
    end
end


FoundationRoomCtrl.CheckCharacter = function()
    local len = #characterList;
    if (len > 0) then
        for i = 1, len do
            characterList[i]:Update();
        end
    end
end


FoundationRoomCtrl.SetUIContainer = function(container)
    uiContainer = container;
end


FoundationRoomCtrl.CheckComfort = function(need)
    if (FoundationMgr.IsActivityRoom()) then return end
    
    if (not need) then
        local time = os.time();
        if (comfortTime > time) then
            return;
        end
        comfortTime = time + 60;
    end
    local roomId = FoundationMgr.GetRoomId();
    local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
    local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
    if (buildingConfig == nil) then return end

    local buildingData = DataMgr.Player.interactions[buildingId];
    if (buildingData == nil) then return end
    if (IsNull(buildingData.Characters) or #buildingData.Characters <= 0) then return end

    local character;
    local characterId;
    local comfort;
    local isDraw = PlayerFoundationMgr.IsRoomDraw(buildingConfig, buildingData);
    local len = #buildingData.Characters;
    for i = 1, len do
        characterId = buildingData.Characters[i];
        character = characterMap[characterId];
        if (character ~= nil) then
            comfort = character.comfort;
            if (i == 1) then
                if (isDraw) then
                    if (comfort == nil) then
                        comfort = FoundationCharacterComfort.New(uiContainer, camera);
                    end
                    character:SetComfort(comfort);
                else
                    if (comfort ~= nil) then
                        character:HideComfort();
                    end
                end
            else
                if (comfort ~= nil) then
                    character:HideComfort();
                end
            end
        end
    end
end


FoundationRoomCtrl.CheckFriendlys = function()
    local len = #characterList;
    if (len > 0) then
        local character;
        local friendlyValue;
        for i = 1, len do
            character = characterList[i];
            friendlyValue = PlayerFoundationMgr.GetFriendlyValue(character.characterId);
            FoundationRoomCtrl.SetCharacterFriendly(character, friendlyValue);
        end
    end
end


FoundationRoomCtrl.SetCharacterFriendly = function(character, friendlyValue)
    if (friendlyValue == -1) then
        local friendFull = character.friendFull;
        if (friendFull == nil) then
            friendFull = FoundationCharacterFriendFull.New(uiContainer, camera);
        end
        character:SetFriendFull(friendFull);
    end
    local friendly = character.friendly;
    if (friendlyValue > 0) then
        if (friendly == nil) then
            friendly = FoundationCharacterFriendly.New(uiContainer, camera);
        end
        character:SetFriendly(friendly);
    else
        if (friendly ~= nil) then
            character:HideFriendly();
        end
    end
end


FoundationRoomCtrl.AddFlyText = function(characterId, content)
    local character = FoundationRoomCtrl.GetCharacterByCid(characterId);
    if (character ~= nil) then
        character:HideFriendly();
        character:Click();
        local flyText = FoundationCharacterFlyText.New(uiContainer, camera);
        flyText:SetData(character, content);
        table.insert(flyTextList, flyText);
    end
end


FoundationRoomCtrl.CheckFlyTexts = function()
    local len = #flyTextList;
    if (len > 0) then
        local flyText;
        local index = 1;
        while (index <= len) do
            flyText = flyTextList[index];
            if (flyText:Update()) then
                index = index + 1;
            else
                table.remove(flyTextList, index);
                len = len - 1;
                flyText:Clear();
                flyText = nil;
            end
        end
    end
end


FoundationRoomCtrl.RemoveFlyTexts = function()
    local len = #flyTextList;
    if (len > 0) then
        for i = 1, len do
            flyTextList[i]:Clear();
        end
        flyTextList = {};
    end
end


FoundationRoomCtrl.RandomInteract = function()
    local len = #characterList;
    if (len <= 0) then return end

    local interactCount = DataMgr.Player.ShareF.InteractCount;
    local roomDecorationRewardLimit = ConfigMgr.Config.constants.RoomDecorationRewardLimit;
    if (interactCount >= roomDecorationRewardLimit) then return end

    local roomDecorationRadomEvent = ConfigMgr.Config.constants.RoomDecorationRadomEvent;
    local eventIndex = math.random(1, #roomDecorationRadomEvent);
    local eventType = roomDecorationRadomEvent[eventIndex];
    if (eventType == 0) then return end

    local character;
    for i = 1, len do
        character = characterList[i];
        if (character.interact ~= nil and character.interact:IsShow()) then
            return;
        end
    end
    character = characterList[math.random(1, len)];
    local interact = character.interact;
    if (interact == nil) then
        interact = FoundationCharacterInteract.New(uiContainer, camera);
    end
    character:SetInteract(interact, eventType);
end


FoundationRoomCtrl.GetInteractMessage = function()
    local sum = 0;
    local fRoomTextMap = ConfigMgr.Config.FRoomTextMap;
    for _, v in pairs(fRoomTextMap) do
        sum = sum + v.Weight;
    end
    local g = 0;
    local f = math.random(1, sum);
    for _, v in pairs(fRoomTextMap) do
        g = g + v.Weight;
        if (g >= f) then
            return v;
        end
    end
    return nil;
end