local JumpOverTimeLineCtrl = class("JumpOverTimeLineCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
JumpOverTimeLineCtrl._mapNodeConfig = {
  btn_JumpOver = {
    sComponentName = "NaviButton",
    callback = "OnClickJump",
    sAction = "Skip"
  }
}
JumpOverTimeLineCtrl._mapEventConfig = {
  CloseJumpOverTimeLine = "OnEvent_CloseJumpOverTimeLine"
}

function JumpOverTimeLineCtrl:Awake()
end

function JumpOverTimeLineCtrl:OnEnable()
  EventManager.Hit("FirstInputEnable")
  GamepadUIManager.EnableGamepadUI("JumpOverTimeLineCtrl", self:GetGamepadUINode())
end

function JumpOverTimeLineCtrl:OnDisable()
end

function JumpOverTimeLineCtrl:OnDestroy()
end

function JumpOverTimeLineCtrl:OnClickJump()
  WwiseAudioMgr:PostEvent("char_common_all_pause")
  WwiseAudioMgr:PostEvent("mon_common_all_pause")
  
  local function confirmCallback()
    WwiseAudioMgr:PostEvent("char_common_all_stop")
    WwiseAudioMgr:PostEvent("mon_common_all_stop")
    AdventureModuleHelper.StopPlayableDirector()
  end
  
  local function cancelCallback()
    WwiseAudioMgr:PostEvent("char_common_all_resume")
    WwiseAudioMgr:PostEvent("mon_common_all_resume")
    AdventureModuleHelper.PausePlayableDirector(false)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("JumpOverTimeLine_Tips"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
  AdventureModuleHelper.PausePlayableDirector(true)
end

function JumpOverTimeLineCtrl:OnEvent_CloseJumpOverTimeLine()
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  GamepadUIManager.DisableGamepadUI("JumpOverTimeLineCtrl")
  self.gameObject:SetActive(false)
end

return JumpOverTimeLineCtrl
