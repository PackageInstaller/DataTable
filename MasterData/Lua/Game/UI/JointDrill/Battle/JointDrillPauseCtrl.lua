local JointDrillPauseCtrl = class("JointDrillPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
JointDrillPauseCtrl._mapNodeConfig = {
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
  aniWindow = {
    sNodeName = "PauseWindow",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Pause"
  },
  txtChallengeTimeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Challenge_Time_Left_Text"
  },
  txtChallengeTime = {sComponentName = "TMP_Text"},
  txtBattleTimeCn = {sComponentName = "TMP_Text"},
  txtBattleTime = {sComponentName = "TMP_Text"},
  btnChar = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  goChar = {
    nCount = 3,
    sNodeName = "btnChar",
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  btnGiveUp = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GiveUp"
  },
  txtBtnGiveUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_GiveUp"
  },
  btnRestart = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Restart",
    sAction = "Retry",
    sActionIconType = "Dark"
  },
  txtBtnRestart = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Restart"
  },
  btnRetreat = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Retreat"
  },
  txtBtnRetreat = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Retreat"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Back",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  txtBtnBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Continue"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  }
}
JointDrillPauseCtrl._mapEventConfig = {
  OpenJointDrillPause = "OnEvent_OpenJointDrillPause",
  RefreshChallengeTime = "OnEvent_RefreshChallengeTime",
  CloseJointDrillPause = "OnEvent_CloseJointDrillPause"
}
JointDrillPauseCtrl._mapRedDotConfig = {}

function JointDrillPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self.bShow then
      self._mapNode.safeAreaRoot:SetActive(true)
      self._mapNode.aniWindow:Play("t_window_04_t_in")
      EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    end
  end
  
  cs_coroutine.start(wait)
end

function JointDrillPauseCtrl:RefreshChallengeTime()
  local function refreshTime()
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    
    local nTime = self.nAllChallengeTime - (nCurTime - self.nOpenTime)
    nTime = math.max(nTime, 0)
    local nMin = math.floor(nTime / 60)
    local nSec = math.fmod(nTime, 60)
    NovaAPI.SetTMPText(self._mapNode.txtChallengeTime, string.format("%02d:%02d", nMin, nSec))
    return nTime
  end
  
  self.nRemainTime = refreshTime()
  if self.nRemainTime > 0 then
    self.challengeTimer = self:AddTimer(0, 1, function()
      self.nRemainTime = refreshTime()
      if self.nRemainTime <= 0 then
        self.challengeTimer:Cancel()
        self.challengeTimer = nil
      end
    end, true, true, true)
  end
end

function JointDrillPauseCtrl:Refresh(nTime)
  for i = 1, 3 do
    self._mapNode.goChar[i].gameObject:SetActive(self.tbChar[i])
    if self.tbChar[i] then
      self._mapNode.goChar[i]:SetChar(self.tbChar[i])
    end
  end
  if self.challengeTimer == nil then
    self:RefreshChallengeTime()
  end
  nTime = nTime or 0
  nTime = self.nTotalTime * 1000 - nTime
  local nMin = math.floor(nTime / 60000)
  local nRemain = nTime % 60000
  local nSec = math.floor(nRemain / 1000)
  local nMs = nTime % 1000
  NovaAPI.SetTMPText(self._mapNode.txtBattleTime, string.format("%02d:%02d:%03d", nMin, nSec, nMs))
end

function JointDrillPauseCtrl:PlayCloseAni(callback)
  if self._mapNode == nil then
    return
  end
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "ClosePanel", true, true, true, callback)
end

function JointDrillPauseCtrl:ClosePanel(_, callback)
  if self._mapNode == nil or not self.bShow then
    return
  end
  self:OnPanelClose(callback)
end

function JointDrillPauseCtrl:OnPanelClose(callback)
  self.bShow = false
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("JointDrillPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  if callback then
    callback()
  end
end

function JointDrillPauseCtrl:Awake()
  self.nAllChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max")
  self.nTotalTime = self._panel.nTotalTime
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  local tbConfig = {
    {
      sAction = "Giveup",
      sLang = "JointDrill_Battle_GiveUp"
    },
    {
      sAction = "Leave",
      sLang = "JointDrill_Battle_Retreat"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function JointDrillPauseCtrl:OnEnable()
  self.nOpenTime = 0
  self.nRemainTime = 0
  if self._panel.nType ~= nil then
    if self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
      self.nOpenTime = PlayerData.JointDrill_1:GetJointDrillStartTime()
    elseif self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
      self.nOpenTime = PlayerData.JointDrill_2:GetJointDrillStartTime()
    end
  end
end

function JointDrillPauseCtrl:OnDisable()
end

function JointDrillPauseCtrl:OnDestroy()
end

function JointDrillPauseCtrl:OnBtnClick_Char(btn, index)
end

function JointDrillPauseCtrl:OnBtnClick_GiveUp()
  local function confirmCallback()
    self:PlayCloseAni(function()
      NovaAPI.DispatchEventWithData("JointDrill_Level_GiveUp")
      
      EventManager.Hit("GiveUpJointDrill")
    end)
  end
  
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nTime = self.nAllChallengeTime - (nCurTime - self.nOpenTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  local sTip = orderedFormat(ConfigTable.GetUIText("JointDrill_Battle_GiveUp_Tip"), string.format("%02d:%02d", nMin, nSec))
  local sContentSub = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Count"), self.nAllBattleCount - self.nCurBattleCount)
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    sContentSub = sContentSub,
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function JointDrillPauseCtrl:OnBtnClick_Restart()
  local function confirmCallback()
    self:PlayCloseAni(function()
      EventManager.Hit("RestartJointDrill")
    end)
  end
  
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nTime = self.nAllChallengeTime - (nCurTime - self.nOpenTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  local sTip = orderedFormat(ConfigTable.GetUIText("JointDrill_Battle_Restart_Tip"), string.format("%02d:%02d", nMin, nSec))
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function JointDrillPauseCtrl:OnBtnClick_Retreat()
  local function confirmCallback()
    self:PlayCloseAni(function()
      EventManager.Hit("RetreatJointDrill")
    end)
  end
  
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nTime = self.nAllChallengeTime - (nCurTime - self.nOpenTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  local sTip = orderedFormat(ConfigTable.GetUIText("JointDrill_Battle_Retreat_Tip"), string.format("%02d:%02d", nMin, nSec))
  local sContentSub = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Count"), self.nAllBattleCount - self.nCurBattleCount + 1)
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    sContentSub = sContentSub,
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function JointDrillPauseCtrl:OnBtnClick_Back()
  self:PlayCloseAni()
end

function JointDrillPauseCtrl:OnEvent_OpenJointDrillPause(nLevelId, tbCharId, nBattleTime)
  self.bShow = true
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  local tbTeam = {}
  local mapLevelCfg
  if self._panel.nType ~= nil then
    if self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
      tbTeam = PlayerData.JointDrill_1:GetJointDrillBuildList()
      mapLevelCfg = ConfigTable.GetData("JointDrillLevel", self.nLevelId)
    elseif self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
      tbTeam = PlayerData.JointDrill_2:GetJointDrillBuildList()
      mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", self.nLevelId)
    end
  end
  self.nCurBattleCount = #tbTeam
  self.nAllBattleCount = 0
  if mapLevelCfg ~= nil then
    self.nAllBattleCount = mapLevelCfg.MaxBattleNum
  end
  local sCount = ConfigTable.GetUIText("JointDrill_Battle_Time_" .. self.nCurBattleCount)
  NovaAPI.SetTMPText(self._mapNode.txtBattleTimeCn, ConfigTable.GetUIText("JointDrill_Battle_Time_Text"))
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh(nBattleTime)
  GamepadUIManager.EnableGamepadUI("JointDrillPauseCtrl", self.tbGamepadUINode)
end

function JointDrillPauseCtrl:OnEvent_RefreshChallengeTime(nTime)
  if not self.bShow then
    return
  end
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function JointDrillPauseCtrl:OnEvent_CloseJointDrillPause()
  self:ClosePanel()
end

return JointDrillPauseCtrl
