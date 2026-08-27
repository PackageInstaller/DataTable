local bs_10044 = class("bs_10044", LuaSkillBase)
local base = LuaSkillBase
bs_10044.config = {buffId = 80, buffTier = 1}

function bs_10044:ctor()
end

function bs_10044:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10044_10", 1, self.OnRoleDie)
end

function bs_10044:OnRoleDie(killer, role)
  if self.caster.belongNum == role.belongNum then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] // 10, nil, true)
  end
end

function bs_10044:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10044
