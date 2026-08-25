local SocialPlayerSetNotePanel, Super = System.NewClass("SocialPlayerSetNotePanel", UIBasePanel)
SocialPlayerSetNotePanel.uiResCls = UI_Social_Popup_IntroductionResource

function SocialPlayerSetNotePanel:ctor(note, callback)
  Super.ctor(self)
  self.note = note
  self.callback = callback
end

function SocialPlayerSetNotePanel:OnBind(binder)
  self.binder = binder
  self:_BindPopupComp(binder)
  self:_BindInputField(binder)
end

function SocialPlayerSetNotePanel:_BindPopupComp(binder)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm)
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("SocialSystemIntroduction"),
    maskClickFunc = function()
    end
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
end

function SocialPlayerSetNotePanel:_BindInputField(binder)
  self.characterLimit = DT.GetConstant("SocializeBlurbLengthLimit")
  self.binder:SetInputText(self.ui.InputField_Account, self.note)
  binder:BindToInputValueChange(self.ui.InputField_Account, function(text)
    local subStr = StrUtils.SubStr(text, self.characterLimit)
    if subStr ~= text then
      self.binder:SetInputText(self.ui.InputField_Account, subStr)
    end
    self.note = subStr
  end)
end

function SocialPlayerSetNotePanel:_OnClickConfirm()
  local function _OnReqSuccCallback()
    if self.callback then
      self.callback(self.note)
    end
    self:Close()
  end
  
  SocialDataUtils.SetPlayerNote(self.note, _OnReqSuccCallback)
end

function SocialPlayerSetNotePanel:Close()
  Super.Close(self)
end

return SocialPlayerSetNotePanel
