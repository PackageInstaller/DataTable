FoundationCharacterFlyText = {};

FoundationCharacterFlyText.__index = FoundationCharacterFlyText;

local objs = {
    text = { path = "Text", type = "Text" },
};

FoundationCharacterFlyText.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterFlyText);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterFlyText.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.distance = 100;
    self.delta = 2;
    return self;
end

function FoundationCharacterFlyText:SetData(character, content)
    self.text.text = content;
    self:SetPosition(character);
    self.gameObject:SetActive(true);
end

function FoundationCharacterFlyText:Hide()
    if (self.gameObject.activeSelf) then
        self.gameObject:SetActive(false);
    end
end

function FoundationCharacterFlyText:Update()
    if (self.distance > 0) then
        self.distance = self.distance - self.delta;
        self.pos.y = self.pos.y + self.delta;
        self.transform.localPosition = self.pos;
        return true;
    end
    return false;
end

function FoundationCharacterFlyText:SetPosition(character)
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    self.pos.x = p.x;
    self.pos.y = p.y + 130;
    self.transform.localPosition = self.pos;
end

function FoundationCharacterFlyText:Clear()
    self.container = nil;
    self.camera = nil;
    self.pos = nil;
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
    end
end