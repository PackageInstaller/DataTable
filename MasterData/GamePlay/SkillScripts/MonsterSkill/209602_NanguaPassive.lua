local bs_209602 = class("bs_209602", LuaSkillBase)
local base = LuaSkillBase
bs_209602.config = {
  effectId1 = 2007205,
  configId = 3,
  realDamage = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0,
    correct_formula = 0
  },
  effectIdAttack = 10953
}

function bs_209602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_209602_165464", 99, self.OnRoleDie, nil, self.caster)
  self.time = 0
end

function bs_209602:OnRoleDie(killer, role)
  if killer.belongNum ~= self.caster.belongNum and killer.hp > 0 and self.time == 0 and role == self.caster then
    LuaSkillCtrl:CallEffectWithArg(killer, self.config.effectId1, self, false, false, self.OnEffectTrigger, killer)
    self.time = self.time + 1
    base.OnCasterDie(self)
  end
end

function bs_209602:OnEffectTrigger(targetRole, effect, eventId, target)
  if effect.dataId == self.config.effectId1 and eventId == eBattleEffectEvent.Trigger and targetRole ~= nil then
    local realHurt = targetRole.maxHp * self.arglist[1] // 1000
    if realHurt <= 0 then
      realHurt = 1
    end
    LuaSkillCtrl:CallRealDamage(self, targetRole, nil, self.config.realDamage, {realHurt}, true)
  end
end

function bs_209602:OnCasterDie()
end

function bs_209602:LuaDispose()
  base.LuaDispose(self)
end

return bs_209602
