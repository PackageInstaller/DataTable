local bs_92059 = class("bs_92059", LuaSkillBase)
local base = LuaSkillBase
bs_92059.config = {buffId = 2052}

function bs_92059:ctor()
end

function bs_92059:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92059_3", 1, self.OnAfterHurt, self.caster)
end

function bs_92059:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet and isCrit and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_92059:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92059
