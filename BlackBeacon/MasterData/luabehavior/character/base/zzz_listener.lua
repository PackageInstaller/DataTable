local behaviorListener = {}
local listenCondition = {
  on_missile_begin = {
    casterConstrain = true,
    targetConstrain = true,
    idConstrain = {
      123,
      456,
      789
    }
  }
}

function behaviorListener.on_missile_begin(behaviorClass, caster, target, misId)
  local condition = behaviorClass.v_on_missile_listen_condition
  local casterConstrain = condition.casterConstrain
  local targetConstrain = condition.targetConstrain
  local idConstrain = condition.idConstrain
  if idConstrain and not idConstrain[misId] then
    return
  elseif not idConstrain then
    if not casterConstrain and not targetConstrain then
      for _, instance in ipairs(behaviorClass.instances) do
        instance:on_missile_begin()
      end
    end
    if casterConstrain then
      caster.misLogics:onBeginS()
    end
    if targetConstrain then
      target.misLogics:onBeginS()
    end
  elseif idConstrain[misId] then
    if casterConstrain then
      caster.misLogics[misId]:onBeginS()
    end
    if targetConstrain then
    end
  end
  if not (idConstrain and casterConstrain) or not targetConstrain then
    for _, instance in ipairs(behaviorClass.instances) do
      instance:on_missile_begin()
    end
  end
end

return behaviorListener
