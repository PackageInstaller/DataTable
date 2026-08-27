local bs_30065 = class("bs_30065", LuaSkillBase)
local base = LuaSkillBase
bs_30065.config = {buffId_newMiniFireBuff = 110152, buffId = 110154}

function bs_30065:ctor()
end

function bs_30065:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30065_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.miniFireBuff = self.config.buffId_newMiniFireBuff
end

function bs_30065:OnAfterBattleStart()
  self.caster.recordTable.miniFireBuffTier = self.arglist[1]
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_30065:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30065
