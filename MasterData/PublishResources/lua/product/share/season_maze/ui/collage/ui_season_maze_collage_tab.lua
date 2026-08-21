_class("UISeasonMazeCollageTab", UICustomWidget)
UISeasonMazeCollageTab = UISeasonMazeCollageTab

function UISeasonMazeCollageTab:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeCollageTab:InitWidget()
  self.txtName = self:GetUIComponent("UILocalizationText", "shadowName")
  self.select = self:GetGameObject("select")
  self.select:SetActive(false)
  self.red = self:GetGameObject("red")
  self.red:SetActive(false)
end

function UISeasonMazeCollageTab:SetData(index, nameKey, clickCb)
  self.index = index
  self.clickCb = clickCb
  local name = StringTable.Get(nameKey)
  self.txtName:SetText(name)
end

function UISeasonMazeCollageTab:SetSelect(bSelect)
  self.select:SetActive(bSelect)
end

function UISeasonMazeCollageTab:SetRed(bVisible)
  self.red:SetActive(bVisible)
end

function UISeasonMazeCollageTab:RootOnClick(go)
  if self.clickCb then
    self.clickCb(self.index)
  end
end
