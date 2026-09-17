local this = class("pageFurnitureShopTip", G_UIPageBase)
local _homeLevelShowTpl = L_GameTpl:getHomeLevelShowTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local homeDormFurnitureRecommendTpl = L_GameTpl:gethomeDormFurnitureRecommendTpl()
local goodsTpl = L_GameTpl:getGoodsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    txt_limitTime = "",
    txt_favorValue = "",
    img_interat = "",
    txt_interact = "",
    txt_name = "",
    txt_desc = "",
    img_icon = "",
    img_currency = "",
    go_soldout = false,
    go_buy = false,
    list_star = {},
    btn_exchange = L_Const.ModuleInfo.ModuleBtn,
    list_item = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {
    onClickExchange = function(self)
      print("=====================兑换")
    end,
    onclick_closeBg = function(self)
      print("=========================guanbi界面")
      L_UI:close(self.pageName)
    end,
    onclick_close = function(self)
      print("=========================guanbi界面")
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
end

function this:open(options)
  self.goodsId = options.goodsId
  self.slotId = options.slotId
  self.owned = options.owned
  self.buyNum = 1
  local tpl = goodsTpl:getTplById(self.goodsId)
  self.itemType = goodsTpl:getItem(tpl)[1][1]
  self.itemId = goodsTpl:getItem(tpl)[1][2]
  local currencyId = goodsTpl:getCurrencyId(tpl)
  self.bind.img_currency = L_ItemTplManager:getCurrencyItem(currencyId).icon
  local itemConfig = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  print("================homeDormFurnitureTpl:getTplById(self.itemId).shopPic", homeDormFurnitureTpl:getTplById(self.itemId).shopPic)
  self.bind.img_icon = homeDormFurnitureTpl:getTplById(self.itemId).shopPic
  if string.find(homeDormFurnitureTpl:getTplById(self.itemId).shopPic, "tex_home_furniture_shop_bg_buy_01") or string.find(homeDormFurnitureTpl:getTplById(self.itemId).shopPic, "tex_home_furniture_shop_bg_buy_02") then
    self.bindComponents.pageFurnitureShopTip:Play("anim_furnitureshop_tip_in1")
  else
    self.bindComponents.pageFurnitureShopTip:Play("anim_furnitureshop_tip_in")
  end
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.txt_name = _commonItemTpl:getName(commonItemTpl)
  self.bind.txt_desc = goodsTpl:getGoodsDesc(tpl)
  self.bind.txt_favorValue = tostring(homeDormFurnitureTpl:getFurnitureFavor(self.itemId))
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  self:_setStars(starNum)
  self:setInteractUI(homeDormFurnitureTpl:getTplById(self.itemId).type)
  local reward = L_DataUtil.parseRewardConfig(goodsTpl:getItem(tpl))
  self.bind.list_item:clear()
  self.bind.list_item:insert_array(reward)
  local tpl = goodsTpl:getTplById(self.goodsId)
  self.costIds = goodsTpl:getCostId(tpl)[1]
  if self.owned then
    self.bind.go_soldout = true
    self.bind.go_buy = false
  else
    self.bind.go_soldout = false
    self.bind.go_buy = true
    self.modules.btn_exchange:setData({
      txtName = L_WordsTpl:getValue("residual_code_pagefurnitureshoptip_01"),
      callback = function()
        local item = L_ItemTplManager:getItemConfig(self.costIds[1], self.costIds[2])
        if self.buyNum * self.costIds[3] > item.num then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageRogueShopPurchase"))
          return
        end
        local data = {
          slot_id = self.slotId,
          times = self.buyNum,
          sign = L_ShopStore:getEndTime(210000)
        }
        L_ShopManager:buyGoods({
          items = {data}
        }, function()
        end)
        L_UI:close(self.pageName)
      end,
      itemType = self.costIds[1],
      itemId = self.costIds[2],
      itemNum = self.costIds[3]
    })
  end
end

function this:close(options)
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

function this:_setStars(num)
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

return this
