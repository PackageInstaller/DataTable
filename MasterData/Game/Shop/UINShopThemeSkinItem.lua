local UINShopThemeSkinItem = class("UINShopThemeSkinItem", UIBaseNode)
local base = UIBaseNode

function UINShopThemeSkinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_shopItem, self, self._OnClick)
end

function UINShopThemeSkinItem:InitItem(resloader, OnClickGoodItem)
  self.resloader = resloader
  self.onClickGoodItem = OnClickGoodItem
end

function UINShopThemeSkinItem:InitNormalGoodsItem(goodData, parentNode, purchaseRoot)
  self.goodData = goodData
  self.parentNode = parentNode
  self.purchaseRoot = purchaseRoot
  self:RefreshGoods()
end

function UINShopThemeSkinItem:_OnClick()
  if self.goodData.isSoldOut then
    return
  end
  if self.onClickGoodItem ~= nil then
    self.onClickGoodItem(self.goodData)
  end
end

function UINShopThemeSkinItem:RefreshGoods()
  self.ui.img_SkinTheme.gameObject:SetActive(false)
  local picPath = self.goodData.pic_skinshop
  if string.IsNullOrEmpty(self.goodData.pic_skinshop) then
    picPath = self.goodData.pic
  end
  self.resloader:LoadABAssetAsync(PathConsts:GetHeroSkinThemePicPath(picPath), function(Texture)
    if Texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_SkinTheme.texture = Texture
    self.ui.img_SkinTheme.gameObject:SetActive(true)
  end)
end

function UINShopThemeSkinItem:OnDelete()
  base.OnDelete(self)
end

return UINShopThemeSkinItem
