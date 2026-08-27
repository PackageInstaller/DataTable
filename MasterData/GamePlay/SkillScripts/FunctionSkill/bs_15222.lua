local bs_15222 = class("bs_15222", LuaSkillBase)
local base = LuaSkillBase
bs_15222.config = {buffId = 110119}

function bs_15222:ctor()
end

function bs_15222:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15222_1", 1, self.OnAfterBattleStart)
end

function bs_15222:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_15222:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15222
