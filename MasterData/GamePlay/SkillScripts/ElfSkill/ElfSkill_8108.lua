local bs_8108 = class("bs_8108", LuaSkillBase)
local base = LuaSkillBase
bs_8108.config = {buffId = 618}

function bs_8108:ctor()
end

function bs_8108:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8108_1", 1, self.OnAfterBattleStart)
end

function bs_8108:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8108:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8108
