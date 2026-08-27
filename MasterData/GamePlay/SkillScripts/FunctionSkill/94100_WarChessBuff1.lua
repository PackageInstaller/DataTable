local bs_94100 = class("bs_94100", LuaSkillBase)
local base = LuaSkillBase
bs_94100.config = {buffId = 26}

function bs_94100:ctor()
end

function bs_94100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94100_1", 1, self.OnAfterBattleStart)
end

function bs_94100:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
end

function bs_94100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94100
