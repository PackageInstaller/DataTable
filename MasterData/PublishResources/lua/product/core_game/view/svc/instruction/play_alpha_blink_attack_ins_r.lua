require("base_ins_r")
_class("PlayAlphaBlinkAttackInstruction", BaseInstruction)
PlayAlphaBlinkAttackInstruction = PlayAlphaBlinkAttackInstruction

function PlayAlphaBlinkAttackInstruction:Constructor(paramList)
  self._disappearEffID = tonumber(paramList.disappearEffID)
  self._firstDisappearTime = tonumber(paramList.firstDisappearTime) or 0
  self._appearEffID = tonumber(paramList.appearEffID)
  self._attackAni = paramList.attackAni
  self._attackEffID = tonumber(paramList.attackEffID)
  self._attackEffID2 = tonumber(paramList.attackEffID2)
  self._attackTime = tonumber(paramList.attackTime) or 0
  self._secondDisappearTime = tonumber(paramList.secondDisappearTime) or 0
end

function PlayAlphaBlinkAttackInstruction:GetCacheResource()
  local t = {}
  if self._disappearEffID and self._disappearEffID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._disappearEffID].ResPath,
      1
    })
  end
  if self._appearEffID and 0 < self._appearEffID then
    table.insert(t, {
      Cfg.cfg_effect[self._appearEffID].ResPath,
      1
    })
  end
  if self._attackEffID and 0 < self._attackEffID then
    table.insert(t, {
      Cfg.cfg_effect[self._attackEffID].ResPath,
      1
    })
  end
  if self._attackEffID2 and 0 < self._attackEffID2 then
    table.insert(t, {
      Cfg.cfg_effect[self._attackEffID2].ResPath,
      1
    })
  end
  return t
end

function PlayAlphaBlinkAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = resultContainer:GetEffectResultByArray(SkillEffectType.AlphaBlinkAttack)
  if not result then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local trapServiceRender = world:GetService("TrapRender")
  local trapIDList = result:GetTrapIDList()
  if trapIDList then
    local trapEntityList = {}
    for _, trapEntityID in ipairs(trapIDList) do
      local trapEntity = world:GetEntityByID(trapEntityID)
      if trapEntity then
        table.insert(trapEntityList, trapEntity)
      end
    end
    trapServiceRender:ShowTraps(TT, trapEntityList, true)
  end
  local effectService = world:GetService("Effect")
  local rideRenderSvc = world:GetService("RideRender")
  if casterEntity:HasRideRender() then
    local rideRenderCmpt = casterEntity:RideRender()
    rideRenderSvc:RemoveRideRender(casterEntity:GetID(), rideRenderCmpt:GetMountID())
  end
  local oldPos = result:GetOldPos()
  local attackPos = result:GetAttackPos()
  local attackDir = result:GetAttackDir()
  local height = result:GetHeight()
  if oldPos ~= attackPos then
    self:Blink(TT, casterEntity, oldPos, attackPos, attackDir, self._firstDisappearTime, height)
  end
  casterEntity:SetAnimatorControllerTriggers({
    self._attackAni
  })
  if self._attackEffID and self._attackEffID ~= 0 then
    effectService:CreateEffect(self._attackEffID, casterEntity)
  end
  if self._attackEffID2 and self._attackEffID2 ~= 0 then
    effectService:CreateEffect(self._attackEffID2, casterEntity)
  end
  YIELD(TT, self._attackTime)
  local teleportPos = result:GetTeleportPos()
  self:Blink(TT, casterEntity, attackPos, teleportPos, attackDir, self._secondDisappearTime, height)
  if casterEntity:HasRide() then
    local rideCmpt = casterEntity:Ride()
    local mountID = rideCmpt:GetMountID()
    local mountEntity = world:GetEntityByID(mountID)
    if mountEntity:HasTrapRender() then
      rideRenderSvc:RideTrap(casterEntity:GetID(), mountID)
    elseif mountEntity:HasMonsterID() then
      rideRenderSvc:RideMonster(casterEntity:GetID(), mountID)
    end
  end
end

function PlayAlphaBlinkAttackInstruction:Blink(TT, casterEntity, oldPos, newPos, newDir, time, height)
  local world = casterEntity:GetOwnerWorld()
  local effectSvc = world:GetService("Effect")
  local playSkillInstructionSvc = world:GetService("PlaySkillInstruction")
  local utilDataSvc = world:GetService("UtilData")
  effectSvc:CreateWorldPositionEffect(self._disappearEffID, oldPos)
  local colorOld = utilDataSvc:FindPieceElement(oldPos)
  local teleportSkillRes = SkillEffectResult_Teleport:New(casterEntity:GetID(), oldPos, colorOld, newPos, newDir, 1)
  playSkillInstructionSvc:Teleport(TT, casterEntity, RoleShowType.TeleportHide, false, teleportSkillRes)
  playSkillInstructionSvc:Teleport(TT, casterEntity, RoleShowType.TeleportMove, false, teleportSkillRes)
  YIELD(TT, time)
  playSkillInstructionSvc:Teleport(TT, casterEntity, RoleShowType.TeleportShow, false, teleportSkillRes)
  effectSvc:CreateWorldPositionEffect(self._appearEffID, newPos)
  casterEntity:SetLocationHeight(height)
end
