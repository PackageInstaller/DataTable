local bs_8113 = class("bs_8113", LuaSkillBase)
local base = LuaSkillBase
bs_8113.config = {buffId = 623}

function bs_8113:ctor()
end

function bs_8113:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8114_1", 1, self.OnAfterBattleStart)
end

function bs_8113:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8113:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8113
