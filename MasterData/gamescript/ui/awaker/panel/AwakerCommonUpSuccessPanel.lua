local UIAnimationController = CS.Z1Client.UIAnimationController
local AwakerCommonUpSuccessPanel, Super = System.NewClass("AwakerCommonUpSuccessPanel", UIBasePanel)
AwakerCommonUpSuccessPanel.uiResCls = UI_Common_Popup_Tip_4Resource

function AwakerCommonUpSuccessPanel:ctor(title, curLv, upLv, tAttrList, awakerId, onClose)
  Super.ctor(self)
  self.title = title
  self.curLv = curLv
  self.upLv = upLv
  self.tAttrList = tAttrList
  self.awakerId = awakerId
  self.onClose = onClose
end

function AwakerCommonUpSuccessPanel:OnBind(binder)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimController:PlayState("UI_Common_Popup_Tip_4_Open", function()
    binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.ClosePanel))
  end)
  binder:BindToText(self.ui.Text_Title, function()
    return self.title
  end)
  binder:BindToText(self.ui.Text_NowNum, function()
    return self.curLv
  end)
  binder:BindToText(self.ui.Text_UpNum, function()
    return self.upLv
  end)
  binder:BindToCircularListView(self.ui.ScrollView_AttrAdd, function()
    return self.tAttrList
  end, function(itemBinder, obj, index)
    local data = self.tAttrList[index]
    itemBinder:BindComponent(AwakerCommonUpAttrItem(obj, data))
  end)
  if self.awakerId then
    AudioManager.Instance:PostSoundEvent("AWAKER_EVOVLE")
    local triggerTime = CommonDefine.AwakerVoiceTrigger.AwakerPromote
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerId)
    local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceId(triggerTime, self.awakerId, awakerData and awakerData.curSkin)
    SuccessPanelUtils.ShowAwakerVoice(voiceId, self)
  end
end

function AwakerCommonUpSuccessPanel:ClosePanel()
  self.uiAnimController:PlayState("UI_Common_Popup_Tip_4_Close", function()
    self:Close()
    if self.onClose then
      self.onClose()
    end
  end)
end

return AwakerCommonUpSuccessPanel
