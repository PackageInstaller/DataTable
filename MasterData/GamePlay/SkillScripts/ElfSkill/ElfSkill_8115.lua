local bs_8115 = class("bs_8115", LuaSkillBase)
local base = LuaSkillBase
bs_8115.config = {buffId = 625}

function bs_8115:ctor()
end

function bs_8115:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8115_1", 1, self.OnAfterBattleStart)
end

function bs_8115:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8115
