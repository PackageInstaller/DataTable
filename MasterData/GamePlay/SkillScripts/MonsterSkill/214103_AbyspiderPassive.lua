local bs_214103 = class("bs_214103", LuaSkillBase)
local base = LuaSkillBase
bs_214103.config = {buffId1 = 214104, buffId_Boss = 3017}

function bs_214103:ctor()
end

function bs_214103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_214103_2", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_214103_3", 1, self.OnAfterHeal, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_214103_4", 2, self.OnAfterBattleStart)
end

function bs_214103:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_214103:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp <= self.caster.maxHp * self.arglist[2] // 1000 and self.caster:GetBuffTier(self.config.buffId1) < 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1)
    self.caster.recordTable.SpitTargetNum = 10
  end
end

function bs_214103:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and self.caster.hp >= self.caster.maxHp * self.arglist[2] // 1000 and self.caster:GetBuffTier(self.config.buffId1) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1)
    self.caster.recordTable.SpitTargetNum = 2
  end
end

function bs_214103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_214103
