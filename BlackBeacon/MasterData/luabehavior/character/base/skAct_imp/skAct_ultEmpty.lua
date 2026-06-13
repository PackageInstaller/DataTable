local skActBase = import("character.base.base_role_skillAction")
local ultEmptyBase = Util.create_child_mt(skActBase)
ultEmptyBase._ultEmptyBase = ultEmptyBase
ultEmptyBase.ultEmptyBase = ultEmptyBase
local ultMgr = import("character.base.base_ultManager")

function ultEmptyBase.setClass(customUltEmptyBase, actBases)
  local ret = customUltEmptyBase or ultEmptyBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == ultEmptyBase then
    ret = {}
  end
  if ret ~= ultEmptyBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.ultEmptyBase = ret.ultEmptyBase or ret
    UtilTable.fill_table(ultEmptyBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function ultEmptyBase.new(customUltEmptyBase, role, _cfg)
  local ult = setmetatable({}, customUltEmptyBase)
  ult.base = customUltEmptyBase
  ult.type = Const.SKILL_ACTION_TYPE.ULT_EMPTY
  customUltEmptyBase:_init(ult, role, _cfg)
  return ult
end

function ultEmptyBase._init(customUltEmptyBase, ult, role, _cfg)
  local ult = ult
  ult.ultEmptyBase = ultEmptyBase
  customUltEmptyBase.skActBase:_init(ult, role, _cfg)
  ult.ultMgr = ultMgr
end

function ultEmptyBase.isCommon()
end

function ultEmptyBase.isUltEmpty()
  return true
end

function ultEmptyBase.showUpPos()
end

function ultEmptyBase.canEvade()
end

function ultEmptyBase.transCheck()
  return true
end

function ultEmptyBase.isReady(ultEmpty)
  local ultMgr = ultEmpty.ultMgr
  local role = ultEmpty.role
  if not ultMgr.isInCloseUp then
    return false
  end
  if role:isInControl() then
    return false
  end
  if ultMgr:isCloseUpDone(role) then
    return false
  end
  return true
end

function ultEmptyBase.tarPos()
end

function ultEmptyBase.onBegin(ultEmpty)
  ultEmpty.role.need_fast_ult = true
  ultEmpty.skActBase.onBegin(ultEmpty)
end

function ultEmptyBase.onCastTime(ultEmpty)
  ultEmpty.isCastOver = true
end

function ultEmptyBase.canStay()
end

function ultEmptyBase.needStopTimer(ultEmpty)
  local ret = not ultEmpty.isCastOver and not ultEmpty.isOver
  return ret, ret
end

return ultEmptyBase
