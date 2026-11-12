local DormJoystickCtrl = class("DormJoystickCtrl", BaseCtrl)
DormJoystickCtrl._mapNodeConfig = {
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
DormJoystickCtrl._mapEventConfig = {
  Dorm_Select_Obj = "OnEvent_DormSelectObj",
  Dorm_Enter_Edit_Mode = "OnEvent_EnterEditMode"
}

function DormJoystickCtrl:Awake()
  self.DormPlaceObjectCS = nil
  if NovaAPI.GetCurrentModuleName() == "DormModuleScene" then
    NovaAPI.DispatchEventWithData("DormJoystickPrefabLoadComplete")
  end
end

function DormJoystickCtrl:OnSliderValueChange(_, value)
  local nValue = value
  if nValue == 0.5 then
    self.DormPlaceObjectCS.gameObject.transform.eulerAngles = Vector3.zero
  elseif nValue < 0.5 then
    local tmxY = 360 - (0.5 - nValue) * 360
    self.DormPlaceObjectCS.gameObject.transform.eulerAngles = Vector3(0, tmxY, 0)
  else
    local tmxY = (nValue - 0.5) * 360
    self.DormPlaceObjectCS.gameObject.transform.eulerAngles = Vector3(0, tmxY, 0)
  end
end

function DormJoystickCtrl:OnBtn_Sure()
  if self.DormPlaceObjectCS.isCollision then
    EventManager.Hit(EventId.OpenMessageBox, "摆放位置有误")
    return
  end
  self._mapNode.placeRoot:SetActive(false)
  self.DormPlaceObjectCS:SavePlaneMsg()
  self.DormPlaceObjectCS = nil
end

function DormJoystickCtrl:OnBtn_Cancel()
  self._mapNode.placeRoot:SetActive(false)
  self.DormPlaceObjectCS:QuitEditMode()
  self.DormPlaceObjectCS = nil
end

function DormJoystickCtrl:OnBtn_Back()
  NovaAPI.EnterModule("MainMenuModuleScene", true)
end

function DormJoystickCtrl:OnEvent_EnterEditMode()
  self._mapNode.placeRoot:SetActive(true)
end

function DormJoystickCtrl:OnEvent_CampingSelectObj(obj)
  self.DormPlaceObjectCS = nil
  self.DormPlaceObjectCS = obj:GetComponent("DormPlaceObject")
  self.tmxY = math.fmod(obj.transform.eulerAngles.y, 360)
  if self.tmxY == 0 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5)
  elseif self.tmxY > 0 and self.tmxY <= 180 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 + self.tmxY / 180 * 0.5)
  else
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 - (360 - self.tmxY) / 180 * 0.5)
  end
end

function DormJoystickCtrl:OnBtn_CancelRound()
  if self.tmxY == 0 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5)
  elseif self.tmxY > 0 and self.tmxY <= 180 then
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 + self.tmxY / 180 * 0.5)
  else
    NovaAPI.SetSliderValue(self._mapNode.Slider, 0.5 - (360 - self.tmxY) / 180 * 0.5)
  end
end

return DormJoystickCtrl
