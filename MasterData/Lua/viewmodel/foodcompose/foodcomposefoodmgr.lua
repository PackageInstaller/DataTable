FoodComposeFoodMgr = {};

local this = {
    FoodItem = nil,
    container = nil,
    foodList = {},
    foodPool = nil,
};

FoodComposeFoodMgr.Init = function(foodItem, container)
    this.foodItem = foodItem;
    this.container = container;
    this.foodList = {};
    this.foodPool = {};
end

FoodComposeFoodMgr.Clear = function()
    if (this.foodList ~= nil) then
        local len = #this.foodList;
        for i = 1, len do
            this.AddFoodItem(this.foodList[i]);
        end
        this.foodList = {};
    end
end

FoodComposeFoodMgr.Destroy = function()
    if (this.foodList ~= nil) then
        local len = #this.foodList;
        for i = 1, len do
            this.foodList[i]:Destroy();
        end
        this.foodList = {};
    end
    if (this.foodPool ~= nil) then
        local len = #this.foodPool;
        for i = 1, len do
            this.foodPool[i]:Destroy();
        end
        this.foodPool = nil;
    end
end

FoodComposeFoodMgr.Update = function()
    this.CheckFoods();
end


FoodComposeFoodMgr.AddFood = function(resId, food, characterFood, callback)
    if (this.container == nil or LuaMgr.IsObjectNull(this.container)) then return end
    if (food == nil) then return end
    
    local p1 = RectTransformTool.ToContainer(food.transform, this.container);
    local p2 = RectTransformTool.ToContainer(characterFood.transform, this.container);
    local item = this.GetFoodItem();
    item:SetData(resId, Vector3(p1.x, p1.y, 0), Vector3(p2.x, p2.y, 0), callback);
    table.insert(this.foodList, item);
    FoodComposeMgr.PlayAudio("2048_BSMerge");
end


this.CheckFoods = function()
    local item;
    local index = 1;
    local len = #this.foodList;
    while (index <= len) do
        item = this.foodList[index];
        if (item.isLive) then
            index = index + 1;
        else
            len = len - 1;
            table.remove(this.foodList, index, 1);
            this.AddFoodItem(item);
        end
    end
end


this.GetFoodItem = function()
    local len = #this.foodPool;
    if (len > 0) then
        local item = this.foodPool[len];
        this.foodPool[len] = nil;
        return item;
    end
    return FoodComposeFoodItem.New(this.foodItem, this.container);
end


this.AddFoodItem = function(item)
    item:Clear();
    local index = #this.foodPool + 1;
    this.foodPool[index] = item;
end