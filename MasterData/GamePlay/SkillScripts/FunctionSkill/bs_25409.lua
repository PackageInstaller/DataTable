local bs_25409 = class("bs_25409", LuaSkillBase)
local base = LuaSkillBase
bs_25409.config = {buffId1 = 2163, buffId2 = 2158}

function bs_25409:ctor()
end

function bs_25409:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25409_1", 1, self.OnAfterBattleStart)
end

function bs_25409:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25409:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25409
