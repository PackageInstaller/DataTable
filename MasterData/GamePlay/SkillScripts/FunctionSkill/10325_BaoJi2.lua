local bs_10325 = class("bs_10325", LuaSkillBase)
local base = LuaSkillBase
bs_10325.config = {Attack1BuffId = 1262}

function bs_10325:ctor()
end

function bs_10325:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10325_1", 1, self.OnAfterBattleStart)
end

function bs_10325:OnAfterBattleStart()
  local buffTier1 = self.caster.crit * self.arglist[1] // 1000
  if buffTier1 < self.arglist[2] // 10 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.Attack1BuffId, buffTier1, nil, true)
  else
    buffTier1 = self.arglist[2] // 10
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.Attack1BuffId, buffTier1, nil, true)
  end
end

function bs_10325:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10325
