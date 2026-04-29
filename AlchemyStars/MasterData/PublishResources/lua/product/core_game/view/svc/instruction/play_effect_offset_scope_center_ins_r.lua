require("base_ins_r")
_class("PlayEffectOffsetScopeCenterInstruction", BaseInstruction)
PlayEffectOffsetScopeCenterInstruction = PlayEffectOffsetScopeCenterInstruction

function PlayEffectOffsetScopeCenterInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  local strOffset = paramList.offset
  if strOffset then
    local arr = string.split(strOffset, "|")
    self._offset = Vector2(tonumber(arr[1]), tonumber(arr[2]))
  else
    self._offset = Vector2.zero
  end
end

function PlayEffectOffsetScopeCenterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local gridRange = skillEffectResultContainer:GetScopeResult():GetWholeGridRange()
  if not gridRange then
    return InstructionConst.PhaseEnd
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local posCenter = self:GetScopeCenterPos(gridRange)
  effectService:CreateWorldPositionEffect(self._effectID, posCenter + self._offset)
end

function PlayEffectOffsetScopeCenterInstruction:GetScopeCenterPos(gridList)
  if gridList then
    local minX, maxX = 999, 0
    local minY, maxY = 999, 0
    for _, pos in ipairs(gridList) do
      if minX > pos.x then
        minX = pos.x
      end
      if minY > pos.y then
        minY = pos.y
      end
      if maxX < pos.x then
        maxX = pos.x
      end
      if maxY < pos.y then
        maxY = pos.y
      end
    end
    local p = Vector2((maxX + minX) * 0.5, (maxY + minY) * 0.5)
    return p
  end
  return Vector2.zero
end

function PlayEffectOffsetScopeCenterInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
