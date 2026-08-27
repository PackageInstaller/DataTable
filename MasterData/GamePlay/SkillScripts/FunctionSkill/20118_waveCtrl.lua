local bs_20118 = class("bs_20118", LuaSkillBase)
local base = LuaSkillBase
bs_20118.config = {
  waveRadium = 30,
  waveEffect = 12010,
  waveEffectBoom = 12011,
  phaseMoveBuffId = 63,
  flyBuff = 110002,
  stunBuff = 110006,
  waveGrid = 1106,
  waveLeftEffect = 12013,
  waveRightEffect = 12012,
  beatBackDurationTimePerGrid = 2,
  waveStunDuration = 30,
  waveInterval = 90,
  waveEffectStartTimer = 65,
  healEffectId = 10092,
  extraHealFormula = 3022,
  heal_config = {baseheal_formula = 3022}
}
local WaveDir = {left = 1, right = -1}

function bs_20118:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20118_1", 1, self.OnStartBattle)
  self:AddLuaTrigger(eSkillLuaTrigger.CallWave, self.CallWaveWithDir)
end

function bs_20118:MakeUpBorderData()
  local border = LuaSkillCtrl:GetMapBorder()
  self.borderPosX = border.x - 1
  self.borderPosY = border.y - 1
end

function bs_20118:OnStartBattle()
  self:MakeUpBorderData()
  if self.caster.recordTable.OverrideCallWave then
    return
  end
end

function bs_20118:CallNextWaveCountDown()
  MsgCenter:Broadcast(eMsgEventId.WaveComing, eWaveType.normalWave)
end

function bs_20118:CallWaveEffect()
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(0, 0)
  if self.waveDir == WaveDir.right then
    gridTarget = LuaSkillCtrl:GetTargetWithGrid(self.borderPosX - (self.borderPosY & 1), self.borderPosY)
    LuaSkillCtrl:CallEffect(gridTarget, self.config.waveRightEffect, self)
  else
    LuaSkillCtrl:CallEffect(gridTarget, self.config.waveLeftEffect, self)
  end
end

function bs_20118:CallWave()
  self:CallWaveWithDir(self.waveDir, self.config.waveEffect)
  self.waveDir = self.waveDir * -1
end

function bs_20118:CallWaveWithDir(waveDirection, effectId, withoutEfcGrid, withouEndEffect)
  for i = 0, self.borderPosY do
    local startStepX = 0
    local nextOffsetArg = 1
    local rotation = Quaternion.Euler(0, 0, 0)
    if waveDirection == WaveDir.right then
      nextOffsetArg = -1
      local rowArg = i & 1
      startStepX = self.borderPosX - rowArg
      rotation = Quaternion.Euler(0, 180, 0)
    end
    local nextStepX = startStepX + nextOffsetArg
    local target = LuaSkillCtrl:GetTargetWithGrid(nextStepX, i)
    if target ~= nil then
      local curTarget = LuaSkillCtrl:GetTargetWithGrid(startStepX, i)
      local effect
      if effectId ~= nil and 0 < effectId then
        effect = LuaSkillCtrl:CallEffect(curTarget, effectId, self)
      end
      if not LuaSkillCtrl.IsInVerify and effect ~= nil then
        effect.lsObject.transform.localRotation = rotation
      end
      local grid = LuaSkillCtrl:GetGridWithPos(startStepX, i)
      self.caster.lsObject.localPosition = grid.fixLogicPosition
      local hasPhaseMove = {}
      local curWavetimer
      if not withoutEfcGrid then
        local waveTimeGrid = {}
        waveTimeGrid.x = curTarget.targetCoord.x
        waveTimeGrid.y = curTarget.targetCoord.y
        curWavetimer = LuaSkillCtrl:StartTimer(nil, 2, BindCallback(self, self.OnCreateEfcGrid, waveTimeGrid, nextOffsetArg), nil, -1, 2)
      end
      LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.waveRadium, 5, 14, BindCallback(self, self.OnCollisionEnter, effect, waveDirection, hasPhaseMove, curWavetimer, withouEndEffect), nil, nil, effect, true, true, BindCallback(self, self.OnArrive, curWavetimer))
    end
  end
end

function bs_20118:OnCreateEfcGrid(waveTimeGrid, nextOffsetArg)
  local x = waveTimeGrid.x
  local y = waveTimeGrid.y
  waveTimeGrid.x = waveTimeGrid.x + nextOffsetArg
  local efcGrid = LuaSkillCtrl:GetEfcGridWithPos(x, y)
  if efcGrid ~= nil then
    return
  end
  local normalGrid = LuaSkillCtrl:GetGridWithPos(x, y)
  if normalGrid == nil then
    return
  end
  if normalGrid.role ~= nil and normalGrid.role.belongNum == eBattleRoleBelong.neutral then
    return
  end
  LuaSkillCtrl:CallCreateEfcGrid(x, y, self.config.waveGrid)
end

function bs_20118:OnCollisionEnter(effect, dir, hasPhaseMove, curWavetimer, withouEndEffect, collider, index, entity)
  if self.config.waveEffectBoom ~= nil and self.config.waveEffectBoom > 0 and not withouEndEffect then
    LuaSkillCtrl:CallEffect(entity, self.config.waveEffectBoom, self)
  end
  local nextArg = dir == WaveDir.left and 1 or -1
  if entity.belongNum == eBattleRoleBelong.neutral then
    if effect ~= nil then
      effect:Die()
    end
    collider.bindEmission:EndAndDisposeEmission()
    if curWavetimer ~= nil then
      curWavetimer:Stop()
    end
  end
  self:CallNextRolePhaseMove(collider, hasPhaseMove, entity, nextArg)
end

function bs_20118:OnArrive(curWavetimer, emission)
  if curWavetimer ~= nil then
    curWavetimer:Stop()
  end
end

function bs_20118:CallNextRolePhaseMove(collider, hasPhaseMove, entity, nextArg)
  if hasPhaseMove[entity] then
    return false
  end
  hasPhaseMove[entity] = true
  if entity.belongNum == eBattleRoleBelong.neutral then
    return false
  end
  if entity.hp <= 0 then
    return false
  end
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnWaveCollision, entity)
  self:CallExtraResult(entity)
  if entity:ContainBuffFeature(eBuffFeatureType.CtrlImmunity) then
    return false
  end
  local result, nextGrid, emptyGrid = self:CollectFurthestGrid(entity, nextArg)
  if nextGrid == nil then
    return false
  end
  if not result then
    local nextEntity = nextGrid.role
    if nextEntity == nil then
      return false
    end
    local result, resultGrid = self:CallNextRolePhaseMove(collider, hasPhaseMove, nextEntity, nextArg)
    nextGrid = resultGrid
    if not result then
      if emptyGrid ~= nil then
        nextGrid = emptyGrid
      else
        return false
      end
    end
  end
  if LuaSkillCtrl:RoleContainsBuffFeature(entity, eBuffFeatureType.BeatBack) or self:CheckSpecialRole(entity) then
    return false
  end
  local catchLastGridArg = -1
  local curX = entity.x
  if entity.collider ~= nil and entity.collider.isActive then
    self:TryResetMoveState(entity)
    local duration = math.abs(entity.x - nextGrid.x) * self.config.beatBackDurationTimePerGrid
    if entity.recordTable["10301_flag"] == nil then
      LuaSkillCtrl:CallBuff(self, entity, self.config.stunBuff, 1, self.config.waveStunDuration)
    end
    LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, entity, nextGrid.x, nextGrid.y, duration, self.config.phaseMoveBuffId, 1, true)
    LuaSkillCtrl:CallBuff(self, entity, self.config.flyBuff, 1, duration)
  end
  local targetX = nextGrid.x
  local lastRoleGrid = nextGrid
  local step = nextArg * catchLastGridArg
  for i = targetX, curX, step do
    lastRoleGrid = LuaSkillCtrl:GetGridWithPos(i, nextGrid.y)
    if lastRoleGrid == nil or lastRoleGrid:IsGridEmpty() then
      break
    end
  end
  return true, lastRoleGrid
end

function bs_20118:CheckSpecialRole(role)
  if role.roleDataId ~= 1049 then
    return false
  end
  if role:GetBuffTier(104902) <= 0 then
    return false
  end
  LuaSkillCtrl:CallBuff(self, role, 104903, 1, 1)
  return true
end

function bs_20118:CallExtraResult(entity)
  local skillCasterAttr = self.caster.sunder
  if skillCasterAttr <= 0 then
    return
  end
  if entity.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallEffect(entity, self.config.healEffectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {skillCasterAttr}, false, false)
    skillResult:EndResult()
  end
end

function bs_20118:CollectFurthestGrid(entity, nextArg)
  local endX = 0
  if 0 < nextArg then
    endX = self.borderPosX - (entity.y & 1)
  else
    endX = 0
  end
  if endX == entity.x then
    return false
  end
  local result = true
  local grid, emptyGrid
  local startX = entity.x + nextArg
  for i = startX, endX, nextArg do
    grid = LuaSkillCtrl:GetGridWithPos(i, entity.y)
    if grid == nil then
      return false
    end
    result = grid:IsGridEmpty()
    if not result then
      break
    end
    emptyGrid = grid
  end
  return result, grid, emptyGrid
end

function bs_20118:LuaDispose()
  self.waveDir = nil
  base.LuaDispose(self)
end

return bs_20118
