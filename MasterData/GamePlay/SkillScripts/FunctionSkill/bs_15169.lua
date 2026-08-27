local bs_15169 = class("bs_15169", LuaSkillBase)
local base = LuaSkillBase
bs_15169.config = {
  pf_dataId = 116,
  effect_heal = 111,
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_15169:ctor()
end

function bs_15169:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.flag = false
  self:AddAfterHurtTrigger("bs_15169_1", 2, self.checkHp, nil, self.caster, nil, nil, nil, nil, nil)
  self:AddAfterHealTrigger("bs_15169_2", 1, self.checkHp, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_15169_3", 1, self.OnRoleDie)
end

function bs_15169:checkHp()
  if self.caster.roleDataId ~= self.config.pf_dataId then
    return
  end
  local hp_percent = self.caster.hp * 1000 // self.caster.maxHp
  if hp_percent < self.arglist[1] then
    self.flag = true
  else
    self.flag = false
  end
end

function bs_15169:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.enemy or self.flag == false then
    return
  end
  if self.caster.roleDataId ~= self.config.pf_dataId then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  local healNum = self.arglist[2] * self.caster.maxHp // 1000
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_heal, self)
end

function bs_15169:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15169
