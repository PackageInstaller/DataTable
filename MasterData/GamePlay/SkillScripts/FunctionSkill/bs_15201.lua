local bs_15201 = class("bs_15201", LuaSkillBase)
local base = LuaSkillBase
bs_15201.config = {buffId = 110102}

function bs_15201:ctor()
end

function bs_15201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15201_1", 1, self.OnAfterBattleStart)
end

function bs_15201:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_15201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15201
