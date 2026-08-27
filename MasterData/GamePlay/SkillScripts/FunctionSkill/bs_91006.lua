local bs_91006 = class("bs_91006", LuaSkillBase)
local base = LuaSkillBase
bs_91006.config = {buffId = 2006, buffTier = 1}

function bs_91006:ctor()
end

function bs_91006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_91006_1", 1, self.OnAfterBattleStart)
end

function bs_91006:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
end

function bs_91006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91006
