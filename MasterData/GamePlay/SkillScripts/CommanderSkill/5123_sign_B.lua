local bs_5123 = class("bs_5123", LuaSkillBase)
local base = LuaSkillBase
bs_5123.config = {
  effectIdAttack = 512301,
  buffId = 512301,
  audioId_start = 142,
  audioId_hit = 143
}

function bs_5123:ctor()
end

function bs_5123:InitSkill(isMidwaySkill)
end

function bs_5123:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5123:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
  end
end

function bs_5123:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5123:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5123
