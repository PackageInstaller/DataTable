_class("UIAircraftEvilInfoController", UIController)
UIAircraftEvilInfoController = UIAircraftEvilInfoController

function UIAircraftEvilInfoController:OnShow(uiParams)
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

function UIAircraftEvilInfoController:InitWidget()
  self.topbar = self:GetUIComponent("UISelectObjectPath", "Topbar")
  self.evilShow = self:GetUIComponent("UISelectObjectPath", "EvilShow")
end
