local ScoreBossPauseCtrl = class("ScoreBossPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ScoreBossPauseCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "Animator"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  imgBlocker = {},
  btnBgClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  aniWindow = {
    sNodeName = "PauseWindow",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Pause"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnGiveUp = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GiveUp"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  btnAgain = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Restart",
    sAction = "ScoreBossRetry",
    sActionIconType = "Dark"
  },
  btnSettings = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Settings"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtGiveUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_GiveUp"
  },
  txtBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_ContinueBattle"
  },
  txtAgain = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_RestartBattle"
  },
  txtBtnSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Skill"
  },
  txtBtnSettings = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Settings"
  },
  goChar = {
    nCount = 3,
    sNodeName = "btnChar",
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  txtSubTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_ReminTime"
  },
  txtSubTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  ScoreStar = {nCount = 7, sComponentName = "Button"},
  texTotalScore = {sComponentName = "TMP_Text"},
  texDamageScore = {sComponentName = "TMP_Text"},
  texSkillScore = {sComponentName = "TMP_Text"},
  texTotalTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_TotalScore"
  },
  texDamageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_DamageScore"
  },
  texSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_SkillScore"
  },
  skillInfoName1 = {sComponentName = "TMP_Text"},
  skillInfoDes1 = {sComponentName = "TMP_Text"},
  skillInfoName2 = {sComponentName = "TMP_Text"},
  skillInfoDes2 = {sComponentName = "TMP_Text"}
}
ScoreBossPauseCtrl._mapEventConfig = {
  ScoreBoss_Gameplay_Time = "OnEvent_Time",
  OpenScoreBossPause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen",
  ScoreBoss_Settlement_Ready = "SettlementReady"
}

function ScoreBossPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", 3, 0))
  self.isSettlementReady = false
  local tbConfig = {
    {
      sAction = "Giveup",
      sLang = "StarTowerMap_Btn_GiveUp"
    },
    {
      sAction = "Settings",
      sLang = "StarTowerMap_Btn_Settings"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function ScoreBossPauseCtrl:OnDisable()
end

function ScoreBossPauseCtrl:Pause(nLevelId, tbCharId)
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh()
  GamepadUIManager.EnableGamepadUI("ScoreBossPauseCtrl", self.tbGamepadUINode)
end

function ScoreBossPauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
end

function ScoreBossPauseCtrl:Refresh()
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", self.nLevelId)
  local getControl = ConfigTable.GetData("ScoreBossGetControl", bossLevelData.NonDamageScoreGet)
  NovaAPI.SetTMPText(self._mapNode.skillInfoName1, getControl.Name)
  NovaAPI.SetTMPText(self._mapNode.skillInfoDes1, UTILS.ParseDesc(getControl))
  local bossAbility = ConfigTable.GetData("ScoreBossAbility", bossLevelData.ScoreBossAbility)
  NovaAPI.SetTMPText(self._mapNode.skillInfoName2, bossAbility.Name)
  NovaAPI.SetTMPText(self._mapNode.skillInfoDes2, UTILS.ParseDesc(bossAbility))
  NovaAPI.SetTMPText(self._mapNode.texTotalScore, PlayerData.ScoreBoss:GetTotalScore())
  NovaAPI.SetTMPText(self._mapNode.texDamageScore, PlayerData.ScoreBoss:GetDamageScore())
  local bScore, bScoreCount = PlayerData.ScoreBoss:GetBehaviorScore()
  NovaAPI.SetTMPText(self._mapNode.texSkillScore, bScore)
  local totalStar = PlayerData.ScoreBoss:ScoreToStar()
  for i = 1, 7 do
    self._mapNode.ScoreStar[i].interactable = i <= totalStar
  end
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetChar(self.tbChar[i])
  end
end

function ScoreBossPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function ScoreBossPauseCtrl:OnBtnClick_GiveUp(btn)
  local sTip = ""
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", self.nLevelId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local sAlert = orderedFormat(ConfigTable.GetUIText("ScoreBoss_GiveUpTips"), mManual.Name)
  sTip = sAlert
  
  local function confirmCallback()
    self:PlayCloseAni(true)
    self._mapNode.imgBlocker:SetActive(true)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ScoreBossPauseCtrl:OnBtnClick_Restart(btn)
  if self.isSettlementReady then
    local sTip = ConfigTable.GetUIText("ScoreBoss_Settlement_Ready")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime > PlayerData.ScoreBoss.EndTime then
    local sTip = ConfigTable.GetUIText("ScoreBoss_Settlement_Tips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  
  local function confirmCallback()
    self:PlayCloseAni(false)
    self._mapNode.imgBlocker:SetActive(true)
    PlayerData.ScoreBoss:SendEnterLvAgain()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("ScoreBoss_RestartBattle_Tips"),
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ScoreBossPauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function ScoreBossPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function ScoreBossPauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function ScoreBossPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "ScoreBossPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

function ScoreBossPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function ScoreBossPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("ScoreBossPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function ScoreBossPauseCtrl:SettlementReady()
  self.isSettlementReady = true
end

return ScoreBossPauseCtrl
