local EnergyBuyItemCtrl = class("EnergyBuyItemCtrl", BaseCtrl)
EnergyBuyItemCtrl._mapNodeConfig = {
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
  txtLeftTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Left_Time"
  },
  txtLeftTimeValue = {sComponentName = "TMP_Text"},
  imgLeftTimeBg = {},
  imgLeftTime = {nCount = 3, sComponentName = "GameObject"},
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
  txtEnergyValue = {sComponentName = "TMP_Text"}
}
EnergyBuyItemCtrl._mapEventConfig = {}

function EnergyBuyItemCtrl:SetItem(mapItemData)
  self.mapItemData = mapItemData
  NovaAPI.SetTMPText(self._mapNode.txtHaveCountValue, mapItemData.nCount)
  NovaAPI.SetTMPText(self._mapNode.txtEnergyValue, "+" .. mapItemData.nEnergyValue)
  local nExpire = mapItemData.nExpire
  self._mapNode.imgLeftTimeBg.gameObject:SetActive(0 < nExpire)
  self._mapNode.txtPermanent.gameObject:SetActive(nExpire == 0 and mapItemData.nCount > 0)
  self._mapNode.btnUseGray.gameObject:SetActive(mapItemData.nCount == 0)
  self._mapNode.btnUse.gameObject:SetActive(mapItemData.nCount > 0)
  if 0 < nExpire then
    local sTimeStr = ""
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nExpire - curTime
    if 86400 <= remainTime then
      local day = math.floor(remainTime / 86400)
      local hour = math.floor((remainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
    elseif 3600 <= remainTime then
      local hour = math.floor(remainTime / 3600)
      local min = math.floor((remainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
    else
      sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
    end
    NovaAPI.SetTMPText(self._mapNode.txtLeftTimeValue, sTimeStr)
    self._mapNode.imgLeftTime[1]:SetActive(86400 <= remainTime)
    self._mapNode.imgLeftTime[2]:SetActive(remainTime < 86400 and 3600 <= remainTime)
    self._mapNode.imgLeftTime[3]:SetActive(remainTime < 3600)
  end
  local itemId = mapItemData.nTid
  local mapItemCfg = ConfigTable.GetData_Item(itemId)
  self._mapNode.ctrlItem:SetItem(itemId, nil, nil, nil, nil, nil, nil, true, nil, true)
  NovaAPI.SetTMPText(self._mapNode.txtItemName, mapItemCfg.Title)
end

function EnergyBuyItemCtrl:OnBtnClick_Use()
  if self.mapItemData.nCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Energy_Use_Tip_5"),
      bBlur = false
    })
    return
  end
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyObtainLimit")
  if nCurEnergy >= nMaxEnergy then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip,
      bBlur = false
    })
    return
  end
  local nExpire = self.mapItemData.nExpire
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = nExpire - curTime
  if remainTime < 0 and 0 < nExpire then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Energy_Use_Tip_4"),
      bBlur = false
    })
    EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
    return
  end
  self._panel.mapItemData = self.mapItemData
  EventManager.Hit("ChangeEnergyBuyPanel", AllEnum.EnergyPanelType.ItemUse)
end

function EnergyBuyItemCtrl:OnBtnClick_Item(btn)
  local mapData = {
    nTid = self.mapItemData.nTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return EnergyBuyItemCtrl
