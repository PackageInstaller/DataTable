local bs_10153 = class("bs_10153", LuaSkillBase)
local base = LuaSkillBase
bs_10153.config = {buffId1 = 1041, buffId2 = 1042}

function bs_10153:ctor()
end

function bs_10153:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10153_1", 1, self.OnAfterBattleStart)
end

function bs_10153:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, self.arglist[1], nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.arglist[2], nil, true)
end

function bs_10153:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10153
