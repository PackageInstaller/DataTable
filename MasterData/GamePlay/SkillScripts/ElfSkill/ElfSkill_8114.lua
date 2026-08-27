local bs_8114 = class("bs_8114", LuaSkillBase)
local base = LuaSkillBase
bs_8114.config = {buffId = 624}

function bs_8114:ctor()
end

function bs_8114:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8114_1", 1, self.OnAfterBattleStart)
end

function bs_8114:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8114:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8114
