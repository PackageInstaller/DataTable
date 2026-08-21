_class("PreviewConvertElementComponent", Object)
PreviewConvertElementComponent = PreviewConvertElementComponent

function PreviewConvertElementComponent:Constructor()
  self._tempConvertElementDic = {}
  self._tempTransportEntityList = {}
  self._sourceTransportEntityList = {}
end

function PreviewConvertElementComponent:SetTempConvertElementDic(elementDic)
  self._tempConvertElementDic = elementDic
end

function PreviewConvertElementComponent:GetTempConvertElementDic()
  return self._tempConvertElementDic
end

function PreviewConvertElementComponent:AddTempConvertElement(gridPos, originalElementType)
  if table.count(self._tempConvertElementDic) == 0 then
    self._tempConvertElementDic[gridPos] = originalElementType
    return
  end
  for pos, v in pairs(self._tempConvertElementDic) do
    if pos.x == gridPos.x and pos.y == gridPos.y then
      v = originalElementType
      return
    end
  end
  self._tempConvertElementDic[gridPos] = originalElementType
end

function PreviewConvertElementComponent:RemoveTempConvertElement(gridPos)
  for pos, v in pairs(self._tempConvertElementDic) do
    if pos.x == gridPos.x and pos.y == gridPos.y then
      self._tempConvertElementDic[pos] = nil
      return
    end
  end
end

function PreviewConvertElementComponent:ClearTempConvertElement()
  self._tempConvertElementDic = {}
end

function PreviewConvertElementComponent:AddPreviewTransportEntity(entity, sourceEntity)
  table.insert(self._tempTransportEntityList, entity:GetID())
  table.insert(self._sourceTransportEntityList, sourceEntity:GetID())
end

function PreviewConvertElementComponent:GetPreviewTransportEntityList()
  return self._tempTransportEntityList, self._sourceTransportEntityList
end

function PreviewConvertElementComponent:ClearPreviewTransportEntity()
  self._tempTransportEntityList = {}
  self._sourceTransportEntityList = {}
end

function Entity:PreviewConvertElement()
  return self:GetComponent(self.WEComponentsEnum.PreviewConvertElement)
end

function Entity:HasPreviewConvertElement()
  return self:HasComponent(self.WEComponentsEnum.PreviewConvertElement)
end

function Entity:AddPreviewConvertElement()
  local index = self.WEComponentsEnum.PreviewConvertElement
  local component = PreviewConvertElementComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewConvertElement()
  local index = self.WEComponentsEnum.PreviewConvertElement
  local component = PreviewConvertElementComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewConvertElement()
  if self:HasPreviewConvertElement() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewConvertElement)
  end
end
