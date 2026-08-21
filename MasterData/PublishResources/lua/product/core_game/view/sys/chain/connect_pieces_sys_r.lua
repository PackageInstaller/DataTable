_class("ConnectPiecesSystem_Render", ReactiveSystem)
ConnectPiecesSystem_Render = ConnectPiecesSystem_Render

function ConnectPiecesSystem_Render:Constructor(world)
  self._world = world
end

function ConnectPiecesSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {"Added"})
  return c
end

function ConnectPiecesSystem_Render:Filter(entity)
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return false
  end
  local autoSvc = self._world:GetService("AutoFight")
  return entity:HasPreviewChainPath() and not autoSvc:IsRunning()
end

function ConnectPiecesSystem_Render:ExecuteEntities(entities)
  for _, e in ipairs(entities) do
    local entity = e
    local chainPathCmp = entity:PreviewChainPath()
    local chain_path = chainPathCmp:GetPreviewChainPath()
    local piece_type = chainPathCmp:GetPreviewPieceType()
    if chain_path and 2 <= #chain_path then
      local connect_pieces = self:_CalcConnectPieces(e, chain_path, chainPathCmp, piece_type)
      e:ReplaceConnectPieces(connect_pieces, piece_type)
    elseif chain_path and #chain_path <= 1 then
      e:ReplaceConnectPieces({}, PieceType.None)
    end
  end
end

function ConnectPiecesSystem_Render:_CalcConnectPieces(e, chain_path, chainPathCmp, piece_type)
  local connect_pieces = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  local viewDataEntity = self._world:GetRenderBoardEntity()
  local waveDataCmpt = viewDataEntity:WaveData()
  local isExitWave = waveDataCmpt:IsExitWave()
  local exitPos = waveDataCmpt:GetExitWavePos()
  local linkLineSvc = self._world:GetService("LinkLine")
  local isTwoChain = linkLineSvc:IsTwoColorChain()
  local firstElementType, firstElementIndex = chainPathCmp:GetFirstElementData()
  local isSecondColor = false
  if isTwoChain then
    isSecondColor = linkLineSvc:IsSecondColorForTwoColorChain(chain_path)
  end
  if isTwoChain and isSecondColor then
    local lastPos = chain_path[#chain_path]
    connect_pieces = self:_CalcSurrondCanLinkList(lastPos, chain_path)
  else
    if isExitWave and exitPos == chain_path[table.count(chain_path)] then
      connect_pieces = chain_path
    else
      connect_pieces = boardServiceRender:CalcConnectPieces(chain_path, piece_type, chainPathCmp:GetMoveBack(), e)
    end
    if 0 < firstElementIndex then
      for checkIndex = 2, #chain_path do
        local curPoint = chain_path[checkIndex]
        local isContain = table.icontains(connect_pieces, curPoint)
        if not isContain then
          table.insert(connect_pieces, curPoint)
        end
      end
    end
  end
  return connect_pieces
end

function ConnectPiecesSystem_Render:_CalcSurrondCanLinkList(center, chainPath)
  local boardServiceRender = self._world:GetService("BoardRender")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local utilDataSvc = self._world:GetService("UtilData")
  local connect_pieces = {}
  for i = -1, 1 do
    for j = -1, 1 do
      local pos = Vector2(center.x + i, center.y + j)
      if utilDataSvc:IsValidPiecePos(pos) then
        local piece_type = env:GetPieceType(pos)
        local canLinkLine = boardServiceRender:IsPosCanLinkLine(pos, chainPath) and not utilDataSvc:IsPosBlockLinkLineForChain(pos)
        if canLinkLine then
          table.insert(connect_pieces, pos)
        end
      end
    end
  end
  for index = 2, #chainPath do
    local curPoint = chainPath[index]
    local hasPoint = table.icontains(connect_pieces, curPoint)
    if not hasPoint then
      table.insert(connect_pieces, curPoint)
    end
  end
  return connect_pieces
end

function ConnectPiecesSystem_Render:_CheckNeedUpdateConnectPieces(entity)
  local chainPathCmp = entity:PreviewChainPath()
  local chainPath = chainPathCmp:GetPreviewChainPath()
  local chainCount = #chainPath
  local lastPos = chainPath[chainCount]
  if chainCount <= 1 then
    return false
  end
  local isExitPos = self:_IsCurrentChainExitPos(lastPos)
  if isExitPos then
    return true
  end
  local isDimensionDoor = self:_IsCurrentChainDimensionDoor(lastPos)
  if isDimensionDoor then
    return true
  end
  local previewEntity = self._world:GetPreviewEntity()
  local envCmpt = previewEntity:PreviewEnv()
  if envCmpt:GetNeedUpdateConnectPieces() then
    envCmpt:SetNeedUpdateConnectPieces(false)
    return true
  end
  local lastPosPieceType = envCmpt:GetPieceType(lastPos)
  if lastPosPieceType ~= PieceType.Any then
    local isAllAny = self:_IsPreChainPathAllAny(chainPath)
    if isAllAny then
      return true
    end
  end
  return false
end

function ConnectPiecesSystem_Render:_IsPreChainPathAllAny(chainPath)
  local chainCount = #chainPath
  local previewEntity = self._world:GetPreviewEntity()
  local envCmpt = previewEntity:PreviewEnv()
  for index = 2, chainCount - 1 do
    local curChainPos = chainPath[index]
    local curPointType = envCmpt:GetPieceType(curChainPos)
    if curPointType ~= PieceType.Any then
      return false
    end
  end
  return true
end

function ConnectPiecesSystem_Render:_IsCurrentChainExitPos(lastPos)
  local viewDataEntity = self._world:GetRenderBoardEntity()
  local waveDataCmpt = viewDataEntity:WaveData()
  local isExitWave = waveDataCmpt:IsExitWave()
  local exitPos = waveDataCmpt:GetExitWavePos()
  if isExitWave and exitPos == lastPos then
    return true
  end
  return false
end

function ConnectPiecesSystem_Render:_IsCurrentChainDimensionDoor(lastPos)
  local utilData = self._world:GetService("UtilData")
  return utilData:IsPosDimensionDoor(lastPos)
end
