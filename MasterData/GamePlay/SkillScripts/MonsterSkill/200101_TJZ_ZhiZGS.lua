local bs_200101 = class("bs_200101", LuaSkillBase)
local base = LuaSkillBase
bs_200101.config = {buffId_1129 = 1129}

function bs_200101:ctor()
end

function bs_200101:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200101_10", 1, self.OnRoleDie)
end

function bs_200101:OnRoleDie(killer, role)
  if self.caster.belongNum == role.belongNum then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1129, 1, nil, true)
  end
end

function bs_200101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200101
