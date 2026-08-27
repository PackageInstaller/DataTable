local UIDormInput = class("UIDormInput", UIBaseWindow)
local base = UIBaseWindow

function UIDormInput:OnInit()
  self.__onJoystickMove = BindCallback(self, self.OnJoystickMove)
  self.ui.joystick:onTouchMove("+", self.__onJoystickMove)
  self.__onJoystickUp = BindCallback(self, self.OnJoystickUp)
  self.ui.joystick:onTouchUp("+", self.__onJoystickUp)
end

function UIDormInput:InitDormInput(joystickMoveAction, joystickUpAction)
  self.__joyStickMoveAction = joystickMoveAction
  self.__joystickUpAction = joystickUpAction
end

function UIDormInput:OnJoystickMove(moveData)
  if self.__joyStickMoveAction ~= nil then
    self.__joyStickMoveAction(moveData)
  end
end

function UIDormInput:OnJoystickUp()
  if self.__joystickUpAction ~= nil then
    self.__joystickUpAction()
  end
end

function UIDormInput:OnDelete()
  self.__joyStickMoveAction = nil
  base.OnDelete(self)
end

return UIDormInput
