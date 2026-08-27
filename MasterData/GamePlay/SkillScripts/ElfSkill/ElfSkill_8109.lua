local bs_8109 = class("bs_8109", LuaSkillBase)
local base = LuaSkillBase
bs_8109.config = {buffId = 619}

function bs_8109:ctor()
end

function bs_8109:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8109_1", 1, self.OnAfterBattleStart)
end

function bs_8109:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8109:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8109
