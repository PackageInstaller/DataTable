local bs_91007 = class("bs_91007", LuaSkillBase)
local base = LuaSkillBase
bs_91007.config = {buffId = 2007, buffTier = 1}

function bs_91007:ctor()
end

function bs_91007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91007_1", 1, self.OnAfterBattleStart)
end

function bs_91007:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
end

function bs_91007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91007
