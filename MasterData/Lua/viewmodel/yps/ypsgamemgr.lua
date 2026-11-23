YPSGameMgr = {};

local this = {
    foodLen = 28,
    oldTime = 0,
    gameTime = 0,
    gameEndTime = 0,
    gridsLimit = 2,
    isSelfCheckOut = false,
    reduceTime = 0,
    stopTime = 0,
    isPlay = false,
    isOpen = false,
    baseFoods = nil,
    composeFoods = nil,
    foodContainers = nil,
    foodList = nil,
    baseFoodList = nil,
    containers = nil,
    foodDatas = nil,
    foodComposeDatas = nil,
    camera = nil,
    selectFood = nil,
    selectContainer = nil,
    lightFood = nil,
    foodItem = nil,
    foodsTF = nil,
    baseFoodItem = nil,
    baseFoodsTF = nil,
    containerItem = nil,
    containersTF = nil,
    finishFoodItem = nil,
    finishFoodsTF = nil,
    finishFoods = {},
    setTime = nil,
    hintList = nil,
    audioPath = "Assets/_BundleResources/Audio/newUI/%s.mp3",
};

YPSGameMgr.Init = function(itemList, tfList, setTime)
    this.foodItem = itemList[1];
    this.foodsTF = tfList[1];
    this.baseFoodItem = itemList[2];
    this.baseFoodsTF = tfList[2];
    this.containerItem = itemList[3];
    this.containersTF = tfList[3];
    this.finishFoodItem = itemList[4];
    this.finishFoodsTF = tfList[4];
    this.setTime = setTime;
    this.camera = LuaMgr.UICamera();
    YPSGameMgr.InitTalent()
end

YPSGameMgr.InitTalent = function()
    this.gridsLimit = 2
    this.isSelfCheckOut = false
    this.reduceTime = 0
    for i = 1, 5 do
        local data = DataMgr.Player.CookGame.TalentMap["talent" .. i]
        if (data == 1) then
            local config = ConfigMgr.Config.CookConstants["Talent" .. i]
            local type = config[3][1]
            local value = tonumber(config[3][2])
            if (type == "1") then
                this.gridsLimit = this.gridsLimit + value;
            elseif (type == "2") then
                this.reduceTime = this.reduceTime + value;
            else
                this.isSelfCheckOut = true
            end
        end
    end
end

YPSGameMgr.Show = function()
    YPSGameMgr.Stop();
    this.oldTime = LuaMgr.TimestampMS();
    this.gameTime = 0;
    this.gameEndTime = ConfigMgr.Config.CookConstants.GameTime;
    this.isOpen = false;
    YPSGameMgr.SetFoods();
    YPSGameMgr.SetBaseFoods()
    YPSGameMgr.SetFoodContainers()
    YPSGameMgr.SetFinishFoods()
    YPSGameMgr.HideFoods();
    LuaMgr.AddUpdate(this.OnUpdate);
end

YPSGameMgr.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    this.gameTime = 0;
    this.selectFood = nil;
    this.selectContainer = nil;
    this.lightFood = nil;
    this.foodComposeDatas = nil;
    this.finishFoods = {};
end

YPSGameMgr.Destroy = function()
    YPSGameMgr.Clear();
    this.DestroyFoods();
    this.baseFoods = nil;
    this.foodItem = nil;
    this.foodsTF = nil;
    this.setTime = nil;
    this.hintList = nil;
end

YPSGameMgr.Play = function()
    this.isPlay = true;
    this.isOpen = true;
    if (this.stopTime ~= 0) then
        local interval = LuaMgr.Timestamp() - this.stopTime;
        for i, v in ipairs(this.foodDatas) do
            if (v.state == 0) then
                this.foodList[i]:AddStopTime(interval);
            end
        end
        this.stopTime = 0
    end
end

YPSGameMgr.Stop = function()
    this.isPlay = false;
    this.stopTime = LuaMgr.Timestamp()
end

YPSGameMgr.IsOpen = function()
    return this.isOpen;
end

YPSGameMgr.Pause = function()
    YPSGameMgr.Stop();
    LuaMgr.ShowLuaPanel(UIName.YPSGamePauseViewModel, 1, nil);
end

YPSGameMgr.GameTime = function()
    return this.gameTime;
end

YPSGameMgr.PlayAudio = function(id)
    AudioMgr.Singleton:PlayUISFX(string.format(this.audioPath, id));
end

YPSGameMgr.GetTexture = function(resId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/YPS/%s.png", resId));
end


YPSGameMgr.GetFoodConfig = function(id)
    return ConfigMgr.Config.CookGameMap[tostring(id)];
end


YPSGameMgr.GetComposeFood = function(id1, id2)
    local foodConfig;
    local len = #this.composeFoods;
    for i = 1, len do
        foodConfig = this.composeFoods[i];
        if (foodConfig.Recipe == id1 and foodConfig.IfMax == id2) then
            return foodConfig;
        end
    end
    return nil;
end


YPSGameMgr.GetFoodContainer = function(id)
    local foodConfig;
    local len = #this.composeFoods;
    for i = 1, len do
        foodConfig = this.composeFoods[i];
        if (foodConfig.IfMax == id) then
            return foodConfig;
        end
    end
    return nil;
end


YPSGameMgr.InitFoods = function()
    this.baseFoods = {};
    this.composeFoods = {};
    this.foodContainers = {};
    local cacheMap = {}
    local mixGameMap = ConfigMgr.Config.CookGameMap;
    for _, v in pairs(mixGameMap) do
        if (v.IfMax ~= 0) then
            if (cacheMap[v.IfMax] == nil) then
                cacheMap[v.IfMax] = 1;
            end
        end
        if (v.Recipe == 0) then
            table.insert(this.baseFoods, v);
        else
            table.insert(this.composeFoods, v);
        end
    end
    for i = #this.baseFoods, 1, -1 do
        local food = this.baseFoods[i];
        if (cacheMap[food.Id] ~= nil) then
            table.insert(this.foodContainers, food);
            table.remove(this.baseFoods, i);
        end
    end
    table.sort(this.composeFoods, this.SortComposeFoods);
    table.sort(this.foodContainers, this.SortComposeFoods);
    table.sort(this.baseFoods, this.SortComposeFoods);
end


this.SortComposeFoods = function(a, b)
    return a.Id < b.Id;
end


YPSGameMgr.GetComposeFoods = function()
    return this.composeFoods;
end


YPSGameMgr.GenFoodDatas = function()
    local foodMap = YPSGameCharacterMgr.GetOrderFoodMap();
    if (this.foodComposeDatas == nil or #this.foodComposeDatas == 0) then
        this.foodComposeDatas = {}
        for k, v in pairs(foodMap) do
            for key, value in ipairs(v) do
                table.insert(this.foodComposeDatas, value)
            end
        end
    else
        for i, v in ipairs(this.foodComposeDatas) do
            local dataList = foodMap[v.guestIndex];
            if (dataList ~= nil) then
                for key, value in ipairs(dataList) do
                    if (v.id == value.id) then
                        foodMap[v.guestIndex][key].state = v.state
                    end
                end
            end
        end
        this.foodComposeDatas = {}
        for k, v in pairs(foodMap) do
            for key, value in ipairs(v) do
                table.insert(this.foodComposeDatas, value)
            end
        end
    end
    table.sort(this.foodComposeDatas, function(a, b)
        if (a.queueIndex == b.queueIndex) then
            return false
        end
        return a.queueIndex < b.queueIndex
    end)
end

YPSGameMgr.RemoveFoodsData = function(guestIndex)
    if (this.foodComposeDatas ~= nil and #this.foodComposeDatas > 0) then
        for i = #this.foodComposeDatas, 1, -1 do
            local data = this.foodComposeDatas[i]
            if (data.guestIndex == guestIndex) then
                table.remove(this.foodComposeDatas, i)
            end
        end
    end
end


YPSGameMgr.SetFoods = function()
    this.foodDatas = {}
    local otherNum = 0
    for i, v in ipairs(this.composeFoods) do
        if (v.IfMax == 0) then
            local index = i - otherNum
            local cache = {}
            cache.config = v
            cache.num = ConfigMgr.Config.CookConstants.FoodStartNum[index]
            cache.cookTime = ConfigMgr.Config.CookConstants.CookTime[index]
            cache.addNum = ConfigMgr.Config.CookConstants.CookNum[index]
cache.state = 1
            table.insert(this.foodDatas, cache)
        else
            otherNum = otherNum + 1
        end
    end

    if (this.foodList == nil) then
        this.foodList = {};
    end
    local len = #this.foodDatas;
    for i = 1, len do
        local food = this.foodList[i];
        if (food == nil) then
            food = YPSGameFoodItem.New(this.foodItem, this.foodsTF);
            this.foodList[i] = food;
        end
        this.foodDatas[i].callback = function()
            if (this.selectFood ~= nil) then
                this.selectFood:SetLight(false);
            end
            if (this.selectFood == food) then
                this.selectFood = nil
                return
            end
            if (food.data.state == 0) then
                return
            end
            this.selectFood = food
            this.selectFood:SetLight(true);
        end
        food:SetData(i, this.foodDatas[i], food.index == 0);
    end
end


YPSGameMgr.SetBaseFoods = function()
    if (this.baseFoodList == nil) then
        this.baseFoodList = {};
    end
    local food;
    local len = #this.baseFoods;
    for i = 1, len do
        food = this.baseFoodList[i];
        if (food == nil) then
food = YPSGameBFoodItem.New(this.baseFoodItem, this.baseFoodsTF);
            this.baseFoodList[i] = food;
        end
        local cache = {}
        cache.config = this.baseFoods[i];
        cache.callback = function()
            local cache = this.foodDatas[i]
            if (cache.state == 0) then
                return
            end
            cache.state = 0
            this.foodList[i]:SetStatus()
            cache.cookStartTime = LuaMgr.Timestamp()
            this.foodDatas[i] = cache
        end
        food:SetData(i, cache, food.index == 0);
    end
end


YPSGameMgr.SetFoodContainers = function()
    if (this.containers == nil) then
        this.containers = {};
    end
    local len = #this.foodContainers;
    for i = 1, len do
        local container = this.containers[i];
        if (container == nil) then
            container = YPSGameContainerItem.New(this.containerItem, this.containersTF);
            this.containers[i] = container;
        end
        local cache = {}
        cache.config = this.foodContainers[i];
        cache.callback = function()
            if (this.selectContainer ~= nil) then
                this.selectContainer:SetLight(false);
            end
            if (this.selectContainer == container) then
                this.selectContainer = nil
                return
            end
            this.selectContainer = container
            this.selectContainer:SetLight(true);
        end
        container:SetData(i, cache);
    end
end


YPSGameMgr.SetFinishFoods = function(newId)
    if (this.finishFoodItems == nil) then
        this.finishFoodItems = {};
    end
    local len = 4;
    for i = 1, len do
        local item = this.finishFoodItems[i];
        if (item == nil) then
            item = YPSGameFinishFoodItem.New(this.finishFoodItem, this.finishFoodsTF);
            this.finishFoodItems[i] = item;
        end
        local cache = {}
        cache.config = this.finishFoods[i];
        cache.isLock = i > this.gridsLimit
        if (cache.config ~= nil) then
            cache.isNew = cache.config.Id == newId
        end
        item:SetData(cache);
    end
end


YPSGameMgr.ShowFoods = function()
    for k, v in pairs(this.foodList) do
        v:ShowItem(true);
    end
    for k, v in pairs(this.baseFoodList) do
        v:ShowItem(true);
    end
    for k, v in pairs(this.containers) do
        v:ShowItem(true);
    end
end


YPSGameMgr.HideFoods = function()
    for k, v in pairs(this.foodList) do
        v:ShowItem(false);
    end
    for k, v in pairs(this.baseFoodList) do
        v:ShowItem(false);
    end
    for k, v in pairs(this.containers) do
        v:ShowItem(false);
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
    if (this.baseFoodList ~= nil) then
        local len = #this.baseFoodList;
        for i = 1, len do
            this.baseFoodList[i]:Destroy();
        end
        this.baseFoodList = nil;
    end
    if (this.containers ~= nil) then
        local len = #this.containers;
        for i = 1, len do
            this.containers[i]:Destroy();
        end
        this.containers = nil;
    end
    if (this.finishFoodItems ~= nil) then
        local len = #this.finishFoodItems;
        for i = 1, len do
            this.finishFoodItems[i]:Destroy();
        end
        this.finishFoodItems = nil;
    end
end


this.CheckClick = function()
    for i, v in ipairs(this.foodDatas) do
        if (v.state == 0) then
            this.foodList[i]:UpdateTime(this.reduceTime);
        end
    end
    if (this.selectContainer == nil or this.selectFood == nil) then
        return
    end

    for k, v in pairs(this.foodComposeDatas) do
        local cookConfig = ConfigMgr.Config.CookGameMap[v.idstr]
        if (cookConfig.Recipe == this.selectFood.config.Id and cookConfig.IfMax == this.selectContainer.config.Id) then
            if (v.state == 0) then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/huazhao_puzzle.mp3");
                YPSGameMgr.FlyFoods(v, this.foodsTF)
                this.foodComposeDatas[k].state = 1
                this.selectFood:CostNum(1)
                this.selectFood:SetLight(false)
                this.selectContainer:SetLight(false)
                this.selectFood = nil
                this.selectContainer = nil
                YPSGameMgr.PlayAudio("Foundation_levelup_2");
                return
            end
        end
    end
    if (this.selectFood ~= nil and this.selectContainer ~= nil) then
        this.selectFood:SetLight(false)
        this.selectContainer:SetLight(false)
        local finishFood = YPSGameMgr.GetComposeFood(this.selectFood.config.Id, this.selectContainer.config.Id)
        if (finishFood ~= nil) then
            if (#this.finishFoods < this.gridsLimit) then
                table.insert(this.finishFoods, finishFood)
                YPSGameMgr.SetFinishFoods(finishFood.Id)
                this.selectFood:CostNum(1)
                this.selectFood = nil
                this.selectContainer = nil
                return
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                    LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29122"))
            end
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29119"))
        end
        this.selectFood = nil
        this.selectContainer = nil
    end
end


YPSGameMgr.GetFoodCount = function(id, guestIndex)
    if (this.foodComposeDatas ~= nil) then
        for k, v in pairs(this.foodComposeDatas) do
            if ((v.state == 1 or v.state == 2) and v.id == id and guestIndex == v.guestIndex) then
                return 1
            end
            local length = #this.finishFoods
            if (length > 0 and v.state == 0 and v.id == id and guestIndex == v.guestIndex) then
                for i = length, 1, -1 do
                    local config = this.finishFoods[i]
                    if (config.Id == id) then
                        this.foodComposeDatas[k].state = 1
                        table.remove(this.finishFoods, i)
                        YPSGameMgr.FlyFoods(v, this.finishFoodsTF)
                        YPSGameMgr.SetFinishFoods()
                        return 1
                    end
                end
                return 0
            end
        end
    end
    return 0
end

YPSGameMgr.CharacterFinishClick = function(guestIndex)
    local hasFinish = false
    for i, v in ipairs(this.foodComposeDatas) do
        if (v.state == 1 and guestIndex == v.guestIndex) then
            this.foodComposeDatas[i].guestFinish = true
            hasFinish = true
        end
    end
    if (hasFinish) then
        YPSGameCharacterMgr.SendGuest(guestIndex)
    else
        LuaDebug.error("出现了送客按钮，也主动点击了送客指令，但是没有完成订单，好好再检查下this.foodComposeDatas数据")
    end
end


YPSGameMgr.IsCompleteOrder = function(foods, guestIndex)
    if (this.foodComposeDatas == nil) then return nil end
    local foodId;
    local list = {};
    local indexList = {};
    local len = #foods;
    for i, v in ipairs(this.foodComposeDatas) do
        if (v.state == 1 and guestIndex == v.guestIndex) then
            for kay, value in ipairs(foods) do
                foodId = value;
                if (v.id == foodId) then
                    table.insert(indexList, i);
                    table.insert(list, v.id);
                    break;
                end
            end
        end
    end
    if (#list == len) then
        for i, v in ipairs(indexList) do
            if (this.foodComposeDatas[v].guestFinish ~= true and this.isSelfCheckOut == false) then
                return nil;
            end
            this.foodComposeDatas[v].state = 2
        end
        return indexList;
    end
    return nil;
end


YPSGameMgr.FlyFoods = function(config, startTF)
    local food = startTF
    local character = YPSGameCharacterMgr.GetCharacterItem(config.guestIndex)
    local foodConfig = YPSGameMgr.GetFoodConfig(config.id);
    local characterFood = character:GetFoodItem(config.id);
    YPSGameFoodMgr.AddFood(foodConfig.Icon, food, characterFood, nil);
end



YPSGameMgr.GameEndTime = function()
    return this.gameEndTime;
end


YPSGameMgr.Result = function()
    YPSGameMgr.Stop();
    YPSGameFoodMgr.Clear();
    local orders = YPSGameCharacterMgr.GetCompleteOrders();
    local orderCount = #orders;
    if (orderCount <= 0) then
        orders = nil;
    end
    ApiMgr.Request("cookgame/orderRewards", { Ids = orders }, true, function(result)
        local data = json.decode(result);
        if (data ~= nil and data.result ~= nil) then
            LuaMgr.ShowLuaPanel(UIName.YPSGameResultViewModel, data.result.Rewards, orderCount);
        end
    end, nil, true, true);
end


this.CheckGameOver = function()
    if (this.setTime ~= nil) then
        this.setTime();
    end
    if (this.gameEndTime <= 0) then
        YPSGameMgr.Result();
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
        YPSGameFoodMgr.Update();
        this.CheckGameOver();
        this.CheckClick();
        YPSGameCharacterMgr.Update();
    end
end