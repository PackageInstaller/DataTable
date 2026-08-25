local LimitTimeGiftItem, Super = System.NewComponent("LimitTimeGiftItem")

function LimitTimeGiftItem:ctor(gameObj, activityTid, taskId, preTaskId, nextTaskId)
  Super.ctor(self)
  self.ui = UI_Events_Item_GiftBagResource(gameObj)
  self.activityTid = activityTid
  self.taskId = taskId
  self.preTaskId = preTaskId
  self.nextTaskId = nextTaskId
end

function LimitTimeGiftItem:OnBind(binder)
  self.binder = binder
  self:SetItems(self.taskId)
  self:SetShopItemAndPrice()
  binder:BindToVisible(self.ui.Btn_Buy, function()
    do return self.IsShowBuyBtn end
    return self.IsShowBuyBtn, self
  end)
  binder:BindButtonClick(self.ui.Btn_Buy, System.fn(self, self.OnBtnBuy))
  binder:BindToVisible(self.ui.Btn_Recieve, function()
    do return self.IsShowReceive end
    return self.IsShowReceive, self
  end)
  binder:BindZ1Button(self.ui.Btn_Recieve, System.fn(self, self.OnBtnRecieve), System.fn(self, self.GetBtnRecieveState))
  binder:BindToVisible(self.ui.Image_Soldout, function()
    do return self.IsSoldout end
    return self.IsSoldout, self
  end)
  binder:BindToRaw(function()
    binder:SetActive(self.ui.Image_Dark, TaskDataUtils.GetTaskPrice(self.taskId) == nil)
    binder:SetActive(self.ui.Dark_Bg, not self:IsSoldout())
    binder:SetActive(self.ui.Dark_Open, self:IsSoldout())
    binder:SetActive(self.ui.Image_Bright, TaskDataUtils.GetTaskPrice(self.taskId) ~= nil)
    binder:SetActive(self.ui.Bright_Bg, not self:IsSoldout())
    binder:SetActive(self.ui.Bright_Open, self:IsSoldout())
  end, function()
    do return self.IsSoldout end
    return self.IsSoldout, self
  end)
  binder:BindToVisible(self.ui.Image_CurRecieve, function()
    do return TaskDataUtils.TaskFinshAndGetedAward end
    return TaskDataUtils.TaskFinshAndGetedAward, self.taskId
  end)
  binder:BindToVisible(self.ui.Image_NextRecieve, function()
    if self.nextTaskId then
      do return TaskDataUtils.TaskFinshAndGetedAward end
      return TaskDataUtils.TaskFinshAndGetedAward, self.nextTaskId
    end
    do return TaskDataUtils.TaskFinshAndGetedAward end
    return TaskDataUtils.TaskFinshAndGetedAward, self.taskId
  end)
end

function LimitTimeGiftItem:IsShowBuyBtn()
  if TaskDataUtils.IsTaskDoneByTaskId(self.taskId) then
    return false
  end
  local shopItem = TaskDataUtils.GetNeededShopItem(self.taskId)
  if shopItem then
    return true
  end
end

function LimitTimeGiftItem:IsSoldout()
  do return TaskDataUtils.TaskFinshAndGetedAward end
  return TaskDataUtils.TaskFinshAndGetedAward, self.taskId
end

function LimitTimeGiftItem:IsShowReceive()
  return not self:IsShowBuyBtn() and not self:IsSoldout()
end

function LimitTimeGiftItem:OnBtnBuy()
  if not self:IsPreTaskCompleteAndGot() then
    Alert.Show(10491)
    return
  end
  local shopItem = TaskDataUtils.GetNeededShopItem(self.taskId)
  local price, priceItem = TaskDataUtils.GetTaskPrice(self.taskId)
  if not price or not priceItem then
    return
  end
  if not ItemDataUtils.IsItemEnough(priceItem, price, true) then
    return
  end
  Alert.ShowPayMoneyBuyConfirm(price, function()
    MainShopDataUtils.ReqBuyItem(shopItem, 1, function(data)
      self:OnBtnRecieve()
    end)
  end)
end

function LimitTimeGiftItem:IsPreTaskCompleteAndGot()
  if not self.preTaskId then
    return true
  end
  do return TaskDataUtils.TaskFinshAndGetedAward end
  return TaskDataUtils.TaskFinshAndGetedAward, self.preTaskId
end

function LimitTimeGiftItem:GetBtnRecieveState()
  if TaskDataUtils.IsTaskCanReward(self.taskId) and self:IsPreTaskCompleteAndGot() then
    return cd.Z1ButtonState.Normal
  end
  return cd.Z1ButtonState.High
end

function LimitTimeGiftItem:OnBtnRecieve()
  if not self:IsPreTaskCompleteAndGot() then
    Alert.Show(10491)
    return
  end
  ActivityDataUtils.ReqGainAward(self.activityTid, self.taskId, {}, function(result)
    EventMgr.Instance.OnLimitGiftReward:Dispatch()
  end)
end

function LimitTimeGiftItem:SetShopItemAndPrice()
  local price, priceItem = TaskDataUtils.GetTaskPrice(self.taskId)
  if priceItem then
    self.binder:SetImage(self.ui.Image_Item, ItemDataUtils.GetIcon(priceItem))
    self.binder:BindToText(self.ui.Text_Price, function()
      return ItemDataUtils.IsItemEnough(priceItem, price) and price or string.format("<color=#FA3A50>%s</color>", price)
    end)
  end
end

function LimitTimeGiftItem:SetItems(taskId)
  local rewards = TaskDataUtils.GetTaskCompleteAward(taskId)
  local itemIndex = 1
  for _, rewardInfo in ipairs(rewards) do
    local gameObj = self.ui["reward_" .. itemIndex]
    self.binder:SetActive(gameObj, true)
    self.binder:BindComponent(LimitTimeGiftAwardItem(gameObj, rewardInfo.tid, rewardInfo.num, taskId, self.preTaskId))
    itemIndex = itemIndex + 1
    local rewardUI = UI_Events_Item_GiftBagAwardResource(gameObj)
    self.binder:SetActive(rewardUI.Image_Bright, TaskDataUtils.GetTaskPrice(taskId) ~= nil)
    self.binder:SetActive(rewardUI.Image_Dark, TaskDataUtils.GetTaskPrice(taskId) == nil)
  end
  local maxShowCount = 5
  for i = itemIndex, maxShowCount do
    local gameObj = self.ui["reward_" .. i]
    if gameObj and not IsNil(gameObj) then
      self.binder:SetActive(gameObj, false)
    end
  end
end

return LimitTimeGiftItem
