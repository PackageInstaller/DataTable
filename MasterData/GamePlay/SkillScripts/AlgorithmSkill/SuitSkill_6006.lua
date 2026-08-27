local bs_6006 = class("bs_6006", LuaSkillBase)
local base = LuaSkillBase
bs_6006.config = {buffId = 127, formulaID = 10023}

function bs_6006:ctor()
end

function bs_6006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6006_1", 1, self.OnAfterBattleStart)
end

function bs_6006:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_6006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6006
