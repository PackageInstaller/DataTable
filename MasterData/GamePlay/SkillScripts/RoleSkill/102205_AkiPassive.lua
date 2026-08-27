local bs_102205 = class("bs_102205", LuaSkillBase)
local base = LuaSkillBase
bs_102205.config = {
  buffId_critical = 102202,
  buffId_storage = 225,
  buffId_crit = 102201
}

function bs_102205:ctor()
end

function bs_102205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102205_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_102205_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.caster.recordTable.weapon2 = true
  self.caster.recordTable.weapon2_target = self.arglist[5]
  self.caster.recordTable.weapon2_caster = self.arglist[6]
  self.caster.recordTable.weapon2_max = self.arglist[7]
  self.caster.recordTable.weapon2_time = self.arglist[8]
end

function bs_102205:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critical, 1)
end

function bs_102205:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    if not isCrit then
      if self.caster:GetBuffTier(self.config.buffId_crit) > 0 then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_crit, 1, self.arglist[3], true)
      else
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_storage, 1, nil, true)
      end
    end
    if isCrit then
      local num = self.caster:GetBuffTier(self.config.buffId_storage)
      if 0 < num and self.caster:GetBuffTier(self.config.buffId_crit) == 0 then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_storage, 0, true)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_crit, num, self.arglist[3], true)
      end
    end
  end
end

function bs_102205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102205
