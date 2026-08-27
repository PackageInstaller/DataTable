local bs_10063 = class("bs_10063", LuaSkillBase)
local base = LuaSkillBase
bs_10063.config = {buffId = 1006}

function bs_10063:ctor()
end

function bs_10063:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10063_1", 1, self.OnAfterBattleStart)
end

function bs_10063:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10063:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10063
