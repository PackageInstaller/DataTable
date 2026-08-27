local bs_10078 = class("bs_10078", LuaSkillBase)
local base = LuaSkillBase
bs_10078.config = {buffId = 80, buffTier = 1}

function bs_10078:ctor()
end

function bs_10078:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10078_10", 1, self.OnRoleDie)
end

function bs_10078:OnRoleDie(killer, role)
  if self.caster.belongNum == role.belongNum then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] // 10, nil, true)
  end
end

function bs_10078:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10078
