local bs_200103 = class("bs_200103", LuaSkillBase)
local base = LuaSkillBase
bs_200103.config = {buffId = 1167, buffTier = 1}

function bs_200103:ctor()
end

function bs_200103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200103_1", 1, self.OnAfterBattleStart)
end

function bs_200103:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_200103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200103
