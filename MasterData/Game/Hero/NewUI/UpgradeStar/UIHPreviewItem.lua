local UIHPreviewItem = class("UIHPreviewItem", UIBaseNode)
local base = UIBaseNode
local previewType = require("Game.Hero.NewUI.UpgradeStar.eHeroStarUpEnum").previewType

function UIHPreviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_PreItem, self, self.__OnClickPreItem)
end

function UIHPreviewItem:InitPreviewItem(index, preData, clickAction)
  self.index = index
  self.clickAction = clickAction
  self.ui.tex_Name.text = preData.name
  if preData.preType == previewType.normal then
    self.ui.btn_PreItem.interactable = false
    self.ui.img_special.color = self.ui.col_Normal
    self.ui.img_CanClick:SetActive(false)
  else
    self.ui.btn_PreItem.interactable = true
    self.ui.img_special.color = self.ui.col_Special
    self.ui.img_CanClick:SetActive(true)
  end
end

function UIHPreviewItem:__OnClickPreItem()
  if self.clickAction ~= nil then
    self.clickAction(self.index)
  end
end

function UIHPreviewItem:OnDelete()
  base.OnDelete(self)
end

return UIHPreviewItem
