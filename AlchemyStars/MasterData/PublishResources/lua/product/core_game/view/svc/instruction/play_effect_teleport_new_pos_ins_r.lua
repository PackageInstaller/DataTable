require("base_ins_r")
_class("PlayEffectTeleportNewPosInstruction", BaseInstruction)
PlayEffectTeleportNewPosInstruction = PlayEffectTeleportNewPosInstruction

function PlayEffectTeleportNewPosInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  self._useCasterDir = tonumber(paramList.useCasterDir)
  self._useTeleportDir = tonumber(paramList.useTeleportDir)
end

function PlayEffectTeleportNewPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local oldPos = teleportEffectResult:GetPosOld()
  local newPos = teleportEffectResult:GetPosNew()
  local world = casterEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local effectEntity = sEffect:CreateWorldPositionEffect(self._effectID, newPos)
  if self._useCasterDir == 1 then
    local dir = casterEntity:Location():GetDirection()
    effectEntity:SetDirection(dir)
  end
  if self._useTeleportDir == 1 then
    local dir = newPos - oldPos
    effectEntity:SetDirection(dir)
  end
end

function PlayEffectTeleportNewPosInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
