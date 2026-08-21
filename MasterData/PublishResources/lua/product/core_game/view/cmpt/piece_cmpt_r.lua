_class("PieceComponent", Object)
PieceComponent = PieceComponent

function PieceComponent:Constructor(pieceType, entity)
  self._pieceType = pieceType or PieceType.None
  self._pieceEffectType = PieceEffectType.Normal
  self._hasInitAsset = false
  self._piecePrefabObjList = {}
  self._piecePrefabEntityList = {}
  self._entity = entity
  self._curBaseLayerObj = nil
  self._curAnimation = "Normal"
end

function PieceComponent:HasInitAsset()
  return self._hasInitAsset
end

function PieceComponent:SetInitAsset()
  self._hasInitAsset = true
end

function PieceComponent:GetPieceType()
  return self._pieceType
end

function PieceComponent:SetPieceType(pieceType)
  self._pieceType = pieceType
end

function PieceComponent:GetRenderPieceEffectType()
  return self._pieceEffectType
end

function PieceComponent:SetRenderPieceEffectType(pieceEffectType)
  self._pieceEffectType = pieceEffectType
end

function PieceComponent:GetPieceAnimName()
  return self._curAnimation
end

function PieceComponent:SetPieceAnimName(animation)
  self._curAnimation = animation
end

function PieceComponent:GetEntity()
  return self._entity
end

function PieceComponent:GetBaseLayerObj()
  return self._curBaseLayerObj
end

function PieceComponent:SetBaseLayerObj(obj)
  self._curBaseLayerObj = obj
end

function PieceComponent:GetPiecePrefabObj(name)
  return self._piecePrefabObjList[name]
end

function PieceComponent:GetPiecePrefabEntityList()
  return self._piecePrefabEntityList
end

function PieceComponent:SetPiecePrefabObj(layerName, name, obj, gridPrefabEntity)
  self:_OnCheckInitPieceLayerData()
  self._piecePrefabObjList[name] = obj
  self._piecePrefabEntityList[name] = gridPrefabEntity
  obj.transform.parent = self:OnGetLayerTransform(layerName)
  obj.transform.localPosition = Vector3(0, 0, 0)
end

function PieceComponent:_OnCheckInitPieceLayerData()
  if self._pieceLayerDataList then
    return
  end
  self._pieceLayerDataList = {}
  self._pieceLayerDataList.BaseLayer = PieceLayerData:New("BaseLayer", self._entity)
  self._pieceLayerDataList.TagLayer = PieceLayerData:New("TagLayer", self._entity)
  self._pieceLayerDataList.ExtraLayer = PieceLayerData:New("ExtraLayer", self._entity)
  self._pieceLayerDataList.EffectLayer = PieceLayerData:New("EffectLayer", self._entity)
end

function PieceComponent:OnGetPieceLayerData(layerName)
  if not self._pieceLayerDataList then
    return nil
  end
  local pieceLayerData = self._pieceLayerDataList[layerName]
  return pieceLayerData
end

function PieceComponent:OnGetLayerTransform(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataTransform()
end

function PieceComponent:OnGetLayerPrefabName(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataPrefabName()
end

function PieceComponent:OnGetLayerPrefabObj(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataPrefabObj()
end

function PieceComponent:OnSetLayerPrefab(layerName, prefabName, prefabObj)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  pieceLayerData:OnSetPieceLayerDataPrefab(prefabName, prefabObj)
  if layerName == "BaseLayer" then
    self._curBaseLayerObj = prefabObj
  end
end

function PieceComponent:OnSetLayerPrefabName(layerName, prefabName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  pieceLayerData:OnSetPieceLayerDataPrefabName(prefabName, prefabName)
end

function PieceComponent:GetDoTweenMaterialDarkness()
  return self._doTweenMaterialDarkness
end

function PieceComponent:SetDoTweenMaterialDarkness(doTween)
  self._doTweenMaterialDarkness = doTween
end

_class("PieceLayerData", Object)
PieceLayerData = PieceLayerData

function PieceLayerData:Constructor(layerName, entity)
  self._layerName = layerName
  self._entity = entity
  local pieceObj = self._entity:View().ViewWrapper.GameObject
  self._layerTransform = pieceObj.transform:Find(self._layerName)
  self._layerPrefabObj = nil
  self._layerPrefabName = nil
end

function PieceLayerData:OnGetPieceLayerDataTransform()
  return self._layerTransform
end

function PieceLayerData:OnSetPieceLayerDataPrefab(prefabName, prefabObj)
  self._layerPrefabName = prefabName
  self._layerPrefabObj = prefabObj
end

function PieceLayerData:OnGetPieceLayerDataPrefabObj()
  return self._layerPrefabObj
end

function PieceLayerData:OnGetPieceLayerDataPrefabName()
  return self._layerPrefabName
end

function PieceLayerData:OnSetPieceLayerDataPrefabName(layerPrefabName)
  self._layerPrefabName = layerPrefabName
end

function Entity:Piece()
  return self:GetComponent(self.WEComponentsEnum.Piece)
end

function Entity:HasPiece()
  return self:HasComponent(self.WEComponentsEnum.Piece)
end

function Entity:AddPiece(pieceType)
  local index = self.WEComponentsEnum.Piece
  local component = PieceComponent:New(pieceType, self)
  self:AddComponent(index, component)
end

function Entity:ReplacePiece(pieceType)
  local index = self.WEComponentsEnum.Piece
  if self:HasPiece() then
    local cmpt = self:Piece()
    cmpt:SetPieceType(pieceType)
    self:ReplaceComponent(index, cmpt)
  else
    local component = PieceComponent:New(pieceType, self)
    self:ReplaceComponent(index, component)
  end
end

function Entity:RemovePiece()
  if self:HasPiece() then
    self:RemoveComponent(self.WEComponentsEnum.Piece)
  end
end
