require("base_ins_r")
_class("PlayGridRangeEffectScorpionInstruction", PlayGridRangeEffectInstruction)
PlayGridRangeEffectScorpionInstruction = PlayGridRangeEffectScorpionInstruction

function PlayGridRangeEffectScorpionInstruction:Constructor(paramList)
end

function PlayGridRangeEffectScorpionInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return InstructionConst.PhaseEnd
  end
  local maxScopeRangeCount = phaseContext:GetMaxRangeCount()
  if not maxScopeRangeCount then
    return InstructionConst.PhaseEnd
  end
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  if maxScopeRangeCount < curScopeGridRangeIndex then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  for _, range in pairs(scopeGridRange) do
    if range then
      local positions = range[curScopeGridRangeIndex]
      if positions then
        local length = table.count(positions)
        for i = 1, length, self._step do
          local position = positions[i]
          local inBody = self:_InCasterBody(position, casterEntity)
          if not inBody then
            local realOffset = self:_GetOffsetByPosition(position, casterEntity)
            local effectPosition = position + realOffset
            if self:_CheckPosition(effectPosition, casterEntity) then
              effectService:CreateWorldPositionEffect(self._effectID, effectPosition)
              if self._delayTime > 0 then
                YIELD(TT, self._delayTime)
              end
            end
          end
        end
      end
    end
  end
end

function PlayGridRangeEffectScorpionInstruction:_InCasterBody(position, casterEntity)
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local casterPosition = casterEntity:GridLocation().Position
  for _, offset in ipairs(casterBodyArea) do
    local bodyPosition = casterPosition + offset
    if bodyPosition == position then
      return true
    end
  end
  return false
end

function PlayGridRangeEffectScorpionInstruction:_CheckPosition(position, casterEntity)
  local casterPosition = casterEntity:GridLocation().Position
  if position.x - casterPosition.x == self._offset.x or position.y - casterPosition.y == self._offset.y then
    return true
  end
  return false
end

function PlayGridRangeEffectScorpionInstruction:_GetOffsetByPosition(position, casterEntity)
  local offset = Vector2(self._offset.x, self._offset.y)
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local casterPosition = casterEntity:GridLocation().Position
  for _, _offset in ipairs(casterBodyArea) do
    local bodyPosition = casterPosition + _offset
    if position.x == bodyPosition.x then
      offset.y = 0
      break
    elseif position.y == bodyPosition.y then
      offset.x = 0
      break
    end
  end
  return offset
end
