_class("UISeasonMazeBossSingleWordItem", UICustomWidget)
UISeasonMazeBossSingleWordItem = UISeasonMazeBossSingleWordItem

function UISeasonMazeBossSingleWordItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeBossSingleWordItem:InitWidget()
  self.DifficultyNumText = self:GetUIComponent("UILocalizationText", "DifficultyNum")
end

function UISeasonMazeBossSingleWordItem:SetData(Des, Color)
  local str = StringTable.Get(Des)
  self.DifficultyNumText:SetText(str)
end
