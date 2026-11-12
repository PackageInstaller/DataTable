local TrialPauseCtrl = class("TrialPauseCtrl", BaseCtrl)
local GameCameraStackManager = CS.GameCameraStackManager.Instance
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TrialPauseCtrl._mapNodeConfig = {
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
  btnPopSkill = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill",
    sAction = "Skill",
    sActionIconType = "Dark"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtGiveUp = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_EndTrial"
  },
  txtBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_ContinueBattle"
  },
  txtBtnSkill = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_PauseSkill"
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
  txtCurTrial = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_CurTrialChar"
  },
  goCurTrial = {nCount = 3},
  rtList = {
    sNodeName = "ContentTarget",
    sComponentName = "Transform"
  },
  goQuest = {}
}
TrialPauseCtrl._mapEventConfig = {
  Trial_Time = "OnEvent_Time",
  OpenTrialPause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen",
  TaskLevel_InitTask = "RefreshQuest",
  TaskLevel_UpdateTaskTargetProcess = "UpdateTarget",
  OpenTrialInfo = "OnEvent_OpenUI"
}

function TrialPauseCtrl:Refresh()
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetChar(self.tbChar[i])
    self._mapNode.goCurTrial[i]:SetActive(self.tbChar[i] == self.nCurCharId)
  end
end

function TrialPauseCtrl:RefreshQuest(nQuestId)
  local mapQuest = ConfigTable.GetData("LevelQuest", nQuestId)
  if not mapQuest then
    return
  end
  local tbTarget = mapQuest.LevelQuestTargetIds
  self.tbTagetNode = {}
  delChildren(self._mapNode.rtList)
  for _, v in ipairs(tbTarget) do
    local mapTarget = ConfigTable.GetData("LevelQuestTarget", v)
    if mapTarget then
      local goItemObj = instantiate(self._mapNode.goQuest, self._mapNode.rtList)
      goItemObj:SetActive(true)
      self.tbTagetNode[v] = {}
      self.tbTagetNode[v].imgOff = goItemObj.transform:Find("goReach/imgOff").gameObject
      self.tbTagetNode[v].imgOn = goItemObj.transform:Find("goReach/imgOn").gameObject
      self.tbTagetNode[v].txtDesc = goItemObj.transform:Find("txtDesc"):GetComponent("TMP_Text")
      self.tbTagetNode[v].sPrefix = UTILS.ParseLevelQuestTargetDesc(mapTarget.QuestDes, mapTarget)
      self.tbTagetNode[v].sSuffix = UTILS.GetLevelQuestTargetProcess(mapTarget)
      self.tbTagetNode[v].imgOff:SetActive(true)
      self.tbTagetNode[v].imgOn:SetActive(false)
      NovaAPI.SetTMPText(self.tbTagetNode[v].txtDesc, self.tbTagetNode[v].sPrefix .. self.tbTagetNode[v].sSuffix)
    end
  end
end

function TrialPauseCtrl:UpdateTarget(nQuestId, nTargetId, nCur, nMax)
  if not self.tbTagetNode[nTargetId] then
    return
  end
  nCur = nCur:AsInt()
  nMax = nMax:AsInt()
  local bComplete = nCur >= nMax
  self.tbTagetNode[nTargetId].imgOff:SetActive(not bComplete)
  self.tbTagetNode[nTargetId].imgOn:SetActive(bComplete)
  local sSuffix = "<color=#2be1f1>(" .. nCur .. "/" .. nMax .. ")</color>"
  NovaAPI.SetTMPText(self.tbTagetNode[nTargetId].txtDesc, self.tbTagetNode[nTargetId].sPrefix .. sSuffix)
end

function TrialPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function TrialPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function TrialPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("TrialPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function TrialPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", 0, 0))
end

function TrialPauseCtrl:OnEnable()
end

function TrialPauseCtrl:OnDisable()
end

function TrialPauseCtrl:OnDestroy()
end

function TrialPauseCtrl:Pause(tbCharId, mapCharData, nCurCharId)
  self.tbChar = tbCharId
  self.mapCharData = mapCharData
  self.nCurCharId = nCurCharId
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh()
  GamepadUIManager.EnableGamepadUI("TrialPauseCtrl", self.tbGamepadUINode)
end

function TrialPauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
end

function TrialPauseCtrl:OnEvent_OpenUI(nQuestId)
  if nQuestId then
    self:RefreshQuest(nQuestId)
  end
end

function TrialPauseCtrl:OnBtnClick_GiveUp(btn)
  local function confirmCallback()
    self:PlayCloseAni(true)
    
    self._mapNode.imgBlocker:SetActive(true)
  end
  
  local bReceived = PlayerData.Trial:CheckGroupReceived()
  if bReceived then
    confirmCallback()
  else
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Trial_Pause_GiveUpTips"),
      callbackConfirm = confirmCallback,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function TrialPauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function TrialPauseCtrl:OnBtnClick_Char(btn, nIndex)
end

function TrialPauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar, false, {}, self.mapCharData)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function TrialPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function TrialPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "TrialPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return TrialPauseCtrl
