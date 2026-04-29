require("base_ins_r")
_class("PlayCasterTeleportByAnimInstruction", BaseInstruction)
PlayCasterTeleportByAnimInstruction = PlayCasterTeleportByAnimInstruction

function PlayCasterTeleportByAnimInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  self._leftAnimName = paramList.leftAnim
  self._rightAnimName = paramList.rightAnim
  self._leftAnimLen = tonumber(paramList.leftAnimLen) or 1000
  self._rightAnimLen = tonumber(paramList.rightAnimLen) or 1000
end

function PlayCasterTeleportByAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local oldPos = teleportEffectResult:GetPosOld()
  local newPos = teleportEffectResult:GetPosNew()
  self._world = casterEntity:GetOwnerWorld()
  local utilScopeCalcSvc = self._world:GetService("UtilScopeCalc")
  local dirType = utilScopeCalcSvc:GetEntityRenderDirType(casterEntity)
  local playAnimName, animLen = self:GetAnimName(newPos, oldPos, dirType)
  local renderEntityService = self._world:GetService("RenderEntity")
  local trapServiceRender = self._world:GetService("TrapRender")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  self:RefreshPieceAnim(oldPos, casterEntity, true)
  trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  casterEntity:SetAnimatorControllerTriggers({playAnimName})
  YIELD(TT, animLen)
  casterEntity:SetAnimatorControllerTriggers({"Idle"})
  casterEntity:SetPosition(newPos + casterEntity:GetGridOffset())
  self:RefreshPieceAnim(newPos, casterEntity, false)
  trapServiceRender:ShowHideTrapAtPos(newPos, false)
end

function PlayCasterTeleportByAnimInstruction:RefreshPieceAnim(pos, casterEntity, bLight)
  local pieceService = self._world:GetService("Piece")
  local utilDataService = self._world:GetService("UtilData")
  local bodyArea = casterEntity:BodyArea():GetArea()
  for i = 1, #bodyArea do
    local posWork = pos + bodyArea[i]
    if utilDataService:IsValidPiecePos(posWork) then
      if bLight then
        pieceService:SetPieceAnimUp(posWork)
      else
        pieceService:SetPieceAnimDown(posWork)
      end
    end
  end
end

function PlayCasterTeleportByAnimInstruction:GetAnimName(newPos, oldPos, dirType)
  if dirType == DirectionType.Left then
    if newPos.y > oldPos.y then
      return self._rightAnimName, self._rightAnimLen
    else
      return self._leftAnimName, self._leftAnimLen
    end
  elseif dirType == DirectionType.Right then
    if newPos.y < oldPos.y then
      return self._rightAnimName, self._rightAnimLen
    else
      return self._leftAnimName, self._leftAnimLen
    end
  elseif dirType == DirectionType.Up then
    if newPos.x > oldPos.x then
      return self._rightAnimName, self._rightAnimLen
    else
      return self._leftAnimName, self._leftAnimLen
    end
  elseif dirType == DirectionType.Down then
    if newPos.x < oldPos.x then
      return self._rightAnimName, self._rightAnimLen
    else
      return self._leftAnimName, self._leftAnimLen
    end
  end
end
