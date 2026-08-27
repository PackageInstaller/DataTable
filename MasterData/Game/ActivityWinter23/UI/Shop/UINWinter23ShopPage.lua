local base = require("Game.ActivitySummer.Year22.Shop.UINActSum22ShopPage")
local UINWinter23ShopPage = class("UINWinter23ShopPage", base)

function UINWinter23ShopPage:RefreshSum22ShopPageState(shopId)
  local flag = self._shopId == shopId
  if flag then
    self.ui.tex_PageName.color = Color.white
    self.ui.img_pageItem:SetIndex(1)
    self.ui.img_pageItem.image.color = self.ui.color_selected
  else
    self.ui.tex_PageName.color = self.ui.color_texUnSelected
    self.ui.img_pageItem:SetIndex(0)
    self.ui.img_pageItem.image.color = self.ui.color_unselected
  end
end

function UINWinter23ShopPage:SetWinter23ShopRed(flag)
  self.ui.blueDot:SetActive(flag)
end

function UINWinter23ShopPage:HideWinter23ShopLine()
  self.ui.line:SetActive(false)
end

return UINWinter23ShopPage
