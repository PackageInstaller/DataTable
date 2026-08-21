_class("UIN30EntrustFinishPopup", UIController)
UIN30EntrustFinishPopup = UIN30EntrustFinishPopup

function UIN30EntrustFinishPopup:Constructor()
end

function UIN30EntrustFinishPopup:LoadDataOnEnter(TT, res, uiParams)
end

function UIN30EntrustFinishPopup:OnShow(uiParams)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UIN30EntrustFinishPopup:OnHide()
end

function UIN30EntrustFinishPopup:OnUpdate(deltaTimeMS)
end

function UIN30EntrustFinishPopup:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
