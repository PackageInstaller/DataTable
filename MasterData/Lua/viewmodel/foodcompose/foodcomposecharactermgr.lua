FoodComposeCharacterMgr = {};

local this = {
    characterLen = 3,
    characterConfigs = nil,
    characterList = nil,
    guestDatas = nil,
    guestQueue = nil,
    characterItem = nil,
    charactersTF = nil,
    characterFoodItem = nil,
    serveNum = 0,
    setServeNum = nil,
    completeOrders = nil,
    isCharacterInfo = false,
};

FoodComposeCharacterMgr.Init = function(characterItem, charactersTF, characterFoodItem, setServeNum)
    this.characterItem = characterItem;
    this.charactersTF = charactersTF;
    this.characterFoodItem = characterFoodItem;
    this.setServeNum = setServeNum;
    this.InitCharacters();
end

FoodComposeCharacterMgr.Show = function()
    this.serveNum = 0;
    this.completeOrders = {};
    this.isCharacterInfo = false;
    FoodComposeCharacterMgr.GenGuests();
end

FoodComposeCharacterMgr.Clear = function()
    this.guestDatas = nil;
    this.guestQueue = nil;
    this.completeOrders = nil;
    this.ClearCharacters();
end

FoodComposeCharacterMgr.Destroy = function()
    this.DestroyCharacters();
    this.characterItem = nil;
    this.charactersTF = nil;
    this.characterFoodItem = nil;
    this.setServeNum = nil;
end

FoodComposeCharacterMgr.Update = function()
    this.CheckGuests();
end


FoodComposeCharacterMgr.GetOrderFoodMap = function()
    local len;
    local baseId;
    local guestData;
    local foodMap = {};
    for i = 1, this.characterLen do
        guestData = this.guestDatas[i];
        if (guestData ~= nil) then
            len = #guestData.foods;
            for j = 1, len do
                baseId = this.FindBaseFood(guestData.foods[j]);
                foodMap[tostring(baseId)] = baseId;
            end
        end
    end
    return foodMap;
end


this.FindBaseFood = function(id)
    local foodConfig = FoodComposeMgr.GetFoodConfig(id);
    if (foodConfig ~= nil) then
        if (foodConfig.Recipe == 0) then
            return id;
        end
        return this.FindBaseFood(foodConfig.Recipe);
    end
    return id;
end


FoodComposeCharacterMgr.GenGuests = function()
    local guestData;
    local character;
    if (this.characterList == nil) then
        this.characterList = {};
    end
    if (this.guestDatas == nil) then
        this.guestDatas = {};
        this.guestQueue = {};
    end
    for i = 1, this.characterLen do
        guestData = nil;
        character = this.characterList[i];
        if (character == nil) then
            character = FoodComposeCharacterItem.New(this.characterItem, this.charactersTF, this.characterFoodItem, i);
            this.characterList[i] = character;
        end
        if (this.guestDatas[i] == nil) then
            guestData = this.GetGuestData();
            this.guestDatas[i] = guestData;
            table.insert(this.guestQueue, i);
        end
        if (guestData ~= nil) then
            character:SetData(guestData);
            if (this.isCharacterInfo) then
                character:ComeIn();
            end
        end
    end
end


FoodComposeCharacterMgr.SetCharacterInfo = function()
    this.isCharacterInfo = true;
    local character;
    for i = 1, this.characterLen do
        character = this.characterList[i];
        if (character ~= nil and character.data ~= nil) then
            character:ComeIn();
        end
    end
end


FoodComposeCharacterMgr.GetCompleteOrders = function()
    return this.completeOrders;
end


this.RemoveGuest = function(index, dataIndex)
    this.guestDatas[dataIndex] = nil;
    table.remove(this.guestQueue, index, 1);
end


FoodComposeCharacterMgr.GetServeNum = function()
    return this.serveNum;
end


this.ClearCharacters = function()
    if (this.characterList ~= nil) then
        local len = #this.characterList;
        for i = 1, len do
            this.characterList[i]:Clear();
        end
    end
end


this.DestroyCharacters = function()
    if (this.characterList ~= nil) then
        local len = #this.characterList;
        for i = 1, len do
            this.characterList[i]:Destroy();
        end
        this.characterList = nil;
    end
end


this.CheckGuests = function()
    local index;
    local character;
    local foodIndexs;
    local len = #this.guestQueue;
    for i = 1, len do
        index = this.guestQueue[i];
        character = this.characterList[index];
        if (character ~= nil and character.data ~= nil and not character.isPlayAni) then
            foodIndexs = FoodComposeMgr.IsCompleteOrder(character.data.foods);
            if (foodIndexs ~= nil) then
                character:SetFoods();
                table.insert(this.completeOrders, character.data.order.Id);
                FoodComposeMgr.CostFoods(foodIndexs, character);
                this.RemoveGuest(i, index);
                this.serveNum = this.serveNum + 1;
                if (this.setServeNum ~= nil) then
                    this.setServeNum();
                end
                character:Leave(1);
            elseif (not character:CheckTime()) then
                this.RemoveGuest(i, index);
                character:Leave(0);
            else
                character:SetItems();
                character:SetFoods();
                character:SetComplete(false);
            end
        end
    end
    for i = 1, this.characterLen do
        character = this.characterList[i];
        if (character.data == nil and not character.isPlayAni and not character:IsCooling()) then
            FoodComposeCharacterMgr.GenGuests();
            break;
        end
    end
end


this.HasLevelType = function(order, level)
    local len = #order.LevelType;
    for i = 1, len do
        if (order.LevelType[i] == level) then
            return true;
        end
    end
    return false;
end


this.GetMixOrder = function()
    local sum = 0;
    local orderList = {};
    local level = DataMgr.Player.MixGame.Level;
    local mixOrderMap = ConfigMgr.Config.MixOrderMap;
    for _, v in pairs(mixOrderMap) do
        if (this.HasLevelType(v, level)) then
            sum = sum + v.Weight;
            table.insert(orderList, v);
        end
    end
    local order;
    local g = 0;
    local f = math.random(1, sum);
    local len = #orderList;
    for i = 1, len do
        order = orderList[i];
        g = g + order.Weight;
        if (g >= f) then
            return order;
        end
    end
    return orderList[len];
end


this.InitCharacters = function()
    this.characterConfigs = {};
    local characterTable = ConfigMgr.Config.characterTable;
    for _, v in pairs(characterTable) do
        if (v.Switch == 0) then
            table.insert(this.characterConfigs, v);
        end
    end
end


this.HasGuest =function(characterId)
    local guestData;
    for i = 1, this.characterLen do
        guestData = this.guestDatas[i];
        if (guestData ~= nil and guestData.character == characterId) then
            return true;
        end
    end
    return false;
end


this.GetGuestData = function()
    local size = #this.characterConfigs;
    if size==0 then size=1 end;
    local rindex = 1;
    local rcount = 100;
    local characterConfig;
    while (rindex <= rcount) do
        local index = math.random(1, size);
        characterConfig = this.characterConfigs[index];
        if (not this.HasGuest(characterConfig.id)) then
            break;
        end
        rindex = rindex + 1;
    end
    local order = this.GetMixOrder();
    local foods = {};
    local tlen = #order.Type;
    for i = 1, tlen do
        local count = order.Type[i][1];
        local content = table.Copy(order.Content[i]);
        if content~=nil and #content>0 then
            for j = 1, count do
                index = math.random(1, #content);
                local id = content[index];
                table.remove(content, index, 1);
                table.insert(foods, id);
            end
        end
    end
    local time = FoodComposeMgr.GameTime();
    local guestData = {
        character = characterConfig.id,
        order = order,
        foods = foods,
        startTime = time,
        endTime = time + order.WaitTime,
    };
    return guestData;
end