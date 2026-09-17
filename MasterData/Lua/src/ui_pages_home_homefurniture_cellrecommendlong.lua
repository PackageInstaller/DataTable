local this = class("cellRecommendLong", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local goodsTpl = L_GameTpl:getGoodsTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()

function this.bind()
  return {
    txt_goodsName = "",
    txt_price = "",
    img_icon = "",
    img_currency = "",
    list_star = {},
    go_img = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      print("============================onclick")
      self:emit("onClick", self.bind)
    end
  }
end

function this:open()
  print("=============================open cellRecommendLong", self.bind.slotId)
  local tpl = goodsTpl:getTplById(self.bind.goodsId)
  self.itemType = goodsTpl:getItem(tpl)[1][1]
  self.itemId = goodsTpl:getItem(tpl)[1][2]
  local itemConfig = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  self.bind.img_icon = "UI/Atlas/HomeFurnitureM/tex_icon_HomeFurnitureM_" .. homeDormFurnitureTpl:getTplById(self.itemId).shopIcon
  local currencyId = goodsTpl:getCurrencyId(tpl)
  self.bind.img_currency = L_ItemTplManager:getCurrencyItem(currencyId).icon
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.txt_goodsName = _commonItemTpl:getName(commonItemTpl)
  self.bind.txt_price = self.bind.price
  self.bind.go_img = self.bind.isOwned
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  self:_setStars(starNum)
end

function this:_setStars(num)
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

return this
