local bs_30011 = class("bs_30011", LuaSkillBase)
local base = LuaSkillBase
bs_30011.config = {
  damageFormular = 10041,
  effectId = 10334,
  effectId2 = 10335
}

function bs_30011:ctor()
end

function bs_30011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30011_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_30011_2", 2, self.OnSetHurt, self.caster)
  self.caster.recordTable["30011_AttackTime"] = 0
  self.caster.recordTable.DamageFlag = false
end

function bs_30011:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    self.caster.recordTable["30011_AttackTime"] = self.caster.recordTable["30011_AttackTime"] + 1
    if self.caster.recordTable["30011_AttackTime"] >= 3 then
      self.caster.recordTable.DamageFlag = true
      self.caster.recordTable["30011_AttackTime"] = 0
    end
  end
end

function bs_30011:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack and not context.isTriggerSet and self.caster.recordTable.DamageFlag then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormular, self.caster, context.target, self)
    if damageNum <= 1 then
      return
    end
    if 1 >= self.caster.hp then
      return
    end
    local enemyDamage = damageNum * self.arglist[2] // 1000
    local lastComAtkRole = self.caster.recordTable.lastAttackRole
    if lastComAtkRole ~= nil then
      LuaSkillCtrl:RemoveLife(enemyDamage, self, lastComAtkRole, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
      self.caster.recordTable.DamageFlag = false
      self:PlayChipEffect()
    end
  end
end

function bs_30011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30011
