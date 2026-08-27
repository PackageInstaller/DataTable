local bs_1000 = class("bs_1000", LuaSkillBase)
local base = LuaSkillBase
bs_1000.config = {buffId_def = 500}

function bs_1000:ctor()
end

function bs_1000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1000_1", 1, self.OnAfterBattleStart)
end

function bs_1000:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_def, 1, nil, true)
end

function bs_1000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1000
