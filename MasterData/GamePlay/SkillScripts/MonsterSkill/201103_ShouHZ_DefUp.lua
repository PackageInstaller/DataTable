local bs_201103 = class("bs_201103", LuaSkillBase)
local base = LuaSkillBase
bs_201103.config = {buffId = 1171, buffTier = 1}

function bs_201103:ctor()
end

function bs_201103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201103_1", 1, self.OnAfterBattleStart)
end

function bs_201103:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_201103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201103
