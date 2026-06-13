local skActBase = import("character.base.base_role_skillAction")
local basicBase = Util.create_child_mt(skActBase)
basicBase._basicBase = basicBase
basicBase.basicBase = basicBase

function basicBase.setClass(customBasicBase, actBases)
  local ret = customBasicBase or basicBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == basicBase then
    ret = {}
  end
  if ret ~= basicBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.basicBase = ret.basicBase or ret
    UtilTable.fill_table(basicBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function basicBase.new(customBasicBase, role, _cfg)
  local basic = setmetatable({}, customBasicBase)
  basic.base = customBasicBase
  basic.type = Const.SKILL_ACTION_TYPE.BASIC
  customBasicBase:_init(basic, role, _cfg)
  return basic
end

function basicBase._init(customBasicBase, basic, role, _cfg)
  basic.basicBase = customBasicBase
  customBasicBase.skActBase:_init(basic, role, _cfg)
  local cfg = _cfg or {}
  local trans = basic.trans
  trans.prio = cfg.TransPrio or 0
  trans.inertia = cfg.TransInertia or 0
end

function basicBase.isCommon()
end

function basicBase.isBasic()
  return true
end

function basicBase.canStay()
  return false, true
end

function basicBase.isReady()
end

function basicBase.tarPos()
end

function basicBase.start(act)
  local role = act.role
  local roleAct = role.skAct
  if not roleAct.isOver then
    roleAct:onBreak(act)
  end
  act.role:updateAct(act)
  act:onBegin()
end

function basicBase.tick(act)
end

function basicBase.onBefTime(act)
end

function basicBase.onCastTime(act)
end

function basicBase.onBreak(act)
end

function basicBase.onEnd(act)
end

basicBase.check = Const.TURE_FUN
return basicBase
