local bs_10068 = class("bs_10068", LuaSkillBase)
local base = LuaSkillBase
bs_10068.config = {buffId = 1009}

function bs_10068:ctor()
end

function bs_10068:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10068_1", 1, self.OnAfterBattleStart)
end

function bs_10068:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], self.arglist[2], true)
end

function bs_10068:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10068
