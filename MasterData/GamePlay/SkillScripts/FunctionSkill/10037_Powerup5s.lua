local bs_10037 = class("bs_10037", LuaSkillBase)
local base = LuaSkillBase
bs_10037.config = {buffId = 1005}

function bs_10037:ctor()
end

function bs_10037:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10037_1", 1, self.OnAfterBattleStart)
end

function bs_10037:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], self.arglist[2], true)
end

function bs_10037:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10037
