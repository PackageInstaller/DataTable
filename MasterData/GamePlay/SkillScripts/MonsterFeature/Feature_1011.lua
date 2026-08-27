local bs_1011 = class("bs_1011", LuaSkillBase)
local base = LuaSkillBase
bs_1011.config = {buffId_dodge = 504}

function bs_1011:ctor()
end

function bs_1011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1000_1", 1, self.OnAfterBattleStart)
end

function bs_1011:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_dodge, 1, nil, true)
end

function bs_1011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1011
