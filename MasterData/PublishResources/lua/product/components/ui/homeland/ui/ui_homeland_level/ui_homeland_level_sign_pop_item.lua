_class("UIHomelandLevelSignPopItem", UICustomWidget)
UIHomelandLevelSignPopItem = UIHomelandLevelSignPopItem

function UIHomelandLevelSignPopItem:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandLevelData()
end

function UIHomelandLevelSignPopItem:OnShow()
  self.level = self:GetUIComponent("UILocalizationText", "level")
  self.txtSignAward = self:GetUIComponent("UILocalizationText", "txtSignAward")
  self.txtNewAward = self:GetUIComponent("UILocalizationText", "txtNewAward")
  self.liveable = self:GetUIComponent("UILocalizationText", "liveable")
end

function UIHomelandLevelSignPopItem:OnHide()
end

function UIHomelandLevelSignPopItem:Flush(level)
  self.level:SetText(level.level)
  self.txtSignAward:SetText(level.signReward)
  self.txtNewAward:SetText(level.furnitureReward)
  self.liveable:SetText(level.livableValueMax)
end
