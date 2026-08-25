local NewbieGuideBattleView, Super = NewClass("NewbieGuideBattleView", NewbieGuideView)
NewbieGuideBattleView.uiResCls = UI_Guide_NewbieGuideResource

function NewbieGuideBattleView:ctor(viewData)
  Super.ctor(self, nil, nil, viewData.guideCfg, viewData.closeCb)
  self._battleNodeName = viewData.nodeName
  self._battleDirection = viewData.direction
end

function NewbieGuideBattleView:GetGuideDirection()
  return self._battleDirection
end

function NewbieGuideBattleView:GetNodeName()
  return self._battleNodeName
end

function NewbieGuideBattleView:IsForceGuide()
  return true
end

return NewbieGuideBattleView
