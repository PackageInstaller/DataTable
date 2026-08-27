local bs_6020 = class("bs_6020", LuaSkillBase)
local base = LuaSkillBase
bs_6020.config = {buffId_1 = 602001, buffId_2 = 602002}

function bs_6020:ctor()
end

function bs_6020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6020_1", 0, self.OnAfterBattleStart)
end

function bs_6020:OnAfterBattleStart()
  local num = self.caster.cd_reduce * 500 // 1000
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, num, nil, true)
  local num_2 = num // self.arglist[2]
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, num_2, nil, true)
end

function bs_6020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6020
