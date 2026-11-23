FoundationCharacterMsg = {};

FoundationCharacterMsg.__index = FoundationCharacterMsg;

local objs = {
    msgText = { path = "Msg/Text", type = "Text" },
};

FoundationCharacterMsg.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterMsg);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterMsg.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.character = nil;
    self.msgTime = 0;
    return self;
end

function FoundationCharacterMsg:SetData(character, content, time)
    self.character = character;
    self.msgText.text = content;
    self:SetPosition(character);
    self.gameObject:SetActive(true);
    self.msgTime = os.time() + time;
end

function FoundationCharacterMsg:Hide()
    self.msgTime = 0;
    if (self.gameObject.activeSelf) then
        self.gameObject:SetActive(false);
    end
end

function FoundationCharacterMsg:Update(character)
    self:SetPosition(character);
    local time = os.time();
    if (self.msgTime > 0 and time > self.msgTime) then
        self:Hide();
    end
end

function FoundationCharacterMsg:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    local z = character.transform.localPosition.z;
    self.pos.x = p.x;
    self.pos.y = p.y + 130 - 60 * (1 - z / 6);
    self.transform.localPosition = self.pos;
end

function FoundationCharacterMsg:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    self.character = nil;
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end