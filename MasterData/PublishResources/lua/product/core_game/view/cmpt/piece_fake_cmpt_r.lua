_class("PieceFakeComponent", Object)
PieceFakeComponent = PieceFakeComponent

function PieceFakeComponent:Constructor(pieceType, entity)
  self._pieceType = pieceType or PieceType.None
  self._pieceEffectType = pieceType or PieceEffectType.Normal
  self._hasInitAsset = false
  self._piecePrefabObjList = {}
  self._piecePrefabEntityList = {}
  self._entity = entity
  self._curBaseLayerObj = nil
  self._curAnimation = "Normal"
end

function PieceFakeComponent:HasInitAsset()
  return self._hasInitAsset
end

function PieceFakeComponent:SetInitAsset()
  self._hasInitAsset = true
end

function PieceFakeComponent:GetPieceType()
  return self._pieceType
end

function PieceFakeComponent:SetPieceType(pieceType)
  self._pieceType = pieceType
end

function PieceFakeComponent:GetRenderPieceEffectType()
  return self._pieceEffectType
end

function PieceFakeComponent:SetRenderPieceEffectType(pieceEffectType)
  self._pieceEffectType = pieceEffectType
end

function PieceFakeComponent:GetPieceAnimName()
  return self._curAnimation
end

function PieceFakeComponent:SetPieceAnimName(animation)
  self._curAnimation = animation
end

function PieceFakeComponent:GetEntity()
  return self._entity
end

function PieceFakeComponent:GetBaseLayerObj()
  return self._curBaseLayerObj
end

function PieceFakeComponent:SetBaseLayerObj(obj)
  self._curBaseLayerObj = obj
end

function PieceFakeComponent:GetPiecePrefabObj(name)
  return self._piecePrefabObjList[name]
end

function PieceFakeComponent:GetPiecePrefabEntityList()
  return self._piecePrefabEntityList
end

function PieceFakeComponent:SetPiecePrefabObj(layerName, name, obj, gridPrefabEntity)
  self:_OnCheckInitPieceLayerData()
  self._piecePrefabObjList[name] = obj
  self._piecePrefabEntityList[name] = gridPrefabEntity
  obj.transform.parent = self:OnGetLayerTransform(layerName)
  obj.transform.localPosition = Vector3(0, 0, 0)
end

function PieceFakeComponent:_OnCheckInitPieceLayerData()
  if self._pieceLayerDataList then
    return
  end
  self._pieceLayerDataList = {}
  self._pieceLayerDataList.BaseLayer = PieceLayerData:New("BaseLayer", self._entity)
  self._pieceLayerDataList.TagLayer = PieceLayerData:New("TagLayer", self._entity)
  self._pieceLayerDataList.ExtraLayer = PieceLayerData:New("ExtraLayer", self._entity)
  self._pieceLayerDataList.EffectLayer = PieceLayerData:New("EffectLayer", self._entity)
end

function PieceFakeComponent:OnGetPieceLayerData(layerName)
  if not self._pieceLayerDataList then
    return nil
  end
  local pieceLayerData = self._pieceLayerDataList[layerName]
  return pieceLayerData
end

function PieceFakeComponent:OnGetLayerTransform(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataTransform()
end

function PieceFakeComponent:OnGetLayerPrefabName(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataPrefabName()
end

function PieceFakeComponent:OnGetLayerPrefabObj(layerName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  if not pieceLayerData then
    return nil
  end
  return pieceLayerData:OnGetPieceLayerDataPrefabObj()
end

function PieceFakeComponent:OnSetLayerPrefab(layerName, prefabName, prefabObj)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  pieceLayerData:OnSetPieceLayerDataPrefab(prefabName, prefabObj)
  if layerName == "BaseLayer" then
    self._curBaseLayerObj = prefabObj
  end
end

function PieceFakeComponent:OnSetLayerPrefabName(layerName, prefabName)
  local pieceLayerData = self:OnGetPieceLayerData(layerName)
  pieceLayerData:OnSetPieceLayerDataPrefabName(prefabName, prefabName)
end

function PieceFakeComponent:GetDoTweenMaterialDarkness()
  return self._doTweenMaterialDarkness
end

function PieceFakeComponent:SetDoTweenMaterialDarkness(doTween)
  self._doTweenMaterialDarkness = doTween
end

function Entity:PieceFake()
  return self:GetComponent(self.WEComponentsEnum.PieceFake)
end

function Entity:HasPieceFake()
  return self:HasComponent(self.WEComponentsEnum.PieceFake)
end

function Entity:AddPieceFake(pieceType)
  local index = self.WEComponentsEnum.PieceFake
  local component = PieceFakeComponent:New(pieceType, self)
  self:AddComponent(index, component)
end

function Entity:ReplacePieceFake(pieceType)
  local index = self.WEComponentsEnum.PieceFake
  if self:HasPieceFake() then
    local cmpt = self:PieceFake()
    cmpt:SetPieceType(pieceType)
    self:ReplaceComponent(index, cmpt)
  else
    local component = PieceFakeComponent:New(pieceType, self)
    self:ReplaceComponent(index, component)
  end
end

function Entity:RemovePieceFake()
  if self:HasPieceFake() then
    self:RemoveComponent(self.WEComponentsEnum.PieceFake)
  end
end
