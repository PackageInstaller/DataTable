local bs_15107 = class("bs_15107", LuaSkillBase)
local base = LuaSkillBase
bs_15107.config = {buffId = 110087}

function bs_15107:ctor()
end

function bs_15107:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15107_1", 1, self.OnAfterBattleStart)
end

function bs_15107:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1], true)
end

function bs_15107:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15107
