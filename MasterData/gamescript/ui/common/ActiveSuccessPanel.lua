local UIBasePanel = require("Managers.UI.UIBasePanel")
local PanelResource = require("UI.UIPackages.UI_Common_Popup_Tip_5Resource")
local UI_Common_Popup_Tip_2Resource = require("UI.UIPackages.UI_Common_Popup_Tip_2Resource")
local System = require("System.System")
local UIAnimationController
local AwakerAudioManager = require("Managers.AwakerAudioManager")
local SuccessPanelUtils = require("UI.Common.SuccessPanelUtils")
local CommonDefine = require("World.Enums.CommonDefine")
local AudioManager = require("Managers.AudioManager")
local ActiveSuccessPanel, Super = System.NewClass("ActiveSuccessPanel", UIBasePanel)
ActiveSuccessPanel.uiResCls = PanelResource

function ActiveSuccessPanel:ctor(str, closeFunc, awakerTid)
  Super.ctor(self)
  UIAnimationController = CS.Z1Client.UIAnimationController
  self.closeFunc = closeFunc
  self.titleText = str
  self.awakerId = awakerTid
end

function ActiveSuccessPanel:OnBind(binder)
  local function OnAnimEnd()
    self.binder:BindTimer(2.0, 0, nil, System.fn(self, self.CloseCall))
  end
  
  self.uiRoot = UI_Common_Popup_Tip_2Resource(self.ui.UI_Common_Popup_Tip_2)
  self.binder = binder
  local animController = self.uiRoot.uiNode:GetComponent(typeof(UIAnimationController))
  animController:PlayState("UI_Common_Popup_Tip_2_Open", OnAnimEnd)
  self:SetTitle(self.titleText)
  if self.awakerId then
    AudioManager.Instance:PostSoundEvent("AWAKER_ENHANCE")
    local triggerTime = CommonDefine.AwakerVoiceTrigger.AwakerPromote
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerId)
    local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceId(triggerTime, self.awakerId, awakerData and awakerData.curSkin)
    SuccessPanelUtils.ShowAwakerVoice(voiceId, self)
  end
end

function ActiveSuccessPanel:CloseCall()
  if self.closeFunc then
    self.closeFunc()
  end
  self:Close()
end

function ActiveSuccessPanel:SetTitle(str)
  if str then
    self.binder:SetText(self.uiRoot.Text_Title, str)
    self.binder:SetText(self.uiRoot.Text_Title_fangda, str)
  end
end

return ActiveSuccessPanel
