local bs_10032 = class("bs_10032", LuaSkillBase)
local base = LuaSkillBase
bs_10032.config = {buffId = 81}

function bs_10032:ctor()
end

function bs_10032:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10032_1", 1, self.OnAfterBattleStart)
end

function bs_10032:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10032
