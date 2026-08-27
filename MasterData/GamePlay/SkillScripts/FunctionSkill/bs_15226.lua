local bs_15226 = class("bs_15226", LuaSkillBase)
local base = LuaSkillBase
bs_15226.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  },
  effectId = 12067
}

function bs_15226:ctor()
end

function bs_15226:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15226_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_15226_3", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, eBattleRoleType.character, nil, nil, eSkillTag.commonAttack)
  self.damageNum = 0
end

function bs_15226:OnAfterBattleStart()
end

function bs_15226:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    if skill.moveSelectTarget == nil then
      return
    end
    if skill.moveSelectTarget.targetRole == nil then
      return
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
    if targetList.Count <= 0 then
      return
    end
    local targetRole = targetList[0].targetRole
    self.damageNum = targetRole.pow * self.arglist[1] // 1000
    LuaSkillCtrl:CallEffect(skill.moveSelectTarget.targetRole, self.config.effectId, self, self.SkillEventFunc, targetRole)
  end
end

function bs_15226:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.damageNum
    }, true)
    skillResult:EndResult()
  end
end

function bs_15226:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15226
