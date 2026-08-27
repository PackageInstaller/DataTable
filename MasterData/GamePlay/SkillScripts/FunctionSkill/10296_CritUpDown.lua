local bs_10296 = class("bs_10296", LuaSkillBase)
local base = LuaSkillBase
bs_10296.config = {buffId1 = 110005, buffId2 = 110004}

function bs_10296:ctor()
end

function bs_10296:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10296_1", 2, self.OnAfterBattleStart)
end

function bs_10296:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10296:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10296
