require("base_ins_r")
_class("PlayGridRangeVisibleInstruction", BaseInstruction)
PlayGridRangeVisibleInstruction = PlayGridRangeVisibleInstruction

function PlayGridRangeVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
end

function PlayGridRangeVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  local pieceSvc = self._world:GetService("Piece")
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        local len = table.count(posList)
        for i = 1, len do
          local pos = posList[i]
          local pieceEntity = pieceSvc:FindPieceEntity(pos)
          pieceEntity:View():GetGameObject():SetActive(self._visible == 1)
          pieceEntity:View():SetViewVisible(self._visible == 1)
        end
      end
    end
  end
end

function PlayGridRangeVisibleInstruction:GetCacheResource()
  local t = {}
  return t
end
