local bs_91001 = class("bs_91001", LuaSkillBase)
local base = LuaSkillBase
bs_91001.config = {buffId = 2001, buffTier = 10}

function bs_91001:ctor()
end

function bs_91001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91001_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_91001_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_91001:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_91001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function bs_91001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91001
