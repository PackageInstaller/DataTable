_class("UIN19P5IntrController", UIController)
UIN19P5IntrController = UIN19P5IntrController

function UIN19P5IntrController:OnShow(uiParams)
  self.key = uiParams[1]
  local cfg = Cfg.cfg_activityintro[self.key]
  self.desc = StringTable.Get(cfg.Intro)
  self.titleImgName = cfg.Title
  self:GetComponents()
  self:OnValue()
end

function UIN19P5IntrController:GetComponents()
  self.titleImg = self:GetUIComponent("RawImageLoader", "Title")
  self.descTex = self:GetUIComponent("UILocalizationText", "Content")
end

function UIN19P5IntrController:OnHide()
end

function UIN19P5IntrController:OnValue()
  self.titleImg:LoadImage(self.titleImgName)
  self.descTex:SetText(self.desc)
end

function UIN19P5IntrController:CloseBtnOnClick(go)
  self:CloseDialog()
end
