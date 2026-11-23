GuoBaoCharacterMgr = {};

local this = {
    camera = nil,
    characterTF = nil,
    characterList = {},
    characterId = 0,
};


GuoBaoCharacterMgr.Init = function(camera, characterTF)
    this.camera = camera;
    this.characterTF = characterTF;
end


GuoBaoCharacterMgr.Clear = function()
    this.RemoveCharacters();
    this.camera = nil;
    this.characterTF = nil;
    this.characterId = 0;
end


GuoBaoCharacterMgr.AddCharacter = function(data)
    local lineData = GuoBaoSceneLineMgr.FindLine();
    if (lineData == nil) then return end
    
    local character = GuoBaoCharacter.New(this.characterTF);
    this.characterId = this.characterId + 1;
    character:SetData(tostring(this.characterId), data.characterId, data.skinId, data.data, true);
    character:SetAI(GuoBaoCharacterAI.New(), lineData);
    character:RoomRotation();
    table.insert(this.characterList, character);
    return character;
end


GuoBaoCharacterMgr.AddNpc = function(id, skin, data, pos)
    local character = GuoBaoCharacter.New(this.characterTF);
    this.characterId = this.characterId + 1;
    character:SetData(tostring(this.characterId), id, skin, data, true);
    character:SetAI(GuoBaoCharacterAI.New(), {points={pos}});
    character:RoomRotation();
    table.insert(this.characterList, character);
end


GuoBaoCharacterMgr.GetCharacterList = function()
    return this.characterList;
end


GuoBaoCharacterMgr.GetCharacter = function(id)
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


GuoBaoCharacterMgr.GetCharacterByCid = function(characterId)
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


this.RemoveCharacters = function()
    local len = #this.characterList;
    if (len > 0) then
        for i = 1, len do
            this.characterList[i]:Clear();
        end
        this.characterList = {};
    end
end


GuoBaoCharacterMgr.CheckCharacters = function()
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


GuoBaoCharacterMgr.CalcAnimationDirection = function(x, z)
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