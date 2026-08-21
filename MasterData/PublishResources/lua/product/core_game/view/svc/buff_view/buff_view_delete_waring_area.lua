_class("BuffViewDeleteWaringArea", BuffViewBase)
BuffViewDeleteWaringArea = BuffViewDeleteWaringArea

function BuffViewDeleteWaringArea:PlayView(TT, notify)
  local result = self._buffResult
  local skillHolderID = result:GetSkillHolderID()
  local skillHolder = self._world:GetEntityByID(skillHolderID)
  if not skillHolder then
    return
  end
  local world = self._world
  local group = world:GetGroup(world.BW_WEMatchers.DamageWarningAreaElement)
  local pubListEntity = group:GetEntities()
  local listEntity = {}
  for _, entity in ipairs(pubListEntity) do
    local cmpt = entity:DamageWarningAreaElement()
    if cmpt:GetOwnerEntityID() and cmpt:GetOwnerEntityID() == skillHolder:GetID() then
      table.insert(listEntity, entity)
    end
  end
  local entityPoolSvcR = world:GetService("EntityPool")
  for i = 1, #listEntity do
    local entityWork = listEntity[i]
    local cmpt = entityWork:DamageWarningAreaElement()
    local entityConfigID = cmpt:GetEntityConfigID()
    if entityConfigID then
      entityPoolSvcR:DestroyCacheEntity(entityWork, entityConfigID)
    else
      entityPoolSvcR:DestroyCacheEntity(entityWork, EntityConfigIDRender.WarningArea)
    end
    cmpt:ClearOwnerEntityID()
  end
  local fxHoldCmpt = skillHolder:EffectHolder()
  if not fxHoldCmpt then
    return
  end
  local dicFxHeld = fxHoldCmpt:GetEffectIDEntityDic()
  local lstFx = dicFxHeld[self._warningTextEffectID]
  if not lstFx then
    return
  end
  local fxSvc = world:GetService("Effect")
  for _, eid in pairs(lstFx) do
    local e = world:GetEntityByID(eid)
    if e then
      world:DestroyEntity(e)
    end
  end
  dicFxHeld[self._warningTextEffectID] = nil
end
