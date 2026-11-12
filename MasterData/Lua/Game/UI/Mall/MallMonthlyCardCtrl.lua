local MallMonthlyCardCtrl = class("MallMonthlyCardCtrl", BaseCtrl)
MallMonthlyCardCtrl._mapNodeConfig = {
  cgBg = {
    sNodeName = "imgMonthlyBg",
    sComponentName = "CanvasGroup"
  },
  Card = {nCount = 2}
}
MallMonthlyCardCtrl._mapEventConfig = {
  MallOrderClear = "OnEvent_OrderClear"
}

function MallMonthlyCardCtrl:Refresh()
  if self._panel.nCurTog ~= AllEnum.MallToggle.MonthlyCard then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBg, 0)
  
  local function callback(mapData)
    self.tbMonthlyCard = mapData
    self:RefreshList()
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBg, 1)
  end
  
  PlayerData.Mall:SendMallMonthlyCardListReq(callback)
end

function MallMonthlyCardCtrl:RefreshList()
  for i = 1, 2 do
    self:RefreshCard(self.tbMonthlyCard[i], i)
  end
end

function MallMonthlyCardCtrl:RefreshCard(cardData, cardIndex)
  if cardData == nil then
    return
  end
  local card = self._mapNode.Card[cardIndex].transform
  local mapCfg = ConfigTable.GetData("MallMonthlyCard", cardData.Id)
  if mapCfg == nil then
    return
  end
  local txtName = card:Find("txtName"):GetComponent("TMP_Text")
  local txtPrice = card:Find("txtPrice"):GetComponent("TMP_Text")
  local txtRemainDay = card:Find("txtRemainDay"):GetComponent("TMP_Text")
  local txtTip1 = card:Find("txtTip1"):GetComponent("TMP_Text")
  local txtTip2 = card:Find("txtTip2"):GetComponent("TMP_Text")
  local txtTip3 = card:Find("txtTip3"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtName, mapCfg.Name)
  NovaAPI.SetTMPText(txtPrice, tostring(mapCfg.ShowPrice))
  local sState = cardData.Received and ConfigTable.GetUIText("Mall_MonthlyCard_Received") or ConfigTable.GetUIText("Mall_MonthlyCard_Unreceived")
  NovaAPI.SetTMPText(txtRemainDay, orderedFormat(ConfigTable.GetUIText("Mall_MonthlyCard_RemainDay"), cardData.Remaining, sState))
  NovaAPI.SetTMPText(txtTip1, ConfigTable.GetUIText("Mall_MonthlyCard_BuyImmediately"))
  NovaAPI.SetTMPText(txtTip2, ConfigTable.GetUIText("Mall_MonthlyCard_Daily"))
  NovaAPI.SetTMPText(txtTip3, ConfigTable.GetUIText("Mall_MonthlyCard_LimitTime" .. mapCfg.MonthlyCardId))
  local img_baseItem = card:Find("imgItem1/imgItemIcon"):GetComponent("Image")
  local txt_baseItemCount = card:Find("imgItem1/txtItemCount"):GetComponent("TMP_Text")
  self:SetPngSprite(img_baseItem, ConfigTable.GetData_Item(mapCfg.BaseItemId).Icon2)
  NovaAPI.SetTMPText(txt_baseItemCount, mapCfg.BaseItemQty)
  local mapMonthlyCard = ConfigTable.GetData("MonthlyCard", mapCfg.MonthlyCardId * 100 + 1)
  local imgItemIcon1 = card:Find("imgItem2/imgItemIcon"):GetComponent("Image")
  local txtItemCount1 = card:Find("imgItem2/txtItemCount"):GetComponent("TMP_Text")
  if mapMonthlyCard.RewardId1 ~= 0 then
    self:SetPngSprite(imgItemIcon1, ConfigTable.GetData_Item(mapMonthlyCard.RewardId1).Icon2)
    NovaAPI.SetTMPText(txtItemCount1, mapMonthlyCard.RewardNum1)
  end
  local imgItemIcon2 = card:Find("imgItem3/imgItemIcon"):GetComponent("Image")
  local txtItemCount2 = card:Find("imgItem3/txtItemCount"):GetComponent("TMP_Text")
  if mapMonthlyCard.RewardId2 ~= 0 then
    self:SetPngSprite(imgItemIcon2, ConfigTable.GetData_Item(mapMonthlyCard.RewardId2).Icon2)
    NovaAPI.SetTMPText(txtItemCount2, mapMonthlyCard.RewardNum2)
  end
  local btnBuy = card:Find("btnBuy"):GetComponent("UIButton")
  local txtBuy = card:Find("btnBuy/AnimRoot/txtBtnBuy"):GetComponent("TMP_Text")
  btnBuy.onClick:RemoveAllListeners()
  btnBuy.onClick:AddListener(function()
    self:OnBtnClick_Buy(cardIndex)
  end)
  NovaAPI.SetTMPText(txtBuy, ConfigTable.GetUIText("Mall_Btn_Buy"))
  local btnRule = card:Find("btnRule"):GetComponent("UIButton")
  btnRule.onClick:RemoveAllListeners()
  btnRule.onClick:AddListener(function()
    local msg = {
      nType = AllEnum.MessageBox.Desc,
      sContent = mapCfg.Desc
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end)
end

function MallMonthlyCardCtrl:Awake()
end

function MallMonthlyCardCtrl:OnEnable()
end

function MallMonthlyCardCtrl:OnDisable()
end

function MallMonthlyCardCtrl:OnDestroy()
end

function MallMonthlyCardCtrl:OnBtnClick_Buy(cardIndex)
  local cardData = self.tbMonthlyCard[cardIndex]
  local mapCfg = ConfigTable.GetData("MallMonthlyCard", cardData.Id)
  if cardData.Remaining > mapCfg.MaxDays then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mall_MaxDay"))
    return
  end
  PlayerData.Mall:BuyMonthlyCard(cardData.Id, mapCfg.StatisticalGroup)
end

function MallMonthlyCardCtrl:OnEvent_OrderClear()
  PopUpManager.OpenPopUpPanelByType(GameEnum.PopUpSeqType.MonthlyCard)
  self:Refresh()
end

return MallMonthlyCardCtrl
