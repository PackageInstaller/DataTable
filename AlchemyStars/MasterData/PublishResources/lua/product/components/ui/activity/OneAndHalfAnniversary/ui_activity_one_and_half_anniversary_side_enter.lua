_class("UIActivityOneAndHalfAnniversarySideEnter", UICustomWidget)
UIActivityOneAndHalfAnniversarySideEnter = UIActivityOneAndHalfAnniversarySideEnter

function UIActivityOneAndHalfAnniversarySideEnter:OnSideEnterLoad(TT, setShowCallback, setNewRedCallback)
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
  self:_Refresh()
end

function UIActivityOneAndHalfAnniversarySideEnter:GetSideEnterRawImage()
  return self._sideEnterIcon
end

function UIActivityOneAndHalfAnniversarySideEnter:SetData(info, callback, pointCallback)
  self._beginTime = info.BeginTime
  self._endTime = info.EndTime
  self._sideEnterIcon = info.SideEnterIcon
  self._callback = callback
  self._pointCallback = pointCallback
  UIWidgetHelper.SetRawImage(self, "bg", self._sideEnterIcon)
end

function UIActivityOneAndHalfAnniversarySideEnter:_Refresh()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Gamble)
  local isOpen = not isLock and UIMainLobbySideEnterFixedTime.CheckOpen(self._beginTime, self._endTime)
  self._setShowCallback(isOpen)
  self:_CheckPoint()
end

function UIActivityOneAndHalfAnniversarySideEnter:BtnOnClick()
  self._callback()
end

function UIActivityOneAndHalfAnniversarySideEnter:_CheckPoint()
  UIWidgetHelper.SetNewAndReds(self, 0, 0, "new", "red")
end
