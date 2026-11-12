local SettingsGemCtrl = class("SettingsGemCtrl", BaseCtrl)
SettingsGemCtrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnConfirm = {sComponentName = "TMP_Text", sLanguageId = "BtnConfirm"},
  txtWindowTitle = {sComponentName = "TMP_Text"},
  txt_allStoneTitle = {sComponentName = "TMP_Text"},
  txt_StoneTitle = {sComponentName = "TMP_Text"},
  txt_freeStoneTitle = {sComponentName = "TMP_Text"},
  txt_allStoneCount = {sComponentName = "TMP_Text"},
  txt_StoneCount = {sComponentName = "TMP_Text"},
  txt_freeStoneCount = {sComponentName = "TMP_Text"},
  txt_tips = {sComponentName = "TMP_Text"}
}
SettingsGemCtrl._mapEventConfig = {}

function SettingsGemCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function SettingsGemCtrl:Refresh()
  local nSTONE = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
  local nFREESTONE = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE)
  local stoneConfig = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
  local freestoneConfig = ConfigTable.GetData_Item(AllEnum.CoinItemId.FREESTONE)
  local sTitle = orderedFormat(ConfigTable.GetUIText("Settings_Account_Gem"), stoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txt_allStoneTitle, ConfigTable.GetUIText("Settings_Gem_Detai_AllStone") .. stoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txt_StoneTitle, ConfigTable.GetUIText("Settings_Gem_Detai_Stone") .. stoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txt_freeStoneTitle, ConfigTable.GetUIText("Settings_Gem_Detai_FreeStone") .. freestoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txt_allStoneCount, nSTONE + nFREESTONE)
  NovaAPI.SetTMPText(self._mapNode.txt_StoneCount, nSTONE)
  NovaAPI.SetTMPText(self._mapNode.txt_freeStoneCount, nFREESTONE)
  local sTips = orderedFormat(ConfigTable.GetUIText("Settings_Gem_Detai_Tips"), stoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txt_tips, sTips)
end

function SettingsGemCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SettingsGemCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function SettingsGemCtrl:Close()
  self.gameObject:SetActive(false)
end

function SettingsGemCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function SettingsGemCtrl:OnEnable()
end

function SettingsGemCtrl:OnDisable()
end

function SettingsGemCtrl:OnDestroy()
end

function SettingsGemCtrl:OnBtnClick_Close()
  EventManager.Hit("SettingsClosePop")
end

return SettingsGemCtrl
