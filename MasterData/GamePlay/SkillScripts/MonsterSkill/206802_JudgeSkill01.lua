local bs_206802 = class("bs_206802", LuaSkillBase)
local base = LuaSkillBase
bs_206802.config = {
  buffId_judge = 206801,
  buffId_rootjudge = 206807,
  buffId_unselected = 206806,
  buffId_invinsible = 88,
  effectId_loop = 2068020,
  effectId_hit = 2068002,
  effectId_flash = 501102,
  effectId_go = 2068021,
  effectId_in = 2068022,
  HurtConfig_crime = {
    hit_formula = 10201,
    basehurt_formula = 3000,
    crit_formula = 0,
    hurt_type = -1
  },
  HurtConfig_punish = {
    hit_formula = 10201,
    basehurt_formula = 3010,
    crit_formula = 0,
    hurt_type = 1
  }
}

function bs_206802:ctor()
end

function bs_206802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self.caster.recordTable.JudgeBuffTime = self.arglist[1]
end

function bs_206802:PlaySkill(data)
  self.isInSkill = true
  self:CallCasterWait(999)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_unselected, 1, 999, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_invinsible, 1, 999, true)
  local CasterGrid = LuaSkillCtrl:GetGridWithRole(self.caster)
  local TargetGridRight
  if self.MapBorder.x == 7 then
    TargetGridRight = LuaSkillCtrl:GetGridWithPos(6, 2)
  end
  if self.MapBorder.x == 6 then
    TargetGridRight = LuaSkillCtrl:GetGridWithPos(5, 2)
  end
  local TargetGridLeft = LuaSkillCtrl:GetGridWithPos(0, 2)
  local empty
  local TargetRoleRight = LuaSkillCtrl:GetRoleWithPos(TargetGridRight.x, TargetGridRight.y)
  local result = self:MoveTarget(TargetRoleRight)
  if result then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_go, self)
    LuaSkillCtrl:SetRolePos(TargetGridRight, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_in, self)
  end
  local distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, TargetGridLeft.x, TargetGridLeft.y)
  local MoveDuration = distance * 3
  local OnAttackTrigger = BindCallback(self, self.AttackTrigger, TargetGridLeft, TargetGridRight, MoveDuration)
  LuaSkillCtrl:PlayAuSource(self.caster, 451)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 10, OnAttackTrigger)
end

function bs_206802:AttackTrigger(TargetGridLeft, TargetGridRight, MoveDuration)
  self:LaunchCollider(TargetGridLeft)
  LuaSkillCtrl:StartShowSkillDurationTime(self, MoveDuration * 2 + 20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1007, 1)
  local effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  LuaSkillCtrl:StartTimer(self, MoveDuration, function()
    effect:Die()
  end)
  local TargetRoleLeft = LuaSkillCtrl:GetRoleWithPos(TargetGridLeft.x, TargetGridLeft.y)
  local result = self:MoveTarget(TargetRoleLeft)
  if not result then
    self.isInSkill = false
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_unselected, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_invinsible, 1, true)
    self:CancleCasterWait()
    self:CallNextBossSkill()
    return
  end
  if TargetRoleLeft ~= nil and TargetRoleLeft.isDead then
    CS.BattleManager.Instance.CurBattleController:RemoveBattleRole(TargetGridLeft.coord, true)
  end
  LuaSkillCtrl:CallPhaseMove(self, self.caster, TargetGridLeft.x, TargetGridLeft.y, MoveDuration, nil)
  LuaSkillCtrl:StartTimer(self, MoveDuration, function()
    self:LaunchCollider(TargetGridRight)
    local distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, TargetGridRight.x, TargetGridRight.y)
    local TargetRoleRight = LuaSkillCtrl:GetRoleWithPos(TargetGridRight.x, TargetGridRight.y)
    local result = self:MoveTarget(TargetRoleRight)
    if not result then
      self.isInSkill = false
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_unselected, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_invinsible, 1, true)
      self:CancleCasterWait()
      self:CallNextBossSkill()
      return
    end
    LuaSkillCtrl:CallRoleAction(self.caster, 1007, 1)
    local effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
    LuaSkillCtrl:StartTimer(self, MoveDuration, function()
      effect:Die()
    end)
    if TargetRoleRight ~= nil and TargetRoleRight.isDead then
      CS.BattleManager.Instance.CurBattleController:RemoveBattleRole(TargetGridRight.coord, true)
    end
    LuaSkillCtrl:CallPhaseMove(self, self.caster, TargetGridRight.x, TargetGridRight.y, MoveDuration, nil)
    LuaSkillCtrl:StartTimer(self, MoveDuration, function()
      LuaSkillCtrl:CallRoleAction(self.caster, 1009, 1)
      LuaSkillCtrl:PlayAuSource(self.caster, 453)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_unselected, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_invinsible, 1, true)
      LuaSkillCtrl:StartTimer(self, 20, function()
        LuaSkillCtrl:CallRoleAction(self.caster, 100, 1)
        self.isInSkill = false
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_unselected, 1, true)
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_invinsible, 1, true)
        self:CancleCasterWait()
        self:CallNextBossSkill()
      end)
    end)
  end)
end

function bs_206802:LaunchCollider(TargetGrid)
  local MoveTargetGrid = LuaSkillCtrl:GetTargetWithGrid(TargetGrid.x, TargetGrid.y)
  local collisionTrigger = BindCallback(self, self.OnColliderEnter)
  local radius = 100
  local speed = 3
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, MoveTargetGrid, radius, speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, nil)
end

function bs_206802:OnColliderEnter(collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  local HurtConfig
  if self.caster.recordTable.mask == 1 then
    HurtConfig = self.config.HurtConfig_crime
  end
  if self.caster.recordTable.mask == 2 then
    HurtConfig = self.config.HurtConfig_punish
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit, self)
  LuaSkillCtrl:HurtResult(self, skillResult, HurtConfig, {
    self.arglist[2]
  })
  skillResult:EndResult()
  if LuaSkillCtrl:IsObstacle(entity) then
    return
  end
  local JudgeBuffTime = self.caster.recordTable.JudgeBuffTime
  if self.caster.recordTable.root4 == true then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_rootjudge, 1, JudgeBuffTime)
  else
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_judge, 1, JudgeBuffTime)
  end
end

function bs_206802:MoveTarget(role)
  local result = false
  if role == self.caster then
    return false
  end
  if role == nil then
    return true
  end
  if role.isDead then
    return true
  end
  local empty
  local maxRange = 10
  local emptyGrid
  for tempRange = 1, maxRange do
    emptyGrid = LuaSkillCtrl:FindEmptyGridWithinRange(role, tempRange)
    if emptyGrid ~= nil then
      LuaSkillCtrl:SetRolePos(emptyGrid, role)
      empty = emptyGrid
      return true
    end
  end
  if empty == nil then
    return false
  end
end

function bs_206802:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster and self.isInSkill then
    self.isInSkill = false
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_unselected, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_invinsible, 1, true)
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end
end

return bs_206802
