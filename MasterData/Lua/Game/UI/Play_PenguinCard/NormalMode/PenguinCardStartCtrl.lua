local PenguinCardStartCtrl = class("PenguinCardStartCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardStartCtrl._mapNodeConfig = {
  txtLevelDesc = {sComponentName = "TMP_Text"},
  txtStartTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Start_Title"
  },
  txtAim = {sComponentName = "TMP_Text"},
  txtTurnLimit = {sComponentName = "TMP_Text"},
  btnStart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtBtnStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Start"
  }
}
PenguinCardStartCtrl._mapEventConfig = {}

function PenguinCardStartCtrl:Refresh()
  NovaAPI.SetTMPText(self._mapNode.txtAim, self:ThousandsNumber(self._panel.mapLevel.tbStarScore[1]))
  NovaAPI.SetTMPText(self._mapNode.txtTurnLimit, orderedFormat(ConfigTable.GetUIText("PenguinCard_Start_Turn"), self._panel.mapLevel.nMaxTurn))
  NovaAPI.SetTMPText(self._mapNode.txtLevelDesc, self._panel.mapLevel.sLevelDesc)
end

function PenguinCardStartCtrl:PlayOutAni()
  self.animator:Play("PengUinCard_Start_out", 0, 0)
end

function PenguinCardStartCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardStartCtrl:OnEnable()
end

function PenguinCardStartCtrl:OnDisable()
end

function PenguinCardStartCtrl:OnBtnClick_Start(btn)
  self._panel.mapLevel:SwitchGameState()
end

return PenguinCardStartCtrl
