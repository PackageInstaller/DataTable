FoodComposeCharacterFoodItem = {};

FoodComposeCharacterFoodItem.__index = FoodComposeCharacterFoodItem;

local objs = {
    icon = { path = "Icon", type = "RawImage" },
    complete = { path = "Complete", type = "GameObject" },
}

function FoodComposeCharacterFoodItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoodComposeCharacterFoodItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);
    return self;
end

function FoodComposeCharacterFoodItem:SetData(data, count)
    self.data = data;
    self.icon.texture = FoodComposeMgr.GetTexture(data.Icon);
    SetActive(self.complete, count > 0);
    SetActive(self.gameObject, true);
end

function FoodComposeCharacterFoodItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function FoodComposeCharacterFoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end