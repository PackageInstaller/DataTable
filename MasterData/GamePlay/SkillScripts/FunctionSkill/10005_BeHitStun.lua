local bs_10005 = class("bs_10005", LuaSkillBase)
local base = LuaSkillBase
bs_10005.config = {
  buffId = 66,
  effectIdSelf = 1001,
  effectIdAttack = 1002
}

function bs_10005:ctor()
end

function bs_10005:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10005_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_10005:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectIdSelf, self)
    LuaSkillCtrl:CallEffect(sender, self.config.effectIdAttack, self)
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, self.arglist[3], self.arglist[2])
  end
end

function bs_10005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10005
