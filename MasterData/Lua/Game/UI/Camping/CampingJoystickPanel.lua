local CampingJoystickPanel = class("CampingJoystickPanel", BasePanel)
CampingJoystickPanel._tbDefine = {
  {
    sPrefabPath = "Campaing/CampingJoystick.prefab",
    sCtrlName = "Game.UI.Camping.CampingJoystickCtrl"
  }
}

function CampingJoystickPanel:Awake()
end

function CampingJoystickPanel:OnEnable()
end

function CampingJoystickPanel:OnDisable()
end

function CampingJoystickPanel:OnDestroy()
end

return CampingJoystickPanel
