_class("PlayAkexiyaForceMovementAndTeleportInstruction", BaseInstruction)
PlayAkexiyaForceMovementAndTeleportInstruction = PlayAkexiyaForceMovementAndTeleportInstruction

function PlayAkexiyaForceMovementAndTeleportInstruction:Constructor(paramList)
  self._oldPosEffectID = tonumber(paramList.oldPosEffectID)
  self._newPosEffectID = tonumber(paramList.newPosEffectID)
  self._mode = tonumber(paramList.mode)
end

function PlayAkexiyaForceMovementAndTeleportInstruction:GetCacheResource()
  local t = {}
  if self._oldPosEffectID and Cfg.cfg_effect[self._oldPosEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._oldPosEffectID].ResPath,
      1
    })
  end
  if self._newPosEffectID and Cfg.cfg_effect[self._newPosEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._newPosEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayAkexiyaForceMovementAndTeleportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local target, oldPos, newPos
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
  if teleportResultArray and 0 < #teleportResultArray then
    local result = teleportResultArray[1]
    target = result:GetTargetID()
    oldPos = result:GetPosOld()
    newPos = result:GetPosNew()
  else
    local forceMovementResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ForceMovement)
    if forceMovementResultArray and 0 < #forceMovementResultArray then
      local result = forceMovementResultArray[1]
      for _, moveResult in ipairs(result:GetMoveResult()) do
        if moveResult.isMoved then
          target = moveResult.targetID
          oldPos = moveResult.v2OldPos
          newPos = moveResult.v2NewPos
        end
      end
    end
  end
  if not (target and oldPos) or not newPos then
    return
  end
  local e = world:GetEntityByID(target)
  if not e then
    return
  end
  if self._mode == 1 then
    local effectService = world:GetService("Effect")
    effectService:CreatePositionEffect(self._oldPosEffectID, oldPos)
    effectService:CreatePositionEffect(self._newPosEffectID, newPos)
  elseif self._mode == 2 then
    e:SetViewVisible(false)
    e:SetLocation(newPos)
  elseif self._mode == 3 then
    e:SetViewVisible(true)
  end
end
