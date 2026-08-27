local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)

function UINCampFetterItem:OnInit()
  local btn = self.transform:FindComponent(eUnityComponentID.Button)
  UIUtil.AddButtonListener(btn, self, self.OnBtnClicked)
  self.ui.tex_FetterInfo = self.transform:FindComponent("Tex_FetterInfo", eUnityComponentID.Text)
  self.ui.image_CompanyIcon = self.transform:FindComponent("Img_Icon", eUnityComponentID.Image)
end

function UINCampFetterItem:InitFetterItem(campId, count, clickAction)
  self.clickAction = clickAction
  self.campId = campId, count
  self.fetters_num = count
  local campCfg = ConfigData.camp[self.campId]
  if campCfg == nil then
    error("camp cfg is null:ID:" .. tostring(self.campId))
    return
  end
  self.campCfg = campCfg
  self.ui.tex_FetterInfo.text = string.format("%s *%d", LanguageUtil.GetLocaleText(campCfg.name), self.fetters_num)
  self.ui.image_CompanyIcon.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
end

function UINCampFetterItem:OnBtnClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

return UINCampFetterItem
