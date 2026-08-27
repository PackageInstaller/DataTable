local bs_10327 = class("bs_10327", LuaSkillBase)
local base = LuaSkillBase
bs_10327.config = {
  buffId = 66,
  buffTier = 1,
  effectId = 10994,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10031,
    crit_formula = 0
  }
}

function bs_10327:ctor()
end

function bs_10327:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10327_14", 90, self.OnAfterHurt, self.caster, nil, nil)
end

function bs_10327:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 15, true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10327:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10327
