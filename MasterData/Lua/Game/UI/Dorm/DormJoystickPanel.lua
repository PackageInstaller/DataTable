local DormJoystickPanel = class("DormJoystickPanel", BasePanel)
DormJoystickPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormJoystick.prefab",
    sCtrlName = "Game.UI.Dorm.DormJoystickCtrl"
  }
}

function DormJoystickPanel:Awake()
end

function DormJoystickPanel:OnEnable()
end

function DormJoystickPanel:OnDisable()
end

function DormJoystickPanel:OnDestroy()
end

return DormJoystickPanel
