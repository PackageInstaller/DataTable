require("base_ins_r")
_class("PlaySetSummonTrapEffectLayerOrderInstruction", BaseInstruction)
PlaySetSummonTrapEffectLayerOrderInstruction = PlaySetSummonTrapEffectLayerOrderInstruction

function PlaySetSummonTrapEffectLayerOrderInstruction:Constructor(paramList)
  self._wait = tonumber(paramList.wait)
  self._targetLayerName = paramList.targetLayerName or "SkillGeziEffect"
end

function PlaySetSummonTrapEffectLayerOrderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not APPVER_LAYERORDER then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local resultIndex = phaseContext:GetCurResultIndexByType(SkillEffectType.SummonScanTrap)
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local tResults = routineCmpt:GetEffectResultsAsArray(SkillEffectType.SummonScanTrap)
  if not tResults then
    return
  end
  local result = tResults[resultIndex]
  local world = casterEntity:GetOwnerWorld()
  local rsvcTrap = world:GetService("TrapRender")
  local eidNewTrap = result:GetSummonTrapEntityID()
  local eNewTrap = world:GetEntityByID(eidNewTrap)
  if not eNewTrap then
    return
  end
  local go = eNewTrap:View():GetGameObject()
  local trapRenderCmpt = eNewTrap:TrapRender()
  if trapRenderCmpt and trapRenderCmpt:GetIsPrismGrid() ~= nil then
    local pos = eNewTrap:GetRenderGridPosition()
    local pieceSvc = world:GetService("Piece")
    local pieceEntity = pieceSvc:FindPieceEntity(pos)
    if pieceEntity and pieceEntity:HasPiece() then
      local pieceComponent = pieceEntity:Piece()
      local curPiecePrefabObj = pieceComponent:GetBaseLayerObj()
      if curPiecePrefabObj then
        curPiecePrefabObj.transform.localPosition = Vector3(0, 0.01, 0)
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          YIELD(TT, self._wait)
          curPiecePrefabObj.transform.localPosition = Vector3(0, 0, 0)
        end)
      end
    end
  end
  local tLayerOrderComponent = go.gameObject:GetComponentInChildren(typeof(TLayerOrderComponent))
  if not tLayerOrderComponent then
    return
  end
  local curLayerName = tLayerOrderComponent:GetSortLayerName()
  tLayerOrderComponent:SetSortLayer(self._targetLayerName)
  tLayerOrderComponent:Sorted()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, self._wait)
    tLayerOrderComponent:SetSortLayer(curLayerName)
    tLayerOrderComponent:Sorted()
    tLayerOrderComponent:TLayerOrderManagerClearAll()
    tLayerOrderComponent:Sorted()
  end)
end
