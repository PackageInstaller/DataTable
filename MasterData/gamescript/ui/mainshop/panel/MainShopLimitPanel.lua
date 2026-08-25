local MainShopLimitPanel, Super = System.NewClass("MainShopLimitPanel", ActivityBasePanel)
MainShopLimitPanel.uiResCls = UI_Recharge_Panel_GiftBagResource

function MainShopLimitPanel:ctor(giftList, gotoIndex, closeCb)
  Super.ctor(self)
  self.giftList = giftList
  self.showIndex = Vue.ref(gotoIndex or 1)
  self.closeCb = closeCb
  if not self.giftList[self.showIndex.value] then
    self.showIndex.value = 1
  end
  self.taskIdList = {}
  self.dotObjList = {}
end

function MainShopLimitPanel:OnBind(binder)
  self.binder = binder
  self:CreateGiftTableView()
  binder:BindToRaw(function(cbinder, index)
    self:BindDetail(cbinder, index)
  end, function()
    return self.showIndex.value
  end)
  self:BindBtns()
  binder:BindEvent(EventMgr.Instance.OnLimitGiftReward, System.fn(self, self.OnLimitGiftReward))
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnRewardPanelClose))
  self:ClearStaleLimitGiftPopUpClientData()
end

function MainShopLimitPanel:_RefreshDotGroup()
  if not (self.ui and self.ui.Dark) or not self.ui.Group_Dot then
    return
  end
  local giftNum = 0
  for idx, _ in ipairs(self.giftList) do
    giftNum = giftNum + 1
    local dotObj = self.dotObjList[idx]
    if not dotObj or IsNil(dotObj) then
      dotObj = self.binder:Instantiate(self.ui.Dark, self.ui.Group_Dot.transform)
      self.dotObjList[idx] = dotObj
    end
    dotObj:SetActive(#self.giftList > 1)
    local brightGo = CS.Framework.GameObjectUtil.FindChildByPath(dotObj, "Bright")
    if brightGo then
      brightGo:SetActive(self.showIndex.value == idx)
    end
  end
  if giftNum < #self.dotObjList then
    for idx = giftNum + 1, #self.dotObjList do
      local dotObj = self.dotObjList[idx]
      if dotObj and not IsNil(dotObj) then
        dotObj:SetActive(false)
      end
    end
  end
end

function MainShopLimitPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.closeCb then
    self.closeCb()
  end
end

function MainShopLimitPanel:ClearStaleLimitGiftPopUpClientData()
  local subTable = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.LimitGiftPopUp)
  if not subTable or next(subTable) == nil then
    return
  end
  local toRemove = {}
  for subKey in pairs(subTable) do
    local actId = tonumber(subKey)
    if actId and not ActivityDataUtils.IsActivityOpen(actId) then
      table.insert(toRemove, subKey)
    end
  end
  if #toRemove > 0 then
    ClientDataUtils.DelSubKeys(cd.ClientDataMainKey.LimitGiftPopUp, toRemove, true)
  end
end

function MainShopLimitPanel:BindBtns()
  self.binder:SetActive(self.ui.Group_UP, #self.giftList > 1)
  self.binder:SetActive(self.ui.Group_Down, #self.giftList > 1)
  self.binder:BindButtonClick(self.ui.Btn_Click_UP, function()
    if self.showIndex.value <= 1 then
      self.showIndex.value = #self.giftList
    else
      self.showIndex.value = self.showIndex.value - 1
    end
  end)
  self.binder:BindButtonClick(self.ui.Btn_Click_Down, function()
    if self.showIndex.value >= #self.giftList then
      self.showIndex.value = 1
    else
      self.showIndex.value = self.showIndex.value + 1
    end
  end)
  self.binder:BindToVisible(self.ui.Image_RedDotLeft, function()
    for i = 1, self.showIndex.value - 1 do
      if ActivityDataUtils.IsHaveLimitTimeReward(self.giftList[i].activityTid) then
        return true
      end
    end
  end)
  self.binder:BindToVisible(self.ui.Image_RedDotRight, function()
    for i = self.showIndex.value + 1, #self.giftList do
      if ActivityDataUtils.IsHaveLimitTimeReward(self.giftList[i].activityTid) then
        return true
      end
    end
  end)
end

function MainShopLimitPanel:SetIndex(index)
  local activityData = self.giftList[index]
  self.activityData = activityData
  self.activityTid = activityData.activityTid
  self.activityCfg = DT.Activity[self.activityTid]
  self.taskIdList = table.clone(self.activityCfg.ActivityPara1)
end

function MainShopLimitPanel:BindDetail(binder, index)
  self:SetIndex(index)
  self:_RefreshDotGroup()
  local isFirstTimeLimitedSale = self.activityCfg.ActivityType == ActivityDefine.ActivityType.FirstTimeLimitedSale
  binder:SetActive(self.ui.Time, not isFirstTimeLimitedSale)
  binder:SetActive(self.ui.Group_NormalGiftbag, not isFirstTimeLimitedSale)
  binder:SetActive(self.ui.Group_SpecialGiftBag, isFirstTimeLimitedSale)
  if isFirstTimeLimitedSale then
    self:_SetFirstTimeLimitedSale(binder)
  else
    self.needReOffset = false
    self.giftTableView:ReloadData()
    self.giftTableView:SetOffset(self:GetFirstRewardOffset(), false)
    binder:BindTimer(0.05, 0, nil, function()
      self.giftTableView:SetOffset(self:GetFirstRewardOffset(), false)
    end)
  end
  binder:SetText(self.ui.Text_Title, self.activityCfg.ActivityName)
  binder:SetText(self.ui.Text_Tip_Awaker, self.activityCfg.ActivityPlot)
  binder:SetText(self.ui.Text_Tip_Chapter, self.activityCfg.ActivityPlot)
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  binder:BindToCanvasGroup(self.ui.Image_Bg_Awaker, function()
    return self.activityCfg.ShowAwaker ~= nil and 1 or 0
  end)
  binder:SetActive(self.ui.Image_Bg_Chapter, self.activityCfg.ShowAwaker == nil)
  if self.activityCfg.ActivityPicture then
    binder:SetImageSync(self.ui.Image_Bg_Chapter, self.activityCfg.ActivityPicture)
  end
  self:_RefreshDotGroup()
end

function MainShopLimitPanel:OnLimitGiftReward()
  self.needReOffset = true
end

function MainShopLimitPanel:_SetFirstTimeLimitedSale(binder)
  local shopItemId = self.activityCfg.ActivityPara1[1]
  local shopItemCfg = DT.Shop[shopItemId]
  assert(shopItemCfg, string.format("shop id %s not found", shopItemId))
  local chargeGroup = shopItemCfg.Price[1]
  local chargeId = ShopDataUtils.GetChargeIdByChargeGroup(chargeGroup, true)
  local chargeCfg = chargeId and ShopDataUtils.GetChargeCfgById(chargeId)
  assert(chargeCfg, string.format("charge id %s not found", chargeId))
  local itemGetMap = chargeCfg.ItemGet
  local itemGetList = {}
  for itemTid, itemCount in pairs(itemGetMap) do
    table.insert(itemGetList, {itemTid = itemTid, itemCount = itemCount})
  end
  table.sort(itemGetList, function(a, b)
    return a.itemTid < b.itemTid
  end)
  binder:SetActive(self.ui.UI_Common_Item_WuPin_Type2, false)
  for _, itemData in ipairs(itemGetList) do
    local rewardGo = binder:Instantiate(self.ui.UI_Common_Item_WuPin_Type2, self.ui.RewardCon.transform)
    rewardGo:SetActive(true)
    binder:BindComponent(CommonIconItemType2(rewardGo, itemData))
  end
  binder:SetText(self.ui.Text_C_Desc, self.activityCfg.ActivityPlot)
  binder:SetText(self.ui.Text_GiftBagPrice, ShopDataUtils.GetChargePriceStr(chargeId))
  binder:BindButtonClick(self.ui.Btn_BuySpecialGiftBag, function()
    SdkMgr.Instance:Pay(chargeCfg.PayCode, chargeCfg.ID)
  end)
  binder:SetText(self.ui.Text_GotSpecialGift, LT.Text("TextAlreadyReceived"))
  binder:BindToVisible(self.ui.Btn_BuySpecialGiftBag, function()
    local activityData = ActivityDataUtils.GetActivityData(self.activityTid)
    return activityData and 0 == activityData.base.hideTs
  end)
  binder:BindToVisible(self.ui.Group_GotSpecialGift, function()
    local activityData = ActivityDataUtils.GetActivityData(self.activityTid)
    return not activityData or 0 ~= activityData.base.hideTs
  end)
end

function MainShopLimitPanel:OnRewardPanelClose(panelUrl)
  if panelUrl == Urls.ShowRewardPanel and self.needReOffset then
    local offset = self.giftTableView:GetOffset()
    local maxOffset = self.giftTableView:GetMaxOffset()
    local delta = self.ui.UI_Recharge_Item_GiftBag.transform.sizeDelta.y
    if delta < math.abs(maxOffset - offset) then
      self.giftTableView:SetOffset(offset + delta, true)
    end
  end
end

function MainShopLimitPanel:GetFirstRewardOffset()
  local rewardIndex = 1
  for index, taskId in ipairs(self.taskIdList) do
    if not TaskDataUtils.TaskFinshAndGetedAward(taskId) then
      rewardIndex = index
      break
    end
  end
  local centerIndex = 2
  if 1 == rewardIndex or rewardIndex == centerIndex then
    return 0
  end
  local offset = (rewardIndex - centerIndex) * self.ui.UI_Recharge_Item_GiftBag.transform.sizeDelta.y
  return offset
end

function MainShopLimitPanel:CreateGiftTableView()
  local baseGameObj = self.ui.UI_Recharge_Item_GiftBag
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.giftTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self.taskIdList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskId, preTaskId, nextTaskId = self.taskIdList[idx], self.taskIdList[idx - 1], self.taskIdList[idx + 1]
    itemComps[gameObj] = self.binder:BindComponent(LimitTimeGiftItem(gameObj, self.activityTid, taskId, preTaskId, nextTaskId))
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function MainShopLimitPanel:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  local leftTime = ActivityDataUtils.GetLeftTime(self.activityData) or 0
  if leftTime <= 0 then
    if self.activityData.endTime > 0 and self.activityData.endTime < TimeUtils.GetServerTime() then
      self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    end
    return
  end
  self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  if self._activityTimer then
    self.binder:StopTimer(self._activityTimer)
  end
  self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  self.binder:SetText(self.ui.Text_SpecialBagTime, TimeUtils.format(leftTime, CommonDefine.TimeParseType.hms))
  self._activityTimer = self.binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      self:Close()
      return
    end
    self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
    self.binder:SetText(self.ui.Text_SpecialBagTime, TimeUtils.format(leftTime, CommonDefine.TimeParseType.hms))
  end, function()
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    self.binder:SetText(self.ui.Text_SpecialBagTime, LT.Text("ActivityTimeExpired"))
    self:_ClearTimer()
    self:Close()
  end)
end

return MainShopLimitPanel
