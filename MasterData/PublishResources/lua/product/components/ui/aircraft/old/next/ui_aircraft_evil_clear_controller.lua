_class("UIAircraftEvilClearController", UIController)
UIAircraftEvilClearController = UIAircraftEvilClearController

function UIAircraftEvilClearController:OnShow(uiParams)
  self:InitWidget()
  self.topBarWidget = self.topbar:SpawnObject("UIAircraftTopBarItem")
  self.topBarWidget:SetData(true, function()
    self:CloseDialog()
  end, function()
    ToastManager.ShowToast(StringTable.Get("str_aircraft_function_not_open"))
  end)
  self.evilShowWidget = self.evilShow:SpawnObject("UIAircraftEvilShowItem")
  self.evilShowWidget:SetData({
    1,
    2,
    3,
    4,
    5,
    6
  })
end

function UIAircraftEvilClearController:InitWidget()
  self.topbar = self:GetUIComponent("UISelectObjectPath", "Topbar")
  self.evilShow = self:GetUIComponent("UISelectObjectPath", "EvilShow")
end
