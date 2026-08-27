local bs_15140 = class("bs_15140", LuaSkillBase)
local base = LuaSkillBase
bs_15140.config = {buffId = 1203, buffId1 = 110093}

function bs_15140:ctor()
end

function bs_15140:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15140_1", 1, self.OnAfterBattleStart)
end

function bs_15140:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  self:PlayChipEffect()
end

function bs_15140:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15140
