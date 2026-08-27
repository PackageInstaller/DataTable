local bs_30058 = class("bs_30058", LuaSkillBase)
local base = LuaSkillBase
bs_30058.config = {configId1 = 27, effectId = 10993}

function bs_30058:ctor()
end

function bs_30058:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30058_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_30058:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and isCrit and self:IsReadyToTake() and not isTriggerSet and skill.isCommonAttack then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId1)
    skillResult:EndResult()
  end
end

function bs_30058:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30058
