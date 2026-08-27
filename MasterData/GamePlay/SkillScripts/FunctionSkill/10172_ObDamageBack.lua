local bs_10172 = class("bs_10172", LuaSkillBase)
local base = LuaSkillBase
bs_10172.config = {damageFormula = 10011}

function bs_10172:ctor()
end

function bs_10172:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10172_3", 1, self.OnRoleDie)
end

function bs_10172:OnRoleDie(killer, role)
  if role.intensity == 0 and killer.belongNum == 2 and self:IsReadyToTake() then
    local damage = math.max(1, LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, killer, self))
    LuaSkillCtrl:RemoveLife(damage, self, killer, true)
    self:OnSkillTake()
  end
end

function bs_10172:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10172
