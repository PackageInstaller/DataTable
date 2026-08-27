local bs_10066 = class("bs_10066", LuaSkillBase)
local base = LuaSkillBase
bs_10066.config = {
  buffId = 195,
  buffTier = 1,
  freezeBuffDuration = 75
}

function bs_10066:ctor()
end

function bs_10066:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10066_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_10066:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.config.freezeBuffDuration)
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

function bs_10066:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10066
