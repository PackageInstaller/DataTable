local bs_92057 = class("bs_92057", LuaSkillBase)
local base = LuaSkillBase
bs_92057.config = {buffId = 2049}

function bs_92057:ctor()
end

function bs_92057:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92057_3", 1, self.OnAfterHurt, self.caster)
end

function bs_92057:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_92057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92057
