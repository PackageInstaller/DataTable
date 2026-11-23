FoundationCharacterFriendly = {};

FoundationCharacterFriendly.__index = FoundationCharacterFriendly;

local objs = {
    friendlyBtn = { path = "Friendly", type = "Button" },
};

FoundationCharacterFriendly.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterFriendly);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterFriendly.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.character = nil;
    self.OnClickFriendly = function()
        PlayerFoundationMgr.GetPrestige(self.character.characterId);
    end
    LuaMgr.AddClick(self.friendlyBtn, self.OnClickFriendly);
    return self;
end

function FoundationCharacterFriendly:SetData(character)
    self.character = character;
    self:SetPosition(character);
    self.gameObject:SetActive(true);
end

function FoundationCharacterFriendly:Hide()
    if (self.gameObject.activeSelf) then
        self.gameObject:SetActive(false);
    end
end

function FoundationCharacterFriendly:Update(character)
    self:SetPosition(character);
end

function FoundationCharacterFriendly:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    local z = character.transform.localPosition.z;
    self.pos.x = p.x;
    self.pos.y = p.y + 130 - 60 * (1 - z / 6);
    self.transform.localPosition = self.pos;
end

function FoundationCharacterFriendly:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    self.character = nil;
    if (self.friendlyBtn ~= nil) then
        LuaMgr.RemoveClick(self.friendlyBtn, self.OnClickFriendly);
        self.friendlyBtn = nil;
        self.OnClickFriendly = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end