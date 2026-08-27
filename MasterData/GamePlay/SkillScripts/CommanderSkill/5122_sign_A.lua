local bs_5122 = class("bs_5122", LuaSkillBase)
local base = LuaSkillBase
bs_5122.config = {
  effectIdAttack = 512201,
  buffId = 512201,
  HurtConfig = {basehurt_formula = 10136},
  audioId_start = 140,
  audioId_hit = 141
}

function bs_5122:ctor()
end

function bs_5122:InitSkill(isMidwaySkill)
end

function bs_5122:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5122:CallSelectExecute(role)
  if role ~= nil and role ~= nil and role.belongNum ~= self.caster.belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, self.config.audioId_start)
  end
end

function bs_5122:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, self.cskill.level, self.arglist[1])
  end
end

function bs_5122:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5122
