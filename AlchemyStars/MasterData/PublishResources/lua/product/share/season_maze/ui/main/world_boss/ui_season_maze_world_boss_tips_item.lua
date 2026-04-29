_class("UISeasonMazeWorldBossTipsItem", UICustomWidget)
UISeasonMazeWorldBossTipsItem = UISeasonMazeWorldBossTipsItem

function UISeasonMazeWorldBossTipsItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeWorldBossTipsItem:InitWidget()
  self.tipsText = self:GetUIComponent("UILocalizationText", "tipsText")
end

function UISeasonMazeWorldBossTipsItem:SetData(str)
  self.tipsText:SetText(StringTable.Get(str))
end
