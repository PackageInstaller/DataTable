local JumpTimelineCtrl = class("JumpTimelineCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
JumpTimelineCtrl._mapNodeConfig = {
  btn_JumpOver = {
    sComponentName = "NaviButton",
    callback = "OnClickJump",
    sAction = "Skip"
  }
}
JumpTimelineCtrl._mapEventConfig = {
  CloseJumpOverTimeLine = "OnEvent_CloseJumpOverTimeLine"
}

function JumpTimelineCtrl:Awake()
  self.gameObject:SetActive(false)
end

function JumpTimelineCtrl:OnEnable()
end

function JumpTimelineCtrl:OpenUI()
  EventManager.Hit("FirstInputEnable")
  self.gameObject:SetActive(true)
  GamepadUIManager.EnableGamepadUI("JumpTimelineCtrl", self:GetGamepadUINode())
end

function JumpTimelineCtrl:CloseUI()
  GamepadUIManager.DisableGamepadUI("JumpTimelineCtrl")
  self.gameObject:SetActive(false)
end

function JumpTimelineCtrl:OnDisable()
end

function JumpTimelineCtrl:OnDestroy()
end

function JumpTimelineCtrl:OnClickJump()
  WwiseAudioMgr:PostEvent("char_common_all_pause")
  WwiseAudioMgr:PostEvent("mon_common_all_pause")
  AdventureModuleHelper.PausePerformTimeline()
  AdventureModuleHelper.PauseLogic()
  
  local function confirmCallback()
    WwiseAudioMgr:PostEvent("char_common_all_stop")
    WwiseAudioMgr:PostEvent("mon_common_all_stop")
    AdventureModuleHelper.StopPerformTimeline()
    AdventureModuleHelper.ResumeLogic()
  end
  
  local function cancelCallback()
    WwiseAudioMgr:PostEvent("char_common_all_resume")
    WwiseAudioMgr:PostEvent("mon_common_all_resume")
    AdventureModuleHelper.ResumePerformTimeline()
    AdventureModuleHelper.ResumeLogic()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("JumpOverTimeLine_Tips"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return JumpTimelineCtrl
