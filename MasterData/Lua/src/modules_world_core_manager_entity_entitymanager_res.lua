local this = {}

function this:destroyEntity(entity)
  self:sendEvent(self.event.destroyEntity, entity)
  local cEntityId = entity.csEntity.entity.data.entityId
  entity:onDestroy()
  C_EntityManager.RemoveEntityWithEntityId(cEntityId)
end

return this
