local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)

function UINCampFetterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_FetterItem, self, self.OnBtnFetterClicked)
  self.ui.image_CompanyIcon = self.transform:FindComponent("Img_Icon", eUnityComponentID.Image)
end

function UINCampFetterItem:InitFetterItem(campId, heroCount, clickAction)
  self.campId = campId
  local campCfg = ConfigData.camp[campId]
  if campCfg == nil then
    error("camp cfg is null,id:" .. tostring(campId))
    return
  end
  self.campCfg = campCfg
  self.ui.image_CompanyIcon.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_FetterInfo.text = tostring(heroCount)
  self.clickAction = clickAction
  self.fetters_num = heroCount
end

function UINCampFetterItem:OnBtnFetterClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

return UINCampFetterItem
