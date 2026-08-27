local bs_10157 = class("bs_10157", LuaSkillBase)
local base = LuaSkillBase
bs_10157.config = {buffTier = 1, buffId_shixue = 257}

function bs_10157:ctor()
end

function bs_10157:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10157_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10157_2", 2, self.OnAfterBattleStart)
end

function bs_10157:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.maxHp * self.arglist[1] // 1000 >= self.caster.hp and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[2], nil, true)
    self:OnSkillTake()
  end
end

function bs_10157:OnAfterBattleStart()
  if self.caster.maxHp * self.arglist[1] // 1000 >= self.caster.hp and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[2])
    self:OnSkillTake()
  end
end

function bs_10157:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10157
