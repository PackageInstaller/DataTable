local bs_8111 = class("bs_8111", LuaSkillBase)
local base = LuaSkillBase
bs_8111.config = {buffId = 621}

function bs_8111:ctor()
end

function bs_8111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8111_1", 1, self.OnAfterBattleStart)
end

function bs_8111:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8111:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8111
