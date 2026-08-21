_class("ActionExistPhantom", AINewNode)
ActionExistPhantom = ActionExistPhantom

function ActionExistPhantom:Constructor()
end

function ActionExistPhantom:OnUpdate()
  local phantoms = self._world:GetGroup(self._world.BW_WEMatchers.Phantom):GetEntities()
  if phantoms and 0 < #phantoms then
    for _, phantom in ipairs(phantoms) do
      if phantom:PhantomComponent():GetOwnerEntityID() == self.m_entityOwn:GetID() and not phantom:HasDeadMark() then
        return AINewNodeStatus.Success
      end
    end
  end
  return AINewNodeStatus.Failure
end
