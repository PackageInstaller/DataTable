local BpPrivilegeLevel = CommonDefine.BpPrivilegeLevel
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local DiamondChargeItemTid = DT.GetConstant("DiamondChargeItemTid")
local STARNUM = 5
local WEAPONROLLDURATION = 5
local BpRechargeView, Super = NewClass("BpRechargeView", BaseView)
BpRechargeView.uiResCls = UI_Passport_Money_Item_NewResource

function BpRechargeView:ctor()
  Super.ctor(self)
  BpRechargeModel.Instance:OnInit()
end

function BpRechargeView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, function(items)
    if not items or type(items) ~= "table" then
      return
    end
    for _, item in pairs(items) do
      if item.tid == DiamondChargeItemTid then
        self:_RefreshView()
      end
    end
  end)
  self:BindEvent(EventMgr.Instance.BpPrivilegeLevelChange, function()
    self:_RefreshView()
  end)
end

function BpRechargeView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Privilege_1, function()
    Alert.ShowToolTips("PassportHoistTips1", self.ui.Btn_Privilege_1)
  end)
  self:AddButtonClickListener(self.ui.Btn_Privilege_2, function()
    Alert.ShowToolTips("PassportHoistTips2", self.ui.Btn_Privilege_2)
  end)
  self:AddButtonClickListener(self.ui.Btn_Privilege_3, function()
    Alert.ShowToolTips("PassportHoistTips3", self.ui.Btn_Privilege_3)
  end)
  self:AddButtonClickListener(self.ui.Btn_Unlock_Ordinary, System.fn(self, self.OnOrdinatyClick))
  self:AddButtonClickListener(self.ui.Btn_Unlock_Advance, System.fn(self, self.OnAdvanceClick))
end

function BpRechargeView:RefreshOnRendered()
end

function BpRechargeView:OnEnterView()
  Super.OnEnterView(self)
  self.rollWeaponRT = self.ui.Content_Roll_Weapon:GetComponent(TYPEOF_RectTransform)
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    BpModel.Instance:SetCurPage(BpModel.Instance.lastPage)
  end)
  self:SetImage(self.ui.Image_Bg, CommonDefine.BpBg.Other)
  self:_InitWeaponGroupView()
  self:_InitAdvanceRewardView()
  self:_InitDLCRewardView()
  self:_RefreshView()
  self:InitTimer()
  self:_InitCompCountDown()
end

function BpRechargeView:_RefreshView()
  BpRechargeModel.Instance:OnReset()
  self.advanceRewardView:ReloadData()
  self.advanceRewardView2:ReloadData()
  self.DLCRewardView:ReloadData()
  self.weaponGroupView:ReloadData()
  self:_InitCurrency()
  local bpPriceList = BattlePassDataUtils.GetBpPriceList()
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(bpPriceList[1]))
  local isEnough = self:CheckCurrencyEnough(CommonDefine.BpChargeKey.Ordinary)
  self:SetText(self.ui.Text_Medium_Ordinary, self:_GetOrdinaryPrice())
  self:SetText(self.ui.Text_Senior_Advance, self:_GetSeniorAdvancePrice())
  self:SetText(self.ui.Text_Senior_Discount, LT.Text(bpPriceList[CommonDefine.BpChargeKey.AdvancedDiscount]))
  self:SetTextColorType(self.ui.Text_Medium_Ordinary, isEnough and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light)
  self:SetTextColorType(self.ui.Text_Senior_Advance, self:_GetSeniorAdvanceTextColorType())
  local curPrivilegeLevel = BattlePassDataUtils.GetPrivilegeLevel()
  self:SetActive(self.ui.Text_Senior_Discount, curPrivilegeLevel == BpPrivilegeLevel.Ordinary)
  self:SetActive(self.ui.Group_Claimed_Ordinary, curPrivilegeLevel >= BpPrivilegeLevel.Advanced)
  self:SetActive(self.ui.Group_Medium_Ordinary, curPrivilegeLevel == BpPrivilegeLevel.Ordinary)
  self:SetActive(self.ui.Group_Claimed_Advance, curPrivilegeLevel == BpPrivilegeLevel.Core)
  self:SetActive(self.ui.Group_Senior_Advance, curPrivilegeLevel <= BpPrivilegeLevel.Advanced)
  self:SetActive(self.ui.Group_Medium_Advance, false)
  self:SetActive(self.ui.Group_Advance, curPrivilegeLevel == BpPrivilegeLevel.Ordinary)
  self:_RefreshRollWeaponView()
  local showStr = curPrivilegeLevel == BpPrivilegeLevel.Ordinary and LT.Text("PassportAdvanced_Txt") or LT.Text("PassportAdvancedPurchased_Txt")
  self:SetText(self.ui.Text_Additional, showStr)
  self:_RefreshHoistText()
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_C_Introduce)
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Hoist)
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Additional)
end

function BpRechargeView:_RefreshHoistText()
  local showStr
  local doubleHoist = BattlePassDataUtils.IsDoubleEx()
  if BattlePassDataUtils.GetPrivilegeLevel() == BpPrivilegeLevel.Ordinary then
    if doubleHoist then
      showStr = LT.Text("PassportHoistDouble_Txt")
    else
      showStr = LT.Text("PassportHoist_Txt")
    end
  elseif doubleHoist then
    showStr = LT.Text("PassportHoistDoubleUpgrade_Txt")
  else
    showStr = LT.Text("PassportHoistUpgrade_Txt")
  end
  local curPrivilegeLevel = BattlePassDataUtils.GetPrivilegeLevel()
  if curPrivilegeLevel == CommonDefine.BpPrivilegeLevel.Core then
    showStr = LT.Text("PassportHoistPurchased_Txt")
  end
  self:SetText(self.ui.Text_Hoist, showStr)
end

function BpRechargeView:_InitCompCountDown()
  self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  self.countDownTimer = self:BindTimer(1, -1, function()
    self:SetText(self.ui.Text_Time, LT.Textf("BPTimeFormat", BpModel.Instance:GetBpCountDown()))
  end)
end

function BpRechargeView:_InitWeaponGroupView()
  local cellRT = self.ui.UI_Passport_Weapon_Item.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.weaponGroupView = self:CreateTableview(self.ui.ScrollView_Weapon, function()
    if not BpRechargeModel.Instance.weaponList then
      return 0
    end
    return #BpRechargeModel.Instance.weaponList
  end, function(view, index)
    do return self._WeaponItemCellAtIndex, self, view end
    return self._WeaponItemCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.weaponGroupView.alignedOnStopMoving = true
  
  function self.weaponGroupView.onScrollValueChanged()
    local curIndex = self.weaponGroupView:GetCurrentIndex()
    BpRechargeModel.Instance:SetRollWeaponIdx(curIndex + 1)
    self:_RefreshRollWeaponView()
  end
end

function BpRechargeView:_WeaponItemCellAtIndex(view, index)
  local tid = BpRechargeModel.Instance.weaponList[index]
  if not tid or DT.Item[tid].Type ~= "Weapon" then
    return
  end
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Passport_Weapon_Item)
  self:CleanTimer()
  self:InitTimer()
  self:_AddWeaponItemViewComponent(cell.gameObject, index)
  return cell
end

function BpRechargeView:_InitAdvanceRewardView()
  local cellRT = self.ui.UI_Passport_Paidrewards_Item:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.advanceRewardView = self:CreateTableview(self.ui.ScrollView_Ordinary_Reward, function()
    if not BpRechargeModel.Instance.chargeAdvanceRewards then
      return 0
    end
    return #BpRechargeModel.Instance.chargeAdvanceRewards
  end, function(view, index)
    do return self._AdvanceRewardCellAtIndex, self, view end
    return self._AdvanceRewardCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.advanceRewardView2 = self:CreateTableview(self.ui.ScrollView_Advance_Reward, function()
    if not BpRechargeModel.Instance.chargeAdvanceRewards then
      return 0
    end
    return #BpRechargeModel.Instance.chargeAdvanceRewards
  end, function(view, index)
    do return self._AdvanceRewardCellAtIndex, self, view end
    return self._AdvanceRewardCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpRechargeView:_AdvanceRewardCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Passport_Paidrewards_Item)
  self:_AddRewardItemViewComponent(cell.gameObject, index, BpRechargeModel.Instance.chargeAdvanceRewards)
  return cell
end

function BpRechargeView:_InitDLCRewardView()
  local cellRT = self.ui.UI_Passport_Paidrewards_Item:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.DLCRewardView = self:CreateTableview(self.ui.ScrollView_Limit_Reward, function()
    if not BpRechargeModel.Instance.chargeDLCRewards then
      return 0
    end
    return #BpRechargeModel.Instance.chargeDLCRewards
  end, function(view, index)
    do return self._AdvanceDLCCellAtIndex, self, view end
    return self._AdvanceDLCCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpRechargeView:_AdvanceDLCCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Passport_Paidrewards_Item)
  self:_AddRewardItemViewComponent(cell.gameObject, index, BpRechargeModel.Instance.chargeDLCRewards)
  return cell
end

function BpRechargeView:_AddRewardItemViewComponent(item, index, rewards)
  local itemObj = require("UI.UIPackages.UI_Passport_Paidrewards_ItemResource")(item)
  local rewardData = rewards[index]
  local tid = rewardData.tid
  local num = rewardData.num
  self:SetText(itemObj.Text_Name, LT.Text(DT.Item[tid].Name))
  local viewData = {itemTid = tid, itemCount = num}
  self:AddViewComponentOnce(itemObj.UI_Passport_Inventory_Item, CompPublicIconItemType2, viewData)
end

function BpRechargeView:_AddWeaponItemViewComponent(item, index)
  local itemObj = require("UI.UIPackages.UI_Passport_Weapon_ItemResource")(item)
  local tid = BpRechargeModel.Instance.weaponList[index]
  if not tid or DT.Item[tid].Type ~= "Weapon" then
    self:SetActive(item, false)
    return
  end
  self:SetActive(item, true)
  local itemCfg = DT.Item[tid]
  local bigWeaponFrame = DT.ItemQuality[itemCfg.Quality].BigWeaponFrame
  self:SetImage(itemObj.Image_Weapon_Large, itemCfg.SpIcon)
  self:SetImage(itemObj.Image_Weapon_Quality, bigWeaponFrame)
  self:SetActive(itemObj.Image_Weapon_Quality, bigWeaponFrame)
  self:SetLongPressButtonIntervalTime(itemObj.Btn_Click, tonumber(DT.GetConstant("Role_Press_Time")))
  self:AddShortPressButtonListener(itemObj.Btn_Click, System.bind(self._OnWeaponShortClick, self, item, tid))
end

function BpRechargeView:_OnWeaponShortClick(item, tid)
  self:CleanTimer()
  ItemDataUtils.ShowItemDetailTips(self.binder, item, nil, tid, nil, {
    closeCb = System.fn(self, self.InitTimer),
    posX = 240
  })
end

function BpRechargeView:_RefreshRollWeaponView()
  local weaponList = BpRechargeModel.Instance.weaponList
  for i = 1, STARNUM do
    local darkItemObj = self.ui["Dark_" .. i]
    self:SetActive(darkItemObj, weaponList[i])
    local brightItemObj = self.ui["Bright_" .. i]
    self:SetActive(brightItemObj, BpRechargeModel.Instance.rollWeaponIdx == i)
  end
end

function BpRechargeView:RollWeapon(id)
  if not BpRechargeModel.Instance.weaponList or #BpRechargeModel.Instance.weaponList <= 0 then
    return
  end
  local tableViewIdx = id - 1
  local moveWithSpring = true
  if 1 == id or id > #BpRechargeModel.Instance.weaponList then
    id = 1
    tableViewIdx = 0
  end
  local offset = self.weaponGroupView:GetOffsetByIndex(tableViewIdx)
  self.weaponGroupView:SetOffset(offset, moveWithSpring)
  BpRechargeModel.Instance:SetRollWeaponIdx(id)
  self:_RefreshRollWeaponView()
end

function BpRechargeView:InitTimer()
  self.timer = self:BindTimer(WEAPONROLLDURATION, -1, function()
    self:RollWeapon(BpRechargeModel.Instance.rollWeaponIdx + 1)
  end)
end

function BpRechargeView:CleanTimer()
  self:StopTimer(self.timer)
  self.timer = nil
end

function BpRechargeView:_InitCurrency()
  local currencyList = DT.GetOriginalConstant("BPBuyCurrencies")
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function BpRechargeView:OnOrdinatyClick()
  local chargeKey
  if BattlePassDataUtils.GetPrivilegeLevel() == BpPrivilegeLevel.Ordinary then
    chargeKey = CommonDefine.BpChargeKey.Ordinary
  end
  if not chargeKey then
    return
  end
  if not self:CheckCurrencyEnough(chargeKey) then
    DiamondShopDataUtils.ChargeNotEnoughTips()
    return
  end
  local price = self:_GetOrdinaryPrice()
  BattlePassDataUtils.ExecuteBuyBp(chargeKey, System.fn(self, self.ChargeSuccessfulCB), nil, price)
end

function BpRechargeView:OnAdvanceClick()
  local chargeKey
  if BattlePassDataUtils.GetPrivilegeLevel() == BpPrivilegeLevel.Ordinary then
    chargeKey = CommonDefine.BpChargeKey.Advanced
  elseif BattlePassDataUtils.GetPrivilegeLevel() == BpPrivilegeLevel.Advanced then
    chargeKey = CommonDefine.BpChargeKey.Core
  end
  if not chargeKey then
    return
  end
  if not self:CheckCurrencyEnough(chargeKey) then
    DiamondShopDataUtils.ChargeNotEnoughTips()
    return
  end
  local dailyNotGainExtraReward = BattlePassDataUtils.GetDailyNotGainExtraReward()
  local needPreview = table.next(dailyNotGainExtraReward)
  BattlePassDataUtils.ExecuteBuyBp(chargeKey, System.fn(self, self.ChargeSuccessfulCB), needPreview, self:_GetSeniorAdvancePrice())
end

function BpRechargeView:ChargeSuccessfulCB()
  self:_RefreshView()
  BpModel.Instance:SetCurPage(BpModel.Instance.lastPage)
  Alert.ShowStr(LT.Text("BPChargeSuccessfulTips"))
end

function BpRechargeView:CheckCurrencyEnough(chargeKey)
  local bpPriceList = BattlePassDataUtils.GetBpPriceList()
  local haveNum = ItemDataUtils.GetItemNum(bpPriceList[1])
  local costNum = bpPriceList[chargeKey]
  return haveNum >= costNum
end

function BpRechargeView:_GetOrdinaryPrice()
  local bpPriceList = BattlePassDataUtils.GetBpPriceList()
  return bpPriceList[CommonDefine.BpChargeKey.Ordinary]
end

function BpRechargeView:_GetSeniorAdvancePrice()
  local bpPriceList = BattlePassDataUtils.GetBpPriceList()
  if BattlePassDataUtils.GetPrivilegeLevel() < BpPrivilegeLevel.Advanced then
    return bpPriceList[CommonDefine.BpChargeKey.Advanced]
  end
  return bpPriceList[CommonDefine.BpChargeKey.Core]
end

function BpRechargeView:_GetSeniorAdvanceTextColorType()
  if BattlePassDataUtils.GetPrivilegeLevel() < BpPrivilegeLevel.Advanced then
    return self:CheckCurrencyEnough(CommonDefine.BpChargeKey.Advanced) and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  end
  return self:CheckCurrencyEnough(CommonDefine.BpChargeKey.Core) and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
end

function BpRechargeView:OnEnterViewFinished()
end

function BpRechargeView:OnExitView()
  Super.OnExitView(self)
end

return BpRechargeView
