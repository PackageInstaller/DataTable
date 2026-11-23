FoodComposeCharacterItem = {};

FoodComposeCharacterItem.__index = FoodComposeCharacterItem;

local normalColor = UnityEngine.Color(1,1,1,1);
local leaveColor = UnityEngine.Color(1,1,1,0);

local objs = {
    body = { path = "Mask/Body", type = "UISpineCharacter" },
    bodyImg = { path = "Mask/Body", type = "RawImage" },
    maskGO = { path = "Mask", type = "GameObject" },
    maskTF = { path = "Mask", type = "Transform" },
    timeGO = { path = "Time", type = "GameObject" },
    timeBar = { path = "Time/Bar", type = "Image" },
    timeText = { path = "Time/Text", type = "Text" },
    itemsGO = { path = "Items", type = "GameObject" },
    itemsListTF = { path = "Items/List", type = "Transform" },
    foodsListGO = { path = "Table/Foods", type = "GameObject" },
    foodsListTF = { path = "Table/Foods", type = "Transform" },
    msgGO = { path = "Msg", type = "GameObject" },
    msgText = { path = "Msg/Text", type = "Text" },
    complete = { path = "Complete", type = "GameObject" },
}

function FoodComposeCharacterItem.New(prefab, parent, foodPrefab, index)
    local self = {};
    setmetatable(self, FoodComposeCharacterItem);
    self.foodPrefab = foodPrefab;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform;
    self.transform.localPosition = Vector3(-315 + (index - 1) * 306, 18, 0);
    UITool.Parse(self.gameObject, self, objs);
    self.maskPos = self.maskTF.localPosition;
    self.itemList = {};
    self.foodList = {};
    self.OnCharacter = function()
        self.body:Play("idle", true, nil);
    end
    self.isPlayAni = false;
    self.OnLeaveComplete = function()
        self:ClearTween();
        self.coolTime = FoodComposeMgr.GameTime() + ConfigMgr.Config.MixConstants.WaitTime;
        self.isPlayAni = false;
    end
    self.OnTweenComplete = function()
        self:ClearItems();
        SetActive(self.itemsGO, false);
        SetActive(self.timeGO, false);
        SetActive(self.msgGO, false);
        self:SetComplete(false);
        self:ClearFoods();
        self.timeText.text = "";
    end
    self.ShowComplete = function()
        self:SetComplete(true);
    end
    self.coolTime = 0;
    self.OnComeInComplete = function()
        self:ClearTween();
        self:SetInfo(true);
        self.isPlayAni = false;
    end
    return self;
end

function FoodComposeCharacterItem:SetData(data)
    self.data = data;
    local skinId = data.character .. "001";
    self.body:SetBattle(data.character, skinId, "-1", 0, self.OnCharacter);
    self:ClearTween();
    self.maskTF.localPosition = self.maskPos;
    self.bodyImg.color = normalColor;
    self:SetItems();
    self:SetFoods();
    self:SetInfo(false);
    self.isPlayAni = false;
    SetActive(self.msgGO, false);
    self:SetComplete(false);
end

function FoodComposeCharacterItem:IsCooling()
    if (self.isPlayAni) then return true end
    
    return FoodComposeMgr.GameTime() < self.coolTime;
end

function FoodComposeCharacterItem:SetInfo(status)
    SetActive(self.maskGO, status);
    SetActive(self.timeGO, status);
    SetActive(self.itemsGO, status);
    SetActive(self.foodsListGO, status);
end

function FoodComposeCharacterItem:SetComplete(status)
    SetActive(self.complete, status);
end

function FoodComposeCharacterItem:SetItems()
    local item;
    local itemData;
    local rewardItem;
    local rewardItems = self.data.order.Reward;
    local len = #rewardItems;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.itemsListTF);
            self.itemList[i] = item;
        end
        rewardItem = rewardItems[i];
        itemData = table.Copy(ConfigMgr.Config.itemMap[rewardItem.id]);
        itemData.count0 = rewardItem.count;
        item:SetData(1, itemData, 1, false, Vector3(0.4, 0.4, 1), false);
        item:SetIconBg(false);
    end
    local rlen = #self.itemList;
    for i = len + 1, rlen do
        self.itemList[i]:Hide();
    end
end

function FoodComposeCharacterItem:ClearItems()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function FoodComposeCharacterItem:SetFoods()
    local foodItem;
    local len = #self.data.foods;
    for i = 1, len do
        foodItem = self.foodList[i];
        if (foodItem == nil) then
            foodItem = FoodComposeCharacterFoodItem.New(self.foodPrefab, self.foodsListTF);
            self.foodList[i] = foodItem;
        end
        local food = self.data.foods[i];
        local foodConfig = FoodComposeMgr.GetFoodConfig(food);
        if (foodConfig ~= nil) then
            foodItem:SetData(foodConfig, FoodComposeMgr.GetFoodCount(food));
        end
    end
    local flen = #self.foodList;
    for i = len + 1, flen do
        self.foodList[i]:Clear();
    end
end

function FoodComposeCharacterItem:ClearFoods()
    local len = #self.foodList;
    for i = 1, len do
        self.foodList[i]:Clear();
    end
end

function FoodComposeCharacterItem:GetFoodItem(id)
    local food;
    local len = #self.foodList;
    for i = 1, len do
        food = self.foodList[i];
        if (food.data ~= nil and food.data.Id == id) then
            return food;
        end
    end
    return nil;
end

function FoodComposeCharacterItem:CheckTime()
    local nowTime = FoodComposeMgr.GameTime();
    if (nowTime < self.data.endTime) then
        local h, m, s = GetTimeHMS(math.ceil(self.data.endTime - nowTime));
        self.timeText.text = string.format("%s:%s", m, s);
        local rate = (nowTime - self.data.startTime) / (self.data.endTime - self.data.startTime);
        self.timeBar.fillAmount = 1 - rate;
        return true;
    end
    self.timeText.text = "00:00";
    return false;
end

function FoodComposeCharacterItem:ComeIn()
    self:ClearTween();
    self.isPlayAni = true;
    self.maskTF.localPosition = Vector3(180, 106, 0);
    self.maskTween = self.maskTF:DOLocalMoveX(20, 1):SetEase(CS.DG.Tweening.Ease.InOutCubic);
    self.maskTween.onComplete = self.OnComeInComplete;
    self.bodyImg.color = leaveColor;
    self.bodyTween = self.bodyImg:DOColor(normalColor, 1):SetEase(CS.DG.Tweening.Ease.InOutCubic);
    SetActive(self.maskGO, true);
end

function FoodComposeCharacterItem:Leave(type)
    self.data = nil;
    self.isPlayAni = true;
    SetActive(self.itemsGO, false);
    local mixConstants = ConfigMgr.Config.MixConstants;
    if (type == 1) then
        local index = math.random(1, #mixConstants.GoodEvaluate);
        self.msgText.text = ConfigMgr.LangGlobal(mixConstants.GoodEvaluate[index]);
    else
        local index = math.random(1, #mixConstants.BadEvaluate);
        self.msgText.text = ConfigMgr.LangGlobal(mixConstants.BadEvaluate[index]);
    end
    SetActive(self.msgGO, true);
    self:ClearTween();
    self.tween = DOTWeen.To(function() return 0 end, function(value) end, 1, 2);
    self.tween.onComplete = self.OnTweenComplete;
    self.maskTween = self.maskTF:DOLocalMoveX(-160, 1):SetDelay(2):SetEase(CS.DG.Tweening.Ease.InOutCubic);
    self.maskTween.onComplete = self.OnLeaveComplete;
    self.bodyTween = self.bodyImg:DOColor(leaveColor, 1):SetDelay(2):SetEase(CS.DG.Tweening.Ease.InOutCubic);
end

function FoodComposeCharacterItem:ClearTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
    if (self.maskTween ~= nil) then
        self.maskTween:Kill(false);
        self.maskTween = nil;
    end
    if (self.bodyTween ~= nil) then
        self.bodyTween:Kill(false);
        self.bodyTween = nil;
    end
end

function FoodComposeCharacterItem:Clear()
    self.data = nil;
    self:ClearTween();
end

function FoodComposeCharacterItem:Destroy()
    self:ClearTween();
    if (self.body ~= nil) then
        self.body:Clear();
        self.body = nil;
    end
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
        self.itemList = nil;
    end
    if (self.foodList ~= nil) then
        local len = #self.foodList;
        for i = 1, len do
            self.foodList[i]:Destroy();
        end
        self.foodList = nil;
    end
    self.maskPos = nil;
    self.OnCharacter = nil;
    self.foodPrefab = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end