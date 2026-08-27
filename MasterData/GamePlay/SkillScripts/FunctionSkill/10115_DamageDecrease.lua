local bs_10115 = class("bs_10115", LuaSkillBase)
local base = LuaSkillBase
bs_10115.config = {buffId = 1015}

function bs_10115:ctor()
end

function bs_10115:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10115_1", 1, self.OnAfterBattleStart)
end

function bs_10115:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10115
