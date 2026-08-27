local bs_200301 = class("bs_200301", LuaSkillBase)
local base = LuaSkillBase
bs_200301.config = {
  buffId_1008 = 1212,
  buffId_1213 = 1213,
  buffId_212 = 212
}

function bs_200301:ctor()
end

function bs_200301:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200301_1", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200301_2", 2, self.OnAfterBattleStart)
  self.time = self.arglist[4]
end

function bs_200301:OnRoleDie(killer, role)
  if self.caster.belongNum == role.belongNum and self.time > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1008, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_212, 1, nil, true)
    self.time = self.time - 1
  end
end

function bs_200301:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1213, 1, nil, true)
end

function bs_200301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200301
