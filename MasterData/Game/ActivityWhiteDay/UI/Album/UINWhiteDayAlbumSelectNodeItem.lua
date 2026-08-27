local UINWhiteDayAlbumSelectNodeItem = class("UINWhiteDayAlbumSelectNodeItem", UIBaseNode)
local base = UIBaseNode

function UINWhiteDayAlbumSelectNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_GetPhoto, self, self.__OnClickGetPhoto)
end

function UINWhiteDayAlbumSelectNodeItem:InitWDSelectNodeItem(isRandom, itemId, itemCostNum, desStr, clickCallback)
  self.isRandom = isRandom
  self.clickCallback = clickCallback
  if isRandom then
    self.ui.tex_Type:SetIndex(1)
    self.ui.tex_Count:SetIndex(1, tostring(itemCostNum))
  else
    self.ui.tex_Type:SetIndex(0)
    self.ui.tex_Count:SetIndex(0, tostring(itemCostNum))
  end
  self.ui.img_ItemIcon.sprite = CRH:GetSpriteByItemId(itemId)
  self.ui.tex_Des.text = desStr
end

function UINWhiteDayAlbumSelectNodeItem:__OnClickGetPhoto()
  if self.clickCallback ~= nil then
    self.clickCallback(self.isRandom)
  end
end

function UINWhiteDayAlbumSelectNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayAlbumSelectNodeItem
