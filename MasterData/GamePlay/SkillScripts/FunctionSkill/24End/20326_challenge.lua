local bs_20324 = class("bs_20324", LuaSkillBase)
local base = LuaSkillBase
bs_20324.config = {buff = 66}

function bs_20324:ctor()
end

function bs_20324:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20324", 1, self.OnAfterBattleStart)
end

function bs_20324:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
end

function bs_20324:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20324
