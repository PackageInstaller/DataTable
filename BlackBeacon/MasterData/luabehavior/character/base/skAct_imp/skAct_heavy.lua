local skActBase = import("character.base.base_role_skillAction")
local heavyBase = Util.create_child_mt(skActBase)
heavyBase._heavyBase = heavyBase
heavyBase.heavyBase = heavyBase

function heavyBase.setClass(customHeavyBase, actBases)
  local ret = customHeavyBase or heavyBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == heavyBase then
    ret = {}
  end
  if ret ~= heavyBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.heavyBase = ret.heavyBase or ret
    UtilTable.fill_table(heavyBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function heavyBase.new(customHeavyBase, role, _cfg)
  local heavy = setmetatable({}, customHeavyBase)
  heavy.base = customHeavyBase
  heavy.type = Const.SKILL_ACTION_TYPE.HEAVY
  customHeavyBase:_init(heavy, role, _cfg)
  return heavy
end

function heavyBase._init(customHeavyBase, heavy, role, _cfg)
  heavy.heavyBase = customHeavyBase
  customHeavyBase.skActBase:_init(heavy, role, _cfg)
  local cfg = _cfg or {}
  local trans = heavy.trans
  trans.prio = cfg.TransPrio or 2
  trans.inertia = cfg.TransInertia or 2
end

function heavyBase.isCommon()
end

function heavyBase.isHeavy()
  return true
end

return heavyBase
