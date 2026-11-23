FoundationCharacterTalk = {};

FoundationCharacterTalk.__index = FoundationCharacterTalk;

local objs = {
    talkBtn = { path = "StartTalks", type = "Button" },
    friendlyLevelText = { path = "arrow/Text", type = "Text" },
};

FoundationCharacterTalk.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterTalk);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterTalk.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.character = nil;
    self.OnClickTalk = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationTeaRoomCharacterClick, self.character.data);
    end
    LuaMgr.AddClick(self.talkBtn, self.OnClickTalk);
    return self;
end

function FoundationCharacterTalk:SetData(character)
    self.character = character;
    local charactersData = DataMgr.Player.characters[character.characterId]
    self.friendlyLevelText.text = charactersData == nil and "1" or tostring(charactersData.prestigeLevel)
    self:SetPosition(character);
end

function FoundationCharacterTalk:Update(character)
    if (character.ai ~= nil) then
        if (character.ai.aiState == FoundationAIState.Move) then
            self:SetPosition(character);
        end
    end
end

function FoundationCharacterTalk:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    local z = character.transform.localPosition.z;
    self.pos.x = p.x;
    self.pos.y = p.y + 130 - 60 * (1 - z / 6);
    self.transform.localPosition = self.pos;
end

function FoundationCharacterTalk:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    self.character = nil;
    if (self.talkBtn ~= nil) then
        LuaMgr.RemoveClick(self.talkBtn, self.OnClickTalk);
        self.talkBtn = nil;
        self.OnClickTalk = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end