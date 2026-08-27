local UIEpStoreRoom = class("UIEpStoreRoom", UIBaseWindow)
local base = UIBaseWindow
local UINEpStoreRoomSellList = require("Game.Exploration.UI.StoreRoom.UINEpStoreRoomSellList")
local UINEpStoreRoomBuyList = require("Game.Exploration.UI.StoreRoom.UINEpStoreRoomBuyList")
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local UINEpBuffDetail = require("Game.Exploration.UI.StoreRoom.UINEpBuffDetail")
local cs_MessageCommon = CS.MessageCommon
local StoreType = {eBuy = 1, eSell = 2}

function UIEpStoreRoom:OnInit()
  UIUtil.SetTopStatus(self, self.OnStoreSkipClicked, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnStoreSkipClicked)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnStoreBuyClicked)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnStoreMapClicked)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnBtnEpStoreRefresh)
  self._onStoreBuyClicked = BindCallback(self, self.OnStoreBuyClicked)
  self.resloader = CS.ResLoader.Create()
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.chipItemDetail)
  self.epBuffDetail = UINEpBuffDetail.New()
  self.epBuffDetail:Init(self.ui.uINEpBuffDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  UIUtil.AddButtonListener(self.ui.btn_BuyTypeItem, self, self.LoadStoreData)
  UIUtil.AddButtonListener(self.ui.btn_SellTypeItem, self, self.LoadChipOwnData)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self:__ShowDetailSellOutUI(false)
  self.buyListNode = UINEpStoreRoomBuyList.New(self)
  self.buyListNode:Init(self.ui.buyList)
  self.sellListNode = UINEpStoreRoomSellList.New(self)
  self.sellListNode:Init(self.ui.sellList)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:TrySetLimitSellBtnActive(false)
  end
end

function UIEpStoreRoom:OnShow()
  base.OnShow(self)
end

function UIEpStoreRoom:OnHide()
  base.OnHide(self)
end

function UIEpStoreRoom:InitStoreRoom(storeCtrl, storeDataList)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self.storeCtrl = storeCtrl
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  self.roomId = epTypeCfg.store_pool
  local needReFill = self.storeDataList == nil or #self.storeDataList ~= #storeDataList
  self.MoneyIconId = ExplorationManager:GetDynPlayer():GetMoneyIconId()
  self.ui.img_Money.sprite = CRH:GetSprite(self.MoneyIconId)
  self.discCountLimitTimes = self.storeCtrl.roomData.storeRoomData.discCountLimitTimes
  self.storeDataList = storeDataList
  self:LoadStoreData()
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
  if self.discCountLimitTimes <= 0 then
    self:SetDiscountUIActive(false)
  else
    self.ui.tex_Discount:SetIndex(0, tostring(self.discCountLimitTimes))
  end
end

function UIEpStoreRoom:LoadStoreData()
  self:SwitchStoreTypeUI(StoreType.eBuy)
  self.buyListNode:InitEpStoreRoomBuyList(self.storeDataList)
end

function UIEpStoreRoom:GetExitButton()
  return self.ui.btn_Skip
end

function UIEpStoreRoom:LoadChipOwnData()
  self:SwitchStoreTypeUI(StoreType.eSell)
  self.chipList = ExplorationManager:GetDynPlayer():GetChipList()
  self.sellListNode:InitEpStoreRoomSell(self.chipList)
end

function UIEpStoreRoom:__onChipListUpdate(chipList)
  self.chipList = chipList
  if self.storeType == StoreType.eSell then
    self.sellListNode:InitEpStoreRoomSell(chipList)
  end
end

function UIEpStoreRoom:SwitchStoreTypeUI(storeType)
  self.storeType = storeType
  self.epBuffDetail:Hide()
  if self.storeType == StoreType.eBuy then
    self.ui.buyTypeImg:SetIndex(0)
    self.ui.buyTypeText.color = Color.black
    self.ui.sellTypeImg:SetIndex(1)
    self.ui.sellTypeText.color = Color.white
    self.buyListNode:Show()
    self.sellListNode:Hide()
  elseif self.storeType == StoreType.eSell then
    self.ui.sellTypeImg:SetIndex(0)
    self.ui.sellTypeText.color = Color.black
    self.ui.buyTypeImg:SetIndex(1)
    self.ui.buyTypeText.color = Color.white
    self.buyListNode:Hide()
    self.sellListNode:Show()
  end
  self.ui.btn_Refresh.gameObject:SetActive(self.storeType == StoreType.eBuy)
  local showDiscount = self.storeType == StoreType.eBuy and 0 < self.discCountLimitTimes
  self:SetDiscountUIActive(showDiscount)
  self:__ShowDetailSellOutUI(false)
end

function UIEpStoreRoom:SetDiscountUIActive(active)
  self.ui.tex_Discount.transform.parent.gameObject:SetActive(active)
end

function UIEpStoreRoom:OnSelectStoreBuffItem(buffItem)
  buffItem:SetStoreBuffItemSelect(true)
  self:RefreshBuySelectItemDetail(buffItem.epStoreItemData.idx, buffItem.price)
end

function UIEpStoreRoom:OnSelectStoreChipItem(storeItem)
  storeItem:SetStoreItemSelect(true)
  storeItem.chipItem:RefreshLevelTween()
  if self.storeType == StoreType.eBuy then
    self:RefreshBuySelectItemDetail(storeItem.epStoreItemData.idx, storeItem.price)
  elseif self.storeType == StoreType.eSell then
    self:RefreshSelectItemDetailSoldOut(storeItem.index)
  end
end

function UIEpStoreRoom:RefreshBuySelectItemDetail(index, price)
  self.chipDetailPanel:Hide()
  local storeData = self.storeDataList[index]
  if storeData == nil then
    self.ui.btn_Buy.gameObject:SetActive(false)
    return
  end
  if storeData.chipData ~= nil then
    self:_RefreshBuyChipDetail(index, storeData.chipData, price, storeData.saled)
  elseif storeData.epBuffData ~= nil then
    self:_RefreshBuyBuffDetail(storeData.epBuffData)
  end
  self.ui.btn_Buy.gameObject:SetActive(not storeData.saled)
  self:__ShowDetailSellOutUI(storeData.saled)
  self.currMoney = ExplorationManager:GetDynPlayer():GetMoneyCount()
  self.itemPrice = price
  local couldLoanMoney = ExplorationManager.epCtrl.campFetterCtrl:GetCouldLeonMoney()
  self.isLack = self.currMoney + couldLoanMoney < self.itemPrice and self.itemPrice > 0
  self:__SetLackState(self.isLack)
  local refreshCostNum = self.storeCtrl:GetEpStoreRefreshPrice()
  local isLack = false
  local currMoney = self.storeCtrl.dynPlayer:GetItemCount(self.storeCtrl.currencyId)
  if 0 < refreshCostNum and refreshCostNum > currMoney then
    isLack = true
  end
  self.ui.tex_Money:SetIndex(1, tostring(self.itemPrice))
  self.ui.obj_RefreshLack:SetActive(isLack)
  self.ui.tex_RefreshPay.text = tostring(refreshCostNum)
  self.ui.tex_Refresh:SetIndex(isLack and 1 or 0)
end

function UIEpStoreRoom:_RefreshBuyChipDetail(index, chipData, price, saled)
  self.epBuffDetail:Hide()
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(index, chipData, self.storeCtrl.dynPlayer, self.resloader)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  self.chipDetailPanel:ShowEpChipDetailEff(5)
  local isHadChip = self.storeCtrl.dynPlayer.chipDic[chipData.dataId] ~= nil
  local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
  self.chipDetailPanel:SetObjNewTagActive(true, chipShowState)
  local detailButtonGroup = self.chipDetailPanel:GetDetailButtonGroup()
  if saled then
    detailButtonGroup:SetDefaultState()
  else
    detailButtonGroup:InitBtnSelByCost(true, price, self._onStoreBuyClicked)
  end
  self:__SetSellOutParent(self.chipDetailPanel.transform)
end

function UIEpStoreRoom:_RefreshBuyBuffDetail(epBuffData)
  self.epBuffDetail:Show()
  self.epBuffDetail:InitEpBuffDetail(epBuffData)
  self:__SetSellOutParent(self.epBuffDetail.transform)
end

function UIEpStoreRoom:RefreshSelectItemDetailSoldOut(index)
  local chipData = self.chipList[index]
  if chipData == nil then
    self.ui.btn_Buy.gameObject:SetActive(false)
    self.chipDetailPanel:Hide()
    return
  end
  self.ui.btn_Buy.gameObject:SetActive(true)
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(index, chipData, self.storeCtrl.dynPlayer, self.resloader, true, eChipDetailPowerType.Subtract, true)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  self.chipDetailPanel:ShowEpChipDetailEff(5)
  self.chipDetailPanel:SetObjNewTagActive(false)
  local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
  local salePrice = ConfigData:CalculateEpChipSalePrice(self.roomId, chipData:GetCount(), buyPrice, self.storeCtrl.dynPlayer)
  self.ui.tex_Money:SetIndex(0, tostring(salePrice))
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelByCost(false, salePrice, self._onStoreBuyClicked)
  self:__SetLackState(false)
end

function UIEpStoreRoom:__SetLackState(isLack)
  self.ui.tex_Buy:SetIndex(isLack and 1 or 0)
  self.ui.btn_Buy.interactable = not isLack
end

function UIEpStoreRoom:OnStoreBuyClicked()
  if self.storeType == StoreType.eBuy then
    local selectIndex, price, chipItem = self.buyListNode:GetEpStoreBuyData()
    local storeItemData = self.storeDataList[selectIndex]
    if storeItemData == nil then
      return
    end
    local buyCompleteFunc
    if storeItemData.chipData ~= nil then
      if storeItemData.chipData:IsConsumeSkillChip() and self:__IsFullActiveAlgCount() then
        local maxConsumeCount = BattleUtil.GetConsumeChipLimit()
        local msg = string.format(ConfigData:GetTipContent(6032), maxConsumeCount, maxConsumeCount)
        cs_MessageCommon.ShowMessageTipsWithErrorSound(msg)
        return
      end
      local uiPos = self.transform:InverseTransformPoint(chipItem.transform.position)
      local localScale = chipItem.transform.localScale
      
      function buyCompleteFunc()
        local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
        if dungeonStateWindow ~= nil then
          local chipData = storeItemData.chipData
          dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
        end
      end
    end
    self.storeCtrl:SendStorePurchase(selectIndex, price, buyCompleteFunc)
  elseif self.storeType == StoreType.eSell then
    local storeItem = self.sellListNode:GetCurEpStoreRoomSell()
    if storeItem == nil then
      return
    end
    local chipData = storeItem.chipData
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(288), chipData:GetName(), tostring(storeItem.salePrice)), function()
        self.storeCtrl:SendStoreSell(chipData, function()
          self.chipList = ExplorationManager:GetDynPlayer():GetChipList()
          self.sellListNode:InitEpStoreRoomSell(self.chipList)
        end)
      end)
    end)
  end
end

function UIEpStoreRoom:OnBtnEpStoreRefresh()
  if self.ui.obj_RefreshLack.activeSelf then
    return
  end
  self.storeCtrl:ReqEpStoreRefresh()
end

function UIEpStoreRoom:OnStoreSkipClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.exploration_Store_Exit), function()
      UIUtil.PopFromBackStackByUiTab(self)
      self.storeCtrl:SendStoreQuit()
    end)
  end)
  return false
end

function UIEpStoreRoom:OnStoreMapClicked()
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UIEpStoreRoom:FromMapBackToUI()
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UIEpStoreRoom:SwitchRoomMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
  self.ui.frameNode:SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

function UIEpStoreRoom:OnChipDetailActiveChange(active)
  if active then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpStoreRoom:__ShowDetailSellOutUI(active)
  if not IsNull(self.ui.obj_IsSellout) then
    self.ui.obj_IsSellout:SetActive(active == true)
  end
end

function UIEpStoreRoom:__SetSellOutParent(parent)
  if not IsNull(self.ui.obj_IsSellout) then
    local trans = self.ui.obj_IsSellout.transform
    trans:SetParent(parent)
    trans.localPosition = Vector3.zero
    trans.sizeDelta = Vector2.zero
    trans:SetAsLastSibling()
  end
end

function UIEpStoreRoom:__IsFullActiveAlgCount()
  local count = BattleUtil.GetConsumeChipLimit()
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil then
    return false
  end
  for _, chipData in pairs(dynPlayer:GetNormalChipDic()) do
    if chipData:IsConsumeSkillChip() then
      count = count - 1
      if count == 0 then
        return true
      end
    end
  end
  return false
end

function UIEpStoreRoom:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self:AutoDeleteTopStatus()
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:TrySetLimitSellBtnActive(true)
  end
  if ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl.inTheTempRoom = nil
  end
  self.chipDetailPanel:Delete()
  self.epBuffDetail:Delete()
  self.buyListNode:Delete()
  self.sellListNode:Delete()
  base.OnDelete(self)
end

return UIEpStoreRoom
