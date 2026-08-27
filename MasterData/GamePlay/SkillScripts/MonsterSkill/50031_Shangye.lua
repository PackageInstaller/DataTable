local bs_50031 = class("bs_50031", LuaSkillBase)
local base = LuaSkillBase
bs_50031.config = {
  buffId = 1501,
  buffId1 = 1127,
  buffId2 = 1128,
  buffTier = 1,
  buffId3 = 1503,
  buffDuration = 45,
  heal_config = {
    baseheal_formula = 1047,
    heal_number = 0,
    correct_formula = 9990
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 1047,
    crit_formula = 0
  },
  damageFormula = 10175
}

function bs_50031:ctor()
end

function bs_50031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_50031_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  if isMidwaySkill then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDuration - 1, arriveCallBack, nil, -1, self.config.buffDuration - 15)
    end
  end
end

function bs_50031:OnArriveAction()
  local buffTier = self.caster:GetBuffTier(self.config.buffId3)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  if self.caster.roleDataId == 25006 or self.caster.roleDataId == 25007 or self.caster.roleDataId == 25008 or self.caster.roleDataId == 1000022 then
    return
  end
  if self.caster.camp == 2 and self.caster.belongNum == 2 or buffTier ~= 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
    skillResult:EndResult()
  else
    local sectorTechRate = LuaSkillCtrl:GetPlayerRealAttribute(2)
    local damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, self.caster, self, sectorTechRate)
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
  end
end

function bs_50031:OnSkillRemove()
  base.OnSkillRemove(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_50031:OnAfterMove()
  local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if GridId ~= 35 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_50031:OnRoleSplash(role, grid)
  if role == self.caster and role.curCoord == grid.coord then
    local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
    if GridId ~= 35 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    end
  end
end

function bs_50031:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_50031
