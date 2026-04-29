require("base_ins_r")
_class("PlayGridRangeEffectInstruction", BaseInstruction)
PlayGridRangeEffectInstruction = PlayGridRangeEffectInstruction

function PlayGridRangeEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._delayTime = tonumber(paramList.delayTime) or 0
  local strIsRotate = paramList.isRotate
  if strIsRotate then
    self._isRotate = tonumber(strIsRotate) == 1
  else
    self._isRotate = false
  end
  local strStep = paramList.step
  if strStep then
    self._step = tonumber(strStep)
  else
    self._step = 1
  end
  local strOffset = paramList.offset
  if strOffset then
    local arr = string.split(strOffset, "|")
    self._offset = Vector2(tonumber(arr[1]), tonumber(arr[2]))
  else
    self._offset = Vector2.zero
  end
  local strOffsetHigh = paramList.offsetHigh
  if strOffsetHigh then
    self._offsetHigh = tonumber(strOffsetHigh)
  end
  local randomRotateXYZ = paramList.randomRotateXYZ
  if randomRotateXYZ then
    self._randomRotateXYZ = tonumber(randomRotateXYZ)
  end
  local randomRotate = paramList.randomRotate
  if randomRotate then
    self._randomRotate = tonumber(randomRotate)
  else
    self._randomRotate = nil
  end
  local randomRotateList = paramList.randomRotateList
  if randomRotateList then
    self._randomRotateList = {}
    local arr = string.split(randomRotateList, "|")
    for i = 1, #arr do
      table.insert(self._randomRotateList, tonumber(arr[i]))
    end
  end
  local bindCaster = paramList.bindCaster
  if bindCaster then
    self._bindCaster = true
  end
end

function PlayGridRangeEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  local casterPos = casterEntity:GridLocation():GetGridPos()
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        local len = table.count(posList)
        for i = 1, len, self._step do
          local pos = posList[i]
          local targetPos = pos + self._offset
          local effectEntity
          if self._isRotate then
            effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, targetPos - casterPos)
          elseif self._randomRotate then
            local randomPos = Vector2(math.random(0, self._randomRotate), math.random(0, self._randomRotate))
            effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, randomPos)
          elseif self._randomRotateList then
            local index = math.random(1, #self._randomRotateList)
            local randomEuler = Quaternion.Euler(0, self._randomRotateList[index], 0)
            local dot = randomEuler * Vector3.forward
            local randomPos = Vector3.Normalize(dot)
            effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, randomPos)
          elseif self._bindCaster then
            effectEntity = effectService:CreateGridEffectWithEffectHolder(self._effectID, targetPos, casterEntity)
          else
            effectEntity = effectService:CreateWorldPositionEffect(self._effectID, targetPos)
          end
          if self._offsetHigh then
            effectEntity:SetLocationHeight(self._offsetHigh)
          end
          if self._randomRotateXYZ then
            effectEntity:SetDirection(Vector3(math.random(0, self._randomRotateXYZ), math.random(0, self._randomRotateXYZ), math.random(0, self._randomRotateXYZ)))
            local randomEuler = Quaternion.Euler(math.random(0, self._randomRotateXYZ), math.random(0, self._randomRotateXYZ), math.random(0, self._randomRotateXYZ))
            local dot = randomEuler * Vector3.forward
            local randomPos = Vector3.Normalize(dot)
            local effectGO = effectEntity:View():GetGameObject()
          end
          if 0 < self._delayTime then
            YIELD(TT, self._delayTime)
          end
        end
      end
    end
  end
end

function PlayGridRangeEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      10
    })
  end
  return t
end
