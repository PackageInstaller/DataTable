local PVPMysideCardUIDelegate, Super = System.NewClass("PVPMysideCardUIDelegate", IBattleCardUIDelegate)

function PVPMysideCardUIDelegate:ctor(ui)
  Super.ctor(self)
  self.ui = ui
end

function PVPMysideCardUIDelegate:GetCardContent()
  return self.ui.Card_Content_Myself
end

function PVPMysideCardUIDelegate:GetDrawDeckBtn()
  return self.ui.Group_Drawdeck_My
end

function PVPMysideCardUIDelegate:GetGraveyardDeckBtn()
  return self.ui.Group_Drawdeck_My
end

function PVPMysideCardUIDelegate:GetHandDeckBtn()
  return self.ui.Group_Handdeck_My
end

function PVPMysideCardUIDelegate:GetTransform()
  return self.ui.uiNode.transform
end

return PVPMysideCardUIDelegate
