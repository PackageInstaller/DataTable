local bs_10024 = class("bs_10024", LuaSkillBase)
local base = LuaSkillBase
bs_10024.config = {
  healBuffId = 72,
  injuredBuffId = 73,
  effectId1 = 12049,
  effectId2 = 12050
}

function bs_10024:ctor()
end

function bs_10024:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10024_1", 1, self.OnAfterBattleStart)
end

function bs_10024:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.healBuffId, self.arglist[1], nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.injuredBuffId, self.arglist[2], nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
end

function bs_10024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10024
