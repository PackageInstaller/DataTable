_class("ConnectAreaRenderSystem_Render", ReactiveSystem)
ConnectAreaRenderSystem_Render = ConnectAreaRenderSystem_Render

function ConnectAreaRenderSystem_Render:Constructor(world)
  self._world = world
end

function ConnectAreaRenderSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.ConnectPieces)
  }, {"Added"})
  return c
end

function ConnectAreaRenderSystem_Render:Filter(entity)
  return entity:HasConnectPieces()
end

function ConnectAreaRenderSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:HandleConnectArea(entities[i])
  end
end

function ConnectAreaRenderSystem_Render:HandleConnectArea(e)
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:GetCurMainStateID() ~= GameStateID.WaitInput and not utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    return
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chain_grid_list = previewChainPathCmpt:GetPreviewChainPath()
  local pieceService = self._world:GetService("Piece")
  local connect_piece_grid_list = e:ConnectPieces():GetConnectPieces()
  local count = #connect_piece_grid_list
  if 0 < count then
    self:HandleNoneConnectAreaDark(chain_grid_list, connect_piece_grid_list)
  elseif count == 0 then
    if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
      self:HandleNoChainPointForCostStep(chain_grid_list)
    else
      self:HandleNoChainPoint(chain_grid_list)
    end
  end
end

function ConnectAreaRenderSystem_Render:HandleNoneConnectAreaDark(chain_grid_list, connectGridList)
  local pieceService = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    if not pieceEntity:HasOutsideRegion() then
      local gridLocationCmpt = pieceEntity:GridLocation()
      local gridPos = gridLocationCmpt.Position
      local inConnectArea = table.icontains(connectGridList, gridPos)
      if utilDataSvc:IsNeedShowLinkageNumForCostStep() then
        if utilDataSvc:IsEnoughStepToLinkMore(chain_grid_list) then
          inConnectArea = true
        elseif not table.icontains(chain_grid_list, gridPos) then
          inConnectArea = false
        else
          inConnectArea = true
        end
      end
      if inConnectArea == false then
        pieceService:SetPieceAnimDark(gridPos)
      elseif not table.icontains(chain_grid_list, gridPos) then
        local animName = pieceService:GetPieceAnimation(gridPos)
        if animName ~= "Normal" then
          pieceService:SetPieceEntityAnimNormal(pieceEntity)
        end
      end
    end
  end
end

function ConnectAreaRenderSystem_Render:HandleNoChainPoint(chain_grid_list)
  local utilDataSvc = self._world:GetService("UtilData")
  local curStateID = utilDataSvc:GetCurMainStateID()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    if not pieceEntity:HasOutsideRegion() then
      local gridPos = pieceEntity:GetGridPosition()
      if not table.icontains(chain_grid_list, gridPos) then
        if curStateID == GameStateID.PieceRefresh then
          self:HandlePieceAnimForPieceRefresh(pieceEntity)
        else
          self:HandlePieceAnimForOther(pieceEntity)
        end
      end
    end
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathComponent = renderBoardEntity:RenderChainPath()
  renderChainPathComponent:SetConnectAreaRenderCantRefresh(false)
end

function ConnectAreaRenderSystem_Render:HandleNoChainPointForCostStep(chain_grid_list)
  local utilDataSvc = self._world:GetService("UtilData")
  local curStateID = utilDataSvc:GetCurMainStateID()
  local isLinkLineState = false
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity then
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    if previewChainPathCmpt and previewChainPathCmpt:IsLinkLine() then
      isLinkLineState = true
    end
  end
  if isLinkLineState then
    local pieceService = self._world:GetService("Piece")
    local utilDataSvc = self._world:GetService("UtilData")
    local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
    for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
      if not pieceEntity:HasOutsideRegion() then
        local gridLocationCmpt = pieceEntity:GridLocation()
        local gridPos = gridLocationCmpt.Position
        local inConnectArea = false
        if utilDataSvc:IsEnoughStepToLinkMore(chain_grid_list) then
          inConnectArea = true
        elseif not table.icontains(chain_grid_list, gridPos) then
          inConnectArea = false
        else
          inConnectArea = true
        end
        if inConnectArea == false then
          pieceService:SetPieceAnimDark(gridPos)
        elseif not table.icontains(chain_grid_list, gridPos) then
          local animName = pieceService:GetPieceAnimation(gridPos)
          if animName ~= "Normal" then
            pieceService:SetPieceEntityAnimNormal(pieceEntity)
          end
        end
      end
    end
  else
    self:HandleNoChainPoint(chain_grid_list)
  end
end

function ConnectAreaRenderSystem_Render:HandlePieceAnimForOther(pieceEntity)
  local gridLocationCmpt = pieceEntity:GridLocation()
  local gridPos = gridLocationCmpt.Position
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceService = self._world:GetService("Piece")
  local is_blocked = utilDataSvc:IsPosListHaveMonster({gridPos})
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathComponent = renderBoardEntity:RenderChainPath()
  local chainAcrossMonster = renderChainPathComponent:GetChainAcrossMonster()
  local cantRefresh = renderChainPathComponent:GetConnectAreaRenderCantRefresh()
  local refresh = chainAcrossMonster and not cantRefresh
  if not is_blocked or refresh then
    local animName = pieceService:GetPieceAnimation(gridPos)
    if animName ~= "Normal" then
      pieceService:SetPieceEntityAnimNormal(pieceEntity)
    end
  end
end

function ConnectAreaRenderSystem_Render:HandlePieceAnimForPieceRefresh(pieceEntity)
  local playerEntity = self._world:Player():GetCurrentTeamEntity()
  local playerLocCmpt = playerEntity:GridLocation()
  local playerPos = playerLocCmpt:GetGridPos()
  local pieceService = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local gridLocationCmpt = pieceEntity:GridLocation()
  local gridPos = gridLocationCmpt.Position
  local is_blocked = utilDataSvc:IsPosListHaveMonster({gridPos})
  local animName = pieceService:GetPieceAnimation(gridPos)
  local isPlayerPos = gridPos == playerPos
  if not is_blocked and animName == "Dark" then
    pieceService:SetPieceEntityAnimNormal(pieceEntity)
  elseif isPlayerPos then
    pieceService:SetPieceEntityAnimNormal(pieceEntity)
  end
end
