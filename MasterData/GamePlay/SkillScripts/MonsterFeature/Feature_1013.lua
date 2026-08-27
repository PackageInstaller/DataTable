local bs_1013 = class("bs_1013", LuaSkillBase)
local base = LuaSkillBase
bs_1013.config = {buffId_def = 506}

function bs_1013:ctor()
end

function bs_1013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1013_1", 1, self.OnAfterBattleStart)
  self.count = self.arglist[1]
  self.maxCount = self.arglist[1]
  self:AddAfterHurtTrigger("bs_1013_2", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1013_3", 1, self.BeforeEndBattle)
end

function bs_1013:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and 0 < hurt and skill.isCommonAttack then
    self.count = self.count - 1
    self:ShowAttackCounting(self.count)
    if self.count == 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_def, 1, true)
    end
  end
end

function bs_1013:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, nil, true)
  self:ShowAttackCounting(self.count)
end

function bs_1013:ShowAttackCounting(Count)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  if Count == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  LuaSkillCtrl:ShowCounting(self.caster, Count, self.maxCount)
end

function bs_1013:BeforeEndBattle()
  self:ShowAttackCounting(0)
end

function bs_1013:OnCasterDie()
  base.OnCasterDie(self)
  self:ShowAttackCounting(0)
end

return bs_1013
