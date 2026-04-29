_class("RenderBoardComponent", Object)
RenderBoardComponent = RenderBoardComponent

function RenderBoardComponent:Constructor()
  self._firstPetEntityID = -1
  self._gridEntityTable = {}
  self._sceneGOs = {}
  self._gridMaterialPath = ""
  self._brillantLineReq = nil
  self._hLineObjList = {}
  self._vLineObjList = {}
  self._brillantGridLineExtendParam = 0.5
  self._dimensionClearPreviewTaskID = -1
  self._chainPathCancelAreaActive = false
  self._mapByPieceType = {}
  self._mapByPosition = {}
  self._gridEffectEntityIDTable = {}
  self._sceneEffectEntityID = nil
  self._mapPieceFirstChainPathEffectEntityID = nil
  self._mapPieceFirstChainPathEffectID = nil
  self._mapPieceFirstChainPathEffectOutAnim = nil
  self._baseGridRenderPos = BattleConst.BaseGridRenderPos
  self._sceneEffEntityIDDic = {}
  self._activeLinkLineGhostEntityID = nil
end

function RenderBoardComponent:Dispose()
  self._sceneGOs = {}
  if self._brillantLineReq then
    self._brillantLineReq:Dispose()
    self._brillantLineReq = nil
  end
  Log.info("RenderBoardComponent:Dispose")
end

function RenderBoardComponent:GetFirstPetRenderEntityID()
  return self._firstPetEntityID
end

function RenderBoardComponent:SetFirstPetRenderEntityID(id)
  self._firstPetEntityID = id
end

function RenderBoardComponent:GetGridRenderEntityTable()
  return self._gridEntityTable
end

function RenderBoardComponent:GetGridRenderEntity(pos)
  if not (pos and self._gridEntityTable[pos.x]) or not self._gridEntityTable[pos.x][pos.y] then
    return nil
  end
  return self._gridEntityTable[pos.x][pos.y]
end

function RenderBoardComponent:SetGridRenderEntityData(pos, gridEntity)
  if not self._gridEntityTable[pos.x] then
    self._gridEntityTable[pos.x] = {}
  end
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = gridEntity
end

function RenderBoardComponent:RemoveGridRenderEntityData(pos)
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = nil
end

function RenderBoardComponent:GetGridEffectEntityID(pos)
  if not (pos and self._gridEffectEntityIDTable[pos.x]) or not self._gridEffectEntityIDTable[pos.x][pos.y] then
    return nil
  end
  return self._gridEffectEntityIDTable[pos.x][pos.y]
end

function RenderBoardComponent:SetGridEffectEntityID(pos, entityID)
  if not self._gridEffectEntityIDTable[pos.x] then
    self._gridEffectEntityIDTable[pos.x] = {}
  end
  if not self._gridEffectEntityIDTable[pos.x][pos.y] then
    self._gridEffectEntityIDTable[pos.x][pos.y] = {}
  end
  self._gridEffectEntityIDTable[pos.x][pos.y] = entityID
end

function RenderBoardComponent:RemoveGridEffectEntityID(pos)
  if self._gridEffectEntityIDTable[pos.x] and self._gridEffectEntityIDTable[pos.x][pos.y] then
    self._gridEffectEntityIDTable[pos.x][pos.y] = nil
  end
end

function RenderBoardComponent:GetSceneEffectEntityID()
  return self._sceneEffectEntityID
end

function RenderBoardComponent:SetSceneEffectEntityID(entityID)
  self._sceneEffectEntityID = entityID
end

function RenderBoardComponent:GetSceneGO(name)
  return self._sceneGOs[name]
end

function RenderBoardComponent:SetSceneGO(go)
  if go then
    self._sceneGOs[go.name] = go
  end
end

function RenderBoardComponent:SetBrillantGridLineExtendParam(len)
  self._brillantGridLineExtendParam = len
end

function RenderBoardComponent:GetBrillantGridLineExtendParam()
  return self._brillantGridLineExtendParam
end

function RenderBoardComponent:GetBrillantGridObj()
  if self._brillantLineReq == nil then
    return nil
  end
  return self._brillantLineReq.Obj
end

function RenderBoardComponent:SetBrillantGridRequest(req)
  self._brillantLineReq = req
end

function RenderBoardComponent:SetBrillantGridLineList(h, v)
  self._hLineObjList = h
  self._vLineObjList = v
end

function RenderBoardComponent:GetBrillantGridLineList()
  return self._hLineObjList, self._vLineObjList
end

function RenderBoardComponent:GetDimensionClearPreviewTaskID()
  return self._dimensionClearPreviewTaskID
end

function RenderBoardComponent:SetDimensionClearPreviewTaskID(id)
  self._dimensionClearPreviewTaskID = id
end

function RenderBoardComponent:GetChainPathCancelAreaActive()
  return self._chainPathCancelAreaActive
end

function RenderBoardComponent:SetChainPathCancelAreaActive(isActive)
  self._chainPathCancelAreaActive = isActive
end

function RenderBoardComponent:GetMapPieceFirstChainPathEffectEntityID()
  return self._mapPieceFirstChainPathEffectEntityID
end

function RenderBoardComponent:SetMapPieceFirstChainPathEffectEntityID(entityID)
  self._mapPieceFirstChainPathEffectEntityID = entityID
end

function RenderBoardComponent:GetMapPieceFirstChainPathEffectID()
  return self._mapPieceFirstChainPathEffectID
end

function RenderBoardComponent:SetMapPieceFirstChainPathEffectID(effectID)
  self._mapPieceFirstChainPathEffectID = effectID
end

function RenderBoardComponent:GetMapPieceFirstChainPathEffectOutAnim()
  return self._mapPieceFirstChainPathEffectOutAnim
end

function RenderBoardComponent:SetMapPieceFirstChainPathEffectOutAnim(outAnim)
  self._mapPieceFirstChainPathEffectOutAnim = outAnim
end

function RenderBoardComponent:SetBaseGridRenderPos(renderPos)
  self._baseGridRenderPos = renderPos
end

function RenderBoardComponent:GetBaseGridRenderPos()
  return self._baseGridRenderPos
end

function RenderBoardComponent:AttachSceneEffByEffID(effectID, effectEntityID)
  if not self._sceneEffEntityIDDic[effectID] then
    self._sceneEffEntityIDDic[effectID] = {}
  end
  table.insert(self._sceneEffEntityIDDic[effectID], effectEntityID)
end

function RenderBoardComponent:GetSceneEffEntityIDByEffID(effectID)
  return self._sceneEffEntityIDDic[effectID]
end

function RenderBoardComponent:GetBattleCheatHideSceneObjList(key)
  if not self._battleCheatHideSceneObjList then
    self._battleCheatHideSceneObjList = {}
  end
  if not self._battleCheatHideSceneObjList[key] then
    self._battleCheatHideSceneObjList[key] = {}
  end
  return self._battleCheatHideSceneObjList[key] or {}
end

function RenderBoardComponent:SetBattleCheatHideSceneObjList(key, value)
  if not self._battleCheatHideSceneObjList then
    self._battleCheatHideSceneObjList = {}
  end
  if not self._battleCheatHideSceneObjList[key] then
    self._battleCheatHideSceneObjList[key] = {}
  end
  self._battleCheatHideSceneObjList[key] = value
end

function RenderBoardComponent:SetActiveLinkLineGhostEntityID(entityID)
  self._activeLinkLineGhostEntityID = entityID
end

function RenderBoardComponent:GetActiveLinkLineGhostEntityID()
  return self._activeLinkLineGhostEntityID
end

function Entity:RenderBoard()
  return self:GetComponent(self.WEComponentsEnum.RenderBoard)
end

function Entity:HasRenderBoard()
  return self:HasComponent(self.WEComponentsEnum.RenderBoard)
end

function Entity:AddRenderBoard()
  local index = self.WEComponentsEnum.RenderBoard
  local component = RenderBoardComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderBoard()
  local index = self.WEComponentsEnum.RenderBoard
  local component = RenderBoardComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderBoard()
  if self:HasRenderBoard() then
    self:RemoveComponent(self.WEComponentsEnum.RenderBoard)
  end
end
