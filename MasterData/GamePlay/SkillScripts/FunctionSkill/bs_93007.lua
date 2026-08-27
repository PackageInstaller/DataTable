local bs_93007 = class("bs_93007", LuaSkillBase)
local base = LuaSkillBase
bs_93007.config = {
  damageFormular = 10041,
  effectId2 = 10966,
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 3031
  }
}

function bs_93007:ctor()
end

function bs_93007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_93007_2", 90, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_93007_5", 1, self.BeforeEndBattle)
end

function bs_93007:OnSetHurt(context)
  if context.skill.isCommonAttack and context.sender == self.caster and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and LuaSkillCtrl:IsFixedObstacle(context.target) ~= true then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, context.target, self)
    if damageNum <= 1 then
      return
    end
    if 1 >= self.caster.hp then
      return
    end
    local enemyDamage = damageNum * self.arglist[2] // 1000
    local lastComAtkRole = context.target
    if lastComAtkRole ~= nil then
      LuaSkillCtrl:RemoveLife(enemyDamage, self, lastComAtkRole, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId2, self)
      self:PlayChipEffect()
    end
  end
end

function bs_93007:BeforeEndBattle()
  local healNum = self.caster.maxHp * self.arglist[3] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healNum}, true)
  skillResult:EndResult()
end

function bs_93007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93007
