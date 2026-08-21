_class("UISeasonMazeCollageBeadTips", UICustomWidget)
UISeasonMazeCollageBeadTips = UISeasonMazeCollageBeadTips

function UISeasonMazeCollageBeadTips:OnShow()
  self:InitWidgets()
end

function UISeasonMazeCollageBeadTips:InitWidgets()
  self.title = self:GetUIComponent("UILocalizationText", "TipsTitle")
  self.desc = self:GetUIComponent("UILocalizationText", "TipsDesc")
end

function UISeasonMazeCollageBeadTips:SetData(strTitle, strDesc)
  self.title:SetText(strTitle)
  self.desc:SetText(strDesc)
end
