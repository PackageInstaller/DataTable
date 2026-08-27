local UINStOTechItemBaseEdge = class("UINStOTechItemBaseEdge", UIBaseNode)
local base = UIBaseNode

function UINStOTechItemBaseEdge:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStOTechItemBaseEdge:SetPreData(edgeType, edgeScale)
  self.edgeType = edgeType
  self.edgeScale = edgeScale
end

function UINStOTechItemBaseEdge:InitEdge(techItem)
  local scaleGroup = techItem.ui.scaleGroup
  self.transform:SetParent(techItem.transform)
  self.transform.localPosition = Vector3.zero
  self.transform.localScale = Vector3.one
  self.transform:SetAsFirstSibling()
  scaleGroup.transform.localScale = Vector3.New(self.edgeScale, self.edgeScale, self.edgeScale)
end

function UINStOTechItemBaseEdge:SetState(level, isUnlock)
end

function UINStOTechItemBaseEdge:GetUpPointPos()
  return self.ui.upPoint.transform.anchoredPosition
end

function UINStOTechItemBaseEdge:GetDownPointPos()
  return self.ui.downPoint.transform.anchoredPosition
end

function UINStOTechItemBaseEdge:TryGetFxRoot()
  if self.ui.fXRoot ~= nil then
    return self.ui.fXRoot
  end
  return nil
end

function UINStOTechItemBaseEdge:GetEdgeType()
  return self.edgeType
end

return UINStOTechItemBaseEdge
