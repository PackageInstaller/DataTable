local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_509 = class("bs_509", bs_1)
local base = bs_1
bs_509.config = {
  effectId_1 = 10225,
  effectId_2 = 10226,
  effectId33 = 10227,
  effectId4 = 10228,
  action3 = 1021,
  buffId_165 = 165,
  hurt_config = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 10055,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  audioId1 = 67,
  audioId2 = 68,
  time2 = 6,
  audioIdPass = 69,
  timePass = 8,
  effectId_up = 10263,
  effectId_down = 10264
}
bs_509.config = setmetatable(bs_509.config, {
  __index = base.config
})

function bs_509:ctor()
end

function bs_509:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_509:PlaySkill(passdata)
  if self.lastAttackRole == nil then
    self.lastAttackRole = self.caster.recordTable.lastAttackRole
  end
  if self.caster:ContainFeature(eBuffFeatureType.Taunt) or self.caster:ContainFeature(eBuffFeatureType.Bewitch) then
    self.lastAttackRole = nil
  end
  if self.lastAttackRole ~= nil and self.lastAttackRole.hp > 0 and self.lastAttackRole.belongNum ~= eBattleRoleBelong.neutral then
    if not LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, self.config.rangeOffset + self.caster.attackRange) then
      self:BlinkCaster(self.lastAttackRole)
    end
    self.caster.recordTable.lastAttackRole = self.lastAttackRole
  else
    self.lastAttackRole = nil
  end
  self:NextPlaySkill(passdata)
end

function bs_509:NextPlaySkill(passdata)
  local data
  if passdata ~= nil then
    data = setmetatable(passdata, {
      __index = self.config
    })
  else
    data = self.config
  end
  self.displaySelectEfc = false
  local moveTarget = self.lastAttackRole
  if self.lastAttackRole == nil then
    moveTarget = self:GetMoveSelectTarget()
  end
  if moveTarget ~= nil then
    local curAtkRole = moveTarget.targetRole
    if curAtkRole ~= nil then
      if self.lastAttackRole ~= curAtkRole then
        self.displaySelectEfc = true
      end
      self.lastAttackRole = curAtkRole
    end
  else
    return
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + self.caster.attackRange) and LuaSkillCtrl:IsWorthAttacking(self, self.lastAttackRole) then
    self.caster:LookAtTarget(self.lastAttackRole)
    if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, self.config.atkDirectionRange) then
      self.rotateWaited = true
      LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
    else
      self.rotateWaited = false
      self:RealPlaySkill(self.lastAttackRole, data)
    end
  else
    self.lastAttackRole = nil
    self.caster.recordTable.lastAttackRole = nil
  end
end

function bs_509:BlinkCaster(role)
  if role == nil or role.hp <= 0 or role:IsUnSelect(self.caster) then
    return
  end
  local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
  if grid == nil then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self)
end

function bs_509:RealPlaySkill(target, data)
  local Roll = self.caster.recordTable.Roll
  if Roll == nil then
    Roll = 0
  end
  if Roll >= LuaSkillCtrl:CallRange(1, 1000) then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = self.config.action1
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
    atkTriggerFrame = 10
    atkActionId = self.config.action3
    self.attackNum = self.attackNum + 1
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data)
    local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
    if 0 < waitTime then
      self:CallCasterWait(waitTime)
    end
    LuaSkillCtrl:StartTimer(self, data.timePass, function()
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioIdPass)
    end)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    LuaSkillCtrl:CallEffect(target, self.config.effectId33, self, nil, nil, nil, true)
    LuaSkillCtrl:CallEffect(target, self.config.effectId4, self, nil, nil, nil, true)
  else
    base.RealPlaySkill(self, target, data)
  end
end

function bs_509:OnAttackTrigger2(target, data)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_165, 1, 13)
  local arg = self.caster.recordTable.arg
  local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if skillResult2.roleList.Count ~= 0 then
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult2, self.config.hurt_config, {arg})
    skillResult2:EndResult()
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if skillResult.roleList.Count ~= 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
        local attackTrigger3 = BindCallback(self, self.OnAttackTrigger3, role)
        LuaSkillCtrl:StartTimer(self, 10, attackTrigger3, nil, 0)
      end
    end
  end
  skillResult:EndResult()
  if self.caster.recordTable.completeFirstComatk == nil then
    self.caster.recordTable.completeFirstComatk = true
  end
end

function bs_509:OnAttackTrigger3(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if skillResult.roleList.Count ~= 0 and 0 < skillResult.roleList[0].hp then
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult)
    skillResult:EndResult()
  end
end

function bs_509:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_509:LuaDispose()
  self.lastAttackRole = nil
  base.LuaDispose(self)
end

return bs_509
