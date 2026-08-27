local bs_50026 = class("bs_50026", LuaSkillBase)
local base = LuaSkillBase
bs_50026.config = {
  buffId = 1275,
  buffDuration = 30,
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
  damageFormula = 10198,
  gridId = 1127
}

function bs_50026:ctor()
end

function bs_50026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_50026_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  if isMidwaySkill then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDuration - 1, arriveCallBack, nil, -1, self.config.buffDuration - 15)
    end
  end
end

function bs_50026:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  if self.caster.camp == 2 and self.caster.belongNum == 2 then
    return
  end
  local damage
  local sectorTechRate = LuaSkillCtrl:GetPlayerRealAttribute(2)
  local damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, self.caster, self, sectorTechRate)
  LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
end

function bs_50026:OnSkillRemove()
  base.OnSkillRemove(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_50026:OnAfterMove()
  local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if GridId ~= self.config.gridId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_50026:OnRoleSplash(role, grid)
  if role == self.caster and role.curCoord == grid.coord then
    local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
    if GridId ~= self.config.gridId then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    end
  end
end

function bs_50026:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_50026
