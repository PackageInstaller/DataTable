require("base_ins_r")
_class("PlayGridEffectOnTrapInstruction", BaseInstruction)
PlayGridEffectOnTrapInstruction = PlayGridEffectOnTrapInstruction

function PlayGridEffectOnTrapInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._trapId = tonumber(paramList.trapId)
end

function PlayGridEffectOnTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  local utilSvc = world:GetService("UtilData")
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      for _, pos in ipairs(posList) do
        local traps = utilSvc:GetTrapsAtPos(pos)
        if traps then
          for _, trap in ipairs(traps) do
            if trap:TrapRender():GetTrapID() == self._trapId then
              effectService:CreateWorldPositionEffect(self._effectID, pos)
            end
          end
        end
      end
    end
  end
end

function PlayGridEffectOnTrapInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
