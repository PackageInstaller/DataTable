_class("HomelandBrickEdge", Object)
HomelandBrickEdge = HomelandBrickEdge

function HomelandBrickEdge:Constructor(go)
  self._go = go
end

function HomelandBrickEdge:SetVisible(status)
  self._go:SetActive(status)
end
