local StarTowerAutoDecisionPhoneCtrl = class("StarTowerAutoDecisionPhoneCtrl", BaseCtrl)
StarTowerAutoDecisionPhoneCtrl._mapNodeConfig = {
  txtVitaToken = {sComponentName = "TMP_Text"},
  txtVitaName = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_VitaName"
  },
  imgBattleCD = {sComponentName = "Image"}
}
StarTowerAutoDecisionPhoneCtrl._mapEventConfig = {
  [EventId.CoinResChange] = "OnEvent_CoinResChange"
}
local tbColors = {
  [1] = "#ea5964",
  [2] = "#ffde6a",
  [3] = "#bde34f"
}

function StarTowerAutoDecisionPhoneCtrl:Refresh()
  self.nTokenCount = PlayerData.StarTowerAutoPlan:GetTokenCount()
  self.nMaxTokenCount = ConfigTable.GetConfigNumber("TowerVitaEnergyMax") or 0
  local nPercent = self.nMaxTokenCount > 0 and math.floor(self.nTokenCount * 100 / self.nMaxTokenCount) or 0
  local nRatio = nPercent / 100
  NovaAPI.SetImageFillAmount(self._mapNode.imgBattleCD, nRatio)
  local color
  if 0 <= nRatio and nRatio < 0.1 then
    color = tbColors[1]
  elseif 0.1 <= nRatio and nRatio < 0.3 then
    color = tbColors[2]
  elseif 0.3 <= nRatio then
    color = tbColors[3]
  end
  if nRatio < 0.01 and 0 < nRatio then
    nRatio = 0.01
  end
  NovaAPI.SetTMPText(self._mapNode.txtVitaToken, nPercent .. "%")
  local _, myColor = ColorUtility.TryParseHtmlString(color)
  NovaAPI.SetImageColor(self._mapNode.imgBattleCD, myColor)
  NovaAPI.SetTMPColor(self._mapNode.txtVitaToken, myColor)
end

function StarTowerAutoDecisionPhoneCtrl:OnEnable()
  self:Refresh()
end

function StarTowerAutoDecisionPhoneCtrl:OnEvent_CoinResChange(nItemId)
  if nItemId == AllEnum.CoinItemId.AutoDecisionToken then
    self:Refresh()
  end
end

return StarTowerAutoDecisionPhoneCtrl
