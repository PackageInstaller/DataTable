local NewbieGuideBattlePanel, Super = System.NewClass("NewbieGuideBattlePanel", NewbieGuidePanel)

function NewbieGuideBattlePanel:ctor(viewData)
  self.guideCfg = viewData.guideCfg
  self.nodeName = viewData.nodeName
  self.closeCb = viewData.closeCb
  self.direction = viewData.direction
end

function NewbieGuideBattlePanel:GetGuideDirection()
  return self.direction
end

function NewbieGuideBattlePanel:GetNodeName()
  return self.nodeName
end

function NewbieGuideBattlePanel:IsForceGuide()
  return true
end

return NewbieGuideBattlePanel
