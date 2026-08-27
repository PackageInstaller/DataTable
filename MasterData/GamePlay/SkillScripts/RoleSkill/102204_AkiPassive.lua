local bs_102204 = class("bs_102204", LuaSkillBase)
local base = LuaSkillBase
bs_102204.config = {
  buffId_critical = 102202,
  buffId_storage = 225,
  buffId_crit = 102201
}

function bs_102204:ctor()
end

function bs_102204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102204_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_102204_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_102204:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critical, 1)
end

function bs_102204:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
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

function bs_102204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102204
