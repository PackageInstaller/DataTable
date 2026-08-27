local bs_200205 = class("bs_200205", LuaSkillBase)
local base = LuaSkillBase
bs_200205.config = {buffId = 1168, buffTier = 1}

function bs_200205:ctor()
end

function bs_200205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200205_1", 1, self.OnAfterBattleStart)
end

function bs_200205:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_200205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200205
