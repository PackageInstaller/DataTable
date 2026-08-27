local bs_25412 = class("bs_25412", LuaSkillBase)
local base = LuaSkillBase
bs_25412.config = {buffId1 = 2164, buffId2 = 2158}

function bs_25412:ctor()
end

function bs_25412:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25412_1", 1, self.OnAfterBattleStart)
end

function bs_25412:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25412:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25412
