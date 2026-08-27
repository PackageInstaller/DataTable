local bs_25056 = class("bs_25056", LuaSkillBase)
local base = LuaSkillBase
bs_25056.config = {buffId = 195}

function bs_25056:ctor()
end

function bs_25056:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_25056_3", 1, self.OnAfterHurt, self.caster)
end

function bs_25056:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and isCrit and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[1], 75)
  end
end

function bs_25056:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25056
