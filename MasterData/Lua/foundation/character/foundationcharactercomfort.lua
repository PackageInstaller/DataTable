FoundationCharacterComfort = {};

FoundationCharacterComfort.__index = FoundationCharacterComfort;

local objs = {
    comfortBtn = { path = "Comfort", type = "Button" },
};

FoundationCharacterComfort.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterComfort);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterComfort.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.character = nil;
    self.OnClickComfort = function()
        local roomId = FoundationMgr.GetRoomId();
        local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
        PlayerFoundationMgr.Draw(buildingId);
    end
    LuaMgr.AddClick(self.comfortBtn, self.OnClickComfort);
    return self;
end

function FoundationCharacterComfort:SetData(character)
    self.character = character;
    self:SetPosition(character);
    SetActive(self.gameObject, true);
end

function FoundationCharacterComfort:Hide()
    SetActive(self.gameObject, false);
end

function FoundationCharacterComfort:Update(character)
    self:SetPosition(character);
end

function FoundationCharacterComfort:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    local z = character.transform.localPosition.z;
    self.pos.x = p.x;
    self.pos.y = p.y + 210 - 60 * (1 - z / 6);
    self.transform.localPosition = self.pos;
end

function FoundationCharacterComfort:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    self.character = nil;
    if (self.comfortBtn ~= nil) then
        LuaMgr.RemoveClick(self.comfortBtn, self.OnClickComfort);
        self.comfortBtn = nil;
        self.OnClickComfort = nil;
    end
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end