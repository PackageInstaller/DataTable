local bs_8105 = class("bs_8105", LuaSkillBase)
local base = LuaSkillBase
bs_8105.config = {buffId = 615}

function bs_8105:ctor()
end

function bs_8105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8105_1", 1, self.OnAfterBattleStart)
end

function bs_8105:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8105
