local typeof = _ENV.typeof
local ActiveSuccessView, Super = NewClass("ActiveSuccessView", BaseView)
ActiveSuccessView.uiResCls = UI_Common_Popup_Tip_5Resource

function ActiveSuccessView:ctor(str, closeFunc, awakerTid, subTitle, isStable)
  Super.ctor(self)
  self._titleText = str
  self._subTitleText = subTitle
  self._closeFunc = closeFunc
  self._awakerTid = awakerTid
  self._isStable = isStable
end

function ActiveSuccessView:OnBuildView()
  self._uiRoot = UI_Common_Popup_Tip_2Resource(self.ui.UI_Common_Popup_Tip_2)
end

function ActiveSuccessView:RegisterNotifications()
end

function ActiveSuccessView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._CloseCall))
end

function ActiveSuccessView:OnEnterView()
  Super.OnEnterView(self)
  local animController = self._uiRoot.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:SetActive(self.ui.UI_Common_Glass, self._isStable)
  if self._isStable then
    animController:PlayState("UI_Common_Popup_Tip_2_OpenStay")
  else
    animController:PlayState("UI_Common_Popup_Tip_2_Open", function()
      self:BindTimer(2.0, 0, nil, System.fn(self, self._CloseCall))
    end)
  end
  self:_SetTitle()
  if self._awakerTid then
    AudioManager.Instance:PostSoundEvent("AWAKER_ENHANCE")
    local triggerTime = CommonDefine.AwakerVoiceTrigger.AwakerPromote
    local awakerData = AwakerDataUtils.GetAwakerData(self._awakerTid)
    local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceId(triggerTime, self._awakerTid, awakerData and awakerData.curSkin)
    SuccessPanelUtils.ShowAwakerVoice(voiceId, self)
  end
end

function ActiveSuccessView:OnExitView()
  Super.OnExitView(self)
end

function ActiveSuccessView:_CloseCall()
  if self._closeFunc then
    self._closeFunc()
  end
  self:Close()
end

function ActiveSuccessView:_SetTitle()
  if not self._titleText then
    return
  end
  local showSub = self._subTitleText ~= nil
  self:SetActive(self._uiRoot.Text_Sub_Title, showSub)
  self:SetActive(self._uiRoot.Text_Sub_SubTitle, showSub)
  self:SetActive(self._uiRoot.Text_Title, not showSub)
  self:SetActive(self._uiRoot.Text_Title_Eng, not showSub)
  if showSub then
    self:SetText(self._uiRoot.Text_Sub_Title, self._titleText)
    self:SetText(self._uiRoot.Text_Sub_SubTitle, self._subTitleText)
  else
    self:SetText(self._uiRoot.Text_Title, self._titleText)
  end
  self:SetText(self._uiRoot.Text_Title_fangda, self._titleText)
end

return ActiveSuccessView
