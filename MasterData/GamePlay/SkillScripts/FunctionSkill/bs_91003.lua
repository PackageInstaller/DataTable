local bs_91003 = class("bs_91003", LuaSkillBase)
local base = LuaSkillBase
bs_91003.config = {buffId = 2003, buffTier = 10}

function bs_91003:ctor()
end

function bs_91003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91003_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_91003_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_91003:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_91003:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function bs_91003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91003
