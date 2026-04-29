require("base_ins_r")
_class("PlayTranspositionInstruction", BaseInstruction)
PlayTranspositionInstruction = PlayTranspositionInstruction

function PlayTranspositionInstruction:Constructor(paramList)
  self._anim1 = paramList.anim1
  self._anim2 = paramList.anim2
  self._materialAnim1 = paramList.materialAnim1
  self._materialAnim2 = paramList.materialAnim2
  self._casterMaterialAnim = paramList.casterMaterialAnim
  self._otherMaterialAnim = paramList.otherMaterialAnim
  self._fadeTime = tonumber(paramList.fadeTime) or 500
  self._hideTime = tonumber(paramList.hideTime) or 500
  self._finishWaitTime = tonumber(paramList.finishWaitTime) or 4000
  self._boardEffectID = tonumber(paramList.boardEffectID)
end

function PlayTranspositionInstruction:GetCacheResource()
  local t = {}
  if self._boardEffectID and self._boardEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._boardEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayTranspositionInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResultAll = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Teleport)
  if not teleportEffectResultAll then
    return
  end
  local casterResult = teleportEffectResultAll[1]
  local targetResult = teleportEffectResultAll[2]
  if not casterResult or not targetResult then
    return
  end
  local targetEntityID = targetResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local effectPos = Vector2(5, 5)
  local effectDir = targetEntity:GetGridPosition() - effectPos
  local sEffect = world:GetService("Effect")
  local effectEntity = sEffect:CreateWorldPositionDirectionEffect(self._boardEffectID, effectPos, effectDir)
  casterEntity:SetAnimatorControllerTriggers({
    self._anim1
  })
  targetEntity:SetAnimatorControllerTriggers({
    self._anim1
  })
  if self._materialAnim1 then
    casterEntity:PlayMaterialAnim(self._materialAnim1)
    targetEntity:PlayMaterialAnim(self._materialAnim1)
  end
  if self._casterMaterialAnim then
    casterEntity:PlayMaterialAnim(self._casterMaterialAnim)
  end
  if self._otherMaterialAnim then
    targetEntity:PlayMaterialAnim(self._otherMaterialAnim)
  end
  YIELD(TT, self._fadeTime)
  local playSkillInstructionService = self._world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportHide2Sky, false, casterResult)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportHide2Sky, false, targetResult)
  YIELD(TT, self._hideTime)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportMove, false, casterResult)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportMove, false, targetResult)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportShow, false, casterResult)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportShow, false, targetResult)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local resvc = self._world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, teamLeaderEntity)
  resvc:TurnToTarget(targetEntity, teamLeaderEntity)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.BuffNotify, false, casterResult)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.BuffNotify, false, targetResult)
  casterEntity:SetAnimatorControllerTriggers({
    self._anim2
  })
  targetEntity:SetAnimatorControllerTriggers({
    self._anim2
  })
  if self._materialAnim2 then
    casterEntity:PlayMaterialAnim(self._materialAnim2)
    targetEntity:PlayMaterialAnim(self._materialAnim2)
  end
  YIELD(TT, self._finishWaitTime)
end
