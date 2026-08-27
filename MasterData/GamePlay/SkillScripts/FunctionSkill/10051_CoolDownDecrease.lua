local bs_10051 = class("bs_10051", LuaSkillBase)
local base = LuaSkillBase
bs_10051.config = {buffId = 1014}

function bs_10051:ctor()
end

function bs_10051:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10051_1", 1, self.OnAfterBattleStart)
end

function bs_10051:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10051
