local bs_10053 = class("bs_10053", LuaSkillBase)
local base = LuaSkillBase
bs_10053.config = {buffId = 1016}

function bs_10053:ctor()
end

function bs_10053:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10053_1", 1, self.OnAfterBattleStart)
end

function bs_10053:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10053
