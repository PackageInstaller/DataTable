local bs_8106 = class("bs_8106", LuaSkillBase)
local base = LuaSkillBase
bs_8106.config = {buffId = 616}

function bs_8106:ctor()
end

function bs_8106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8106_1", 1, self.OnAfterBattleStart)
end

function bs_8106:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8106
