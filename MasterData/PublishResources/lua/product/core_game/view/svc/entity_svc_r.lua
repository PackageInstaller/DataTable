_class("RenderEntityService", Object)
RenderEntityService = RenderEntityService
local OutlineType = {
  Short = 1,
  LeftShort = 2,
  RightShort = 3,
  Long = 4
}
_enum("OutlineType", OutlineType)

function RenderEntityService:Constructor(world)
  self._world = world
  self._outLineResPathList = {
    [OutlineType.Short] = "eff_gezi_bossyj_short.prefab",
    [OutlineType.LeftShort] = "eff_gezi_bossyj_L.prefab",
    [OutlineType.RightShort] = "eff_gezi_bossyj_R.prefab",
    [OutlineType.Long] = "eff_gezi_bossyj_long.prefab"
  }
  self._configService = self._world:GetService("Config")
end

local OutlineDirType = {
  Up = 1,
  Down = 2,
  Left = 3,
  Right = 4,
  LeftUp = 5,
  RightUp = 6,
  RightDown = 7,
  LeftDown = 8
}
_enum("OutlineDirType", OutlineDirType)

function RenderEntityService:CreateRenderBoardEntity()
  local reBoard = self:CreateRenderEntity(EntityConfigIDRender.RenderBoard)
  self._world:SetRenderBoardEntity(reBoard)
end

function RenderEntityService:CreateMoveRangeArrowEntity(pos, dir, entityID)
  local entityPoolService = self._world:GetService("EntityPool")
  local arrowEntity = entityPoolService:GetCacheEntityByConfigID(entityID)
  arrowEntity:SetLocation(pos, dir)
  local monsterAttackRangeCmpt = arrowEntity:MonsterAttackRange()
  monsterAttackRangeCmpt:SetUseState(true)
  if EntityConfigIDRender.MoveRangeArrow == entityID then
    local pieceService = self._world:GetService("Piece")
    pieceService:SetEffectEntityParentWithPiecePos(arrowEntity, pos)
  end
end

function RenderEntityService:CreateDeathRangeEntity(pos, entityID)
  local entityPoolService = self._world:GetService("EntityPool")
  local arrowEntity = entityPoolService:GetCacheEntityByConfigID(entityID)
  arrowEntity:SetLocation(pos, Vector2(0, 0))
  local monsterAttackRangeCmpt = arrowEntity:MonsterAttackRange()
  if monsterAttackRangeCmpt then
    monsterAttackRangeCmpt:SetUseState(true)
  end
  return arrowEntity
end

function RenderEntityService:CreateAreaEntityFromEntityPool(gridPos, entityID)
  local entityPoolService = self._world:GetService("EntityPool")
  local areaEntity = entityPoolService:GetCacheEntityByConfigID(entityID)
  areaEntity:SetPosition(gridPos)
  local monsterAttackRangeCmpt = areaEntity:MonsterAttackRange()
  monsterAttackRangeCmpt:SetUseState(true)
  return areaEntity
end

function RenderEntityService:CreateAreaEntity(gridPos, entityID, resPath)
  if string.isnullorempty(resPath) then
    return
  end
  local areaEntity = self:CreateRenderEntity(entityID)
  areaEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath))
  areaEntity:SetLocation(gridPos, nil)
  return areaEntity
end

function RenderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterAttackRange)
  for i, entity in ipairs(entityList) do
    local monsterAttackRangeCmpt = entity:MonsterAttackRange()
    if monsterAttackRangeCmpt:IsUse() then
      self:DestroyAreaOutlineEntity({entity}, monsterAttackRangeCmpt:GetEntityConfigID())
      monsterAttackRangeCmpt:SetUseState(false)
    end
  end
end

function RenderEntityService:DestroyAreaOutlineEntity(entityList, entityID)
  entityID = entityID or EntityConfigIDRender.SkillRangeOutline
  local entityPoolService = self._world:GetService("EntityPool")
  for i, entity in ipairs(entityList) do
    entityPoolService:DestroyCacheEntity(entity, entityID)
  end
end

function RenderEntityService:CreatePreviewAreaOutlineEntity(gridList, entityID)
  local entityList = self:CreateAreaOutlineEntity(gridList, entityID)
  for i, entity in ipairs(entityList) do
    local monsterAttackRangeCmpt = entity:MonsterAttackRange()
    monsterAttackRangeCmpt:SetUseState(true)
  end
end

function RenderEntityService:CreateAreaOutlineEntity(gridList, entityID, resPath, pieceType, height, radius)
  local boardServiceRender = self._world:GetService("BoardRender")
  local entityPoolService = self._world:GetService("EntityPool")
  local outlineEntityList = {}
  for _, pos in ipairs(gridList) do
    local roundPosList = boardServiceRender:GetRoundPosList(pos)
    for i = 1, #roundPosList do
      local roundPos = roundPosList[i]
      if not table.icontains(gridList, roundPos) then
        local outlineEntity
        if entityID then
          outlineEntity = entityPoolService:GetCacheEntityByConfigID(entityID)
          if resPath then
            outlineEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath))
          end
        else
          outlineEntity = entityPoolService:GetCacheEntityByConfigID(EntityConfigIDRender.SkillRangeOutline)
        end
        if pieceType then
          outlineEntity:ReplaceSkillRangeOutline(pieceType, false)
        end
        local gridOutlineHeight = 0
        if height then
          gridOutlineHeight = height
        end
        local outlineDir = roundPos - pos
        local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
        outlineEntity:SetLocationHeight(gridOutlineHeight)
        self:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, radius)
        outlineEntityList[#outlineEntityList + 1] = outlineEntity
      end
    end
  end
  return outlineEntityList
end

function RenderEntityService:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, radius)
  local outlinePos, outlineDir = self:_GetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, radius)
  outlineEntity:SetLocation(outlinePos, outlineDir)
end

function RenderEntityService:GetOutlineSourcePos(outlineEntity, radius)
  local boardRenderSvc = self._world:GetService("BoardRender")
  local renderPos = outlineEntity:GetPosition()
  local gridOutlineRadius = radius or 0.5
  local renderGridPos = boardRenderSvc:BoardRenderPos2FloatGridPos_New(renderPos)
  local renderDir = outlineEntity:GetRenderGridDirection()
  local sourcePos
  if renderDir.x == 0 and renderDir.y == -1 then
    sourcePos = Vector2(renderGridPos.x, renderGridPos.y - gridOutlineRadius)
  elseif renderDir.x == 0 and renderDir.y == 1 then
    sourcePos = Vector2(renderGridPos.x, renderGridPos.y + gridOutlineRadius)
  elseif renderDir.x == 1 and renderDir.y == 0 then
    sourcePos = Vector2(renderGridPos.x + gridOutlineRadius, renderGridPos.y)
  elseif renderDir.x == -1 and renderDir.y == 0 then
    sourcePos = Vector2(renderGridPos.x - gridOutlineRadius, renderGridPos.y)
  end
  return sourcePos
end

function RenderEntityService:_GetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, radius)
  local gridOutlineRadius = 0.5
  if radius then
    gridOutlineRadius = radius
  end
  local outlinePos = pos
  local outlineDir = Vector2(0, 0)
  if outlineDirType == OutlineDirType.Up then
    outlinePos = pos + Vector2(0, gridOutlineRadius)
    outlineDir = Vector2(0, -1)
  elseif outlineDirType == OutlineDirType.Down then
    outlinePos = pos + Vector2(0, -gridOutlineRadius)
    outlineDir = Vector2(0, 1)
  elseif outlineDirType == OutlineDirType.Left then
    outlinePos = pos + Vector2(-gridOutlineRadius, 0)
    outlineDir = Vector2(1, 0)
  elseif outlineDirType == OutlineDirType.Right then
    outlinePos = pos + Vector2(gridOutlineRadius, 0)
    outlineDir = Vector2(-1, 0)
  end
  return outlinePos, outlineDir
end

function RenderEntityService:CreateAreaOutlineEntity_New(gridList, entityID)
  local boardServiceRender = self._world:GetService("BoardRender")
  local outlineInfoList = {}
  local outlineEntityList = {}
  for _, pos in ipairs(gridList) do
    local roundPosList = boardServiceRender:GetRoundPosList(pos)
    for i = 1, #roundPosList do
      local roundPos = roundPosList[i]
      if not table.icontains(gridList, roundPos) then
        local outlineDir = roundPos - pos
        local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
        table.insert(outlineInfoList, {
          pos = roundPos,
          sourcePos = pos,
          dirType = outlineDirType
        })
      end
    end
  end
  for k, v in pairs(outlineInfoList) do
    local outlineEntity = self:CreateRenderEntity(entityID)
    local resourcePathType = self:_GetOutlineType(outlineInfoList, v)
    outlineEntity:ReplaceAsset(NativeUnityPrefabAsset:New(self._outLineResPathList[resourcePathType]))
    local gridOutlineHeight = BattleConst.WaringHeight
    self:_SetOutlineEntityPosAndDir(v.sourcePos, outlineEntity, v.dirType)
    outlineEntity:SetLocationHeight(gridOutlineHeight)
    outlineEntityList[#outlineEntityList + 1] = outlineEntity
  end
  return outlineEntityList
end

function RenderEntityService:_GetOutlineType(outlineInfoList, element)
  local boardServiceRender = self._world:GetService("BoardRender")
  local roundPosList = boardServiceRender:GetRoundPosList(element.pos)
  if element.dirType == OutlineDirType.Up then
    if self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Left], OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Up) then
      return OutlineType.Long
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, -1), OutlineDirType.Left) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, -1), OutlineDirType.Right) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, -1), OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Up) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Left], OutlineDirType.Up) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Up) then
      return OutlineType.LeftShort
    end
    return OutlineType.Short
  end
  if element.dirType == OutlineDirType.Down then
    if self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Left], OutlineDirType.Down) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Down) then
      return OutlineType.Long
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, 1), OutlineDirType.Right) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, 1), OutlineDirType.Left) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, 1), OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Left], OutlineDirType.Down) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, 1), OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Down) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Left], OutlineDirType.Down) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Right], OutlineDirType.Down) then
      return OutlineType.RightShort
    end
    return OutlineType.Short
  end
  if element.dirType == OutlineDirType.Left then
    if self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Up], OutlineDirType.Left) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Left) then
      return OutlineType.Long
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, 1), OutlineDirType.Up) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Down) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, -1), OutlineDirType.Down) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(1, 1), OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Left) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Up], OutlineDirType.Left) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Down) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Left) then
      return OutlineType.RightShort
    end
    return OutlineType.Short
  end
  if element.dirType == OutlineDirType.Right then
    if self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Up], OutlineDirType.Right) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Right) then
      return OutlineType.Long
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Down) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, -1), OutlineDirType.Down) then
      return OutlineType.LeftShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, 1), OutlineDirType.Up) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos + Vector2(-1, 1), OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Right) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Up) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Up], OutlineDirType.Right) then
      return OutlineType.RightShort
    end
    if self:_IsHasOutLine(outlineInfoList, element.pos, OutlineDirType.Down) and self:_IsHasOutLine(outlineInfoList, roundPosList[OutlineDirType.Down], OutlineDirType.Right) then
      return OutlineType.LeftShort
    end
    return OutlineType.Short
  end
end

function RenderEntityService:_IsHasOutLine(outlineInfoList, pos, dirType)
  for k, v in pairs(outlineInfoList) do
    if v.pos.x == pos.x and v.pos.y == pos.y and v.dirType == dirType then
      return true
    end
  end
  return false
end

function RenderEntityService:DestroyRenderEntities(matcher)
  local rangeGroup = self._world:GetGroup(matcher)
  local removeEntities = {}
  for _, e in ipairs(rangeGroup:GetEntities()) do
    removeEntities[#removeEntities + 1] = e
  end
  for i = 1, #removeEntities do
    self._world:DestroyEntity(removeEntities[i])
  end
end

function RenderEntityService:SetHudPosition(ownEntity, hudEntity, offsetVector3)
  local ownerObj = ownEntity:View().ViewWrapper.GameObject
  local owner_entity_render_pos = self:_CalcGridHUDWorldPos(ownerObj.transform.position + offsetVector3)
  local go = hudEntity:View().ViewWrapper.GameObject
  local owner_foot_pos = owner_entity_render_pos
  go.transform.position = owner_foot_pos
end

function RenderEntityService:_CalcGridHUDWorldPos(gridRenderPos)
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(gridRenderPos)
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = hudCamera:ScreenToWorldPoint(screenPos)
  return hudWorldPos
end

function RenderEntityService:GetGridPackageRoundPos(pos, radius)
  local offset = radius
  if not radius then
    offset = 0.5
  end
  return {
    Vector2(pos.x - offset, pos.y + offset),
    Vector2(pos.x - offset, pos.y - offset),
    Vector2(pos.x + offset, pos.y - offset),
    Vector2(pos.x + offset, pos.y + offset)
  }
end

function RenderEntityService:GetGridPackagePosList(gridList, radius)
  local lines, source2RealMap = self:_GetGridPackagePosList_MakeLines(gridList, radius)
  local sameLines = {}
  for index, line1 in ipairs(lines) do
    for index, line2 in ipairs(lines) do
      if line1 ~= line2 and line1.head == line2.trail and line1.trail == line2.head then
        table.insert(sameLines, line1)
        table.insert(sameLines, line2)
      end
    end
  end
  for _, line in ipairs(sameLines) do
    for i = #lines, 1, -1 do
      if lines[i] == line then
        table.remove(lines, i)
      end
    end
  end
  local sortPos = {}
  local sortPosIndexs = {}
  local target = lines[1].trail
  table.insert(sortPos, target)
  table.insert(sortPosIndexs, lines[1].trailPosIndex)
  while #sortPos <= #lines do
    for _, line in ipairs(lines) do
      if line.head == target then
        target = line.trail
        table.insert(sortPos, target)
        table.insert(sortPosIndexs, line.trailPosIndex)
        break
      end
    end
  end
  local realSortPos = {}
  for i, tmp in ipairs(sortPos) do
    local posIndex = sortPosIndexs[i]
    local realPos = source2RealMap[posIndex]
    if realPos then
      realSortPos[i] = realPos:Clone()
    end
  end
  return realSortPos
end

function RenderEntityService:_GetGridPackagePosList_MakeLines(gridList, radius)
  local lines = {}
  local source2RealMap = {}
  for gridIndex, pos in ipairs(gridList) do
    local sourcePosList = self:GetGridPackageRoundPos(pos)
    local realPosList = self:GetGridPackageRoundPos(pos, radius)
    for i = 1, #sourcePosList do
      local _roundPos = sourcePosList[i]
      local posIndex = gridIndex * 10 + i
      source2RealMap[posIndex] = realPosList[i]
      local _trail, _trailPosIndex
      if i + 1 <= #sourcePosList then
        _trail = sourcePosList[i + 1]
        _trailPosIndex = gridIndex * 10 + i + 1
      else
        _trail = sourcePosList[1]
        _trailPosIndex = gridIndex * 10 + 1
      end
      table.insert(lines, {
        head = _roundPos,
        headPosIndex = posIndex,
        trail = _trail,
        trailPosIndex = _trailPosIndex
      })
    end
  end
  return lines, source2RealMap
end

function RenderEntityService:GetEdgePosList()
  local lines = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  local edgePieces = boardServiceRender:GetEdgePosList()
  for _, data in ipairs(edgePieces) do
    local roundPosList = self:GetGridPackageRoundPos(data.pos)
    for i = 1, #roundPosList do
      local _roundPos = roundPosList[i]
      local _trail = i + 1 <= #roundPosList and roundPosList[i + 1] or roundPosList[1]
      for index, value in ipairs(data.dirs) do
        if i == value then
          table.insert(lines, {head = _roundPos, trail = _trail})
        end
      end
    end
  end
  local sortPos = {}
  local target = lines[1].trail
  table.insert(sortPos, target)
  while #sortPos <= #lines do
    for _, line in ipairs(lines) do
      if line.head == target then
        target = line.trail
        table.insert(sortPos, target)
        break
      end
    end
  end
  return sortPos
end

function RenderEntityService:CreateBoardOutlineEntity(TT)
  local effectEntity = self:CreateRenderEntity(EntityConfigIDRender.TurnChangeEffect, false)
  return effectEntity
end

function RenderEntityService:ShowBoardOutline(isPlayerTurn)
  local sortPos = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BoardOutline)
  local entities = group:GetEntities()
  if not next(entities) then
    local e = self:CreateBoardOutlineEntity()
    TaskManager:GetInstance():CoreGameStartTask(function(TT)
      YIELD(TT)
      YIELD(TT)
      e:ReplaceBoardOutline(isPlayerTurn)
      sortPos = self:GetEdgePosList()
      local go = e:View():GetGameObject()
      local child = GameObjectHelper.FindChild(go.transform, "biankuang")
      local lineRender = child:GetComponent("LineRenderer")
      local count = #sortPos
      lineRender.positionCount = count
      local boardServiceRender = self._world:GetService("BoardRender")
      for index = 1, count do
        local realPos = boardServiceRender:GridPos2RenderPos(sortPos[index])
        lineRender:SetPosition(index - 1, realPos)
      end
      e:SetViewVisible(true)
    end)
    return
  end
  local e = entities[1]
  e:ReplaceBoardOutline(isPlayerTurn)
end

function RenderEntityService:ShowUITurnTips(isPlayerTurn, isAuroraTime)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowTurnTips, isPlayerTurn, isAuroraTime)
end

function RenderEntityService:GetScreenHeadPos(entity)
  local go = entity:View():GetGameObject()
  return self:_CalcSkinnedMeshPos(go)
end

function RenderEntityService:_CalcSkinnedMeshPos(ownerObj, camera)
  local hudWorldPos = ownerObj.transform.position
  local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(ownerObj)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(ownerObj)
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    local cameraMain = self._world:MainCamera():Camera()
    local screenPos = cameraMain:WorldToScreenPoint(targetPos)
    hudWorldPos = screenPos
    if camera then
      hudWorldPos = camera:ScreenToWorldPoint(screenPos)
    end
  else
    Log.fatal("ownerObj", ownerObj.name, "has no skinned mesh")
  end
  return hudWorldPos
end

function RenderEntityService:SetEntityVisible(entity, isVisible)
  local view = entity:View()
  if not view then
    return
  end
  if tostring(view.ViewWrapper.GameObject) == "null" then
    return
  end
  view.ViewWrapper:SetVisible(isVisible)
  if isVisible then
    self:RefreshAnimatoreLayerWeight(entity)
  end
end

function RenderEntityService:RefreshAnimatoreLayerWeight(entity)
  local view = entity:View()
  if not view then
    return
  end
  local cAnimatorController = entity:AnimatorController()
  if cAnimatorController then
    local gameObject = view.ViewWrapper.GameObject
    local rootTF = gameObject.transform:Find("Root")
    if rootTF == nil then
      return
    end
    local animator = rootTF:GetComponent("Animator")
    animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
    if not animator then
      return
    end
    for layerIndex, weight in pairs(cAnimatorController.AnimatorLayerWeightTable) do
      animator:SetLayerWeight(layerIndex, weight)
    end
  end
end

function RenderEntityService:CreateBoardGridEntity()
  local utilData = self._world:GetService("UtilData")
  local gridEntityData = utilData:GetReplicaGridEntityData()
  if gridEntityData then
    local boardServiceRender = self._world:GetService("BoardRender")
    for pos, pieceType in pairs(gridEntityData) do
      local gridEntity = boardServiceRender:CreateGridEntity(pieceType, pos, true)
    end
  end
end

function RenderEntityService:CreateBoardSpliceGridEntity()
  local utilData = self._world:GetService("UtilData")
  local gridEntityData = utilData:GetReplicaSpliceGridEntityData()
  if gridEntityData then
    local boardServiceRender = self._world:GetService("BoardRender")
    for pos, pieceType in pairs(gridEntityData) do
      local gridEntity = boardServiceRender:CreateGridFakeEntity(pieceType, pos)
    end
  end
end

function RenderEntityService:CreateBoardMultiGridEntity()
  local boardMultiServiceRender = self._world:GetService("BoardMultiRender")
  local utilData = self._world:GetService("UtilData")
  local gridEntityDataList = utilData:GetReplicaBoardMultiGridEntityData()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
  if gridEntityDataList then
    for boardIndex, gridEntityData in pairs(gridEntityDataList) do
      local boardInfo = utilData:GetMultiBoardInfo(boardIndex)
      local boardRoot = UnityEngine.GameObject:New("board_" .. boardIndex)
      boardRoot.transform.localPosition = Vector3(boardInfo.pos[1], boardInfo.pos[2], boardInfo.pos[3])
      local targetAngle = Vector3(math.floor(boardInfo.rotation[1] + 0.5), math.floor(boardInfo.rotation[2] + 0.5), math.floor(boardInfo.rotation[3] + 0.5))
      boardRoot.transform.localEulerAngles = targetAngle
      renderMultiBoardCmpt:SetMultiBoardRootGameObject(boardIndex, boardRoot)
      for pos, pieceType in pairs(gridEntityData._gridEntityTable) do
        local gridEntity = boardMultiServiceRender:CreateGridEntity(boardIndex, pieceType, pos, true, boardRoot)
      end
    end
  end
end

function RenderEntityService:CreateGhost(pos, ownerEntity, anim, prefab, disableAlpha)
  local configSvc = self._world:GetService("Config")
  local ghostEntity = self:CreateRenderEntity(EntityConfigIDRender.Ghost)
  if ownerEntity:HasTeam() then
    ownerEntity = ownerEntity:GetTeamLeaderPetEntity()
  end
  local cGridLocation = ownerEntity:GridLocation()
  local casterPos = cGridLocation:GetGridPos()
  ghostEntity:SetGridLocationAndOffset(pos, cGridLocation:GetGridDir(), cGridLocation:GetGridOffset())
  ghostEntity:ReplaceGhost(ownerEntity:GetID())
  ghostEntity:ReplaceBodyArea(ownerEntity:BodyArea():GetArea())
  local prefabResPath = ""
  if ownerEntity:HasPetPstID() then
    local petPstIDCmpt = ownerEntity:PetPstID()
    local petPstID = petPstIDCmpt:GetPstID()
    local petData = self._world:GetPetData(petPstID)
    prefabResPath = petData:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
  elseif ownerEntity:HasMonsterID() then
    local monsterIDCmpt = ownerEntity:MonsterID()
    local monsterID = monsterIDCmpt:GetMonsterID()
    local monsterConfigData = configSvc:GetMonsterConfigData()
    prefabResPath = ownerEntity:Asset():GetResPath()
    ghostEntity:AddMonsterID()
    local utilDataSvc = self._world:GetService("UtilData")
    local elementType = utilDataSvc:GetEntityElementPrimaryType(ownerEntity)
    ghostEntity:AddElement(elementType)
    Log.debug("Create Ghost monster, owner:", ownerEntity:GetID(), " monsterID:", monsterID, " res:", prefabResPath)
  elseif ownerEntity:HasTrapID() then
    local trapRenderCmpt = ownerEntity:TrapRender()
    local trapConfigData = configSvc:GetTrapConfigData()
    prefabResPath = trapConfigData:GetTrapResPath(trapRenderCmpt:GetTrapID())[1]
  elseif ownerEntity:HasChessPet() then
    prefabResPath = ownerEntity:Asset():GetResPath()
    local utilDataSvc = self._world:GetService("UtilData")
    local elementType = utilDataSvc:GetEntityElementPrimaryType(ownerEntity)
    ghostEntity:AddElement(elementType)
  else
    Log.fatal("### PreviewActiveSkillService unknwon entity.")
  end
  if prefab then
    prefabResPath = prefab
  end
  ghostEntity:ReplaceAsset(NativeUnityPrefabAsset:New(prefabResPath, true))
  if not ownerEntity:HasPetPstID() then
    self:ModifyElementMaterial(ghostEntity)
  end
  local dir = ownerEntity:Location():GetDirection()
  ghostEntity:SetLocation(pos + cGridLocation:GetGridOffset(), Vector2(dir.x, dir.z))
  local gameObject = ghostEntity:View().ViewWrapper.GameObject
  local csMaterialAnimation = gameObject:GetComponent(typeof(MaterialAnimation))
  if not csMaterialAnimation or tostring("csMaterialAnimation") == "null" then
    csMaterialAnimation = gameObject:AddComponent(typeof(MaterialAnimation))
  end
  local resServ = self._world.BW_Services.ResourcesPool
  local container = resServ:LoadAsset("globalShaderEffects.asset")
  ghostEntity:AddMaterialAnimationComponent(container, csMaterialAnimation)
  if not disableAlpha then
    ghostEntity:NewEnableGhost()
  end
  local materialAnimationComponent = ownerEntity:MaterialAnimationComponent()
  if materialAnimationComponent and materialAnimationComponent:MaterialAnimation() and materialAnimationComponent:MaterialAnimation():IsPlaying("common_shadoweff") then
    ghostEntity:PlayMaterialAnim("common_shadoweff")
  end
  local buffViewCmpt = ownerEntity:BuffView()
  local modelPetIndex = buffViewCmpt:GetBuffValue("ChangeModelWithPetIndex")
  if modelPetIndex and prefabResPath then
    local ancName = HelperProxy:GetPetAnimatorControllerName(prefabResPath, PetAnimatorControllerType.Battle)
    if ancName then
      local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
      local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
      if anim then
        local pet = ghostEntity:View().ViewWrapper.GameObject
        local petAnim = pet:GetComponentInChildren(typeof(UnityEngine.Animator))
        petAnim.runtimeAnimatorController = anim.runtimeAnimatorController
      end
    end
  end
  local rootTF = gameObject.transform:Find("Root")
  if rootTF then
    local animator = rootTF:GetComponent("Animator")
    animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
    if animator then
      animator:CrossFade("idle", 0)
      if anim then
        ghostEntity:SetAnimatorControllerTriggers({anim})
      end
    end
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env then
    local pos = ownerEntity:GetRenderGridPosition()
    for _, area in ipairs(ownerEntity:BodyArea():GetArea()) do
      local blockData = env:GetPosBlockData(pos + area)
      blockData:AddBlock(ownerEntity:GetID(), BlockFlag.LinkLine)
    end
  end
  if ownerEntity:HasMonsterID() and rootTF then
    local trailEffectExCmpt = rootTF.gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
    if trailEffectExCmpt then
      UnityEngine.Object.Destroy(trailEffectExCmpt)
    end
    ghostEntity:RemoveTrailEffectEx()
    local eliteEffIDList = {}
    local monsterIDCmpt = ownerEntity:MonsterID()
    if monsterIDCmpt then
      local eliteIDs = monsterIDCmpt:GetEliteIDArray()
      for _, eliteID in ipairs(eliteIDs) do
        local cfgElite = Cfg.cfg_monster_elite[eliteID]
        if cfgElite and cfgElite.EffectID then
          table.insert(eliteEffIDList, cfgElite.EffectID)
        end
      end
    end
    if #eliteEffIDList == 0 then
      local cfg_monster = Cfg.cfg_monster[ownerEntity:MonsterID():GetMonsterID()]
      local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
      local eliteIDs = cfg_monster.EliteID
      local trailEffect = cfg_monster_class.TrailEffect
      if eliteIDs and 0 < table.count(eliteIDs) and trailEffect then
        trailEffectExCmpt = rootTF.gameObject:AddComponent(typeof(TrailsFX.TrailEffectEx))
        local containerTrailEffect = resServ:LoadAsset(trailEffect)
        ghostEntity:AddTrailEffectEx(containerTrailEffect, trailEffectExCmpt)
      end
    end
  end
  return ghostEntity
end

function RenderEntityService:DestroyGhost()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local ghostEntities = self._world:GetGroup(self._world.BW_WEMatchers.Ghost):GetEntities()
  local removeList = {}
  for _, e in ipairs(ghostEntities) do
    removeList[#removeList + 1] = e:GetID()
  end
  for _, entityID in ipairs(removeList) do
    local ghostEntity = self._world:GetEntityByID(entityID)
    if env then
      local ownerID = ghostEntity:Ghost():GetOwnerID()
      local ownerEntity = self._world:GetEntityByID(ownerID)
      env:DelEntityBlockFlag(ownerEntity, ghostEntity:GridLocation():GetGridPos())
      env:AddEntityBlockFlag(ownerEntity, ownerEntity:GridLocation():GetGridPos())
    end
    local gridPos = Vector2.zero
    if ghostEntity:HasGridMove() then
      gridPos = ghostEntity:GridMove():GetTargetPos()
    elseif ghostEntity:HasLocation() then
      gridPos = self._world:GetService("BoardRender"):GetEntityRealTimeGridPos(ghostEntity, false)
    end
    local bodyArea = ghostEntity:BodyArea():GetArea()
    local traprsvc = self._world:GetService("TrapRender")
    for _, v2RelativePos in ipairs(bodyArea) do
      local v2 = gridPos + v2RelativePos
      traprsvc:ShowHideTrapAtPos(v2, true)
    end
    if ghostEntity:HasViewExtension() then
      ghostEntity:SetViewVisible(false)
    end
    local effectLineRenderer = ghostEntity:EffectLineRenderer()
    if effectLineRenderer then
      ghostEntity:RemoveEffectLineRenderer()
    end
    local sEffect = self._world:GetService("Effect")
    sEffect:DestroyStaticEffect(ghostEntity)
    local headRoundInfoRender = ghostEntity:TrapRoundInfoRender()
    if headRoundInfoRender then
      local eId = headRoundInfoRender:GetRoundInfoEntityID()
      local eRound = self._world:GetEntityByID(eId)
      if eRound then
        self._world:DestroyEntity(eRound)
        ghostEntity:RemoveTrapRoundInfoRender()
      end
    end
    self._world:DestroyEntity(ghostEntity)
  end
end

function RenderEntityService:CreateBattleTeamMemberRender()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local loadingResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.Loading)
  local teamCreateResult = loadingResCmpt:GetTeamCreationResult()
  for i, teamRes in ipairs(teamCreateResult) do
    local creationList = teamRes:GetPetCreationResultList()
    for _, v in ipairs(creationList) do
      local creationRes = v
      local resPath = creationRes:GetPetCreationRes()
      local logicEntityID = creationRes:GetPetCreationLogicEntityID()
      local petEntity = self._world:GetEntityByID(logicEntityID)
      Log.info("load res path: " .. tostring(resPath))
      petEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
      local id = string.gsub(resPath, ".prefab", "")
      petEntity:PetPstID():SetResID(tonumber(id))
      self:_InitRenderAttributes(petEntity, creationRes)
    end
  end
end

function RenderEntityService:_InitRenderAttributes(entity, creationRes)
  local hp = creationRes:GetPetCreation_CurHp()
  local maxHP = creationRes:GetPetCreation_MaxHp()
  entity:ReplaceRedAndMaxHP(hp, maxHP)
end

function RenderEntityService:CreateRenderEntity(entityConstId, bShow)
  local ctx = EntityCreationContext:New()
  ctx.entity_config_id = entityConstId
  if bShow == nil then
    ctx.bShow = true
  else
    ctx.bShow = bShow
  end
  local entity = self._world:CreateEntity()
  self._world:SetEntityIdByEntityConfigId(entity, entityConstId)
  EntityAssembler.AssembleEntityComponents(entity, ctx)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    GameGlobal.GetModule(SkillPerfModule):AddEffectEntity(entity)
  end
  return entity
end

function RenderEntityService:AssembleRenderEntity(renderEntity, entityConstId, bShow)
  local ctx = EntityCreationContext:New()
  ctx.entity_config_id = entityConstId
  if bShow == nil then
    ctx.bShow = true
  else
    ctx.bShow = bShow
  end
  self._world:SetEntityIdByEntityConfigId(renderEntity, entityConstId)
  EntityAssembler.AssembleEntityComponents(renderEntity, ctx)
  return renderEntity
end

function RenderEntityService:CreateBattleTeamRender()
  self:_CreateTeamRender()
end

function RenderEntityService:_CreateTeamRender()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local res = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.Loading)
  local teamResults = res:GetTeamCreationResult()
  for i, teamRes in ipairs(teamResults) do
    local teamEntityID = teamRes:GetCreationResultTeamEntityID()
    local teamEntity = self._world:GetEntityByID(teamEntityID)
    local hpCmpt = teamEntity:HP()
    local hpSliderEntity
    if self._world:Player():IsLocalTeamEntity(teamEntity) then
      hpSliderEntity = self:CreateRenderEntity(EntityConfigIDRender.PlayerHPSlider)
    else
      hpSliderEntity = self:CreateRenderEntity(EntityConfigIDRender.BossHPSlider)
    end
    hpCmpt:SetHPSliderEntityID(hpSliderEntity:GetID())
    local previewEntity = self._world:GetPreviewEntity()
    if not previewEntity:HasConnectPieces() then
      previewEntity:AddConnectPieces({}, PieceType.None)
    end
    local hpOffset = teamRes:GetCreationResultHPOffset()
    hpCmpt:SetHPOffset(hpOffset)
    local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
    if teamLeaderEntity then
      local leaderHpCmpt = teamLeaderEntity:HP()
      if leaderHpCmpt then
        leaderHpCmpt:SetHPOffset(hpOffset)
      end
    end
    local element = teamRes:GetCreationResultElement()
    TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), hpSliderEntity, element)
    local hp = teamRes:GetCreationResultHP()
    local maxHP = teamRes:GetCreationResultMaxHP()
    teamEntity:ReplaceRedAndMaxHP(hp, maxHP)
    local heroPos = teamRes:GetCreationResultBornPos()
    local heroRotation = teamRes:GetCreationResultBornRotation()
    teamEntity:SetLocation(heroPos, heroRotation)
    local firstPetEnityID = teamRes:GetCreationResultFirstPetEntityID()
    local firstPetEntity = self._world:GetEntityByID(firstPetEnityID)
    firstPetEntity:SetLocation(heroPos, heroRotation)
    hpSliderEntity:SetViewVisible(false)
    if self._world:MatchType() == MatchType.MT_Maze then
      teamEntity:HP():SetShowHPSliderState(false)
    end
    if self._world:Player():IsLocalTeamEntity(teamEntity) then
      local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
      autoBeadServiceRender:InitAutoBeadHolder(teamEntity)
    end
  end
end

function RenderEntityService:SetTeamLeaderRender(petEntity, showEffect)
  local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local petData = self._world:GetPetData(petPstID)
  local hpComponent = teamEntity:HP()
  local hpOffset = petData:GetHPOffset()
  hpComponent:SetHPOffset(hpOffset)
  hpComponent:SetHPPosDirty(true)
  local hpSliderEntity = self._world:GetEntityByID(hpComponent:GetHPSliderEntityID())
  local utilDataSvc = self._world:GetService("UtilData")
  local firstElement = utilDataSvc:GetEntityElementPrimaryType(teamEntity)
  TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), hpSliderEntity, firstElement)
  if showEffect then
    local effectService = self._world:GetService("Effect")
    local effectID = BattleConst.ChangeTeamLeaderEffect[firstElement]
    local pos = petEntity:GetRenderGridPosition()
    effectService:CreateWorldPositionEffect(effectID, pos)
  end
  local cEffectAttached = teamEntity:EffectAttached()
  local tFxCtrlEntity = cEffectAttached:GetAttachedEntityIDArray()
  local mapFxEntity, mapFxID = cEffectAttached:GetAttachedFxMap()
  cEffectAttached:ClearAttachedEntityIDArray()
  if 0 < #tFxCtrlEntity then
    for _, id in ipairs(tFxCtrlEntity) do
      local e = self._world:GetEntityByID(id)
      if e then
        local cEffectController = e:EffectController()
        local bindPos = cEffectController.BindPos
        local duration = cEffectController.Duration
        local type = cEffectController:GetEffectType()
        local followMove = cEffectController:GetFollowMove()
        local followRotate = cEffectController:GetFollowRotate()
        local bindLayer = cEffectController:GetBindLayer()
        local followRotateCaster = cEffectController:GetFollowRotateCaster()
        e:RemoveEffectController()
        e:AddEffectController(petEntity, bindPos, duration, type)
        local cNewController = e:EffectController()
        cNewController:SetFollowMove(followMove)
        cNewController:SetFollowRotate(followRotate)
        cNewController:SetBindLayer(bindLayer)
        cNewController:SetFollowRotateCaster(followRotateCaster)
        if not mapFxID[id] then
          cEffectAttached:AddAttachedEntityID(id)
        else
          local effectID = mapFxID[id]
          cEffectAttached:AddAttachedEffectEntityID(id, effectID)
        end
      end
    end
  end
end

function RenderEntityService:_GetOutlinePointPos(pos, outlineDirType, radius, gridList)
  local gridOutlineRadius = 0.6
  local outlinePos1, outlinePos2
  if outlineDirType == OutlineDirType.Up then
    if table.icontains(gridList, Vector2(pos.x + 1, pos.y)) then
      outlinePos1 = Vector2(pos.x + gridOutlineRadius, pos.y + radius)
    else
      outlinePos1 = Vector2(pos.x + radius, pos.y + radius)
    end
    if table.icontains(gridList, Vector2(pos.x - 1, pos.y)) then
      outlinePos2 = Vector2(pos.x - gridOutlineRadius, pos.y + radius)
    else
      outlinePos2 = Vector2(pos.x - radius, pos.y + radius)
    end
  elseif outlineDirType == OutlineDirType.Down then
    if table.icontains(gridList, Vector2(pos.x + 1, pos.y)) then
      outlinePos1 = Vector2(pos.x + gridOutlineRadius, pos.y - radius)
    else
      outlinePos1 = Vector2(pos.x + radius, pos.y - radius)
    end
    if table.icontains(gridList, Vector2(pos.x - 1, pos.y)) then
      outlinePos2 = Vector2(pos.x - gridOutlineRadius, pos.y - radius)
    else
      outlinePos2 = Vector2(pos.x - radius, pos.y - radius)
    end
  elseif outlineDirType == OutlineDirType.Left then
    if table.icontains(gridList, Vector2(pos.x, pos.y + 1)) then
      outlinePos1 = Vector2(pos.x - radius, pos.y + gridOutlineRadius)
    else
      outlinePos1 = Vector2(pos.x - radius, pos.y + radius)
    end
    if table.icontains(gridList, Vector2(pos.x, pos.y - 1)) then
      outlinePos2 = Vector2(pos.x - radius, pos.y - gridOutlineRadius)
    else
      outlinePos2 = Vector2(pos.x - radius, pos.y - radius)
    end
  elseif outlineDirType == OutlineDirType.Right then
    if table.icontains(gridList, Vector2(pos.x, pos.y + 1)) then
      outlinePos1 = Vector2(pos.x + radius, pos.y + gridOutlineRadius)
    else
      outlinePos1 = Vector2(pos.x + radius, pos.y + radius)
    end
    if table.icontains(gridList, Vector2(pos.x, pos.y - 1)) then
      outlinePos2 = Vector2(pos.x + radius, pos.y - gridOutlineRadius)
    else
      outlinePos2 = Vector2(pos.x + radius, pos.y - radius)
    end
  end
  return outlinePos1, outlinePos2
end

function RenderEntityService:SetLineRendererPoint(outlineEntity, sortPos)
  local boardServiceRender = self._world:GetService("BoardRender")
  local go = outlineEntity:View():GetGameObject()
  if go then
    local newPos = Vector3(0, 0, 0)
    go.transform.position = newPos
    local lineRender = go:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
    local count = #sortPos
    lineRender.positionCount = count
    for index = 1, count do
      local realPos = boardServiceRender:GridPos2RenderPos(sortPos[index])
      lineRender:SetPosition(index - 1, realPos)
    end
    outlineEntity:SetViewVisible(true)
  end
end

function RenderEntityService:_CreateMonsterAreaOutlineEntity(centerPos, gridList, entityID)
  local boardServiceRender = self._world:GetService("BoardRender")
  local entityPoolService = self._world:GetService("EntityPool")
  local pieceService = self._world:GetService("Piece")
  local edgeGridList = gridList
  local sortPos = self:GetGridPackagePosList(edgeGridList, 0.4)
  local outlineEntity
  outlineEntity = entityPoolService:GetCacheEntityByConfigID(entityID)
  local go = outlineEntity:View():GetGameObject()
  if go then
    local lineRender = go:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
    local count = #sortPos
    lineRender.positionCount = count
    for index = 1, count do
      local realPos = boardServiceRender:GridPos2RenderPos(sortPos[index])
      realPos.y = 0.01
      lineRender:SetPosition(index - 1, realPos)
    end
    outlineEntity:SetViewVisible(true)
  end
  return {outlineEntity}
end

function RenderEntityService:CreateMonsterAreaOutlineEntity(monsterEntity)
  if not monsterEntity then
    Log.fatal("entity is null Trace", Log.traceback())
  end
  if not monsterEntity:MonsterID() then
    return
  end
  if monsterEntity:HasOutsideRegion() then
    return
  end
  local gridPos = monsterEntity:GetGridPosition()
  local utilDataService = self._world:GetService("UtilData")
  local extraBoardPosRange = utilDataService:GetExtraBoardPosList()
  if extraBoardPosRange and table.count(extraBoardPosRange) > 0 then
    local bodyAreaList = monsterEntity:BodyArea():GetArea()
    for _, bodyArea in ipairs(bodyAreaList) do
      local workPos = gridPos + bodyArea
      if table.intable(extraBoardPosRange, workPos) then
        return
      end
    end
  end
  local areaGridList = utilDataService:GetMonsterGridAreaList(monsterEntity)
  local areaOutLineEntityList = self:_CreateMonsterAreaOutlineEntity(gridPos, areaGridList, EntityConfigIDRender.MonsterAreaOutLine)
  if not monsterEntity:HasMonsterAreaOutLineComponent() then
    monsterEntity:AddMonsterAreaOutLineComponent()
  end
  local monsterAreaOutLineCmpt = monsterEntity:MonsterAreaOutLineComponent()
  for k, e in pairs(areaOutLineEntityList) do
    monsterAreaOutLineCmpt:AddEntityID(e:GetID())
  end
end

function RenderEntityService:DestroyMonsterAreaOutLineEntity(monsterEntity)
  local monsterAreaOutLineCmpt = monsterEntity:MonsterAreaOutLineComponent()
  if monsterAreaOutLineCmpt then
    local entityIDList = monsterAreaOutLineCmpt:GetEntityIDList()
    local entityPoolService = self._world:GetService("EntityPool")
    for k, id in pairs(entityIDList) do
      local entity = self._world:GetEntityByID(id)
      if entity and entity:View() then
        local go = entity:View():GetGameObject()
        if go and tostring(go) ~= "null" then
          go.transform.parent = nil
          entityPoolService:DestroyCacheEntity(entity, EntityConfigIDRender.MonsterAreaOutLine)
        end
      end
    end
    monsterAreaOutLineCmpt:ClearEntityIDList()
  end
end

function RenderEntityService:ModifyElementMaterial(targetEntity)
  local monsterViewCmpt = targetEntity:View()
  if not monsterViewCmpt then
    Log.error("ModifyElementMaterial entity has no view ,entityID:", targetEntity:GetID())
    local monsterIDCmpt = targetEntity:MonsterID()
    if monsterIDCmpt then
      local monsterID = monsterIDCmpt:GetMonsterID()
      Log.error("ModifyElementMaterial entity has no view ,monsterID:", monsterID)
    end
  end
  local monsterObj = targetEntity:View().ViewWrapper.GameObject
  local resHolderCmpt = monsterObj:GetComponent("UnitResourceHolder")
  if resHolderCmpt == nil then
    return
  end
  local elementBodyMat, elementWeaponMat
  local utilDataSvc = self._world:GetService("UtilData")
  local elementType = utilDataSvc:GetEntityElementPrimaryType(targetEntity)
  if elementType == ElementType.ElementType_Blue then
    elementBodyMat = resHolderCmpt.elementBodyMaterial_Blue
    elementWeaponMat = resHolderCmpt.elementWeaponMaterial_Blue
  elseif elementType == ElementType.ElementType_Red then
    elementBodyMat = resHolderCmpt.elementBodyMaterial_Red
    elementWeaponMat = resHolderCmpt.elementWeaponMaterial_Red
  elseif elementType == ElementType.ElementType_Green then
    elementBodyMat = resHolderCmpt.elementBodyMaterial_Green
    elementWeaponMat = resHolderCmpt.elementWeaponMaterial_Green
  elseif elementType == ElementType.ElementType_Yellow then
    elementBodyMat = resHolderCmpt.elementBodyMaterial_Yellow
    elementWeaponMat = resHolderCmpt.elementWeaponMaterial_Yellow
  end
  if elementBodyMat == nil then
    Log.notice("element material is nil ", monsterObj.name)
    return
  end
  local bodyRender = GameObjectHelper.FindFirstSkinedMeshRender(monsterObj)
  if bodyRender ~= nil then
    local sharedMaterials = bodyRender.sharedMaterials
    local curMat = sharedMaterials[0]
    if string.find(curMat.name, "Instance") then
      UnityEngine.Object.Destroy(curMat)
    end
    local newBodyMat = UnityEngine.Material:New(elementBodyMat)
    local newMats = {}
    newMats[#newMats + 1] = newBodyMat
    bodyRender.sharedMaterials = newMats
  end
  if elementWeaponMat == nil then
    return
  end
  local weaponRender = GameObjectHelper.FindSecondSkinedMeshRender(monsterObj)
  if weaponRender ~= nil then
    local sharedMaterials = weaponRender.sharedMaterials
    local curMat = sharedMaterials[0]
    if string.find(curMat.name, "Instance") then
      UnityEngine.Object.Destroy(curMat)
    end
    local newWeaponMat = UnityEngine.Material:New(elementWeaponMat)
    local newMats = {}
    newMats[#newMats + 1] = newWeaponMat
    weaponRender.sharedMaterials = newMats
  end
end

function RenderEntityService:CreateStuntMonster(ownerEntity, stuntTag, monsterClassID)
  if not ownerEntity:HasMonsterID() and not monsterClassID then
    Log.error("CreateStuntMonster: monster ID is required. ")
    return
  end
  local e = self:CreateRenderEntity(EntityConfigIDRender.StuntMonster)
  local resPath = ownerEntity:Asset():GetResPath()
  if monsterClassID then
    local cfg = Cfg.cfg_monster_class[monsterClassID]
    if cfg then
      resPath = cfg.ResPath
    else
      Log.error(self._className, "invalid monsterClassID: ", monsterClassID)
    end
  end
  e:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, true))
  e:SetAnimatorControllerTriggers({"idle"})
  local gameObject = e:View().ViewWrapper.GameObject
  local csMaterialAnimation = gameObject:GetComponent(typeof(MaterialAnimation))
  if not csMaterialAnimation or tostring("csMaterialAnimation") == "null" then
    csMaterialAnimation = gameObject:AddComponent(typeof(MaterialAnimation))
  end
  local resServ = self._world.BW_Services.ResourcesPool
  local container = resServ:LoadAsset("globalShaderEffects.asset")
  e:AddMaterialAnimationComponent(container, csMaterialAnimation)
  if not ownerEntity:StuntOwnerComponent() then
    ownerEntity:AddStuntOwnerComponent()
  end
  local cStunt = ownerEntity:StuntOwnerComponent()
  if cStunt:GetStuntByTag(stuntTag) then
    cStunt:RemoveStunt(stuntTag)
  end
  cStunt:AddStunt(stuntTag, e)
  return e
end

function RenderEntityService:CreateSideEffects(truePosList, sideEffectID, v3SideScale)
  local retEntity = {}
  for _, pos in ipairs(truePosList) do
    local entityList = {}
    local sideList = {}
    if not table.icontains(truePosList, pos + Vector2(0, 1)) then
      local tmp = {
        gridPos = pos + Vector2(0, BattleConst.GridSideLength / 2),
        gridDir = Vector3(0, 0, -1)
      }
      table.insert(sideList, {
        gridPos = pos + Vector2(0, BattleConst.GridSideLength / 2),
        gridDir = Vector3(0, 0, -1)
      })
    end
    if not table.icontains(truePosList, pos + Vector2(0, -1)) then
      local tmp = {
        gridPos = pos + Vector2(0, -BattleConst.GridSideLength / 2),
        gridDir = Vector3(0, 0, 1)
      }
      table.insert(sideList, {
        gridPos = pos + Vector2(0, -BattleConst.GridSideLength / 2),
        gridDir = Vector3(0, 0, 1)
      })
    end
    if not table.icontains(truePosList, pos + Vector2(1, 0)) then
      local tmp = {
        gridPos = pos + Vector2(BattleConst.GridSideLength / 2, 0),
        gridDir = Vector3(-1, 0, 0)
      }
      table.insert(sideList, {
        gridPos = pos + Vector2(BattleConst.GridSideLength / 2, 0),
        gridDir = Vector3(-1, 0, 0)
      })
    end
    if not table.icontains(truePosList, pos + Vector2(-1, 0)) then
      local tmp = {
        gridPos = pos + Vector2(-BattleConst.GridSideLength / 2, 0),
        gridDir = Vector3(1, 0, 0)
      }
      table.insert(sideList, {
        gridPos = pos + Vector2(-BattleConst.GridSideLength / 2, 0),
        gridDir = Vector3(1, 0, 0)
      })
    end
    for _, v in pairs(sideList) do
      local entity = self:CreateSideEffect(v.gridPos, v.gridDir, v3SideScale, sideEffectID)
      table.insert(retEntity, entity)
    end
  end
  return retEntity
end

function RenderEntityService:CreateSideEffect(girdPos, girdDir, scale, sideEffectID)
  local sEffect = self._world:GetService("Effect")
  local effEntitySide = sEffect:CreateWorldPositionDirectionEffect(sideEffectID, girdPos, girdDir)
  effEntitySide:SetViewVisible(true)
  effEntitySide:SetScale(scale)
  return effEntitySide
end

function RenderEntityService:AttackTurn(source_entity, target_entity)
  if target_entity == nil then
    Log.notice("TurnToTarget ,targetEntity is nil")
    return
  end
  local trapRenderCmpt = source_entity:TrapRender()
  if trapRenderCmpt then
    return
  end
  local buff = source_entity:BuffView()
  if buff:HasBuffEffect(BuffEffectType.Stun) then
    return
  end
  local cfgsvc = self._world:GetService("Config")
  if source_entity:HasMonsterID() then
    local mstcfg = cfgsvc:GetMonsterConfigData()
    local utilData = self._world:GetService("UtilData")
    local buffVal = utilData:GetEntityBuffValue(source_entity, "MONSTER_VIEW_CAN_TURN")
    if buffVal == nil then
      local cMonsterID = source_entity:MonsterID()
      if not mstcfg:CanTurn(cMonsterID:GetMonsterID()) then
        return false
      end
    elseif buffVal == 0 then
      return false
    end
  end
  if not source_entity:HasBodyArea() then
    return
  end
  local body_area = source_entity:BodyArea()._area
  local boardServiceRender = self._world:GetService("BoardRender")
  if #body_area == 4 then
    local targetGridPos = boardServiceRender:GetEntityRealTimeGridPos(target_entity, true)
    local sourceGridPos = boardServiceRender:GetEntityRealTimeGridPos(source_entity, true)
    local tmpV = targetGridPos - sourceGridPos
    local arrDir = {
      Vector2.left,
      Vector2.right,
      Vector2.up,
      Vector2.down
    }
    local minIdx = 1
    local min = Vector2.Angle(arrDir[minIdx], tmpV)
    for i = 2, #arrDir do
      local angle = Vector2.Angle(arrDir[i], tmpV)
      if min > angle then
        min = angle
        minIdx = i
      end
    end
    local minDir = arrDir[minIdx]
    source_entity:SetDirection(minDir)
  else
    local castPos = source_entity:Location().Position
    local holderTf = target_entity:View().ViewWrapper.Transform
    local targetPos = holderTf.position
    local bindTf = GameObjectHelper.FindChild(holderTf, "EffectSlot")
    if bindTf then
      targetPos = bindTf.position
    end
    local dir = targetPos - castPos
    local gridDir = Vector2(dir.x, dir.z)
    source_entity:SetDirection(gridDir)
  end
end

function RenderEntityService:TurnToTarget(source_entity, target_entity, forceTurn, damagePos, turnToTargetType)
  if source_entity == nil or target_entity == nil or target_entity:HasView() == false then
    Log.notice("TurnToTarget ,targetEntity is nil")
    return
  end
  local playSkillSvc = self._world:GetService("PlaySkill")
  if not playSkillSvc:CheckSourceCanTurn(source_entity) and not forceTurn then
    return
  end
  if source_entity:HasTeam() then
    source_entity = source_entity:GetTeamLeaderPetEntity()
  end
  local castPos = source_entity:Location().Position
  local holderTf = target_entity:View().ViewWrapper.Transform
  local targetPos = holderTf.position
  if damagePos then
    targetPos = damagePos
  elseif turnToTargetType == TurnToTargetType.PickupPos then
    local renderPickUpComponent = target_entity:RenderPickUpComponent()
    local firstPickUpPos = renderPickUpComponent:GetFirstValidPickUpGridPos()
    local boardServiceRender = self._world:GetService("BoardRender")
    targetPos = boardServiceRender:GridPos2RenderPos(firstPickUpPos)
  else
    local bindTf = GameObjectHelper.FindChild(holderTf, "EffectSlot")
    if bindTf then
      targetPos = bindTf.position
    end
  end
  local dir = targetPos - castPos
  local gridDir = Vector2(dir.x, dir.z)
  source_entity:SetDirection(gridDir)
end

function RenderEntityService:TurnToTargetGrid(sourceEntity, targetEntity, dirOffset)
  if sourceEntity == nil or targetEntity == nil then
    Log.notice("TurnToTarget, entity is nil")
    return
  end
  local playSkillSvc = self._world:GetService("PlaySkill")
  if not playSkillSvc:CheckSourceCanTurn(sourceEntity) then
    return
  end
  if sourceEntity:HasTeam() then
    sourceEntity = sourceEntity:GetTeamLeaderPetEntity()
  end
  local casterPos = sourceEntity:Location().Position
  local targetPosVec2 = targetEntity:GetGridPosition()
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetPos = boardServiceRender:GridPosition2LocationPos(targetPosVec2, targetEntity)
  local dir = targetPos - casterPos
  local gridDir = Vector2(dir.x, dir.z)
  if dirOffset then
    gridDir = gridDir + dirOffset
  end
  sourceEntity:SetDirection(gridDir)
end

function RenderEntityService:CreateChessPet()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local res = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.Loading)
  local chessPetResults = res:GetChessPetCreationResult()
  for i, v in ipairs(chessPetResults) do
    local chessPetRes = v
    local chessPetEntityID = chessPetRes:GetChessPetEntityIID()
    local chessPetEntity = self._world:GetEntityByID(chessPetEntityID)
    local resPath = chessPetRes:GetChessPetResPath()
    chessPetEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
    local hpCmpt = chessPetEntity:HP()
    hpCmpt:SetHPBarTempHide(true)
    local hpSliderEntity = self:CreateRenderEntity(EntityConfigIDRender.PlayerHPSlider)
    hpCmpt:SetHPSliderEntityID(hpSliderEntity:GetID())
    local hpOffset = chessPetRes:GetChessPetHPOffset()
    hpCmpt:SetHPOffset(hpOffset)
    local element = chessPetRes:GetChessPetElement()
    TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), hpSliderEntity, element)
    local hp = chessPetRes:GetChessPetHP()
    local maxHP = chessPetRes:GetChessPetMaxHP()
    chessPetEntity:ReplaceRedAndMaxHP(hp, maxHP)
    local gridLocRes = chessPetRes:GetChessPetGridLocResult()
    local heroPos = gridLocRes:GetGridLocResultBornPos()
    local bornOffset = gridLocRes:GetGridLocResultBornOffset()
    local heroRotation = gridLocRes:GetGridLocResultBornDir()
    chessPetEntity:SetLocation(heroPos + bornOffset, heroRotation)
    hpSliderEntity:SetViewVisible(false)
  end
end

function RenderEntityService:CreateTrapAreaOutlineEntity(gridList, resPath)
  local gridIndexBoolDic = {}
  for _, pos in ipairs(gridList) do
    gridIndexBoolDic[Vector2.Pos2Index(pos)] = true
  end
  local tTaskIDs = {}
  for _, pos in ipairs(gridList) do
    local posIndex = Vector2.Pos2Index(pos)
    if not gridIndexBoolDic[posIndex + 100] then
      self:_CreateTrapAreaOutlineEntityAtPos(resPath, pos, Vector2.right)
    end
    if not gridIndexBoolDic[posIndex - 100] then
      self:_CreateTrapAreaOutlineEntityAtPos(resPath, pos, Vector2.left)
    end
    if not gridIndexBoolDic[posIndex + 1] then
      self:_CreateTrapAreaOutlineEntityAtPos(resPath, pos, Vector2.up)
    end
    if not gridIndexBoolDic[posIndex - 1] then
      self:_CreateTrapAreaOutlineEntityAtPos(resPath, pos, Vector2.down)
    end
  end
end

function RenderEntityService:_CreateTrapAreaOutlineEntityAtPos(resPath, v2Pos, v2Dir)
  local entityPoolService = self._world:GetService("EntityPool")
  local eOutline = self:CreateRenderEntity(EntityConfigIDRender.TrapAreaOutline)
  eOutline:ReplaceAsset(NativeUnityPrefabAsset:New(resPath))
  eOutline:SetLocation(v2Pos, v2Dir)
  return eOutline
end

function RenderEntityService:ClearTrapAreaOutlineEntity()
  self:DestroyRenderEntities(self._world.BW_WEMatchers.TrapAreaElement)
end

function RenderEntityService:CreateBoardPushGridEntity()
  local utilData = self._world:GetService("UtilData")
  local gridEntityData = utilData:GetReplicaPushGridEntityData()
  if gridEntityData then
    local boardServiceRender = self._world:GetService("BoardRender")
    for pos, pieceType in pairs(gridEntityData) do
      boardServiceRender:CreatePushBoardGridFakeEntity(pieceType, pos, false)
    end
  end
end
