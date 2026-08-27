local bs_5121 = class("bs_5121", LuaSkillBase)
local base = LuaSkillBase
bs_5121.config = {
  effectIdAttack = 512101,
  buffId = 512101,
  audioId_start = 138,
  audioId_hit = 139
}

function bs_5121:ctor()
end

function bs_5121:InitSkill(isMidwaySkill)
end

function bs_5121:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5121:CheckManualSkillTakeAvailable(role)
  local available = base.CheckManualSkillTakeAvailable(self, role)
  if not available then
    return false
  end
  if role.belongNum == self.caster.belongNum then
    return false
  end
  return true
end

function bs_5121:CallSelectExecute(role)
  LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
  LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
end

function bs_5121:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5121:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5121
