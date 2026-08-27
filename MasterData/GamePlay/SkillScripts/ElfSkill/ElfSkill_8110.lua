local bs_8110 = class("bs_8110", LuaSkillBase)
local base = LuaSkillBase
bs_8110.config = {buffId = 620}

function bs_8110:ctor()
end

function bs_8110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8110_1", 1, self.OnAfterBattleStart)
end

function bs_8110:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8110
