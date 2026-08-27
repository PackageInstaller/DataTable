local bs_10156 = class("bs_10156", LuaSkillBase)
local base = LuaSkillBase
bs_10156.config = {buffId1 = 1031, buffId2 = 1030}

function bs_10156:ctor()
end

function bs_10156:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10156_1", 1, self.OnAfterBattleStart)
end

function bs_10156:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, self.arglist[1], nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.arglist[2], nil, true)
end

function bs_10156:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10156
