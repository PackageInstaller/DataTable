local FormationCharInfoCtrl = class("FormationCharInfoCtrl", BaseCtrl)
FormationCharInfoCtrl._mapNodeConfig = {
  imgCharColor = {sComponentName = "Image"},
  txtPowerCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_Power"
  },
  txtPower = {sComponentName = "TMP_Text"},
  goElement = {
    sCtrlName = "Game.UI.TemplateEx.TemplateElementCtrl"
  },
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_CharRank"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Formation_Btn_Info"
  }
}
FormationCharInfoCtrl._mapEventConfig = {}

function FormationCharInfoCtrl:Refresh(nCharId, tbTeamId, bTrialLevel)
  self.bTrialLevel = bTrialLevel
  self._mapNode.btnDetail.gameObject:SetActive(not bTrialLevel)
  if bTrialLevel then
    local mapTrialChar = PlayerData.Char:GetTrialCharById(nCharId)
    self.nCharId = mapTrialChar.nId
    self.tbTeamId = tbTeamId
    local mapChar = ConfigTable.GetData_Character(self.nCharId)
    local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharId)
    local _, colorChar = ColorUtility.TryParseHtmlString(mapCharDescCfg.CharColor)
    NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
    self._mapNode.goElement:Refresh(mapChar.EET)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, mapTrialChar.nLevel)
    self:SetSprite_FrameColor(self._mapNode.imgRareName, mapChar.Grade, AllEnum.FrameType_New.Text)
    NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapTrialChar.sCharacterName)
  else
    self.nCharId = nCharId
    self.tbTeamId = tbTeamId
    local mapChar = ConfigTable.GetData_Character(nCharId)
    local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharId)
    local _, colorChar = ColorUtility.TryParseHtmlString(mapCharDescCfg.CharColor)
    NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
    self._mapNode.goElement:Refresh(mapChar.EET)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, PlayerData.Char:GetCharLv(self.nCharId))
    self:SetSprite_FrameColor(self._mapNode.imgRareName, mapChar.Grade, AllEnum.FrameType_New.Text)
    NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapChar.Name)
  end
end

function FormationCharInfoCtrl:RefreshShow(nCharId, nLevel)
  self.nCharId = nCharId
  self.tbTeamId = nil
  local mapChar = ConfigTable.GetData_Character(nCharId)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharId)
  local _, colorChar = ColorUtility.TryParseHtmlString(mapCharDescCfg.CharColor)
  NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
  self._mapNode.goElement:Refresh(mapChar.EET)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, mapChar.Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapChar.Name)
end

function FormationCharInfoCtrl:OnBtnClick_Detail(btn)
  if self.tbTeamId == nil then
    return
  end
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if not self.bTrialLevel then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, self.tbTeamId, false)
  end
end

return FormationCharInfoCtrl
