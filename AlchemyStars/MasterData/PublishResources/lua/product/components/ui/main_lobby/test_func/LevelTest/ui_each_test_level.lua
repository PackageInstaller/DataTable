_class("UIEachTestLevel", UICustomWidget)
UIEachTestLevel = UIEachTestLevel

function UIEachTestLevel:OnShow(uiParams)
  self:InitWidget()
end

function UIEachTestLevel:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "title")
end

function UIEachTestLevel:SetData(LevelList, BtnCallBack)
  self.LevelList = LevelList
  self.LevelID = LevelList[1]
  self.BtnCallBack = BtnCallBack
  self.title:SetText(self.LevelID)
end

function UIEachTestLevel:BtnOnClick(go)
  if self.BtnCallBack then
    self.BtnCallBack(self.LevelID)
  end
end
