local bs_6004 = class("bs_6004", LuaSkillBase)
local base = LuaSkillBase
bs_6004.config = {buffId_1152 = 1152}

function bs_6004:ctor()
end

function bs_6004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6004_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_6004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self:IsReadyToTake() and self.caster.hp <= self.caster.maxHp * self.arglist[1] // 1000 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1152, 1, self.arglist[5], true)
    self:OnSkillTake()
  end
end

function bs_6004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6004
