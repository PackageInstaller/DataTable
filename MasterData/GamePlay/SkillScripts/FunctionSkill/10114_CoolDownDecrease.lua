local bs_10114 = class("bs_10114", LuaSkillBase)
local base = LuaSkillBase
bs_10114.config = {buffId = 1014}

function bs_10114:ctor()
end

function bs_10114:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10114_1", 1, self.OnAfterBattleStart)
end

function bs_10114:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10114:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10114
