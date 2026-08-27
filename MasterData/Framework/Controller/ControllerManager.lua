local ControllerManager = class("ControllerManager")

function ControllerManager:ctor()
  self.controllers = {}
end

local function CreateControllerInternal(self, typeId)
  local config = ControllerGlobalConfig[typeId]
  assert(config)
  local controller = config.ControllerClass.New()
  self.controllers[typeId] = controller
  controller.__typeId = typeId
  controller:OnInit()
  return controller
end

function ControllerManager:GetController(typeId, allowCreate)
  if self.controllers[typeId] ~= nil then
    return self.controllers[typeId]
  elseif allowCreate then
    return CreateControllerInternal(self, typeId)
  else
    return nil
  end
end

function ControllerManager:DeleteController(typeId)
  local controller = self.controllers[typeId]
  if controller ~= nil then
    controller:OnDelete()
    self.controllers[typeId] = nil
  end
end

function ControllerManager:DeleteAllController()
  for k, _ in pairs(self.controllers) do
    self:DeleteController(k)
  end
end

return ControllerManager
