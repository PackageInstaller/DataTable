local AuraBaseSkill = class("bs_1", LuaSkillBase)
local base = LuaSkillBase
AuraBaseSkill.config = {}

function AuraBaseSkill:CallAura(buffId, buffTier, influenceType, casterRole, range)
  local collisionEnter = BindCallback(self, self.__OnAuraCollisionEnter, buffId, buffTier)
  local collisionExit = BindCallback(self, self.__OnAuraCollisionExit, buffId)
  return LuaSkillCtrl:CallCircledEmissionStraightly(self, casterRole, casterRole, range, 0, influenceType, collisionEnter, nil, collisionExit, nil, false, false, nil, casterRole)
end

function AuraBaseSkill:CallAuraWithTrigger(influenceType, casterRole, range, onAuraEnter, onAuraExit)
  local collisionEnter = BindCallback(self, onAuraEnter)
  local collisionExit = BindCallback(self, onAuraExit)
  return LuaSkillCtrl:CallCircledEmissionStraightly(self, casterRole, casterRole, range, 0, influenceType, collisionEnter, nil, collisionExit, nil, false, false, nil, casterRole)
end

function AuraBaseSkill:__OnAuraCollisionEnter(buffId, buffTier, collider, index, entity)
  LuaSkillCtrl:CallBuff(self, entity, buffId, buffTier)
end

function AuraBaseSkill:__OnAuraCollisionExit(buffId, collider, entity)
  LuaSkillCtrl:DispelBuff(entity, buffId, 0)
end

function AuraBaseSkill:KillAura(auraEmission)
  if auraEmission ~= nil then
    auraEmission:EndAndDisposeEmission()
  end
end

return AuraBaseSkill
