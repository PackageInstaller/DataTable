local MainBattlePauseCtrl = class("MainBattlePauseCtrl", BaseCtrl)
local GameCameraStackManager = CS.GameCameraStackManager.Instance
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
MainBattlePauseCtrl._mapNodeConfig = {
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
  txtSubTitle3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Time"
  },
  txtAim1 = {sComponentName = "TMP_Text"},
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
MainBattlePauseCtrl._mapEventConfig = {
  Mainline_Time_CountUp = "OnEvent_Time",
  GamepadUIReopen = "OnEvent_Reopen"
}

function MainBattlePauseCtrl:Refresh(sAim)
  NovaAPI.SetTMPText(self._mapNode.txtAim1, sAim)
  for i = 1, 3 do
    self._mapNode.goChar[i].gameObject:SetActive(self.tbChar[i])
    if self.tbChar[i] then
      self._mapNode.goChar[i]:SetChar(self.tbChar[i].nTid, false, false, self.tbChar[i].nTrialId)
    end
  end
end

function MainBattlePauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function MainBattlePauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function MainBattlePauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("MainBattlePauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.MainBattlePause)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  else
    EventManager.Hit(EventId.PasueAvgBubble, false)
  end
end

function MainBattlePauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
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

function MainBattlePauseCtrl:OnEnable()
  self:Pause()
end

function MainBattlePauseCtrl:OnDisable()
end

function MainBattlePauseCtrl:OnDestroy()
end

function MainBattlePauseCtrl:Pause()
  local tbParam = self:GetPanelParam()
  local nTime = 0
  local sAim = ""
  if type(tbParam) == "table" then
    nTime = tbParam[1]
    self.tbChar = tbParam[2]
    sAim = tbParam[3]
  end
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh(sAim)
  self:OnEvent_Time(nTime)
  GamepadUIManager.EnableGamepadUI("MainBattlePauseCtrl", self:GetGamepadUINode())
end

function MainBattlePauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
end

function MainBattlePauseCtrl:OnBtnClick_GiveUp(btn)
  self:PlayCloseAni(true)
  self._mapNode.imgBlocker:SetActive(true)
end

function MainBattlePauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function MainBattlePauseCtrl:OnBtnClick_Char(btn, nIndex)
end

function MainBattlePauseCtrl:OnBtnClick_Skill(btn)
  local tbCharId, tbTrial = {}, {}
  for _, v in ipairs(self.tbChar) do
    table.insert(tbCharId, v.nTid)
    if v.nTrialId then
      table.insert(tbTrial, v.nTrialId)
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, tbCharId, false, tbTrial)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function MainBattlePauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function MainBattlePauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "MainBattlePauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return MainBattlePauseCtrl
