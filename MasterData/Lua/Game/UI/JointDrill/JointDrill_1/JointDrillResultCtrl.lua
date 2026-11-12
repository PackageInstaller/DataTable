local JointDrillResultCtrl = class("JointDrillResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local ModuleManager = require("GameCore.Module.ModuleManager")
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goBg = {},
  imgUIBg = {},
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goResult = {},
  animComplete = {sNodeName = "goResult", sComponentName = "Animator"},
  goComplete = {
    sNodeName = "goComplete1"
  },
  txtMainlineName = {nCount = 2, sComponentName = "TMP_Text"},
  txtTimeScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Time_Score"
  },
  txtTimeScoreValue = {sComponentName = "TMP_Text"},
  txtDamageScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Hp_Score"
  },
  txtDamageScoreValue = {sComponentName = "TMP_Text"},
  txtDiffScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Difficulty_Score"
  },
  txtDiffScoreValue = {sComponentName = "TMP_Text"},
  txtFinalScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Result_Score"
  },
  txtFinalScoreValue = {sComponentName = "TMP_Text"},
  imgNewScore = {},
  txtNewScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_New_Record"
  },
  goFail = {},
  txtFinalScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Result_Score"
  },
  txtScoreValue = {sComponentName = "TMP_Text"},
  imgSimulate = {nCount = 2},
  txtSimulate = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Start_Challenge_Simulate"
  },
  imgTag = {},
  goBattleEnd = {},
  imgBattleEnd = {},
  imgRetreat = {},
  imgBattleLevel = {},
  txtBattleLevel = {sComponentName = "TMP_Text"},
  txtBossName = {sComponentName = "TMP_Text"},
  imgBossHpBarBg = {
    sComponentName = "RectTransform"
  },
  imgBossHpBar = {sComponentName = "Image"},
  txtBossHp = {sComponentName = "TMP_Text"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  ButtonClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goTip = {},
  txtTip = {sComponentName = "TMP_Text"},
  btnDamage = {
    nCount = 3,
    sNodeName = "btnDamageResult",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Damage"
  }
}
JointDrillResultCtrl._mapEventConfig = {}

function JointDrillResultCtrl:Refresh()
  for _, v in ipairs(self._mapNode.btnDamage) do
    v.gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  end
  local bInAdventure = ModuleManager.GetIsAdventure()
  self._mapNode.goBg:SetActive(self.nResultType ~= AllEnum.JointDrillResultType.Success)
  self._mapNode.imgUIBg.gameObject:SetActive(not bInAdventure)
  if self.nResultType ~= AllEnum.JointDrillResultType.Success and bInAdventure then
    CS.AdventureModuleHelper.PauseLogic()
  end
  local nMaxBattleCount = 0
  local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", self.nLevelId)
  if mapLevelCfg == nil then
    return
  end
  nMaxBattleCount = mapLevelCfg.MaxBattleNum
  if 0 < #self.tbChar then
    PlayerData.Voice:PlayBattleResultVoice(self.tbChar, self.nResultType == AllEnum.JointDrillResultType.Success)
  end
  local nAnimTime = 0
  if self.nResultType == AllEnum.JointDrillResultType.Success or self.nResultType == AllEnum.JointDrillResultType.ChallengeEnd then
    self._mapNode.goResult:SetActive(true)
    self._mapNode.goBattleEnd:SetActive(false)
    self._mapNode.goTip.gameObject:SetActive(false)
    self._mapNode.goComplete.gameObject:SetActive(self.nResultType == AllEnum.JointDrillResultType.Success)
    self._mapNode.goFail.gameObject:SetActive(self.nResultType == AllEnum.JointDrillResultType.ChallengeEnd)
    if self.nResultType == AllEnum.JointDrillResultType.ChallengeEnd then
      nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {
        "JointDrillResult_Result"
      })
      self.animRoot:Play("JointDrillResult_Result", 0, 0)
      WwiseManger:SetState("system", "defeat")
    else
      nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animComplete, {
        "BattleResultPanel_victory_out"
      })
      self._mapNode.animComplete:Play("BattleResultPanel_victory_out", 0, 0)
      WwiseManger:SetState("system", "victory2")
    end
    local nMonsterId = mapLevelCfg.BossId
    local nDiff = mapLevelCfg.Difficulty
    local sMonsterName = PlayerData.JointDrill_1:GetMonsterName(nMonsterId)
    local sLevelName = string.format("%s/%s", sMonsterName, ConfigTable.GetUIText("JointDrill_Difficulty_Name_" .. nDiff))
    for _, v in ipairs(self._mapNode.txtMainlineName) do
      NovaAPI.SetTMPText(v, sLevelName)
    end
    local bNew = false
    if self.mapScore ~= nil then
      local nFinalScore = self.mapScore.nScore or 0
      NovaAPI.SetTMPText(self._mapNode.txtScoreValue, FormatWithCommas(nFinalScore))
      NovaAPI.SetTMPText(self._mapNode.txtFinalScoreValue, FormatWithCommas(nFinalScore))
      NovaAPI.SetTMPText(self._mapNode.txtTimeScoreValue, FormatWithCommas(self.mapScore.FightScore or 0))
      NovaAPI.SetTMPText(self._mapNode.txtDamageScoreValue, FormatWithCommas(self.mapScore.HpScore or 0))
      NovaAPI.SetTMPText(self._mapNode.txtDiffScoreValue, FormatWithCommas(self.mapScore.DifficultyScore or 0))
      local nScoreOld = self.mapScore.nScoreOld or 0
      bNew = nFinalScore > nScoreOld
    end
    for _, v in ipairs(self._mapNode.imgSimulate) do
      v.gameObject:SetActive(self.bSimulate)
    end
    self._mapNode.imgTag.gameObject:SetActive(bNew and not self.bSimulate and self.nResultType == AllEnum.JointDrillResultType.Success)
    self._mapNode.imgNewScore.gameObject:SetActive(bNew and not self.bSimulate and self.nResultType == AllEnum.JointDrillResultType.Success)
  else
    WwiseManger:SetState("system", "defeat")
    nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {
      "JointDrillResult_BattleEnd"
    })
    self.animRoot:Play("JointDrillResult_BattleEnd", 0, 0)
    self._mapNode.goResult:SetActive(false)
    self._mapNode.goBattleEnd:SetActive(true)
    self._mapNode.goTip.gameObject:SetActive(true)
    self._mapNode.imgBattleEnd.gameObject:SetActive(self.nResultType == AllEnum.JointDrillResultType.BattleEnd)
    self._mapNode.imgRetreat.gameObject:SetActive(self.nResultType == AllEnum.JointDrillResultType.Retreat)
    self._mapNode.imgBattleLevel.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtTip, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Count"), nMaxBattleCount - self.nBattleCount))
    local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", self.nLevelId)
    if mapLevelCfg ~= nil then
      local nMonsterId = mapLevelCfg.BossId
      local nDiff = mapLevelCfg.Difficulty
      local sMonsterName = PlayerData.JointDrill_1:GetMonsterName(nMonsterId)
      NovaAPI.SetTMPText(self._mapNode.txtBossName, string.format("%s/%s", sMonsterName, ConfigTable.GetUIText("JointDrill_Difficulty_Name_" .. nDiff)))
    end
    local nBossHp = self.mapBossInfo.nHp
    local nBossHpMax = self.mapBossInfo.nHpMax
    NovaAPI.SetTMPText(self._mapNode.txtBossHp, string.format("%s/%s", self:ThousandsNumber(nBossHp), self:ThousandsNumber(nBossHpMax)))
    NovaAPI.SetImageFillAmount(self._mapNode.imgBossHpBar, nBossHp / nBossHpMax)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
end

function JointDrillResultCtrl:OpenReward()
  local function closeCallback()
    self:ClosePanel()
  end
  
  local function callback()
    if (self.nResultType == AllEnum.JointDrillResultType.Success or self.nResultType == AllEnum.JointDrillResultType.ChallengeEnd) and self.mapScore ~= nil and next(self.mapScore) ~= nil then
      EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_1.nActId, "RankUp"), self.nOld, self.nNew, self.mapScore, self.nResultType, closeCallback)
    else
      closeCallback()
    end
  end
  
  if self.mapReward ~= nil and next(self.mapReward) ~= nil then
    UTILS.OpenReceiveByDisplayItem(self.mapReward, self.mapChangeInfo, callback)
  else
    callback()
  end
end

function JointDrillResultCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", false)
end

function JointDrillResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nResultType = tbParam[1]
  self.nBattleLevel = tbParam[2]
  local nBattleTime = tbParam[3]
  self.nLevelId = tbParam[4]
  self.mapBossInfo = tbParam[5]
  self.mapScore = tbParam[6]
  self.mapReward = tbParam[7]
  self.mapChangeInfo = tbParam[8]
  self.nOld = tbParam[9]
  self.nNew = tbParam[10]
  self.bSimulate = tbParam[11]
  self.nBattleCount = tbParam[12]
  self.tbCharDamage = tbParam[13]
  self.tbChar = tbParam[14]
  self.mapSelfRank = PlayerData.JointDrill_1:GetSelfRankData()
  if self.nOld == 0 and self.nNew == 0 and self.mapSelfRank ~= nil then
    self.nOld = self.mapSelfRank.Rank
    self.nNew = self.mapSelfRank.Rank
  end
  self._mapNode.Mask.gameObject:SetActive(false)
  self._mapNode.ButtonClose.gameObject:SetActive(false)
  NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", true)
  if self.nResultType ~= AllEnum.JointDrillResultType.Success then
    self._mapNode.goRoot.gameObject:SetActive(false)
    self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  end
  WwiseManger:PostEvent("ui_loading_combatSFX_mute", nil, false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.ButtonClose.gameObject:SetActive(true)
    self:Refresh()
  end
  
  cs_coroutine.start(wait)
end

function JointDrillResultCtrl:OnDisable()
  PlayerData.Voice:StopCharVoice()
end

function JointDrillResultCtrl:ClosePanel()
  CS.AdventureModuleHelper.ResumeLogic()
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:OnBackToMainMenuModule()
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      if self.nResultType == AllEnum.JointDrillResultType.Success then
        NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        self._mapNode.imgBlurredBg:SetActive(false)
      else
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
          self._mapNode.imgBlurredBg:SetActive(false)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end
    end)
    sequence:SetUpdate(true)
  end
end

function JointDrillResultCtrl:OnBtnClick_Close(btn)
  if not self.bSimulate then
    self:OpenReward()
  else
    self:ClosePanel()
  end
end

function JointDrillResultCtrl:OnBtnClick_Damage()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

return JointDrillResultCtrl
