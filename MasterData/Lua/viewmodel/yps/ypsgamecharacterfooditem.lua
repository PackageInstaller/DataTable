YPSGameCharacterFoodItem = {};

YPSGameCharacterFoodItem.__index = YPSGameCharacterFoodItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    complete = { path = "Complete", type = "GameObject" },
    textT = { path = "Text", type = "Text" },
}

function YPSGameCharacterFoodItem.New(prefab, parent)
    local self = {};
    setmetatable(self, YPSGameCharacterFoodItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);
    return self;
end

function YPSGameCharacterFoodItem:SetData(data, count)
    self.data = data;
    self.icon.texture = YPSGameMgr.GetTexture(data.Icon);
    SetActive(self.complete, count > 0);
    SetActive(self.gameObject, true);
    self.textT.text = data.Recipe.."+"..data.IfMax
end

function YPSGameCharacterFoodItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function YPSGameCharacterFoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end