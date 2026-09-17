local this = class("cellFurnitureShopItem", G_UIModuleBase)

function this.bind()
  return {
    txt_favorValue = "",
    txt_goodsName = "",
    txt_goodsDesc = "",
    txt_price = "",
    go_soldout = false,
    list_soulEssenceStar = {}
  }
end

function this.methods()
  return {
    onclick = {
      self:emit("click", self.bind)
    }
  }
end

function this:open()
  this.super.open(self)
  print("==============================")
end

return this
