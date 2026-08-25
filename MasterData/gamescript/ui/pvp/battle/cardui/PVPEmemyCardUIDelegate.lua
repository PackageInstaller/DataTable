local PVPEmemyCardUIDelegate, Super = System.NewClass("PVPEmemyCardUIDelegate", IBattleCardUIDelegate)

function PVPEmemyCardUIDelegate:ctor(ui)
  Super.ctor(self)
  self.ui = ui
end

function PVPEmemyCardUIDelegate:GetCardContent()
  return self.ui.Card_Content_Enemy
end

function PVPEmemyCardUIDelegate:GetDrawDeckBtn()
  return self.ui.Group_Drawdeck_Enemy
end

function PVPEmemyCardUIDelegate:GetGraveyardDeckBtn()
  return nil
end

function PVPEmemyCardUIDelegate:GetHandDeckBtn()
  return self.ui.Group_Handdeck_Enemy
end

function PVPEmemyCardUIDelegate:GetTransform()
  return self.ui.uiNode.transform
end

return PVPEmemyCardUIDelegate
