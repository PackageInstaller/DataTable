local bs_10317 = class("bs_10317", LuaSkillBase)
local base = LuaSkillBase
bs_10317.config = {
  ysBuff = 1227,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectId = 12030
}

function bs_10317:ctor()
end

function bs_10317:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("10316_after_hurt", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_10317:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    local buffTier = target:GetBuffTier(self.config.ysBuff)
    if 0 < buffTier then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      skillResult:EndResult()
      self:PlayChipEffect()
      self:OnSkillTake()
    end
  end
end

function bs_10317:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10317
