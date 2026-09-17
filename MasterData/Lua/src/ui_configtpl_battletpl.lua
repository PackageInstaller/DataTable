local this = class("battleTpl")

function this:init(cfg)
  self.cfg = cfg
end

function this:getTplById(id)
  return self.cfg[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getOpening(tpl)
  return tpl.opening
end

function this:getBirthPosition(tpl)
  local p = tpl.birthPosition
  return L_Vector3.new(p[1], p[2], p[3])
end

function this:getBirthRotation(tpl)
  local p = tpl.birthRotation
  return L_Vector3.new(p[1], p[2], p[3])
end

function this:getBattleZoneId(tpl)
  return tpl.battleZoneId
end

function this:getTeleportBattleType(tpl)
  return tpl.battleType or L_Const.teleportBattleType.nowTeleportBattle
end

function this:getIsDefaultWin(tpl)
  return tpl.isDefaultWin == 1
end

function this:getBattleType(tpl)
  return tpl.battleType
end

function this:getBattleFsmPath(tpl)
  return tpl.battleFsm
end

return this
