local this = {}
this.isInitHero = false
this.initQuene = {}

function this:generateSimpleHero(heroId, go, isPlayer, animatorConfig, needLoadedAnimaNameList, entranceType)
  local entity = require(L_EcsConst.aliveType.previewHero).new(L_EcsConst.aliveType.previewHero)
  local avatarData
  if isPlayer then
    avatarData = L_ModStore:getPlayerModData(L_PlayerStore:getSex())
  end
  entity:initPreview(heroId, go, avatarData, animatorConfig, needLoadedAnimaNameList, entranceType)
  return entity
end

function this:generateSimpleHeroAsync(heroId, go, isPlayer, animatorConfig, callback, needLoadedAnimaNameList, entranceType)
  local entity = require(L_EcsConst.aliveType.previewHero).new(L_EcsConst.aliveType.previewHero)
  local avatarData
  if isPlayer then
    avatarData = L_ModStore:getPlayerModData(L_PlayerStore:getSex())
  end
  entity:initPreviewAsync(heroId, go, avatarData, animatorConfig, function()
    if callback then
      callback(entity)
    end
  end, needLoadedAnimaNameList, entranceType)
end

function this:getCallBackHandle()
  if self.triggerStackHandle ~= nil then
    return self.triggerStackHandle
  end
  self.triggerStackHandle = handler(self, self.triggerStackChange)
  return self.triggerStackHandle
end

function this:registerEntityTriggerStack(csEntity)
  if csEntity then
    csEntity.data.onTriggerStackElement:Add(self:getCallBackHandle())
  end
end

function this:unRegisterEntityTriggerStack(csEntity)
  if csEntity and self:getCallBackHandle() ~= nil then
    csEntity.data.onTriggerStackElement:Remove(self:getCallBackHandle())
  end
end

function this:registerCSEntityTriggerStack(csEntity)
  if csEntity then
    L_BattleDataManager:addMonsterCsEntity(csEntity.data.entityId, true, csEntity)
    csEntity.data.onTriggerStackElement:Add(self:getCallBackHandle())
  end
end

function this:unRegisterCSEntityTriggerStack(csEntity)
  if not csEntity then
    return
  end
  L_BattleDataManager:addMonsterCsEntity(csEntity.data.entityId, false)
  if csEntity and self:getCallBackHandle() ~= nil then
    csEntity.data.onTriggerStackElement:Remove(self:getCallBackHandle())
  end
end

function this:triggerStackChange(type, elementId)
  self:sendEvent(self.event.triggerStack, {type = type, elementId = elementId})
end

return this
