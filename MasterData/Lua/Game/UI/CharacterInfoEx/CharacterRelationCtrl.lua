local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharacterRelationCtrl = class("CharacterRelationCtrl", BaseCtrl)
CharacterRelationCtrl._mapNodeConfig = {
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "GameObject"
  },
  favourPanel = {
    sNodeName = "Favorability",
    sCtrlName = "Game.UI.CharacterFavour.CharacterFavourCtrl"
  },
  recordPanel = {
    sNodeName = "CharRecordInfoRoot",
    sCtrlName = "Game.UI.CharacterRecord.CharacterRecordCtrl"
  },
  Reddot = {nCount = 1},
  txtDub = {sComponentName = "TMP_Text"},
  txtDubLabel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"}
}
CharacterRelationCtrl._mapEventConfig = {
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack",
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel"
}

function CharacterRelationCtrl:Awake()
end

function CharacterRelationCtrl:RegisterRedDot(nCharId)
  RedDotManager.RegisterNode(RedDotDefine.Role_AffinityTask, nCharId, self._mapNode.Reddot[1])
end

function CharacterRelationCtrl:OnEnable()
  if self._panel.nPanelId ~= PanelId.CharacterRelation then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  else
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self:OnRefreshPanel()
  end
end

function CharacterRelationCtrl:OnDisable()
end

function CharacterRelationCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
end

function CharacterRelationCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
end

function CharacterRelationCtrl:OnEvent_RefreshPanel()
  if self._panel.nPanelId ~= PanelId.CharacterRelation then
    return
  end
  self:OnRefreshPanel()
end

function CharacterRelationCtrl:OnRefreshPanel()
  self.nCharId = self._panel.nCharId
  self._mapNode.favourPanel:Refresh(self.nCharId)
  self._mapNode.recordPanel:Refresh(self.nCharId)
  local mapCfg = ConfigTable.GetData_Character(self.nCharId)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, mapCfg.Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", self.nCharId)
  local sColor, sCnCv, sCvDesc
  local sCurrentVoLanguage = NovaAPI.GetCur_VoiceLanguage()
  if mapCharDescCfg ~= nil then
    sColor = mapCharDescCfg.CharColor
    if sCurrentVoLanguage == "zh_CN" then
      sCnCv = mapCharDescCfg.CnCv
      sCvDesc = ConfigTable.GetUIText("ZN_CV")
    elseif sCurrentVoLanguage == "ja_JP" then
      sCnCv = mapCharDescCfg.JpCv
      sCvDesc = ConfigTable.GetUIText("JP_CV")
    end
  else
    sColor = ""
    sCnCv = ""
    sCvDesc = ""
  end
  NovaAPI.SetTMPText(self._mapNode.txtDub, sCnCv)
  NovaAPI.SetTMPText(self._mapNode.txtDubLabel, sCvDesc)
  self:RegisterRedDot(self.nCharId)
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharacterRelation")
end

function CharacterRelationCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
  if nClosePanelId == PanelId.CharacterRelation then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
    self:ResetData()
  end
  if nOpenPanelId == PanelId.CharacterRelation then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self:OnRefreshPanel()
  end
end

function CharacterRelationCtrl:ResetData()
  self._mapNode.favourPanel:ResetData()
end

return CharacterRelationCtrl
