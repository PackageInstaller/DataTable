local bs_10164 = class("bs_10164", LuaSkillBase)
local base = LuaSkillBase
bs_10164.config = {buffId = 1118, buffTier = 1}

function bs_10164:ctor()
end

function bs_10164:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10164_10", 1, self.OnRoleDie)
end

function bs_10164:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
  end
end

function bs_10164:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10164
