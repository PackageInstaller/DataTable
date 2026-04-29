_class("UISeasonMazeWorldBoss", UICustomWidget)
UISeasonMazeWorldBoss = UISeasonMazeWorldBoss

function UISeasonMazeWorldBoss:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeWorldBoss:InitWidget()
  self.turn = self:GetGameObject("Turn")
  self.go = self:GetUIComponent("Image", "Go")
end

function UISeasonMazeWorldBoss:SetData()
end

function UISeasonMazeWorldBoss:GoOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazeWorldBossDetailPopUp", true)
end
