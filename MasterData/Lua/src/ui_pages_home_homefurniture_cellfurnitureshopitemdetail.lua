local this = class("cellFurnitureShopItemDetail", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local qualityMap = {
  ["2"] = "UI/Page/HomeFurnitureShop/tex_home_furniture_shop_bg_exchange_05.png",
  ["4"] = "UI/Page/HomeFurnitureShop/tex_home_furniture_shop_bg_exchange_06.png",
  ["3"] = "UI/Page/HomeFurnitureShop/tex_home_furniture_shop_bg_exchange_07.png"
}

function this.bind()
  return {
    txt_limitTime = "",
    txt_favorValue = "",
    img_interat = "",
    txt_interact = "",
    txt_name = "",
    txt_desc = "",
    img_icon = "",
    go_soldout = false,
    go_recommend = false,
    list_star = {},
    stockText = "",
    go_delCost = false,
    txt_cost = "",
    go_currencyImg = false,
    img_currency = "",
    img_quality = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      print("=====================兑换")
      L_UI:open("pageFurnitureShopTip", {
        goodsId = self.bind.goodsId,
        slotId = self.bind.slotId,
        owned = self.bind.soldOutMask
      })
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local tpl = goodsTpl:getTplById(self.bind.goodsId)
  self.itemType = goodsTpl:getItem(tpl)[1][1]
  self.itemId = goodsTpl:getItem(tpl)[1][2]
  local itemConfig = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  self.bind.img_icon = "UI/Atlas/HomeFurnitureM/tex_icon_HomeFurnitureM_" .. homeDormFurnitureTpl:getTplById(self.itemId).shopIcon
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.txt_name = _commonItemTpl:getName(commonItemTpl)
  self.bind.txt_desc = _goodsTpl:getGoodsDesc(tpl)
  self.bind.go_recommend = tpl.recommend ~= ""
  self.bind.txt_favorValue = tostring(homeDormFurnitureTpl:getFurnitureFavor(self.itemId))
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  self:_setStars(starNum)
  self:setInteractUI(homeDormFurnitureTpl:getTplById(self.itemId).type)
  self:refreshMoney()
  self.bind.go_soldout = self.bind.soldOutMask
  if self.bind.soldOutMask == false then
    self.bindComponents.board:ResetColors()
  else
    self.bindComponents.board:SetGray(0.33)
  end
  self.bind.img_quality = qualityMap[tostring(tpl.rarity)]
end

function this:setInteractUI(interact)
  if interact then
    if interact == 0 then
      self.bind.txt_interact = L_WordsTpl:getValue("ui_homefurniture_shop_type_03")
      self.bind.img_interat = "HomeFurnitureShop/tex_home_furniture_shop_icon_exchange_03.png"
    elseif interact == 1 then
      self.bind.txt_interact = L_WordsTpl:getValue("ui_homefurniture_shop_type_02")
      self.bind.img_interat = "HomeFurnitureShop/tex_home_furniture_shop_icon_exchange_02.png"
    elseif interact == 2 then
      self.bind.txt_interact = L_WordsTpl:getValue("ui_homefurniture_shop_type_01")
      self.bind.img_interat = "HomeFurnitureShop/tex_home_furniture_shop_icon_exchange_01.png"
    end
  end
end

function this:checkRefreshTime(tpl)
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local refreshType = goodsTpl:getRefreshType(tpl)
  if refreshType == 1 then
    self:closeRefreshGoods()
    self.bind.timeRefresh = false
  else
    self.bind.timeRefresh = true
    self:openRefreshGoods()
  end
end

function this:openRefreshGoods()
  if self.goodsRefreshTimer then
    self:closeRefreshGoods()
  end
  local endTime = self.bind.deadTime
  self.bind.timeRefresh = true
  if string.isEmpty(endTime) then
    self.bind.timeRefresh = false
    return
  end
  local frequency = 1
  local shopId = self.bind.curShopId
  
  local function _run()
    local tempEndTime = self.bind.deadTime
    self.bind.txt_refreshTime = L_TimeUtil.getLeftTimeString(tempEndTime)
    if tempEndTime and tempEndTime < L_TimeUtil.getServerTime() then
      self:closeRefreshGoods()
      self.bind.timeRefresh = false
    end
  end
  
  self.bind.txt_refreshTime = L_TimeUtil.getLeftTimeString(endTime)
  if endTime and endTime >= L_TimeUtil.getServerTime() then
    self.goodsRefreshTimer = Timer.repeated(frequency, _run)
  end
end

function this:refreshMoney()
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local tpl = goodsTpl:getTplById(self.bind.goodsId)
  local currency = goodsTpl:getCurrencyNum(tpl)
  if currency <= 0 then
    self.bind.go_currencyImg = false
    self.bind.txt_cost = L_GameTpl:getWordsTpl():getTplById("npc_shop_free")
  else
    local currencyId = goodsTpl:getCurrencyId(tpl)
    self.bind.go_currencyImg = true
    print("====================currencyID", currencyId)
    self.bind.img_currency = L_ItemTplManager:getCurrencyItem(currencyId).icon
    self.bind.txt_cost = tostring(currency)
  end
end

function this:closeRefreshGoods()
  if self.goodsRefreshTimer == nil then
    return
  end
  self.goodsRefreshTimer:destroy()
  self.goodsRefreshTimer = nil
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
