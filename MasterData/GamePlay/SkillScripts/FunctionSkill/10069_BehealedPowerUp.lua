local bs_10069 = class("bs_10069", LuaSkillBase)
local base = LuaSkillBase
bs_10069.config = {buffId = 1006}

function bs_10069:ctor()
end

function bs_10069:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10069_1", 1, self.OnAfterBattleStart)
end

function bs_10069:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10069:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10069
