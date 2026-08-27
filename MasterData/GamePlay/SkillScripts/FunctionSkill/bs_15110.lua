local bs_15110 = class("bs_15110", LuaSkillBase)
local base = LuaSkillBase
bs_15110.config = {buffId = 110089}

function bs_15110:ctor()
end

function bs_15110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15110_1", 1, self.OnAfterBattleStart)
end

function bs_15110:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2], true)
end

function bs_15110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15110
