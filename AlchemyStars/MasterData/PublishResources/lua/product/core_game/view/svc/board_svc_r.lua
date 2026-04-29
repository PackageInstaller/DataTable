require("base_service")
_class("BoardServiceRender", BaseService)
BoardServiceRender = BoardServiceRender

function BoardServiceRender:Constructor(world)
  self.pieceHeight = 0
  self._gridEntityTable = {}
end

function BoardServiceRender:GetEntityRealTimeGridPosByGO(entity, needOffSet)
  local go = entity:View():GetGameObject()
  local pos = go.transform.position
  return self:_GetEntityRealTimeGridPos(entity, pos, needOffSet)
end

function BoardServiceRender:_GetEntityRealTimeGridPos(entity, renderPosition, needOffSet)
  local targetGridPos
  if not needOffSet then
    local monster_body_area_cmpt = entity:BodyArea()
    local monster_body_area = {}
    if monster_body_area_cmpt then
      monster_body_area = monster_body_area_cmpt:GetArea()
    end
    if 1 < #monster_body_area then
      targetGridPos = self:BoardRenderPos2FloatGridPos_New(renderPosition)
      local offset = entity:GridLocation().Offset
      targetGridPos = targetGridPos - offset
      targetGridPos = Vector2(math.floor(targetGridPos.x), math.floor(targetGridPos.y))
    else
      targetGridPos = self:BoardRenderPos2GridPos(renderPosition)
    end
  else
    targetGridPos = self:BoardRenderPos2FloatGridPos_New(renderPosition)
  end
  return targetGridPos
end

function BoardServiceRender:GetEntityRealTimeGridPos(entity, needOffSet)
  return self:_GetEntityRealTimeGridPos(entity, entity:Location().Position, needOffSet)
end

function BoardServiceRender:BoardRenderPos2FloatGridPos_New(pos)
  local basePos = self:GetBaseGridRenderPos()
  local render_pos_offset = pos - basePos
  local new_grid_pos = Vector3(1, 0, 1) + render_pos_offset
  return Vector2(new_grid_pos.x, new_grid_pos.z)
end

function BoardServiceRender:BoardRenderPos2GridPos(pos)
  local gridPos = self:BoardRenderPos2FloatGridPos(pos)
  return Vector2(math.floor(gridPos.x), math.floor(gridPos.y))
end

function BoardServiceRender:BoardRenderPos2FloatGridPos(pos)
  local basePos = self:GetBaseGridRenderPos()
  local render_pos_offset = pos - basePos
  local new_grid_pos = Vector3(1, 0, 1) + render_pos_offset
  local clamp_x = math.floor(new_grid_pos.x + 0.5)
  local clamp_y = math.floor(new_grid_pos.z + 0.5)
  return Vector2(clamp_x, clamp_y)
end

function BoardServiceRender:GetRealEntityGridPos(target)
  if target:HasLocation() then
    local localPosition = target:GetPosition()
    return self:BoardRenderPos2FloatGridPos_New(localPosition)
  end
  return Vector2(0, 0)
end

function BoardServiceRender:IsLeftOrRight(casterEntity, targetEntity)
  local viewPos = self:GetEntityRealTimeGridPos(casterEntity, true)
  local viewDir = casterEntity:GetDirection()
  local targetPos = self:GetEntityRealTimeGridPos(targetEntity, true)
  if viewPos and targetPos and viewDir then
    local vVT = targetPos - viewPos
    local v = Vector3.Cross(Vector3(viewDir.x, 0, viewDir.z), Vector3(vVT.x, 0, vVT.y))
    if v then
      return v.y
    end
  end
  return 0
end

function BoardServiceRender:GridPos2RenderPos(gridPos)
  local xOffset = gridPos.x - 1
  local zOffset = gridPos.y - 1
  local basePos = self:GetBaseGridRenderPos()
  return basePos + Vector3(xOffset, self.pieceHeight, zOffset)
end

function BoardServiceRender:GridPosition2LocationPos(pos, entity)
  if pos then
    if pos._className ~= "Vector3" then
      if pos._className == "Vector2" then
        local height = entity:GetGridHeight()
        local retPos = self:GridPos2RenderPos(pos)
        if height then
          retPos.y = retPos.y + height
        end
        return retPos
      else
        Log.fatal("Param Invalid  TrackBack:", Log.traceback())
        return nil
      end
    else
      return pos
    end
  end
  return nil
end

function BoardServiceRender:GridDir2LocationDir(dir)
  if dir then
    if dir._className ~= "Vector3" then
      if dir._className == "Vector2" then
        return Vector3(dir.x, 0, dir.y)
      else
        Log.fatal("Param Invalid  TrackBack:", Log.traceback())
        return nil
      end
    else
      return dir
    end
  end
  return nil
end

function BoardServiceRender:GetPosListCenter(posList)
  local tmp = Vector2(0, 0)
  for k, v in pairs(posList) do
    tmp = tmp + v
  end
  tmp = Vector2(tmp.x / #posList, tmp.y / #posList)
  return tmp
end

function BoardServiceRender:BoardGridPosOffset(pos)
  local roundX = math.floor(math.abs(pos.x) + 0.5)
  if pos.x < 0 then
    roundX = roundX * -1
  end
  local roundZ = math.floor(math.abs(pos.z) + 0.5)
  if 0 > pos.z then
    roundZ = roundZ * -1
  end
  local decimalX = pos.x - roundX
  local decimalZ = pos.z - roundZ
  local offset = Vector2(decimalX, decimalZ)
  return offset
end

function BoardServiceRender:IsSameCrossPos(center, pos)
  if center.x == pos.x or center.y == pos.y then
    return true
  end
  return false
end

function BoardServiceRender:CheckColumnBoundary(columnVal, attackArea)
  if columnVal >= attackArea.minX and columnVal <= attackArea.maxX then
    return true
  end
  return false
end

function BoardServiceRender:IsInPlayerArea(pos)
  local x, y = pos.x, pos.y
  if x == nil or y == nil then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local playerArea = utilDataSvc:GetPlayerArea()
  local gridTiles = utilDataSvc:GetGridTiles()
  return x >= playerArea.minX and x <= playerArea.maxX and y >= playerArea.minY and y <= playerArea.maxY and gridTiles[x] and gridTiles[x][y]
end

function BoardServiceRender:GetEdgePosList()
  local utilDataSvc = self._world:GetService("UtilData")
  local edgePosList = {}
  local left, right, top, down
  local playerArea = utilDataSvc:GetPlayerArea()
  for x = playerArea.minX, playerArea.maxX do
    for y = playerArea.minY, playerArea.maxY do
      if self:IsInPlayerArea(Vector2(x, y)) then
        left = {
          x - 1,
          y
        }
        right = {
          x + 1,
          y
        }
        top = {
          x,
          y + 1
        }
        down = {
          x,
          y - 1
        }
        local dirs = {
          left,
          down,
          right,
          top
        }
        local curDirs = {}
        local isAdd = false
        local data = {}
        for dir, gridPos in ipairs(dirs) do
          if not self:IsInPlayerArea(Vector2(gridPos[1], gridPos[2])) then
            if isAdd == false then
              data.pos = Vector2(x, y)
              data.dirs = {}
              isAdd = true
            end
            table.insert(data.dirs, dir)
          end
        end
        if isAdd then
          table.insert(edgePosList, data)
        end
      end
    end
  end
  return edgePosList
end

function BoardServiceRender:IsPosCanLinkLine(pos, chainPath)
  local len = table.count(chainPath)
  if len <= 1 then
    return true
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local lastPos = chainPath[len]
  local isBreakLastPos = utilDataSvc:IsPosExit(lastPos) or utilDataSvc:IsPosDimensionDoor(lastPos)
  if isBreakLastPos and not table.icontains(chainPath, pos) then
    return false
  end
  return true
end

function BoardServiceRender:CalcConnectPieces(chainPath, pieceType, bMoveBack, entityWork)
  if #chainPath <= 1 or pieceType == PieceType.None or pieceType == PieceType.Any then
    return {}
  end
  local endPos = chainPath[#chainPath]
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieces = env:GetAllPieceType()
  local conn = {}
  for x, v in pairs(pieces) do
    conn[x] = {}
  end
  local connect_pieces = {}
  table.insert(connect_pieces, endPos)
  conn[endPos.x][endPos.y] = true
  local utilDataSvc = self._world:GetService("UtilData")
  
  local function search9(center, next)
    for i = -1, 1 do
      for j = -1, 1 do
        local pos = Vector2(center.x + i, center.y + j)
        if utilDataSvc:IsValidPiecePos(pos) then
          local piece_type = env:GetPieceType(pos)
          local canLinkLine = self:IsInPlayerArea(pos) and self:IsPosCanLinkLine(pos, chainPath) and not utilDataSvc:IsPosBlockLinkLineForChain(pos)
          local pieceMatch = CanMatchPieceType(pieceType, piece_type) or utilDataSvc:IsPosCanMapOtherPiece(pos, pieceType, piece_type)
          if not conn[pos.x][pos.y] and pieceMatch and canLinkLine then
            table.insert(connect_pieces, pos)
            conn[pos.x][pos.y] = true
            next(pos, next)
          end
        end
      end
    end
  end
  
  search9(endPos, search9)
  return connect_pieces
end

local OutlineDirType = {
  Up = 1,
  Down = 2,
  Left = 3,
  Right = 4
}
local OutlineType = {
  Short = 1,
  LeftShort = 2,
  RightShort = 3,
  Long = 4
}

function BoardServiceRender:GetRoundPosList(pos)
  local res = {}
  res[OutlineDirType.Up] = Vector2(pos.x, pos.y + 1)
  res[OutlineDirType.Down] = Vector2(pos.x, pos.y - 1)
  res[OutlineDirType.Right] = Vector2(pos.x + 1, pos.y)
  res[OutlineDirType.Left] = Vector2(pos.x - 1, pos.y)
  return res
end

function BoardServiceRender:GetOutlineDirType(dir)
  if dir.x > 0 and dir.y == 0 then
    return OutlineDirType.Right
  elseif dir.x < 0 and dir.y == 0 then
    return OutlineDirType.Left
  elseif dir.x == 0 and 0 < dir.y then
    return OutlineDirType.Up
  else
    return OutlineDirType.Down
  end
end

function BoardServiceRender:GetBoardRect()
  local utilDataSvc = self._world:GetService("UtilData")
  local playerArea = utilDataSvc:GetPlayerArea()
  local basePos = self:GetBaseGridRenderPos()
  self.boardRect = {
    x = basePos.x - 0.5,
    y = basePos.z - 0.5,
    z = basePos.x - 0.5 + playerArea.maxX - playerArea.minX,
    w = basePos.z - 0.5 + playerArea.maxY - playerArea.minY
  }
  return self.boardRect
end

function BoardServiceRender:CreateEmptyGridEffectEntity(gridPos)
  local sEntity = self._world:GetService("RenderEntity")
  local gridEffectEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.EmptyGridEffect)
  gridEffectEntity:SetGridPosition(gridPos)
  gridEffectEntity:SetPosition(gridPos)
  return gridEffectEntity
end

function BoardServiceRender:GetExceptGrids(curGrids)
  local gridGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  local targetGridEntity
  local exceptGrids = {}
  for _, gridEntity in ipairs(gridGroup:GetEntities()) do
    local curGridPos = gridEntity:GridLocation().Position
    table.insert(exceptGrids, curGridPos)
  end
  for index, pos in ipairs(curGrids) do
    for i = #exceptGrids, 1, -1 do
      if exceptGrids[i] == pos then
        table.remove(exceptGrids, i)
        break
      end
    end
  end
  return exceptGrids
end

function BoardServiceRender:FillChainPathPieces(fillPieceTable)
  local pieceService = self._world:GetService("Piece")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  for i, grid in ipairs(fillPieceTable) do
    local x, y = grid.x, grid.y
    local targetGridColor = grid.color
    local pos = Vector2(x, y)
    local currentPiece = renderBoardCmpt:GetGridRenderEntity(grid)
    if currentPiece then
      Log.debug("FillChainPathPieces() pos=", Vector2.Pos2Index(pos), " from=", currentPiece:Piece():GetPieceType(), " to=", targetGridColor)
      local gridEntity = self:ChangeGridEntity(targetGridColor, pos)
      pieceService:SetPieceEntityBirth(gridEntity)
    else
      local gridEntity = self:CreateGridEntity(targetGridColor, pos)
    end
  end
end

function BoardServiceRender:ChangeGridEntity(pieceType, gridPos, isHide)
  local pieceService = self._world:GetService("Piece")
  local modifyEntity = pieceService:FindPieceEntity(gridPos)
  if modifyEntity == nil then
    Log.debug("BoardServiceRender:ChangeGridEntity() pos=", Vector2.Pos2Index(gridPos), " not FindPieceEntity")
    return
  end
  pieceService:SetPieceEntityPieceType(modifyEntity, pieceType)
  modifyEntity:SetGridPosition(gridPos)
  modifyEntity:SetPosition(gridPos)
  Log.debug("ChangeGridEntity gridPos=", Vector2.Pos2Index(gridPos), " pieceType=", pieceType)
  return modifyEntity
end

function BoardServiceRender:_GetBrokenGridPrefabPath(gridType)
  if 1 <= gridType and gridType <= 5 then
    local path = string.format("eff_gezi_suilie_0%d.prefab", gridType)
    return path
  end
end

function BoardServiceRender:_GetGridConfig()
  local levelID = self._world.BW_WorldInfo.level_id
  local levelConfig = Cfg.cfg_level[levelID]
  local themeID = levelConfig.Theme
  local cfgThemeData = Cfg.cfg_theme[themeID]
  return cfgThemeData
end

function BoardServiceRender:CreateGridEntity(pieceType, piecePos, isHide, pieceEffectType)
  local sEntity = self._world:GetService("RenderEntity")
  local gridEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.Grid)
  if pieceEffectType then
    local pieceComponent = gridEntity:Piece()
    pieceComponent:SetRenderPieceEffectType(pieceEffectType)
  end
  self:_InitGridEntity(gridEntity, pieceType, piecePos, isHide)
  Log.debug("CreateGridEntity gridPos=", Vector2.Pos2Index(piecePos), " pieceType=", pieceType)
  return gridEntity
end

function BoardServiceRender:ReCreateGridEntity(pieceType, gridPos, isHide, needBirthEffect, notRefreshPrism)
  local pieceSvc = self._world:GetService("Piece")
  local newGridEntity = pieceSvc:FindPieceEntity(gridPos)
  if newGridEntity == nil then
    return
  end
  self:_InitGridEntity(newGridEntity, pieceType, gridPos, isHide)
  if needBirthEffect then
    pieceSvc:SetPieceEntityBirth(newGridEntity)
  else
    pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
  end
  local brokenTrap = self._world:GetPreviewEntity():PreviewEnv():GetEntitiesAtPos(gridPos, function(e)
    return e:TrapRender() and e:TrapRender():GetTrapRender_IsBrokenGrid() and not e:HasDeadMark()
  end)
  if brokenTrap and 0 < #brokenTrap then
    local trapSvc = self._world:GetService("TrapRender")
    for i, trap in ipairs(brokenTrap) do
      local prefabPath = self:_GetBrokenGridPrefabPath(pieceType)
      if prefabPath then
        trap:ReplaceAsset(NativeUnityPrefabAsset:New(prefabPath, not isHide))
      end
      trapSvc:OnCheckTrapViewSetPieceExtraLayer(trap, gridPos)
    end
  end
  Log.debug("ReCreateGridEntity gridPos=", Vector2.Pos2Index(gridPos), " pieceType=", pieceType)
  if GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    GameGlobal.GetModule(SkillPerfModule):SetGridEntityScale(newGridEntity)
  end
  return newGridEntity
end

function BoardServiceRender:_InitGridEntity(gridEntity, pieceType, piecePos, isHide)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceEntityPieceType(gridEntity, pieceType)
  gridEntity:SetGridPosition(piecePos)
  gridEntity:SetPosition(piecePos)
  gridEntity:RemoveOutsideRegion()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  renderBoardCmpt:SetGridRenderEntityData(piecePos, gridEntity)
end

function BoardServiceRender:ApplyPrism(piecePrePos, piecePos)
  local pieceService = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  pieceService:SetPieceRenderEffect(piecePos, PieceEffectType.Normal)
  local changed = self:_ApplyPrismToPreviewEnv(piecePrePos, piecePos)
  local pieceType = env:GetPieceType(piecePos)
  for posIdx, color in pairs(changed) do
    local pos = Vector2.Index2Pos(posIdx)
    if color ~= pieceType then
      self:ReCreateGridEntity(pieceType, pos, false, true)
    end
  end
end

function BoardServiceRender:_ApplyPrismToPreviewEnv(prePos, prismPos)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local prismPieceType = env:GetPieceType(prismPos)
  local tTargetPieces = {}
  local prismEntityID = env:GetPrismEntityIDAtPos(prismPos)
  local scopeType, scopeParam = self._world:GetService("UtilData"):GetPrismCustomScopeConfig(prismEntityID)
  if scopeType then
    local calc = SkillScopeCalculator:New(self._world:GetService("UtilScopeCalc"))
    local result = calc:ComputeScopeRange(scopeType, scopeParam, prismPos, {
      Vector2.zero
    })
    local range = result:GetAttackRange() or {}
    for _, v2 in ipairs(range) do
      local targetPieceType = env:GetPieceType(v2)
      local canChange = not env:IsPosBlock(v2, BlockFlag.ChangeElement)
      if targetPieceType and targetPieceType ~= PieceType.None and canChange then
        table.insert(tTargetPieces, {
          pos = v2,
          originalPieceType = env:GetPieceType(v2),
          pieceType = prismPieceType
        })
      end
    end
  else
    local dir = prismPos - prePos
    for i = 1, BattleConst.PrismEffectPieceCount do
      local targetPos = prismPos + dir * i
      local targetPieceType = env:GetPieceType(targetPos)
      local canChange = not env:IsPosBlock(targetPos, BlockFlag.ChangeElement)
      if targetPieceType and targetPieceType ~= PieceType.None and canChange then
        table.insert(tTargetPieces, {
          pos = targetPos,
          originalPieceType = targetPieceType,
          pieceType = prismPieceType
        })
      end
    end
  end
  local changed = {}
  for _, data in ipairs(tTargetPieces) do
    local changedPosIndex = Vector2.Pos2Index(data.pos)
    changed[changedPosIndex] = data.originalPieceType
    env._pieceTypes[changedPosIndex] = data.pieceType
  end
  local prismPosIndex = Vector2.Pos2Index(prismPos)
  env._prismChangedPieces[prismPosIndex] = changed
  env:SetNeedUpdateConnectPieces(true)
  return changed
end

function BoardServiceRender:UnapplyPrism(prismPos)
  local pieceService = self._world:GetService("Piece")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  pieceService:ResetPieceEffectRender(prismPos)
  local pieceType = env:GetPieceType(prismPos)
  local changed = env:GetPrismChangedPieces(prismPos)
  if not changed then
    Log.error("[UnapplyPrism]: PreviewEnvComponent:GetPrismChangedPieces(prismPos) == nil.  prismPos=" .. tostring(Vector2.Pos2Index(prismPos)))
  end
  for posIdx, color in pairs(changed) do
    local pos = Vector2.Index2Pos(posIdx)
    self:ReCreateGridEntity(color, pos, false, true)
  end
  env:UnapplyPrism(prismPos)
end

function BoardServiceRender:RefreshPiece(targetEntity, bUp, isAI)
  local sPiece = self._world:GetService("Piece")
  local sTrapRender = self._world:GetService("TrapRender")
  local curPos = self:GetRealEntityGridPos(targetEntity)
  local workPos = curPos - targetEntity:GridLocation():GetGridOffset()
  local renderEntityService = self._world:GetService("RenderEntity")
  if bUp then
    renderEntityService:DestroyMonsterAreaOutLineEntity(targetEntity)
  else
    renderEntityService:CreateMonsterAreaOutlineEntity(targetEntity)
  end
  local area = targetEntity:BodyArea():GetArea()
  for i, p in ipairs(area) do
    local posWork = workPos + p
    if posWork.x == math.floor(posWork.x) and posWork.y == math.floor(posWork.y) then
      if bUp then
        sPiece:SetPieceAnimUp(posWork)
        if not isAI then
          sTrapRender:ShowHideTrapAtPos(posWork, true)
        end
      else
        sPiece:SetPieceAnimDown(posWork)
        if not isAI then
          sTrapRender:ShowHideTrapAtPos(posWork, false)
        end
      end
    end
  end
end

function BoardServiceRender:GetAllTerrainAbyssAreas()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local eTraps = group:GetEntities()
  local areaList = {}
  for k, entity in pairs(eTraps) do
    local trapComponent = entity:Trap()
    if trapComponent:GetTrapType() == TrapType.TerrainAbyss then
      local areaCmpt = entity:BodyArea()
      local areas = areaCmpt:GetArea()
      local basePos = entity:GetGridPosition()
      for i, offSet in ipairs(areas) do
        local area = Vector2(basePos.x + offSet.x, basePos.y + offSet.y)
        table.insert(areaList, area)
      end
    end
  end
  return areaList
end

function BoardServiceRender:CreateGridFakeEntity(pieceType, piecePos, pieceEffectType)
  local sEntity = self._world:GetService("RenderEntity")
  local gridEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.GridFake)
  if pieceEffectType then
    local pieceFakeComponent = gridEntity:PieceFake()
    pieceFakeComponent:SetRenderPieceEffectType(pieceEffectType)
  end
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceFakeEntityPieceType(gridEntity, pieceType)
  gridEntity:SetGridPosition(piecePos)
  gridEntity:SetPosition(piecePos)
  gridEntity:RemoveOutsideRegion()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardSpliceComponent = renderBoardEntity:RenderBoardSplice()
  renderBoardSpliceComponent:SetGridRenderEntityData(piecePos, gridEntity)
  Log.debug("CreateGridFakeEntity gridPos=", Vector2.Pos2Index(piecePos), " pieceType=", pieceType)
  return gridEntity
end

function BoardServiceRender:InitBaseGridRenderPos()
  local renderPos = BattleConst.BaseGridRenderPos
  local themeCfg = self:_GetGridConfig()
  if themeCfg then
    if themeCfg.BaseGridRenderPos then
      renderPos = Vector3(themeCfg.BaseGridRenderPos[1], themeCfg.BaseGridRenderPos[2], themeCfg.BaseGridRenderPos[3])
    else
      renderPos = BattleConst.BaseGridRenderPos
    end
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  if renderBoardEntity then
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    renderBoardCmpt:SetBaseGridRenderPos(renderPos)
  end
end

function BoardServiceRender:GetBaseGridRenderPos()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  if renderBoardEntity then
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    return renderBoardCmpt:GetBaseGridRenderPos()
  else
    return BattleConst.BaseGridRenderPos
  end
end

function BoardServiceRender:SetBaseGridRenderPos(renderPos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  if renderBoardEntity then
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    renderBoardCmpt:SetBaseGridRenderPos(renderPos)
  end
end

function BoardServiceRender:ModifyGridEntity(modifyEntity, gridPos, pieceType)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceEntityPieceType(modifyEntity, pieceType)
  modifyEntity:SetGridPosition(gridPos)
  modifyEntity:SetPosition(gridPos)
  return modifyEntity
end

function BoardServiceRender:CreatePushBoardGridFakeEntity(pieceType, piecePos, isHide)
  local sEntity = self._world:GetService("RenderEntity")
  local gridEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.GridFake)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceFakeEntityPieceType(gridEntity, pieceType)
  gridEntity:SetGridPosition(piecePos)
  gridEntity:SetPosition(piecePos)
  gridEntity:RemoveOutsideRegion()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardPushComponent = renderBoardEntity:RenderBoardPush()
  renderBoardPushComponent:SetGridRenderEntityData(piecePos, gridEntity)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceFakeEntityAnimDark(gridEntity)
  Log.debug("CreatePushBoardGridFakeEntity gridPos=", Vector2.Pos2Index(piecePos), " pieceType=", pieceType)
  return gridEntity
end

function BoardServiceRender:CalcConnectPiecesMoye(chainPath, pieceType, skillConfigData)
  if #chainPath <= 0 or pieceType == PieceType.None then
    return {}
  end
  local endPos = chainPath[#chainPath]
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieces = env:GetAllPieceType()
  local conn = {}
  for x, v in pairs(pieces) do
    conn[x] = {}
  end
  local connect_pieces = {}
  table.insert(connect_pieces, endPos)
  conn[endPos.x][endPos.y] = true
  local utilDataSvc = self._world:GetService("UtilData")
  
  local function search9(center, next)
    for i = -1, 1 do
      for j = -1, 1 do
        local pos = Vector2(center.x + i, center.y + j)
        if utilDataSvc:IsValidPiecePos(pos) then
          local piece_type = env:GetPieceType(pos)
          local pieceMatch = CanMatchPieceType(pieceType, piece_type) or self:_TrapCheck(utilDataSvc, pos, skillConfigData)
          if not conn[pos.x][pos.y] and pieceMatch then
            table.insert(connect_pieces, pos)
            conn[pos.x][pos.y] = true
            next(pos, next)
          end
        end
      end
    end
  end
  
  search9(endPos, search9)
  return connect_pieces
end

function BoardServiceRender:_TrapCheck(utilDataSvc, gridPos, skillConfigData)
  local vaildTrapIDs = skillConfigData._pickUpParam.trapIdList
  if vaildTrapIDs and 0 < #vaildTrapIDs then
    local traps = utilDataSvc:GetTrapsAtPos(gridPos)
    for _, trap in pairs(traps) do
      local trapId = trap:TrapRender():GetTrapID()
      if table.icontains(vaildTrapIDs, trapId) then
        return true
      end
    end
  end
  return false
end
