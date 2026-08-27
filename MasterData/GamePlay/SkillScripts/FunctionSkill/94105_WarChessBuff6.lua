local bs_94105 = class("bs_94105", LuaSkillBase)
local base = LuaSkillBase
bs_94105.config = {buffId = 1256}

function bs_94105:ctor()
end

function bs_94105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94105_1", 1, self.OnAfterBattleStart)
end

function bs_94105:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_94105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94105
