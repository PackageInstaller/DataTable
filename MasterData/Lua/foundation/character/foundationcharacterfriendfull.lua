FoundationCharacterFriendFull = {};

FoundationCharacterFriendFull.__index = FoundationCharacterFriendFull;

local objs = {
    fullTF = { path = "Full", type = "Transform" },
    canvasGroup = { path = "Full", type = "CanvasGroup" },
};

FoundationCharacterFriendFull.New = function(container, camera)
    local self = {};
    setmetatable(self, FoundationCharacterFriendFull);
    self.container = container;
    self.camera = camera;
    self.prefabPath = "Assets/_BundleResources/UI/Foundation/FoundationCharacterFriendFull.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(container, false);
    self.pos = Vector3(0, 0, 0);
    self.alpha = 1.0;
    self.delay = 0;
    return self;
end

function FoundationCharacterFriendFull:SetData(character)
    self:SetPosition(character);
    self.delay = os.time() + 0.5;
    self.alpha = 1.0;
    self.canvasGroup.alpha = self.alpha;
    self.gameObject:SetActive(true);
end

function FoundationCharacterFriendFull:SetPosition(character)
    if self.transform==nil then return end;
    local p = RectTransformTool.ToContainer(self.camera, character.transform, self.container);
    local z = character.transform.localPosition.z;
    self.pos.x = p.x;
    self.pos.y = p.y + 130 - 60 * (1 - z / 6);
    self.transform.localPosition = self.pos;
end

function FoundationCharacterFriendFull:Update(character)
    if self.transform==nil then return end;
    if (os.time() < self.delay) then
        self:SetPosition(character);
    else
        if (self.alpha > 0) then
            self.pos.y = self.pos.y + 0.3;
            self.transform.localPosition = self.pos;
            self.alpha = self.alpha - 0.006;
            self.canvasGroup.alpha = self.alpha;
        else
            character:RemoveFriendFull();
        end
    end
end

function FoundationCharacterFriendFull:Clear()
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