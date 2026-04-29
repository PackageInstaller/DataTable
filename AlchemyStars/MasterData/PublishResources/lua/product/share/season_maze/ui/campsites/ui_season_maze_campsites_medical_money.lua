_class("UISeasonMaze_Campsites_Medical_Money", UICustomWidget)
UISeasonMaze_Campsites_Medical_Money = UISeasonMaze_Campsites_Medical_Money

function UISeasonMaze_Campsites_Medical_Money:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMaze_Campsites_Medical_Money:InitWidget()
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UISeasonMaze_Campsites_Medical_Money:SetData(count, clickCb)
  self.txtCount:SetText(count)
  self._clickCb = clickCb
end

function UISeasonMaze_Campsites_Medical_Money:IconOnClick(go)
  if self._clickCb then
    self._clickCb()
  end
end
