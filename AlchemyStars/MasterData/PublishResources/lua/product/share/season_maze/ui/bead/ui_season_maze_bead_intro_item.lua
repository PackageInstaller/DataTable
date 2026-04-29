_class("UISeasonMazeBeadIntroItem", UICustomWidget)
UISeasonMazeBeadIntroItem = UISeasonMazeBeadIntroItem

function UISeasonMazeBeadIntroItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeBeadIntroItem:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UISeasonMazeBeadIntroItem:SetData(data)
  self.title:SetText(data.title)
  self.desc:SetText(data.desc)
end
