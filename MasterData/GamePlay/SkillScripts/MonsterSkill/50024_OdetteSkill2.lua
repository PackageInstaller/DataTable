local bs_50024 = class("bs_50024", LuaSkillBase)
local base = LuaSkillBase
bs_50024.config = {
  buffId = 1257,
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
  damageFormula = 10189,
  damageFormula1 = 10191,
  gridId = 1125
}

function bs_50024:ctor()
end

function bs_50024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_50024_1", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  if isMidwaySkill then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.config.buffDuration - 1, arriveCallBack, nil, -1, self.config.buffDuration - 15)
    end
  end
  self:AddLuaTrigger(eSkillLuaTrigger.OnOdetteHalfHp, self.OnOdetteHalfHp)
  self.halfHp = false
end

function bs_50024:OnOdetteHalfHp(target, sender, skill)
  if self.halfHp == ture then
    return
  end
  self.halfHp = ture
end

function bs_50024:OnArriveAction()
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
  if self.halfHp == ture then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    local sectorTechRate = LuaSkillCtrl:GetPlayerRealAttribute(2)
    damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula1, self.caster, self.caster, self, sectorTechRate, buffTier)
  else
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    local sectorTechRate = LuaSkillCtrl:GetPlayerRealAttribute(2)
    damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, self.caster, self, sectorTechRate, buffTier)
  end
  LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 1257, 1, nil, true)
end

function bs_50024:OnSkillRemove()
  base.OnSkillRemove(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_50024:OnAfterMove()
  local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if GridId ~= self.config.gridId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_50024:OnRoleSplash(role, grid)
  if role == self.caster and role.curCoord == grid.coord then
    local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
    if GridId ~= self.config.gridId then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    end
  end
end

function bs_50024:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_50024
