local PopupMonthSignActivityComp = System.NewClass("PopupMonthSignActivityComp", PopupBaseComp)

function PopupMonthSignActivityComp:ctor()
  self.popupMonthLoginActivitiesList = {}
end

function PopupMonthSignActivityComp:OnBind(binder)
  self.binder = binder
  self.binder:BindEvent(EventMgr.Instance.CloseUIPanel, function(url)
    if url == Urls.ActivityMainPanel then
      self:SetBusy(false)
    end
  end)
end

function PopupMonthSignActivityComp:Clear()
  table.clear(self.popupMonthLoginActivitiesList)
end

function PopupMonthSignActivityComp:CheckPopup()
end

return PopupMonthSignActivityComp
