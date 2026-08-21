_class("UISeasonBuildTabBtnS3", UICustomWidget)
UISeasonBuildTabBtnS3 = UISeasonBuildTabBtnS3

function UISeasonBuildTabBtnS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildTabBtnS3:InitWidget()
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
  self.txtName2 = self:GetUIComponent("UILocalizationText", "txtName2")
  self.selectGo = self:GetGameObject("select")
  self.unSelectGo = self:GetGameObject("unSelect")
end

function UISeasonBuildTabBtnS3:SetData(cfg, clickCb)
  self.clickCb = clickCb
  self.index = cfg.index
  self.txtName1:SetText(StringTable.Get(cfg.name))
  self.txtName2:SetText(StringTable.Get(cfg.name))
end

function UISeasonBuildTabBtnS3:SetSelect(bSelect)
  self.selectGo:SetActive(bSelect)
  self.unSelectGo:SetActive(not bSelect)
end

function UISeasonBuildTabBtnS3:BtnOnClick(go)
  if self.clickCb then
    self.clickCb(self.index)
  end
end
