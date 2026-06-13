local listener = {}

local function cbAll(instance, mis)
end

local function cbCaster(instance, mis)
end

local function cbTarget(instance, mis)
end

local function cbId1(instance, mis)
end

local function cbId2(instance, mis)
end

local switch = {
  on_missile_begin = {
    all = cbAll,
    caster = cbCaster,
    target = cbTarget,
    id = {
      [123] = cbId1,
      [456] = cbId2
    }
  }
}

function listener.on_missile_begin(behaviorClass, caster, target, misId, mis)
  local switch = switch.on_missile_begin
  local instList = listener.instances
  local cbAll = switch.all
  if cbAll then
    for _, instance in pairs(instList) do
      cbAll(instance, mis)
    end
  end
  local cbCaster = switch.caster
  if cbCaster then
    cbCaster(instList[caster], mis)
  end
  local cbTarget = switch.target
  if cbTarget then
    cbTarget(instList[target], mis)
  end
  local cbId = switch.id[misId]
  if cbId then
    for _, instance in pairs(instList) do
      cbId(instance, mis)
    end
  end
end

return listener
