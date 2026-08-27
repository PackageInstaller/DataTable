local base = UIBaseWindow
local UIWarChessStore = class("UIWarChessStore", base)
local UINWarChessStoreSellList = require("Game.WarChess.UI.Store.UINWarChessSellList")
local UINWarChessStoreBuyList = require("Game.WarChess.UI.Store.UINWarChessBuyList")
local UINWarChessExchangeList = require("Game.WarChess.UI.Store.UINWarChessExchangeList")
local UINWarChessBuffDetail = require("Game.WarChess.UI.Store.UINWarChessBuffDetail")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local UINWarChessCoinDetail = require("Game.WarChess.UI.Store.UINWarChessCoinDetail")
local StoreType = {
  eBuy = 1,
  eSell = 2,
  eExchange = 3
}

function UIWarChessStore:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClicWCSkLeave)
  UIUtil.AddButtonListener(self.ui.btn_BuffBuy, self, self.OnStoreBuyBuffClicked)
  UIUtil.AddButtonListener(self.ui.btn_CoinBuy, self, self.OnStoreBuyCoinClicked)
  UIUtil.AddButtonListener(self.ui.btn_BuyTypeItem, self, self.LoadStoreData)
  UIUtil.AddButtonListener(self.ui.btn_SellTypeItem, self, self.LoadChipOwnData)
  UIUtil.AddButtonListener(self.ui.btn_ExchangeTypeItem, self, self.LoadExchangeData)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnBtnEpStoreRefresh)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickShowMap)
  self.__onCoinNumChange = BindCallback(self, self.OnCoinNumChange)
  MsgCenter:AddListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
  self.resloader = CS.ResLoader.Create()
  self._onStoreSellClicked = BindCallback(self, self.OnStoreSellClicked)
  self._onBuyChipBuyEvent = BindCallback(self, self.OnStoreBuyClicked)
  self._onBuyChipReturnEvent = BindCallback(self, self.OnBuyChipLevel)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.chipItemDetail)
  self.epBuffDetail = UINWarChessBuffDetail.New()
  self.epBuffDetail:Init(self.ui.uINBuffDetail)
  self.epCoinDetail = UINWarChessCoinDetail.New()
  self.epCoinDetail:Init(self.ui.uINCoinDetail)
  self.buyListNode = UINWarChessStoreBuyList.New(self)
  self.buyListNode:Init(self.ui.buyList)
  self.sellListNode = UINWarChessStoreSellList.New(self)
  self.sellListNode:Init(self.ui.sellList)
  self.exchangeListNode = UINWarChessExchangeList.New(self)
  self.exchangeListNode:Init(self.ui.exchangeList)
end

function UIWarChessStore:LoadStoreData()
  self:SwitchStoreTypeUI(StoreType.eBuy)
  self.buyListNode:InitWarchessStoreRoomBuyList(self.storeChipDataList)
end

function UIWarChessStore:LoadChipOwnData()
  self:SwitchStoreTypeUI(StoreType.eSell)
  local teamDic = self.storeCtrl.wcCtrl.teamCtrl:GetWCTeams()
  self.sellListNode:InitWarChessStoreRoomSell(teamDic)
end

function UIWarChessStore:OnCoinNumChange(itemId, num)
  if itemId == ConstGlobalItem.WCMoney then
    self.ui.tex_TopCoinNum.text = tostring(num)
    self:RefreshBuyRefreshBtn()
  else
    self.ui.tex_TopRareNum.text = tostring(num)
  end
end

function UIWarChessStore:LoadExchangeData()
  self:SwitchStoreTypeUI(StoreType.eExchange)
  self.exchangeListNode:InitExchangeList(self.storeBuffDataList)
end

function UIWarChessStore:SwitchRoomMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
end

function UIWarChessStore:SwitchStoreTypeUI(storeType)
  self.storeType = storeType
  self.epCoinDetail:Hide()
  self.epBuffDetail:Hide()
  self.chipDetailPanel:Hide()
  if self.storeType == StoreType.eBuy then
    self.ui.buyTypeImg:SetIndex(0)
    self.ui.buyTypeText.color = Color.black
    self.ui.sellTypeImg:SetIndex(1)
    self.ui.sellTypeText.color = Color.white
    self.ui.exchangeTypeImg:SetIndex(1)
    self.ui.exchangeTypeText.color = Color.white
    self.buyListNode:Show()
    self.sellListNode:Hide()
    self.exchangeListNode:Hide()
    self:RefreshBuyRefreshBtn()
  elseif self.storeType == StoreType.eSell then
    self.ui.sellTypeImg:SetIndex(0)
    self.ui.sellTypeText.color = Color.black
    self.ui.buyTypeImg:SetIndex(1)
    self.ui.buyTypeText.color = Color.white
    self.ui.exchangeTypeImg:SetIndex(1)
    self.ui.exchangeTypeText.color = Color.white
    self.exchangeListNode:Hide()
    self.buyListNode:Hide()
    self.sellListNode:Show()
  elseif self.storeType == StoreType.eExchange then
    self.ui.exchangeTypeImg:SetIndex(0)
    self.ui.exchangeTypeText.color = Color.black
    self.ui.buyTypeImg:SetIndex(1)
    self.ui.buyTypeText.color = Color.white
    self.ui.sellTypeImg:SetIndex(1)
    self.ui.sellTypeText.color = Color.white
    self.buyListNode:Hide()
    self.sellListNode:Hide()
    self.exchangeListNode:Show()
  end
  self.ui.btn_Refresh.gameObject:SetActive(self.storeType == StoreType.eBuy or self.storeType == StoreType.eExchange)
  self:__ShowDetailSellOutUI(false)
end

function UIWarChessStore:SetDiscountUIActive(active)
  self.ui.tex_Discount.transform.parent.gameObject:SetActive(active)
end

function UIWarChessStore:OnSelectStoreBuffItem(buffItem)
  buffItem:SetStoreBuffItemSelect(true)
  self:RefreshBuffDetail(buffItem.epStoreItemData.idx, buffItem.price)
end

function UIWarChessStore:OnSelectStoreCoinItem(coinItem)
  coinItem:SetStoreCoinItemSelect(true)
  self:RefreshCoinDetail(coinItem)
end

function UIWarChessStore:InitWCChipStore(storeCtrl)
  self.storeCtrl = storeCtrl
  self.storeChipDataList = self.storeCtrl:GetWCChipDataList()
  self.storeBuffDataList = self.storeCtrl:GetWCBuffDataList()
  self.CoinIconId = self.storeCtrl:GetWCCoinItemIconId()
  self.RareIconId = self.storeCtrl:GetWCRareItemIconId()
  self:LoadStoreData()
  self:SwitchRoomMapBtnState(false)
  self:SetDiscountUIActive(false)
  self:OnCoinNumChange(ConstGlobalItem.WCMoney, self.storeCtrl.wcCtrl.backPackCtrl:GetWCCoinNum())
  self:OnCoinNumChange(ConstGlobalItem.WCDeployPoint, self.storeCtrl.wcCtrl.backPackCtrl:GetWCDeployPointNum())
end

function UIWarChessStore:__SetBuffLackState(isLack)
  self.ui.tex_BuffBuy:SetIndex(isLack and 1 or 0)
  self.ui.btn_BuffBuy.interactable = not isLack
end

function UIWarChessStore:__SetCoinLackState(isLack, isWCPoint)
  if isLack then
    self.ui.tex_CoinBuy:SetIndex(isWCPoint and 1 or 2)
  else
    self.ui.tex_CoinBuy:SetIndex(0)
  end
  self.ui.btn_CoinBuy.interactable = not isLack
end

function UIWarChessStore:__ShowDetailSellOutUI(active)
  if not IsNull(self.ui.obj_IsSellout) then
    self.ui.obj_IsSellout:SetActive(active == true)
  end
end

function UIWarChessStore:__SetSellOutParent(parent)
  if not IsNull(self.ui.obj_IsSellout) then
    local trans = self.ui.obj_IsSellout.transform
    trans:SetParent(parent)
    trans.localPosition = Vector3.zero
    trans:SetAsLastSibling()
  end
end

function UIWarChessStore:RefreshBuffDetail(index, price)
  self.epBuffDetail:Show()
  self.epCoinDetail:Hide()
  local storeData = self.storeBuffDataList[index]
  self.epBuffDetail:InitEpBuffDetail(storeData.epBuffData)
  self:__SetSellOutParent(self.epBuffDetail.transform)
  local currMoney = self.storeCtrl:GetWCRareItemNum()
  local isCanBuy = not storeData.saled
  self.ui.btn_BuffBuy.gameObject:SetActive(isCanBuy)
  self:__ShowDetailSellOutUI(not isCanBuy)
  if isCanBuy then
    local buyPrice = price
    local isLack = isCanBuy == true and currMoney < buyPrice and 0 < buyPrice
    self:__SetBuffLackState(isLack)
    self.ui.img_BuffMoney.sprite = CRH:GetSprite(self.storeCtrl:GetWCRareItemIconId())
    self.ui.tex_BuffMoney:SetIndex(1, tostring(buyPrice))
  end
end

function UIWarChessStore:RefreshCoinDetail(coinItem)
  self.epBuffDetail:Hide()
  self.epCoinDetail:Show()
  self.epCoinDetail:InitCoinDetail(coinItem.itemCfg)
  self:__SetSellOutParent(self.epCoinDetail.transform)
  local currMoney = 0
  local isCanBuy = false
  local isWCPoint = false
  if coinItem.itemCfg.id == ConstGlobalItem.WCMoney then
    currMoney = self.storeCtrl:GetWCRareItemNum()
    isCanBuy = not self.storeCtrl:GetCoinExchangeIsUse()
    isWCPoint = false
  elseif coinItem.itemCfg.id == ConstGlobalItem.WCDeployPoint then
    currMoney = self.storeCtrl:GetWCCoinItemNum()
    isCanBuy = not self.storeCtrl:GetRareExchangeIsUse()
    isWCPoint = true
  end
  self.ui.btn_CoinBuy.gameObject:SetActive(isCanBuy)
  self:__ShowDetailSellOutUI(not isCanBuy)
  if isCanBuy then
    local buyPrice = coinItem.buyPrice
    local isLack = isCanBuy == true and currMoney < buyPrice and 0 < buyPrice
    self:__SetCoinLackState(isLack, isWCPoint)
    self.ui.img_CoinMoney.sprite = CRH:GetSprite(coinItem.MoneyIconId)
    self.ui.tex_CoinMoney:SetIndex(1, tostring(buyPrice))
  end
end

function UIWarChessStore:RefreshBuyRefreshBtn()
  local refreshCostNum = self.storeCtrl:GetWarChessStoreRefreshPrice()
  local isLack = false
  local currMoney = self.storeCtrl:GetWCCoinItemNum()
  if 0 < refreshCostNum and refreshCostNum > currMoney then
    isLack = true
  end
  self.ui.tex_Refresh:SetIndex(isLack and 1 or 0)
  self.ui.obj_RefreshLack:SetActive(isLack)
  self.ui.tex_RefreshPay.text = tostring(refreshCostNum)
end

function UIWarChessStore:RefreshSelectItemDetailSoldOut(teamData, chipData)
  if chipData == nil then
    self.ui.btn_BuffBuy.gameObject:SetActive(false)
    self.chipDetailPanel:Hide()
    return
  end
  self.ui.btn_BuffBuy.gameObject:SetActive(true)
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(nil, chipData, teamData:GetTeamDynPlayer(), self.resloader, true, eChipDetailPowerType.Subtract, true)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  self.chipDetailPanel:ShowEpChipDetailEff(5)
  self.chipDetailPanel:SetObjNewTagActive(false)
  local buyPrice = chipData:GetChipBuyPriceForWarChess()
  local salePrice = chipData:GetChipSellPriceForWarChess()
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelByCost(false, salePrice, self._onStoreSellClicked)
  self:__SetBuffLackState(false)
end

function UIWarChessStore:__IsFullActiveAlgCount()
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

function UIWarChessStore:OnBtnEpStoreRefresh()
  if self.ui.obj_RefreshLack.activeSelf then
    return
  end
  local refreshCostNum = self.storeCtrl:GetWarChessStoreRefreshPrice()
  local currMoney = self.storeCtrl:GetWCCoinItemNum()
  if 0 < refreshCostNum and refreshCostNum > currMoney then
    return
  end
  self.storeCtrl:WCRefresh(function()
    self:RefreshBuyRefreshBtn()
    if self.storeType == StoreType.eBuy then
      self.storeChipDataList = self.storeCtrl:GetWCChipDataList()
      self.storeBuffDataList = self.storeCtrl:GetWCBuffDataList()
      self:LoadStoreData()
    elseif self.storeType == StoreType.eExchange then
      self.storeChipDataList = self.storeCtrl:GetWCChipDataList()
      self.storeBuffDataList = self.storeCtrl:GetWCBuffDataList()
      self:LoadExchangeData()
    end
  end)
end

function UIWarChessStore:OnClickShowMap()
  local isOpen = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(isOpen and 1 or 0)
  self.ui.frameNode:SetActive(not isOpen)
end

function UIWarChessStore:OnStoreBuyBuffClicked()
  local index, price, item = self.exchangeListNode:GetEpStoreBuyData()
  local storeData = self.storeBuffDataList[index]
  if storeData == nil or storeData.saled then
    return
  end
  self.storeCtrl:WCBuyBuff(storeData, function()
    item:UpdateSellOutActive()
    self:RefreshBuffDetail(index, price)
  end)
end

function UIWarChessStore:OnStoreBuyCoinClicked()
  local curCoinItem = self.exchangeListNode:GetCurCoinItem()
  if curCoinItem == nil or curCoinItem.itemCfg == nil then
    return
  end
  local itemId = curCoinItem.itemCfg.id
  self.storeCtrl:WCExchangeItem(itemId, function()
    local isExchangeCoin = false
    if itemId == ConstGlobalItem.WCMoney then
      isExchangeCoin = self.storeCtrl:GetCoinExchangeIsUse()
    elseif itemId == ConstGlobalItem.WCDeployPoint then
      isExchangeCoin = self.storeCtrl:GetRareExchangeIsUse()
    end
    curCoinItem:UpdateSellOutActive(isExchangeCoin)
    self:RefreshCoinDetail(curCoinItem)
  end)
end

function UIWarChessStore:OnStoreSellClicked()
  local chipItem = self.sellListNode:GetCurChipItem()
  local teamData = self.sellListNode:GetCurTeamData()
  if chipItem ~= nil and teamData ~= nil then
    local stid = teamData:GetWCTeamId()
    self.storeCtrl:WCSaleChip(chipItem.chipData.dataId, stid, nil)
    self.chipDetailPanel:Hide()
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8533))
  end
end

function UIWarChessStore:OnStoreBuyClicked(chipItem, teamData, storeData)
  if chipItem == nil or teamData == nil or storeData == nil then
    return
  end
  if chipItem.price > self.storeCtrl:GetWCCoinItemNum() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8514))
    return
  end
  local stid = teamData:GetWCTeamId()
  self.storeCtrl:WCBuyChip(storeData, stid, function()
    local window = UIManager:GetWindow(UIWindowTypeID.WarChessBuyChip)
    if window ~= nil then
      window:OnBuyChipSuccessCallback(chipItem, storeData)
    end
  end)
end

function UIWarChessStore:OnBuyChipLevel(index)
  self.ui.canvasGroup.alpha = 1
  if index ~= -1 then
    local item = self.buyListNode:GetChipItemByIndex(index)
    if item ~= nil then
      item:SetStoreItemSelect(true)
    end
  end
  self.buyListNode:RefreshAllItemSellOut()
end

function UIWarChessStore:OnSelectWCSChipItemForBuy(chipItem)
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessBuyChip, function(window)
    if window ~= nil then
      local teamDic = self.storeCtrl.wcCtrl.teamCtrl:GetWCTeams()
      local currMoney = self.storeCtrl:GetWCCoinItemNum()
      local currRare = self.storeCtrl:GetWCRareItemNum()
      window:InitWCBuyChip(self.storeChipDataList, teamDic, self._onBuyChipBuyEvent, self._onBuyChipReturnEvent, currMoney, currRare)
      window:SetDefaultChip(chipItem.chipData)
      self.ui.canvasGroup.alpha = 0
    end
  end)
end

function UIWarChessStore:OnClicWCSkLeave()
  self.storeCtrl:ExitWCStore(function()
    self:Delete()
  end)
end

function UIWarChessStore:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.sellListNode:Delete()
  self.buyListNode:Delete()
  self.exchangeListNode:Delete()
  self.chipDetailPanel:Delete()
  self.epBuffDetail:Delete()
  self.epCoinDetail:Delete()
  self.sellListNode = nil
  self.buyListNode = nil
  self.exchangeListNode = nil
  self.chipDetailPanel = nil
  self.epBuffDetail = nil
  self.epCoinDetail = nil
  self.storeCtrl = nil
  MsgCenter:RemoveListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
end

return UIWarChessStore
