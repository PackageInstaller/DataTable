local skActBase = import("character.base.base_role_skillAction")
local qteMgr = import("character.base.base_qteManager")
local qteBase = Util.create_child_mt(skActBase)
qteBase._qteBase = qteBase
qteBase.qteBase = qteBase
qteBase.invulMagic = Const.SWITCH_CONFIG.QTE_INVUL

function qteBase.setClass(customQteBase, actBases)
  local ret = customQteBase or qteBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == qteBase then
    ret = {}
  end
  if ret ~= qteBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.qteBase = ret.qteBase or ret
    UtilTable.fill_table(qteBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function qteBase.new(customQteBase, role, _cfg)
  local qte = setmetatable({}, customQteBase)
  qte.base = customQteBase
  qte.type = Const.SKILL_ACTION_TYPE.QTE
  customQteBase:_init(qte, role, _cfg)
  return qte
end

function qteBase._init(customQteBase, qte, role, _cfg)
  qte.qteBase = customQteBase
  customQteBase.skActBase:_init(qte, role, _cfg)
  local cfg = _cfg or {}
  local trans = qte.trans
  trans.prio = cfg.TransPrio or 3
  trans.inertia = cfg.TransInertia or 2
end

function qteBase.isCommon()
end

function qteBase.isQte()
  return true
end

function qteBase.isReady(qte)
  if not qte.role.target then
    return false
  end
  if not qte.skActBase.isReady(qte) then
    return false
  end
  return true
end

function qteBase.tarPos(qte)
  local role = qte.role
  local target = role.target
  if not target then
    return
  end
  qte.target = target
  local tarPos = role._tarPos
  return tarPos:SetB(target:get_pos_vec3())
end

function qteBase.onBegin(qte)
  local roleNpc = qte.role.npc
  cast_magic(roleNpc, roleNpc, qte.invulMagic)
  qte.skActBase.onBegin(qte)
end

function qteBase.onCastTime(qte, retainCache, ignoreIcon)
  abort_magic_by_id(qte.role.npc, qte.invulMagic)
  qte.skActBase.onCastTime(qte, retainCache, ignoreIcon)
end

function qteBase.onBreak(qte, tarAct)
  if not qte.isCastOver then
    abort_magic_by_id(qte.role.npc, qte.invulMagic)
  end
  qte.skActBase.onBreak(qte, tarAct)
end

function qteBase.onEnd(qte)
  if not qte.isCastOver then
    abort_magic_by_id(qte.role.npc, qte.invulMagic)
  end
  qte.skActBase.onEnd(qte)
end

qteBase.showUpPos = qteMgr.showUpPos_byTarget
return qteBase
