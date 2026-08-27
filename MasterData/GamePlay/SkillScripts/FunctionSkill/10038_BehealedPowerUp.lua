local bs_10038 = class("bs_10038", LuaSkillBase)
local base = LuaSkillBase
bs_10038.config = {buffId = 1006}

function bs_10038:ctor()
end

function bs_10038:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10038_1", 1, self.OnAfterBattleStart)
end

function bs_10038:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10038
