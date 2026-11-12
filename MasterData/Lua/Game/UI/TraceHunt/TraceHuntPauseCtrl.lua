local TraceHuntPauseCtrl = class("TraceHuntPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TraceHuntPauseCtrl._mapNodeConfig = {
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
  txtSubTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_ReminTime"
  },
  txtSubTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Pause_RewardPreview"
  },
  ScoreStar = {nCount = 7, sComponentName = "Button"},
  sv = {
    sComponentName = "LoopScrollView"
  },
  svGamepad = {
    sNodeName = "sv",
    sComponentName = "GamepadScroll",
    sAction = "Scroll"
  },
  goLockMask = {},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Help_HuntNoneRewardMask"
  }
}
TraceHuntPauseCtrl._mapEventConfig = {
  TraceHunt_Gameplay_Time = "OnEvent_Time",
  OpenTraceHuntPause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen",
  TraceHunt_Settlement_Ready = "SettlementReady"
}

function TraceHuntPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  local nTime = PlayerData.TraceHunt:GetBossTimeLimit()
  self:OnEvent_Time(nTime)
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

function TraceHuntPauseCtrl:OnDisable()
end

function TraceHuntPauseCtrl:Pause(nLevelId, tbCharId, bSelfBoss)
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  self.bSelfBoss = bSelfBoss
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  GamepadUIManager.EnableGamepadUI("TraceHuntPauseCtrl", self.tbGamepadUINode)
end

function TraceHuntPauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
end

function TraceHuntPauseCtrl:Refresh()
  local totalStar = PlayerData.TraceHunt:ScoreToStar()
  local nMaxStar = PlayerData.TraceHunt:GetMaxStar()
  for i = 1, 7 do
    self._mapNode.ScoreStar[i].gameObject:SetActive(i <= nMaxStar)
    if i <= nMaxStar then
      self._mapNode.ScoreStar[i].interactable = i <= totalStar
    end
  end
  local nDifficulty = 1
  if self.bSelfBoss then
    nDifficulty = PlayerData.TraceHunt:GetSelfBossHard()
  else
    nDifficulty = PlayerData.TraceHunt:GetHelpBossHard()
  end
  self.tbDrop = PlayerData.TraceHunt:GetStarDropCount(nDifficulty)
  self.nStar = totalStar
  self._mapNode.sv:SetAnim(0.04)
  self._mapNode.sv:Init(7, self, self.OnGridRefresh)
  local nCost = PlayerData.TraceHunt:GetHuntCostCount(self.bSelfBoss)
  local nHasCoin = PlayerData.TraceHunt:GetHuntTokenCount()
  self._mapNode.goLockMask:SetActive(not self.bSelfBoss and nCost > nHasCoin)
end

function TraceHuntPauseCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local txtAimStarCount = goGrid.transform:Find("btnGrid/AnimRoot/txtAimStarCount"):GetComponent("TMP_Text")
  local txtRewardCount = goGrid.transform:Find("btnGrid/AnimRoot/txtRewardCount"):GetComponent("TMP_Text")
  local txtCurStar = goGrid.transform:Find("btnGrid/AnimRoot/imgCurStar/txtCurStar"):GetComponent("TMP_Text")
  local imgCurStar = goGrid.transform:Find("btnGrid/AnimRoot/imgCurStar").gameObject
  local imgRewardIcon = goGrid.transform:Find("btnGrid/AnimRoot/imgRewardIcon"):GetComponent("Image")
  NovaAPI.SetTMPText(txtAimStarCount, "×" .. nIndex)
  self:SetSprite(imgRewardIcon, ConfigTable.GetData_Item(AllEnum.CoinItemId.TraceHunt).Icon)
  NovaAPI.SetTMPText(txtRewardCount, "×" .. self.tbDrop[nIndex])
  imgCurStar:SetActive(self.nStar == nIndex)
  NovaAPI.SetTMPText(txtCurStar, ConfigTable.GetUIText("TraceHunt_Pause_CurStar"))
end

function TraceHuntPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    self:Refresh()
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function TraceHuntPauseCtrl:OnBtnClick_GiveUp(btn)
  local bossLevelData = ConfigTable.GetData("TraceHuntBoss", self.nLevelId)
  local nId = ConfigTable.GetConfigNumber("TraceHuntPermitItemTid")
  local mapItemCfg = ConfigTable.GetData_Item(nId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  
  local function confirmCallback()
    self:PlayCloseAni(true)
    self._mapNode.imgBlocker:SetActive(true)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = orderedFormat(ConfigTable.GetUIText("TraceHunt_GiveUpTips_Main"), mManual.Name),
    sContentSub = orderedFormat(ConfigTable.GetUIText("TraceHunt_GiveUpTips_Sub"), mapItemCfg.Title),
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function TraceHuntPauseCtrl:OnBtnClick_Restart(btn)
  if self.isSettlementReady then
    local sTip = ConfigTable.GetUIText("TraceHunt_Settlement_Ready")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  
  local function confirmCallback()
    self:PlayCloseAni(false)
    self._mapNode.imgBlocker:SetActive(true)
    PlayerData.TraceHunt:SendEnterLvAgain()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("TraceHunt_RestartBattle_Tips"),
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function TraceHuntPauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function TraceHuntPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function TraceHuntPauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function TraceHuntPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "TraceHuntPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

function TraceHuntPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function TraceHuntPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("TraceHuntPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function TraceHuntPauseCtrl:SettlementReady()
  self.isSettlementReady = true
end

return TraceHuntPauseCtrl
