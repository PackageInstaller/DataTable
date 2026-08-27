local bs_10155 = class("bs_10155", LuaSkillBase)
local base = LuaSkillBase
bs_10155.config = {buffId = 1026}

function bs_10155:ctor()
end

function bs_10155:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10155_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10155:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not skill.isCommonAttack and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  end
end

function bs_10155:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10155
