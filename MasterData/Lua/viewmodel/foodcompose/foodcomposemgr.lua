FoodComposeMgr = {};

local this = {
    foodLen = 28,
    oldTime = 0,
    gameTime = 0, 
    gameEndTime = 0,
    isPlay = false,
    isOpen = false,
    baseFoods = nil,
    composeFoods = nil,
    foodList = nil,
    foodDatas = nil,
    camera = nil,
    selectFood = nil,
    selectFoodOffset = {x=0, y=0},
    lightFood = nil,
    foodItem = nil,
    foodsTF = nil,
    dragFoodTF = nil,
    dragFoodImg = nil,
    dragFoodPos = Vector3(10000,0,0),
    setTime = nil,
    hintTime = 0,
    hintList = nil,
    audioPath = "Assets/_BundleResources/Audio/newUI/%s.mp3",
};

FoodComposeMgr.Init = function(foodItem, foodsTF, dragFoodTF, dragFoodImg, setTime)
    this.foodItem = foodItem;
    this.foodsTF = foodsTF;
    this.dragFoodTF = dragFoodTF;
    this.dragFoodImg = dragFoodImg;
    this.setTime = setTime;
    this.camera = LuaMgr.UICamera();
end

FoodComposeMgr.Show = function()
    FoodComposeMgr.Stop();
    this.oldTime = LuaMgr.TimestampMS();
    this.gameTime = 0;
    this.gameEndTime = ConfigMgr.Config.MixConstants.GameTime;
    this.isOpen = false;
    this.SetHintTime();
    FoodComposeMgr.SetFoods(false);
    FoodComposeMgr.HideFoods();
    LuaMgr.AddUpdate(this.OnUpdate);
end

FoodComposeMgr.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    FoodComposeMgr.ClearFoods();
    this.gameTime = 0;
    this.selectFood = nil;
    this.lightFood = nil;
end

FoodComposeMgr.Destroy = function()
    FoodComposeMgr.Clear();
    this.DestroyFoods();
    this.baseFoods = nil;
    this.foodItem = nil;
    this.foodsTF = nil;
    this.dragFoodTF = nil;
    this.dragFoodImg = nil;
    this.setTime = nil;
    this.hintList = nil;
end

FoodComposeMgr.Play = function()
    this.isPlay = true;
    this.isOpen = true;
end

FoodComposeMgr.Stop = function()
    this.isPlay = false;
end

FoodComposeMgr.IsOpen = function()
    return this.isOpen;
end

FoodComposeMgr.Pause = function()
    FoodComposeMgr.Stop();
    LuaMgr.ShowLuaPanel(UIName.FoodComposePauseViewModel, 1, nil);
end

FoodComposeMgr.GameTime = function()
    return this.gameTime;
end

FoodComposeMgr.PlayAudio = function(id)
    AudioMgr.Singleton:PlayUISFX(string.format(this.audioPath, id));
end

FoodComposeMgr.GetTexture = function(resId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Farm/%s.png", resId));
end


FoodComposeMgr.GetFoodConfig = function(id)
    return ConfigMgr.Config.MixGameMap[tostring(id)];
end


FoodComposeMgr.GetComposeFood = function(id)
    local foodConfig;
    local len = #this.composeFoods;
    for i = 1, len do
        foodConfig = this.composeFoods[i];
        if (foodConfig.Recipe == id) then
            return foodConfig;
        end
    end
    return nil;
end


FoodComposeMgr.InitFoods = function()
    this.baseFoods = {};
    this.composeFoods = {};
    local mixGameMap = ConfigMgr.Config.MixGameMap;
    for _, v in pairs(mixGameMap) do
        if (v.Recipe == 0) then
            table.insert(this.baseFoods, v);
        else
            table.insert(this.composeFoods, v);
        end
    end
    table.sort(this.composeFoods, this.SortComposeFoods);
end


this.SortComposeFoods = function(a, b)
    return a.Id < b.Id;
end


FoodComposeMgr.GetComposeFoods = function()
    return this.composeFoods;
end


FoodComposeMgr.GenFoodDatas = function()
    local foodMap = FoodComposeCharacterMgr.GetOrderFoodMap();
    if (this.foodDatas == nil) then
        this.foodDatas = {};
        for i = 1, this.foodLen do
            this.foodDatas[i] = this.GetOneFood(foodMap);
        end
    else
        for i = 1, this.foodLen do
            if (this.foodDatas[i] == nil) then
                this.foodDatas[i] = this.GetOneFood(foodMap);
            end
        end
    end
end


this.GetOneFood = function(foodMap)
    local food;
    local sum = 0;
    local len = #this.baseFoods;
    for i = 1, len do
        food = this.baseFoods[i];
        if (foodMap[tostring(food.Id)] ~= nil) then
            sum = sum + food.Probility[2];
        else
            sum = sum + food.Probility[1];
        end
    end
    local g = 0;
    local f = 1;
    if sum>1 then
        f=math.random(1, sum);
    end
    for i = 1, len do
        food = this.baseFoods[i];
        if (foodMap[tostring(food.Id)] ~= nil) then
            g = g + food.Probility[2];
        else
            g = g + food.Probility[1];
        end
        if (g >= f) then
            return food;
        end
    end
    return foodList[len];
end


FoodComposeMgr.GetFoodCount = function(id)
    local count = 0;
    if (this.foodDatas ~= nil) then
        local foodData;
        for i = 1, this.foodLen do
            foodData = this.foodDatas[i];
            if (foodData ~= nil and foodData.Id == id) then
                count = count + 1;
            end
        end
    end
    return count;
end


FoodComposeMgr.SetFoods = function(isPut)
    if (this.foodList == nil) then
        this.foodList = {};
    end
    local food;
    local len = #this.foodDatas;
    for i = 1, len do
        food = this.foodList[i];
        if (food == nil) then
            food = FoodComposeItem.New(this.foodItem, this.foodsTF);
            this.foodList[i] = food;
        end
        food:SetData(i, this.foodDatas[i], isPut and food.index == 0);
    end
    this.dragFoodPos.x = 10000;
    this.SetDragFood();
end


FoodComposeMgr.ShowFoods = function()
    local len = #this.foodList;
    for i = 1, len do
        this.foodList[i]:SetStatus(true);
    end
end


FoodComposeMgr.HideFoods = function()
    local len = #this.foodList;
    for i = 1, len do
        this.foodList[i]:SetStatus(false);
    end
end


FoodComposeMgr.ClearFoods = function()
    this.foodDatas = nil;
    if (this.foodList ~= nil) then
        local len = #this.foodList;
        for i = 1, len do
            this.foodList[i]:Clear();
        end
    end
end


this.DestroyFoods = function()
    if (this.foodList ~= nil) then
        local len = #this.foodList;
        for i = 1, len do
            this.foodList[i]:Destroy();
        end
        this.foodList = nil;
    end
end


this.GetClickFood = function(pos)
    local len = #this.foodList;
    for i = 1, len do
        if (this.foodList[i]:InRect(pos)) then
            return this.foodList[i];
        end
    end
    return nil;
end


this.SetDragFood = function()
    if (this.selectFood ~= nil) then
        local foodConfig = this.foodDatas[this.selectFood.index];
        this.dragFoodImg.texture = FoodComposeMgr.GetTexture(foodConfig.Icon);
    else
        this.dragFoodImg.texture = nil;
    end
    this.dragFoodTF.localPosition = this.dragFoodPos;
    this.dragFoodTF:SetAsLastSibling();
end


this.CheckClickFood = function(food, pos)
    if (food == nil) then return end
    if (this.foodDatas == nil) then return end
    if (this.foodDatas[food.index] == nil) then return end

    this.selectFood = food;
    food:SetStatus(false);
    this.selectFoodOffset.x = pos.x - food.pos.x;
    this.selectFoodOffset.y = pos.y - food.pos.y;
    this.SetDragFood();
end


this.CheckComposeFood = function(food)
    if (this.selectFood == nil or this.foodDatas==nil ) then return end
    local selectFoodConfig = this.foodDatas[this.selectFood.index];
    if (selectFoodConfig == nil) then return end
    
    local newFoodConfig = nil;
    if (food ~= nil and this.selectFood.index ~= food.index) then
        local foodConfig = this.foodDatas[food.index];
        if (foodConfig ~= nil and foodConfig.IfMax == 0 and selectFoodConfig.Id == foodConfig.Id) then
            this.foodDatas[this.selectFood.index] = nil;
            this.selectFood:Clear();
            newFoodConfig = FoodComposeMgr.GetComposeFood(foodConfig.Id);
            if (newFoodConfig ~= nil) then
                this.foodDatas[food.index] = newFoodConfig;
                food:SetIcon(newFoodConfig.Icon);
                food:SetLight(true);
                food:SetMax(newFoodConfig.IfMax == 1);
                this.lightFood = food;
                FoodComposeMgr.PlayAudio("Foundation_levelup_2");
            end
        end
    end
    if (newFoodConfig == nil) then
        this.selectFood:SetStatus(true);
    end
    this.selectFood = nil;
    this.dragFoodPos.x = 10000;
    this.SetDragFood();
end


this.CheckClick = function()
    if (LuaMgr.OutOfScreen()) then 
        return 
    end
    if (this.selectFood ~= nil and RaycastTool.GetMouseButtonUp(0)) then
        local pos = RectTransformTool.ScreenToLocal(RaycastTool.GetMousePosition(), this.foodsTF, this.camera);
        local food = this.GetClickFood(pos);
        this.CheckComposeFood(food);
        this.SetHintTime();
        return;
    end
    if (this.selectFood == nil and RaycastTool.GetMouseButtonDown(0)) then
        local pos = RectTransformTool.ScreenToLocal(RaycastTool.GetMousePosition(), this.foodsTF, this.camera);
        if (this.lightFood ~= nil) then
            this.lightFood:SetLight(false);
            this.lightFood = nil;
        end
        local food = this.GetClickFood(pos);
        this.CheckClickFood(food, pos);
        this.SetHintTime();
    end
    if (this.selectFood == nil) then
        this.dragFoodPos.x = 10000;
        this.SetDragFood();
        return;
    end
    local pos = RectTransformTool.ScreenToLocal(RaycastTool.GetMousePosition(), this.foodsTF, this.camera);
    this.dragFoodPos.x = pos.x - this.selectFoodOffset.x;
    this.dragFoodPos.y = pos.y - this.selectFoodOffset.y;
    this.dragFoodTF.localPosition = this.dragFoodPos;
    this.SetHintTime();
end


FoodComposeMgr.IsCompleteOrder = function(foods)
    if (this.foodDatas == nil) then return nil end
    
    local food;
    local foodId;
    local list = {};
    local len = #foods;
    for i = 1, len do
        foodId = foods[i];
        for j = 1, this.foodLen do
            food = this.foodDatas[j];
            if (food ~= nil and food.Id == foodId) then
                table.insert(list, j);
                break;
            end
        end
    end
    if (#list == len) then
        return list;
    end
    return nil;
end


FoodComposeMgr.CostFoods = function(foodIndexs, character)
    local index;
    local food;
    local foodConfig;
    local characterFood;
    local len = #foodIndexs;
    for i = 1, len do
        index = foodIndexs[i];
        food = this.foodList[index];
        if (food == this.selectFood) then
            this.selectFood = nil;
            this.dragFoodPos.x = 10000;
            this.SetDragFood();
        end
        food:Clear();
        foodConfig = this.foodDatas[index];
        this.foodDatas[index] = nil;
        characterFood = character:GetFoodItem(foodConfig.Id);
        FoodComposeFoodMgr.AddFood(foodConfig.Icon, food, characterFood, character.ShowComplete);
    end
end


FoodComposeMgr.GameEndTime = function()
    return this.gameEndTime;
end


FoodComposeMgr.Result = function()
    FoodComposeMgr.Stop();
    FoodComposeFoodMgr.Clear();
    local orders = FoodComposeCharacterMgr.GetCompleteOrders();
    orderCount = #orders;
    if (orderCount <= 0) then
        orders = nil;
    end
    ApiMgr.Request("mixgame/mixGameRewards", {Ids=orders}, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            LuaMgr.ShowLuaPanel(UIName.FoodComposeResultViewModel, data.result.Rewards, orderCount);
        end
    end, nil, true, true);
end


this.CheckGameOver = function()
    if (this.setTime ~= nil) then
        this.setTime();
    end
    if (this.gameEndTime <= 0) then
        FoodComposeMgr.Result();
    end
end


this.SetHintTime = function()
    this.hintTime = FoodComposeMgr.GameTime() + ConfigMgr.Config.MixConstants.HelpShow;
    if (this.hintList == nil) then
        this.hintList = {};
    end
    if (this.hintList[1] ~= nil) then
        this.hintList[1]:SetHint(false);
        this.hintList[1] = nil;
    end
    if (this.hintList[2] ~= nil) then
        this.hintList[2]:SetHint(false);
        this.hintList[2] = nil;
    end 
end


this.CheckHint = function()
    if (this.foodDatas == nil) then return end
    
    if (FoodComposeMgr.GameTime() > this.hintTime) then
        this.SetHintTime();
        local foodData;
        local nowData;
        for i = 1, this.foodLen do
            nowData = this.foodDatas[i];
            if (nowData ~= nil and nowData.IfMax == 0) then
                for j = 1, this.foodLen do
                    if (i ~= j) then
                        foodData = this.foodDatas[j];
                        if (foodData ~= nil) then
                            if (nowData.Id == foodData.Id) then
                                this.foodList[i]:SetHint(true);
                                this.foodList[j]:SetHint(true);
                                this.hintList[1] = this.foodList[i];
                                this.hintList[2] = this.foodList[j];
                                return;
                            end
                        end
                    end
                end
            end
        end
    end
end


this.OnUpdate = function()
    local nowTime = LuaMgr.TimestampMS();
    local time = nowTime - this.oldTime;
    this.oldTime = nowTime;
    if (this.isPlay) then
        this.gameTime = this.gameTime + time;
        this.gameEndTime = this.gameEndTime - time;
        if (this.gameEndTime < 0) then
            this.gameEndTime = 0;
        end
        FoodComposeFoodMgr.Update();
        this.CheckGameOver();
        this.CheckClick();
        this.CheckHint();
        FoodComposeCharacterMgr.Update();
    end
end