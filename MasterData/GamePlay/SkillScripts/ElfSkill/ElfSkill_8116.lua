local bs_8116 = class("bs_8116", LuaSkillBase)
local base = LuaSkillBase
bs_8116.config = {buffId = 626}

function bs_8116:ctor()
end

function bs_8116:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_8116_1", 1, self.OnAfterBattleStart)
end

function bs_8116:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_8116:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8116
