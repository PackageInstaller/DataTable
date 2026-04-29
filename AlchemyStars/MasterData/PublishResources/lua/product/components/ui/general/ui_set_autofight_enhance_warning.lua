_class("UISetAutoFightEnhanceWarning", UIController)
UISetAutoFightEnhanceWarning = UISetAutoFightEnhanceWarning

function UISetAutoFightEnhanceWarning:OnShow(uiParams)
  local callback = uiParams[1]
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnNormal = self:GetGameObject("CancelBtnNormal")
  self._cancelBtnClick = self:GetGameObject("CancelBtnClick")
  self._confirmBtn = self:GetGameObject("ConfirmBtn")
  self._confirmBtnNormal = self:GetGameObject("ConfirmBtnNormal")
  self._confirmBtnClick = self:GetGameObject("ConfirmBtnClick")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Press, function(go)
    self._cancelBtnNormal:SetActive(false)
    self._cancelBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Release, function(go)
    self._cancelBtnNormal:SetActive(true)
    self._cancelBtnClick:SetActive(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._confirmBtn), UIEvent.Press, function(go)
    self._confirmBtnNormal:SetActive(false)
    self._confirmBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._confirmBtn), UIEvent.Release, function(go)
    self._confirmBtnNormal:SetActive(true)
    self._confirmBtnClick:SetActive(false)
  end)
end

function UISetAutoFightEnhanceWarning:CancelBtnOnClick()
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UISetController",
    input = "SetAutoFight",
    args = {1}
  })
  self:CloseDialog()
end

function UISetAutoFightEnhanceWarning:ConfirmBtnOnClick()
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UISetController",
    input = "SetAutoFight",
    args = {2}
  })
  self:CloseDialog()
end
