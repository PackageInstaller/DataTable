local CampingJoystickCtrl = class("CampingJoystickCtrl", BaseCtrl)
CampingJoystickCtrl._mapNodeConfig = {
  placeRoot = {},
  Slider = {
    sComponentName = "Slider",
    callback = "OnSliderValueChange"
  },
  btnSure = {sComponentName = "UIButton", callback = "OnBtn_Sure"},
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtn_Cancel"
  },
  btnBack = {sComponentName = "UIButton", callback = "OnBtn_Back"},
  btnCancelRound = {
    sComponentName = "UIButton",
    callback = "OnBtn_CancelRound"
  }
}
CampingJoystickCtrl._mapEventConfig = {
  Camping_Select_Obj = "OnEvent_CampingSelectObj",
  Camping_Enter_Edit_Mode = "OnEvent_EnterEditMode"
}

function CampingJoystickCtrl:Awake()
  self.CampingPlaceObjectCS = nil
  if NovaAPI.GetCurrentModuleName() == "CampingModuleScene" then
    CS.AdventureModuleHelper.CampingModuleLoadComplete()
  end
end

function CampingJoystickCtrl:OnSliderValueChange(_, value)
  local nValue = value
  if nValue == 0.5 then
    self.CampingPlaceObjectCS.gameObject.transform.eulerAngles = Vector3.zero
  elseif nValue < 0.5 then
    local tmxY = 360 - (0.5 - nValue) * 360
    self.CampingPlaceObjectCS.gameObject.transform.eulerAngles = Vector3(0, tmxY, 0)
  else
    local tmxY = (nValue - 0.5) * 360
    self.CampingPlaceObjectCS.gameObject.transform.eulerAngles = Vector3(0, tmxY, 0)
  end
end

function CampingJoystickCtrl:OnBtn_Sure()
  if self.CampingPlaceObjectCS.isCollision then
    EventManager.Hit(EventId.OpenMessageBox, "摆放位置有误")
    return
  end
  self._mapNode.placeRoot:SetActive(false)
  self.CampingPlaceObjectCS:SavePlaneMsg()
  self.CampingPlaceObjectCS = nil
end

function CampingJoystickCtrl:OnBtn_Cancel()
  self._mapNode.placeRoot:SetActive(false)
  self.CampingPlaceObjectCS:QuitEditMode()
  self.CampingPlaceObjectCS = nil
end

function CampingJoystickCtrl:OnBtn_Back()
  NovaAPI.EnterModule("MainMenuModuleScene", true)
end

function CampingJoystickCtrl:OnEvent_EnterEditMode()
  self._mapNode.placeRoot:SetActive(true)
end

function CampingJoystickCtrl:OnEvent_CampingSelectObj(obj)
  self.CampingPlaceObjectCS = nil
  self.CampingPlaceObjectCS = obj:GetComponent("CampingPlaceObject")
  self.tmxY = math.fmod(obj.transform.eulerAngles.y, 360)
  if self.tmxY == 0 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5)
  elseif self.tmxY > 0 and self.tmxY <= 180 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 + self.tmxY / 180 * 0.5)
  else
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 - (360 - self.tmxY) / 180 * 0.5)
  end
end

function CampingJoystickCtrl:OnBtn_CancelRound()
  if self.tmxY == 0 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5)
  elseif self.tmxY > 0 and self.tmxY <= 180 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 + self.tmxY / 180 * 0.5)
  else
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 - (360 - self.tmxY) / 180 * 0.5)
  end
end

return CampingJoystickCtrl
