local bs_25404 = class("bs_25404", LuaSkillBase)
local base = LuaSkillBase
bs_25404.config = {buffId = 110156}

function bs_25404:ctor()
end

function bs_25404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25404_1", 1, self.OnAfterBattleStart)
end

function bs_25404:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_25404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25404
