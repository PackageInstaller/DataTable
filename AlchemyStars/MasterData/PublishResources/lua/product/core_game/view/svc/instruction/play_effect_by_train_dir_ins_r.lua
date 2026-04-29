require("base_ins_r")
_class("PlayEffectByTrainDirInstruction", BaseInstruction)
PlayEffectByTrainDirInstruction = PlayEffectByTrainDirInstruction

function PlayEffectByTrainDirInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayEffectByTrainDirInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local directionType = renderPickUpComponent:GetLastPickUpDirection()
  local castPos = casterEntity:GridLocation().Position
  local sEffect = self._world:GetService("Effect")
  local trainEffectEntity = sEffect:CreateWorldPositionDirectionEffect(self._effectID, castPos, self:_GetDirection(directionType))
end

function PlayEffectByTrainDirInstruction:_GetDirection(directionType)
  if directionType == HitBackDirectionType.Up then
    return Vector2(0, -1)
  elseif directionType == HitBackDirectionType.Down then
    return Vector2(0, 1)
  elseif directionType == HitBackDirectionType.Left then
    return Vector2(1, 0)
  elseif directionType == HitBackDirectionType.Right then
    return Vector2(-1, 0)
  else
    return Vector2(0, 0)
  end
end

function PlayEffectByTrainDirInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
