local skActBase = import("character.base.base_role_skillAction")
local counterBase = Util.create_child_mt(skActBase)
counterBase._counterBase = counterBase
counterBase.counterBase = counterBase

function counterBase.setClass(customCounterBase, actBases)
  local ret = customCounterBase or counterBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == counterBase then
    ret = {}
  end
  if ret ~= counterBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.counterBase = ret.counterBase or ret
    UtilTable.fill_table(counterBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function counterBase.new(customCounterBase, role, _cfg)
  local counter = setmetatable({}, customCounterBase)
  counter.base = customCounterBase
  counter.type = Const.SKILL_ACTION_TYPE.COUNTER
  customCounterBase:_init(counter, role, _cfg)
  return counter
end

function counterBase._init(customCounterBase, counter, role, _cfg)
  counter.counterBase = counterBase
  customCounterBase.skActBase:_init(counter, role, _cfg)
  local cfg = _cfg or {}
  counter.trans.prio = cfg.TransPrio or 5
  counter.trans.inertia = cfg.TransInertia or 2
  local COUNTER = Const.DEFEND.COUNTER
  counter.fx = COUNTER.FX
  counter.invual = COUNTER.INVUL
end

function counterBase.isCommon()
end

function counterBase.isCounter()
  return true
end

function counterBase.isReady(counter)
  if not counter.role:canCounter() then
    return false
  end
  if not counter.skActBase.isReady(counter) then
    return false
  end
  return true
end

function counterBase.onBegin(counter)
  counter.skActBase.onBegin(counter)
  local role = counter.role
  local roleNpc = role.npc
  cast_magic(roleNpc, roleNpc, counter.fx)
  cast_magic(roleNpc, roleNpc, counter.invual)
end

function counterBase.onCastTime(counter, retainCache, ignoreIcon)
  local role = counter.role
  local roleNpc = role.npc
  abort_magic_by_id(roleNpc, counter.invual)
  counter.skActBase.onCastTime(counter, retainCache, ignoreIcon)
end

function counterBase.onBreak(counter, tarAct)
  if not counter.isCastOver then
    abort_magic_by_id(counter.role.npc, counter.invual)
  end
  counter.skActBase.onBreak(counter, tarAct)
end

return counterBase
