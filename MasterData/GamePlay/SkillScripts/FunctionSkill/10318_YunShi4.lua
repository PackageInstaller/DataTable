local bs_10318 = class("bs_10318", LuaSkillBase)
local base = LuaSkillBase
bs_10318.config = {
  ysBuff = 1227,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectId = 12030
}

function bs_10318:ctor()
end

function bs_10318:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10318_1", 1, self.OnAfterPlaySkill)
end

function bs_10318:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if self:IsReadyToTake() and skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local buffTier = targetRole:GetBuffTier(self.config.ysBuff)
      if 0 < buffTier then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
        skillResult:EndResult()
      end
    end
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_10318:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10318
