local monsterGroup = {}
monsterGroup.__index = monsterGroup

function monsterGroup.setUp(monsterGroup)
  local monsterGroup = monsterGroup
  monsterGroup.tool = ComnMgr.MonsterTool
end

function monsterGroup.insertFun(group, funName, newFun)
  group.tool.insert(group, funName, newFun)
end

function monsterGroup.removeFun(group, funName, newFun)
  group.tool.remove(group, funName, newFun)
end

function monsterGroup.new(base, aiId)
  if 0 == aiId then
    Log.Error("group ai id returns 0, ", debug.traceback())
  end
  local result = setmetatable({}, base)
  result.aiId = aiId
  local cfg = get_group_ai_cfg(aiId)
  local atkSlots = {
    melee = {
      max = cfg.MeleeMax,
      slotCd = cfg.MeleeSlotCd,
      interval = cfg.MeleeInterval,
      timer = 0,
      slots = {}
    },
    ranged = {
      max = cfg.RangedMax,
      slotCd = cfg.RangedSlotCd,
      interval = cfg.RangedInterval,
      timer = 0,
      slots = {}
    },
    counter = {
      max = cfg.CounterMax,
      slotCd = cfg.CounterSlotCd,
      interval = cfg.CounterInterval,
      timer = 0,
      slots = {}
    }
  }
  for i = 1, atkSlots.melee.max do
    atkSlots.melee.slots[i] = {isOccupied = false, timer = 0}
  end
  for i = 1, atkSlots.ranged.max do
    atkSlots.ranged.slots[i] = {isOccupied = false, timer = 0}
  end
  for i = 1, atkSlots.counter.max do
    atkSlots.counter.slots[i] = {isOccupied = false, timer = 0}
  end
  result.base = base
  result.atkSlots = atkSlots
  result.npcList = {}
  result.npcNum = 0
  return result
end

function monsterGroup.getNpcNum(group)
  return group.npcNum
end

function monsterGroup.addNpc(group, npc)
  if group.npcList[npc] then
    return
  end
  group.npcList[npc] = npc
  group.npcNum = group.npcNum + 1
end

function monsterGroup.removeNpc(group, npc)
  if not group.npcList[npc] then
    return
  end
  if 0 == group.npcNum then
    Log.Error("groupBase.removeNpc is called, but npcList is already empty, ", debug.traceback())
  end
  group.npcList[npc] = nil
  group.npcNum = group.npcNum - 1
  if 0 == group.npcNum then
    group:onClear()
  end
end

function monsterGroup.onClear(group)
  group:clearCd()
end

function monsterGroup.clearCd(group)
  group.atkSlots.melee.timer = 0
  for _, slot in ipairs(group.atkSlots.melee.slots) do
    slot.isOccupied = false
    slot.timer = 0
  end
  group.atkSlots.ranged.timer = 0
  for _, slot in ipairs(group.atkSlots.ranged.slots) do
    slot.isOccupied = false
    slot.timer = 0
  end
end

function monsterGroup.has_melee_atk_slot(group, monster)
  local melee = group.atkSlots.melee
  local cdNum = 0
  local now = get_time()
  if now < melee.timer then
    return false
  end
  for _, slot in ipairs(melee.slots) do
    if slot.isOccupied or now < slot.timer then
      cdNum = cdNum + 1
    end
  end
  if cdNum >= melee.max then
    return false
  else
    return true
  end
end

function monsterGroup.occupy_melee_atk_slot(group, monster)
  local melee = group.atkSlots.melee
  local slot
  local now = get_time()
  for _, _slot in ipairs(melee.slots) do
    if not _slot.isOccupied and now > _slot.timer then
      slot = _slot
      break
    end
  end
  if slot then
    slot.isOccupied = true
  else
    slot = {isOccupied = true, timer = 0}
    table.insert(melee.slots, slot)
  end
  melee.timer = now + melee.interval
  return slot
end

function monsterGroup.release_melee_atk_slot(group, monster, slot)
  slot.timer = get_time() + group.atkSlots.melee.slotCd
  slot.isOccupied = false
end

function monsterGroup.has_ranged_atk_slot(group, monster)
  local ranged = group.atkSlots.ranged
  local cdNum = 0
  local now = get_time()
  if now < ranged.timer then
    return false
  end
  for _, slot in ipairs(ranged.slots) do
    if slot.isOccupied or now < slot.timer then
      cdNum = cdNum + 1
    end
  end
  if cdNum >= ranged.max then
    return false
  else
    return true
  end
end

function monsterGroup.occupy_ranged_atk_slot(group, monster)
  local ranged = group.atkSlots.ranged
  local slot
  local now = get_time()
  for _, _slot in ipairs(ranged.slots) do
    if not _slot.isOccupied and now > _slot.timer then
      slot = _slot
      break
    end
  end
  if slot then
    slot.isOccupied = true
  else
    slot = {isOccupied = true, timer = 0}
    table.insert(ranged.slots, slot)
  end
  ranged.timer = now + ranged.interval
  return slot
end

function monsterGroup.release_ranged_atk_slot(group, monster, slot)
  slot.timer = get_time() + group.atkSlots.ranged.slotCd
  slot.isOccupied = false
end

function monsterGroup.has_counter_atk_slot(group, monster)
  local counter = group.atkSlots.counter
  local cdNum = 0
  local now = get_time()
  if now < counter.timer then
    return false
  end
  for _, slot in ipairs(counter.slots) do
    if slot.isOccupied or now < slot.timer then
      cdNum = cdNum + 1
    end
  end
  if cdNum >= counter.max then
    return false
  else
    return true
  end
end

function monsterGroup.occupy_counter_atk_slot(group, monster)
  local counter = group.atkSlots.counter
  local slot
  local now = get_time()
  for _, _slot in ipairs(counter.slots) do
    if not _slot.isOccupied and now > _slot.timer then
      slot = _slot
      break
    end
  end
  if slot then
    slot.isOccupied = true
  else
    slot = {isOccupied = true, timer = 0}
    table.insert(counter.slots, slot)
  end
  counter.timer = now + counter.interval
  return slot
end

function monsterGroup.release_counter_atk_slot(group, monster, slot)
  slot.timer = get_time() + group.atkSlots.counter.slotCd
  slot.isOccupied = false
end

return monsterGroup
