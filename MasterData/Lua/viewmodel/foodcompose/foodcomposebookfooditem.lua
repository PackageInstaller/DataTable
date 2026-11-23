FoodComposeBookFoodItem = {};

FoodComposeBookFoodItem.__index = FoodComposeBookFoodItem;

local objs = {
    icon = { path = "Group/Icon", type = "RawImage" },
    name = { path = "Group/Name", type = "Text" },
    food1 = { path = "Group/Food1", type = "RawImage" },
    food1Name = { path = "Group/Food1/Name", type = "Text" },
    food2 = { path = "Group/Food2", type = "RawImage" },
    food2Name = { path = "Group/Food2/Name", type = "Text" },
}

function FoodComposeBookFoodItem.New()
    local self = {};
    setmetatable(self, FoodComposeBookFoodItem);
    return self;
end

function FoodComposeBookFoodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function FoodComposeBookFoodItem:SetData(data)
    local config = data.data;
    self.icon.texture = FoodComposeMgr.GetTexture(config.Icon);
    self.name.text = LuaMgr.GetLangText(config.NameLan);
    local foodConfig = FoodComposeMgr.GetFoodConfig(config.Recipe);
    if (foodConfig ~= nil) then
        local foodTex = FoodComposeMgr.GetTexture(foodConfig.Icon);
        local nameStr = LuaMgr.GetLangText(foodConfig.NameLan);
        self.food1Name.text = nameStr;
        self.food2Name.text = nameStr;
        self.food1.texture = foodTex;
        self.food2.texture = foodTex;
    end 
end

function FoodComposeBookFoodItem:Clear()
    self.icon.texture = nil;
    self.food1.texture = nil;
    self.food2.texture = nil;
end

function FoodComposeBookFoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end