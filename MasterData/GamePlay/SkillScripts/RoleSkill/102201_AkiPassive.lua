local bs_102201 = class("bs_102201", LuaSkillBase)
local base = LuaSkillBase
bs_102201.config = {buffId_critical = 224, buffId_storage = 225}

function bs_102201:ctor()
end

function bs_102201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102201_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_102201_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_102201:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critical, 1)
end

function bs_102201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    if not isCrit then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_storage, 1, nil, true)
    end
    if isCrit and self.caster:GetBuffTier(self.config.buffId_storage) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_storage, 0, true)
    end
  end
end

function bs_102201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102201
