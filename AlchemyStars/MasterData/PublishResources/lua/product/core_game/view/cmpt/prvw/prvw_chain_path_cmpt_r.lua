_class("PreviewChainPathComponent", Object)
PreviewChainPathComponent = PreviewChainPathComponent

function PreviewChainPathComponent:Constructor(chainPath, elementType, lastElementType)
  self._chainPath = chainPath or {}
  self._elementType = elementType or PieceType.None
  self._lastElementType = lastElementType or PieceType.None
  self._chainNum = 0
  if #self._chainPath > 0 then
    self._chainNum = #self._chainPath - 1
  end
  self._nearbyGridRadius = {}
  self._bMoveBack = false
  self._firstElementType = nil
  self._firstElementIndex = -1
  self._linkLineState = false
  self._linkLineType = ELinkLineType.ELLT_LINE_Common
end

function PreviewChainPathComponent:SetLinkLineType(type)
  self._linkLineType = type
end

function PreviewChainPathComponent:GetLinkLineType()
  return self._linkLineType
end

function PreviewChainPathComponent:GetPreviewChainPath()
  return self._chainPath
end

function PreviewChainPathComponent:GetPreviewPieceType()
  return self._elementType
end

function PreviewChainPathComponent:SetPreviewChainPath(chainPath, elementType)
  self._chainPath = chainPath
  self._elementType = elementType
  if chainPath then
    self._chainNum = #chainPath - 1
  else
    self._chainNum = 0
  end
end

function PreviewChainPathComponent:GetPreviewChainNum()
  return self._chainNum
end

function PreviewChainPathComponent:GetPreviewChainTotalCount()
  return #self._chainPath
end

function PreviewChainPathComponent:ClearPreviewChainPath()
  self._chainPath = {}
  self._firstElementType = nil
  self._firstElementIndex = -1
end

function PreviewChainPathComponent:SetGridRadius(nearbyGridRadius)
  self._nearbyGridRadius = nearbyGridRadius
end

function PreviewChainPathComponent:GetGridRadius(gridPos)
  for k, v in pairs(self._nearbyGridRadius) do
    if k == gridPos then
      return v
    end
  end
  return GridRadiusType.Default
end

function PreviewChainPathComponent:GetMoveBack()
  return self._bMoveBack
end

function PreviewChainPathComponent:SetMoveBack(bMoveBack)
  self._bMoveBack = bMoveBack
end

function PreviewChainPathComponent:SetFirstElementData(elementType, index)
  self._firstElementType = elementType
  self._firstElementIndex = index
end

function PreviewChainPathComponent:GetFirstElementData()
  return self._firstElementType, self._firstElementIndex
end

function PreviewChainPathComponent:IsLinkLine()
  return self._linkLineState
end

function PreviewChainPathComponent:SetLinkLineState(stage)
  self._linkLineState = stage
end

function Entity:PreviewChainPath()
  return self:GetComponent(self.WEComponentsEnum.PreviewChainPath)
end

function Entity:HasPreviewChainPath()
  return self:HasComponent(self.WEComponentsEnum.PreviewChainPath)
end

function Entity:AddPreviewChainPath()
  local index = self.WEComponentsEnum.PreviewChainPath
  local component = PreviewChainPathComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewChainPath(chainPath, elementType, lastElementType, inheritLinkLineType)
  local linkLineType
  if inheritLinkLineType then
    linkLineType = self:PreviewLinkLine():GetLinkLineType()
  end
  local index = self.WEComponentsEnum.PreviewChainPath
  local component = PreviewChainPathComponent:New(chainPath, elementType, lastElementType)
  if chainPath and 0 < #chainPath then
    component:SetLinkLineState(true)
  end
  component:SetLinkLineType(linkLineType)
  self:ReplaceComponent(index, component)
  Log.debug("UpdatePath----elemType:", elementType, " laseElemType:", lastElementType, Log.traceback())
end

function Entity:RemovePreviewChainPath()
  if self:HasPreviewChainPath() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewChainPath)
  end
end
