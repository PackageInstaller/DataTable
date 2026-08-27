ControllerBase = class("ControllerBase")

function ControllerBase:OnInit()
end

function ControllerBase:OnDelete()
end

function ControllerBase:Delete()
  ControllerManager:DeleteController(self.__typeId)
end

return ControllerBase
