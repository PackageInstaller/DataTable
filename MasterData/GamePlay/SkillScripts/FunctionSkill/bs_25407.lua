local bs_25407 = class("bs_25407", LuaSkillBase)
local base = LuaSkillBase
bs_25407.config = {buffId1 = 2161, buffId2 = 2158}

function bs_25407:ctor()
end

function bs_25407:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25407_1", 1, self.OnAfterBattleStart)
end

function bs_25407:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_25407:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25407
