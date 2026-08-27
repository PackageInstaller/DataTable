local bs_10116 = class("bs_10116", LuaSkillBase)
local base = LuaSkillBase
bs_10116.config = {buffId = 1016}

function bs_10116:ctor()
end

function bs_10116:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10116_1", 1, self.OnAfterBattleStart)
end

function bs_10116:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10116:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10116
