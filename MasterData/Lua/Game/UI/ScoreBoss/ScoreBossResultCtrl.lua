local ScoreBossResultCtrl = class("ScoreBossResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
ScoreBossResultCtrl._mapNodeConfig = {
  txtLevelName1 = {sComponentName = "TMP_Text"},
  ScoreStar = {nCount = 7, sComponentName = "Button"},
  texTotalScore = {sComponentName = "TMP_Text"},
  texDamageScore = {sComponentName = "TMP_Text"},
  texSkillScore = {sComponentName = "TMP_Text"},
  texTotalTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_EndScore"
  },
  texDamageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_DamageScore"
  },
  texSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_SkillScore"
  },
  ButtonClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnDamageResult1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DamageResult"
  },
  txtClickToContinue1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
ScoreBossResultCtrl._mapEventConfig = {}

function ScoreBossResultCtrl:Awake()
end

function ScoreBossResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.entryLevelId = tbParam[1]
  self.totalScore = tbParam[2]
  self.totalStar = tbParam[3]
  self.tbCharDamage = tbParam[4]
  local tbChar = tbParam[5]
  self.callback = tbParam[6]
  self._mapNode.btnDamageResult1.gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  self:SetMsg()
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseManger:PlaySound("ui_roguelike_victory")
  WwiseManger:SetState("system", "victory2")
  PlayerData.Voice:PlayBattleResultVoice(tbChar, true)
  self:AddTimer(1, 7.5, function()
    for i = 1, #self._mapNode.ButtonClose do
      self._mapNode.ButtonClose[i].gameObject:SetActive(true)
    end
  end, true, true, true)
end

function ScoreBossResultCtrl:SetMsg()
  local levelId = self.entryLevelId
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", levelId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local str = "Lv" .. PlayerData.ScoreBoss.BattleLv .. "    " .. mManual.Name
  NovaAPI.SetTMPText(self._mapNode.txtLevelName1, str)
  for i = 1, 7 do
    self._mapNode.ScoreStar[i].interactable = i <= self.totalStar
  end
  NovaAPI.SetTMPText(self._mapNode.texTotalScore, FormatWithCommas(self.totalScore))
  NovaAPI.SetTMPText(self._mapNode.texDamageScore, PlayerData.ScoreBoss:GetDamageScore())
  local bScore, bScoreCount = PlayerData.ScoreBoss:GetBehaviorScore()
  bossLevelData = ConfigTable.GetData("ScoreBossLevel", PlayerData.ScoreBoss.entryLevelId)
  local getControl = ConfigTable.GetData("ScoreBossGetControl", bossLevelData.NonDamageScoreGet)
  NovaAPI.SetTMPText(self._mapNode.texSkillScore, getControl.OnceScore .. "x" .. bScoreCount)
end

function ScoreBossResultCtrl:OnBtnClick_Close()
  if self.callback ~= nil then
    self.callback()
  else
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
end

function ScoreBossResultCtrl:OnBtnClick_DamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

function ScoreBossResultCtrl:OnDestroy()
end

return ScoreBossResultCtrl
