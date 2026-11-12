local DailyInstancePauseCtrl = class("DailyInstancePauseCtrl", BaseCtrl)
local GameCameraStackManager = CS.GameCameraStackManager.Instance
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
DailyInstancePauseCtrl._mapNodeConfig = {
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
    callback = "OnBtnClick_GiveUp",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  btnSettings = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Settings"
  },
  btnPopSkill = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtGiveUp = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_EndBattle"
  },
  txtBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_ContinueBattle"
  },
  txtBtnSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Skill"
  },
  txtBtnSettings = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Settings"
  },
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
  txtSubTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Time"
  },
  txtSubTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  txtAim = {nCount = 3, sComponentName = "TMP_Text"},
  goAim = {nCount = 3},
  imgOff = {nCount = 3},
  imgOn = {nCount = 3},
  txtTime = {sComponentName = "TMP_Text"},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  }
}
DailyInstancePauseCtrl._mapEventConfig = {
  Daily_Instance_Gameplay_Time = "OnEvent_Time",
  OpenDailyInstancePause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen"
}

function DailyInstancePauseCtrl:Refresh()
  local mapCfg = ConfigTable.GetData("DailyInstance", self.nLevelId)
  if mapCfg == nil then
    return
  end
  local curStar = PlayerData.DailyInstance:GetDailyInstanceStar(self.nLevelId)
  local tbCond = {
    mapCfg.OneStarDesc,
    mapCfg.TwoStarDesc,
    mapCfg.ThreeStarDesc
  }
  for i = 1, 3 do
    self._mapNode.imgOn[i]:SetActive(i <= curStar)
    self._mapNode.imgOff[i]:SetActive(i > curStar)
    local cond = tbCond[i]
    if cond == "" then
      self._mapNode.goAim[i]:SetActive(false)
      break
    else
      self._mapNode.goAim[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtAim[i], cond)
    end
  end
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetChar(self.tbChar[i])
  end
end

function DailyInstancePauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function DailyInstancePauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function DailyInstancePauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("DailyInstancePauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function DailyInstancePauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", 0, 0))
  local tbConfig = {
    {
      sAction = "Skill",
      sLang = "StarTowerMap_Btn_Skill"
    },
    {
      sAction = "Settings",
      sLang = "StarTowerMap_Btn_Settings"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function DailyInstancePauseCtrl:OnEnable()
end

function DailyInstancePauseCtrl:OnDisable()
end

function DailyInstancePauseCtrl:OnDestroy()
end

function DailyInstancePauseCtrl:Pause(nLevelId, tbCharId)
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh()
  GamepadUIManager.EnableGamepadUI("DailyInstancePauseCtrl", self.tbGamepadUINode)
end

function DailyInstancePauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
end

function DailyInstancePauseCtrl:OnBtnClick_GiveUp(btn)
  local sTip = ""
  local mapCfg = ConfigTable.GetData("DailyInstance", self.nLevelId)
  if mapCfg == nil then
    printError("没有当前关卡信息")
    sTip = "Level None"
  else
    local sAlert = orderedFormat(ConfigTable.GetUIText("RogueBoss_Pause_GiveUpTips") or "", mapCfg.Name, mapCfg.Difficulty)
    sTip = sAlert
  end
  
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

function DailyInstancePauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function DailyInstancePauseCtrl:OnBtnClick_Char(btn, nIndex)
end

function DailyInstancePauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function DailyInstancePauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function DailyInstancePauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "DailyInstancePauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return DailyInstancePauseCtrl
