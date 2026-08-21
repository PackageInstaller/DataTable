_class("UISeniorSKinProItems", UICustomWidget)
UISeniorSKinProItems = UISeniorSKinProItems

function UISeniorSKinProItems:OnShow(uiParams)
  self:InitWidget()
end

function UISeniorSKinProItems:InitWidget()
  self.icon1 = self:GetUIComponent("RawImageLoader", "icon1")
  self.count1 = self:GetUIComponent("UILocalizationText", "count1")
  self.icon2 = self:GetUIComponent("RawImageLoader", "icon2")
  self.count2 = self:GetUIComponent("UILocalizationText", "count2")
end

function UISeniorSKinProItems:SetData(ids)
  local cfg1 = Cfg.cfg_item[ids[1][1]]
  self.icon1:LoadImage(cfg1.Icon)
  self.count1:SetText("x" .. ids[1][2])
  if ids[2] then
    local cfg2 = Cfg.cfg_item[ids[2][1]]
    self.icon2:LoadImage(cfg2.Icon)
    self.count2:SetText("x" .. ids[2][2])
  else
    self.icon2.gameObject:SetActive(false)
    self.count2.gameObject:SetActive(false)
  end
end
