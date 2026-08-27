local base = require("Game.ActivitySummer.Year22.Shop.UINActSum22ShopGoodsItem")
local UINWinter23ShopGoodsItem = class("UINWinter23ShopGoodsItem", base)

function UINWinter23ShopGoodsItem:RefreshCharDungeonShopItem()
  base.RefreshCharDungeonShopItem(self)
  self.ui.canvasGroup_root.alpha = self.__shopGoodData.isSoldOut and self.ui.alpha_sellOut or 1
end

return UINWinter23ShopGoodsItem
