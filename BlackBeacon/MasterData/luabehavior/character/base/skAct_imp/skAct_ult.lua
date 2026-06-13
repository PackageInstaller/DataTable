local skActBase = import("character.base.base_role_skillAction")
local ultMgr = import("character.base.base_ultManager")
local mathx = require("base.mathx")
local ultBase = Util.create_child_mt(skActBase)
ultBase._ultBase = ultBase
ultBase.ultBase = ultBase

function ultBase.setClass(customUltBase, actBases)
  local ret = customUltBase or ultBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == ultBase then
    ret = {}
  end
  if ret ~= ultBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.ultBase = ret.ultBase or ret
    UtilTable.fill_table(ultBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function ultBase.new(customUltBase, role, _cfg)
  local ult = setmetatable({}, customUltBase)
  ult.base = customUltBase
  ult.type = Const.SKILL_ACTION_TYPE.ULT
  customUltBase:_init(ult, role, _cfg)
  return ult
end

function ultBase._init(customUltBase, ult, role, _cfg)
  ult.ultBase = customUltBase
  customUltBase.skActBase:_init(ult, role, _cfg)
  local cfg = _cfg or {}
  local trans = ult.trans
  trans.prio = cfg.TransPrio or 5
  trans.inertia = cfg.TransInertia or 5
  ult.ultMgr = ultMgr
  ult.hideList = role.ultHideList
  ult.invulMagic = Const.ULT_INVUL
end

function ultBase.passLinkFrame(ult)
  ult.is_link_frame_passed = true
end

function ultBase.isCommon()
end

function ultBase.isUlt()
  return true
end

function ultBase.showUpPos(ult)
  local newRole = ult.role
  local tool = newRole.tool
  local oldRole = tool.curRole
  local target = newRole.target
  local showUpPos = newRole._showUpPos
  local oldRolePos = oldRole.npc:get_pos_vec3()
  local idealDist = ult.startDist
  if not idealDist then
    newRole:debugOutput("ultBase.showUpPos is called but ult.startDist is lost, ultAct is " .. ult.name)
    idealDist = 5
  end
  if not target then
    local inputDir = oldRole:inputDir()
    if not inputDir then
      return showUpPos:SetB(oldRolePos)
    else
      return showUpPos:SetB(inputDir):Mul(idealDist):Add(oldRolePos)
    end
  end
  local tarPos = target:get_pos_vec3()
  local x, z = oldRolePos.x - tarPos.x, oldRolePos.z - tarPos.z
  x, z = mathx.normalize2(x, z)
  x = x * idealDist
  z = z * idealDist
  showUpPos:Set(tarPos.x + x, oldRolePos.y, tarPos.z + z)
  return showUpPos
end

function ultBase.canEvade()
  return false
end

function ultBase.start(ult, event)
  local role = ult.role
  cast_magic(role.npc, role.npc, ult.invulMagic)
  ult.is_link_frame_passed = false
  ult.ultMgr:onUltBegin(ult)
  if not event or not event.isSwitch then
    role.tool:teamClearStay()
  end
  return ult.skActBase.start(ult, event)
end

function ultBase.onCloseUpEnd(ult)
  set_all_npc_hp_visible(true)
  return ult.ultMgr:onCloseUpEnd(ult)
end

function ultBase.onBefTime(ult)
  ult.skActBase.onBefTime(ult)
  return ult.ultMgr:onUltBefTime(ult)
end

function ultBase.onCastTime(ult, retainCache, ignoreIcon)
  ult.skActBase.onCastTime(ult, retainCache, ignoreIcon)
  return ult.ultMgr:onUltCastTime(ult)
end

function ultBase.onEnd(ult)
  abort_magic_by_id(ult.role.npc, ult.invulMagic)
  return ult.skActBase.onEnd(ult)
end

function ultBase.onBreak(ult, tarAct)
  abort_magic_by_id(ult.role.npc, ult.invulMagic)
  ult.skActBase.onBreak(ult, tarAct)
  return ult.ultMgr:onUltBreak(ult, tarAct)
end

function ultBase.showUpFx(ult)
  local role = ult.role
  local facePos = get_npc_offset_position(role.npc, nil, 0, 10)
  local chestPos = get_npc_pos(role.npc, "Bip001 Chest")
  chestPos.y = chestPos.y - 0.15
  local roleNpc = role.npc
  if not role:isInRealStay() then
    cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK1_TIMER)
    cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK2_TIMER)
  end
  cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK_OUTLINE)
  create_scene_effect(Const.SWITCH_CONFIG.TO_FRONT_FLASH_QTE, chestPos, 5, nil, facePos, true)
end

function ultBase.canStay(ult)
  if ult.isCastOver then
    if get_npc_time(ult.role.npc) - ult.castOverTime > 0.75 then
      return false, true
    else
      return false, false
    end
  else
    return true
  end
end

function ultBase.needStopTimer(ult)
  local ret = not ult.isCastOver and not ult.isOver
  return ret, ret
end

return ultBase
