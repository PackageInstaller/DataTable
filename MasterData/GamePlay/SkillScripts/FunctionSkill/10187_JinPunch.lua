local bs_10187 = class("bs_10187", LuaSkillBase)
local base = LuaSkillBase
bs_10187.config = {beatBackBuff = 151}

function bs_10187:ctor()
end

function bs_10187:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10187_3", 1, self.OnAfterHurt, self.caster)
  self.caster.recordTable["10187_time"] = 1
end

function bs_10187:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp > 0 and sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and 0 < self.caster.recordTable["10187_time"] and not isTriggerSet then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.beatBackBuff, 1, 3)
    self.caster.recordTable["10187_time"] = 0
  end
end

function bs_10187:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10187
