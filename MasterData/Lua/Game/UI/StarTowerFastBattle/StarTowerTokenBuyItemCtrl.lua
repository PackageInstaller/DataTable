local StarTowerTokenBuyItemCtrl = class("StarTowerTokenBuyItemCtrl", BaseCtrl)
StarTowerTokenBuyItemCtrl._mapNodeConfig = {
  btnUse = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Use"
  },
  txtBtnUse = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Item_Use"
  },
  btnUseGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Use"
  },
  txtBtnUseGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Item_Use"
  },
  txtPermanent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Permanent_Time"
  },
  txtHaveCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Count_Text"
  },
  txtHaveCountValue = {sComponentName = "TMP_Text"},
  ctrlItem = {
    sNodeName = "goEnergyItem",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  txtItemName = {sComponentName = "TMP_Text"},
  txtTokenValue = {sComponentName = "TMP_Text"},
  imgToken = {sComponentName = "Image"}
}
StarTowerTokenBuyItemCtrl._mapEventConfig = {}

function StarTowerTokenBuyItemCtrl:SetItem(mapItemData)
  self.mapItemData = mapItemData
  NovaAPI.SetTMPText(self._mapNode.txtHaveCountValue, mapItemData.nCount)
  self._mapNode.btnUseGray.gameObject:SetActive(mapItemData.nCount == 0)
  self._mapNode.btnUse.gameObject:SetActive(mapItemData.nCount > 0)
  local itemId = mapItemData.nTid
  local mapItemCfg = ConfigTable.GetData_Item(itemId)
  self._mapNode.ctrlItem:SetItem(itemId, nil, nil, nil, nil, nil, nil, true, nil, true)
  NovaAPI.SetTMPText(self._mapNode.txtItemName, mapItemCfg.Title)
  local nCountTemp = mapItemData.nTokenValue * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  local nRatio = math.floor(nCountTemp)
  NovaAPI.SetTMPText(self._mapNode.txtTokenValue, "+" .. nRatio .. "%")
end

function StarTowerTokenBuyItemCtrl:OnBtnClick_Use()
  if self.mapItemData.nCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("TokenBuy_NoItem"),
      bBlur = false
    })
    return
  end
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  if nCurToken >= self._panel.nMaxToken then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("TokenBuy_HitLimit"),
      bBlur = false
    })
    return
  end
  self._panel.mapItemData = self.mapItemData
  EventManager.Hit("ChangeTokenBuyPanel", AllEnum.TokenBuyPanelType.ItemUse)
end

function StarTowerTokenBuyItemCtrl:OnBtnClick_Item(btn)
  local mapData = {
    nTid = self.mapItemData.nTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return StarTowerTokenBuyItemCtrl
