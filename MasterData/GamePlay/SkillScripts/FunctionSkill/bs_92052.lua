local bs_92052 = class("bs_92052", LuaSkillBase)
local base = LuaSkillBase
bs_92052.config = {buffId = 2036, buffTier = 1}

function bs_92052:ctor()
end

function bs_92052:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_92052_1", 1, self.OnRoleDie)
end

function bs_92052:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and role.belongNum ~= 0 then
    self:PlayChipEffect()
    local heal_Num = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal_Num}, true, true)
  end
end

function bs_92052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92052
