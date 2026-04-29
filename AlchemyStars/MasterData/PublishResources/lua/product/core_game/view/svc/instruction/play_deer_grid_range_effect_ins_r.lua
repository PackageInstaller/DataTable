require("base_ins_r")
_class("PlayDeerGridRangeEffectInstruction", BaseInstruction)
PlayDeerGridRangeEffectInstruction = PlayDeerGridRangeEffectInstruction

function PlayDeerGridRangeEffectInstruction:Constructor(paramList)
  self._effectID = 2926
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
  local randomRotate = paramList.randomRotate
  if randomRotate then
    self._randomRotate = tonumber(randomRotate)
  else
    self._randomRotate = nil
  end
end

function PlayDeerGridRangeEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  local boardServiceRender = world:GetService("BoardRender")
  local worldPos = boardServiceRender:GridPos2RenderPos(casterEntity:GetGridPosition())
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        local len = table.count(posList)
        for i = 1, len, self._step do
          local pos = posList[i]
          local targetPos = pos + self._offset
          if self._isRotate then
            local effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, targetPos - casterPos)
            self:SatisfyShader(effectEntity, worldPos)
          elseif self._randomRotate then
            local randomPos = Vector2(math.random(0, self._randomRotate), math.random(0, self._randomRotate))
            local effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, targetPos, randomPos)
            self:SatisfyShader(effectEntity, worldPos)
          else
            local effectEntity = effectService:CreateWorldPositionEffect(self._effectID, targetPos)
            self:SatisfyShader(effectEntity, worldPos)
          end
        end
      end
    end
  end
end

function PlayDeerGridRangeEffectInstruction:SatisfyShader(effectEntity, worldPos)
  local csgo = effectEntity:View():GetGameObject()
  local grass = GameObjectHelper.FindChild(csgo.transform, "caodi")
  local csRenderer = grass.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  local v4 = Vector4.zero
  v4.x = worldPos.x
  v4.y = worldPos.y
  v4.z = worldPos.z
  csRenderer.sharedMaterial:SetVector("_Location_xyz", v4)
end

function PlayDeerGridRangeEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      10
    })
  end
  return t
end
