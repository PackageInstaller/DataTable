_class("DataAttributeResult", Object)
DataAttributeResult = DataAttributeResult

function DataAttributeResult:Constructor(eid, name, value)
  self._entityID = eid
  self._attrName = name
  self._attrValue = value
end

function DataAttributeResult:GetEntityID()
  return self._entityID
end

function DataAttributeResult:GetAttrName()
  return self._attrName
end

function DataAttributeResult:GetAttrValue()
  return self._attrValue
end
