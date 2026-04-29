_class("UISetAgeConfirmController", UIController)
UISetAgeConfirmController = UISetAgeConfirmController

function UISetAgeConfirmController:LoadDataOnEnter(TT, res, uiParams)
  self._payModule = GameGlobal.GetModule(PayModule)
  local res, replyEvent = self._payModule:GetAgeId(TT)
  if res:GetSucc() then
    self._currentSelectId = replyEvent.cfg_id
  end
end

function UISetAgeConfirmController:OnShow(uiParams)
  self._ageDes1 = self:GetUIComponent("UILocalizationText", "AgeDes1")
  self._limitDes1 = self:GetUIComponent("UILocalizationText", "LimitDes1")
  self._selected1 = self:GetGameObject("Selected1")
  self._ageDes2 = self:GetUIComponent("UILocalizationText", "AgeDes2")
  self._limitDes2 = self:GetUIComponent("UILocalizationText", "LimitDes2")
  self._selected2 = self:GetGameObject("Selected2")
  self._ageDes3 = self:GetUIComponent("UILocalizationText", "AgeDes3")
  self._limitDes3 = self:GetUIComponent("UILocalizationText", "LimitDes3")
  self._selected3 = self:GetGameObject("Selected3")
  self._callback = uiParams[1]
  for i = 1, 3 do
    local cfg = Cfg.cfg_pay_limit[i]
    self["_selected" .. i]:SetActive(i == self._currentSelectId)
    self["_ageDes" .. i]:SetText(StringTable.Get(cfg.AgeDes))
    self["_limitDes" .. i]:SetText(StringTable.Get(cfg.LimitDes))
  end
end

function UISetAgeConfirmController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetAgeConfirmController:ConfirmBtnOnClick()
  self:Lock("UISetAgeConfirmController_SetAgeId")
  GameGlobal.TaskManager():StartTask(self.SetAgeId, self)
end

function UISetAgeConfirmController:SetAgeId(TT)
  self._payModule:SetAgeId(TT, self._currentSelectId)
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
  self:UnLock("UISetAgeConfirmController_SetAgeId")
end

function UISetAgeConfirmController:Age1OnClick()
  self:SetCurrentSelectedId(1)
end

function UISetAgeConfirmController:Age2OnClick()
  self:SetCurrentSelectedId(2)
end

function UISetAgeConfirmController:Age3OnClick()
  self:SetCurrentSelectedId(3)
end

function UISetAgeConfirmController:SetCurrentSelectedId(id)
  if self._currentSelectId and self._currentSelectId > 0 then
    self["_selected" .. self._currentSelectId]:SetActive(false)
  end
  self._currentSelectId = id
  if self._currentSelectId and self._currentSelectId > 0 then
    self["_selected" .. self._currentSelectId]:SetActive(true)
  end
end
