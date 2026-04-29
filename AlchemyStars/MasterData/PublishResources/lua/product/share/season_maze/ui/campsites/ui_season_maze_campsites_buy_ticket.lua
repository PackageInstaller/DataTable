_class("UISeasonMaze_Campsites_BuyTicket", UIController)
UISeasonMaze_Campsites_BuyTicket = UISeasonMaze_Campsites_BuyTicket

function UISeasonMaze_Campsites_BuyTicket:InitWidget()
end

function UISeasonMaze_Campsites_BuyTicket:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMaze_Campsites_BuyTicket:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonMaze_Campsites_BuyTicket:BuyBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Smithy")
  self:CloseDialog()
end

function UISeasonMaze_Campsites_BuyTicket:OnHide()
end
