local this = class("pageHomeFurnitureShop", G_UIPageBase)
local _homeLevelShowTpl = L_GameTpl:getHomeLevelShowTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
local homeDormFurnitureRecommendTpl = L_GameTpl:gethomeDormFurnitureRecommendTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _heroTpl = L_GameTpl.getHeroTpl()
local EHeroState = {
  canExchange = 1,
  notInDorm = 2,
  cannotExchange = 3
}

function this.bind()
  return {
    listHeroHeads = {
      moduleName = "pages/home/homeFurniture/cellFurnitureHead"
    },
    list_recommendLong = {
      moduleName = "pages/home/homeFurniture/cellRecommendLong"
    },
    list_recommendShort = {
      moduleName = "pages/home/homeFurniture/cellRecommendShort"
    },
    goodList = {
      moduleName = "pages/home/homeFurniture/cellFurnitureShopItemDetail"
    },
    moduleRecPrice = {
      moduleName = "pages/home/homeFurniture/modulePrice"
    },
    go_normal = false,
    go_recommend = false,
    go_Exchange = false,
    img_recommendBg = ""
  }
end

function this.methods()
  return {
    onClickRecommend = function(self)
      print("=====================切换推荐页")
      self.bindComponents.moduleRecommend:Play("anim_furnitureshop_in1")
      self:getAudio()
      self.bRecommendState = true
      self:refreshPageStateRelatedUI()
      self.selHeroIndex = -1
      for i = 1, #self.bind.listHeroHeads do
        self.bind.listHeroHeads:change(i, {
          selIndex = self.selHeroIndex
        })
      end
    end,
    onClickAllExchange = function(self)
      print("=====================全部兑换")
      self.allExchangeItem = {}
      local totalPrice = 0
      local currencyId = 0
      for _, v in pairs(self.heroGoodsMap[self.heroIDs[self.selHeroIndex].id]) do
        if v.soldOutMask == false then
          local tpl = _goodsTpl:getTplById(v.goodsId)
          local currency = _goodsTpl:getCurrencyNum(tpl)
          currencyId = _goodsTpl:getCurrencyId(tpl)
          totalPrice = totalPrice + currency
          table.insert(self.allExchangeItem, {
            itemType = L_Const.resType.commonItem,
            itemId = v.itemId,
            quality = v.quality,
            itemNumTxt = tostring(v.stockNum),
            slotId = v.slotId
          })
        end
      end
      local icon = L_ItemTplManager:getCurrencyItem(currencyId).icon
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_homefurniture_shop_allbuy"),
        itemList = self.allExchangeItem,
        txtBottomSubContent = string.format(L_WordsTpl:getValue("notice_homefurniture_shop_allbuy", {
          [0] = "<p=%s w=25 h=25/>",
          [1] = totalPrice
        }), icon),
        totalPrice = totalPrice,
        currencyId = currencyId,
        confirmCallback = function()
          local res = {}
          for key, value in ipairs(self.allExchangeItem) do
            table.insert(res, {
              slot_id = value.slotId,
              times = 1,
              sign = L_ShopStore:getEndTime(210000)
            })
          end
          L_ShopManager:buyGoods({items = res}, function()
            L_UI:close("pageAllExchangeTip")
          end)
        end
      }
      L_UI:open("pageAllExchangeTip", data)
    end,
    listHeroHeads = {
      onClick = function(self, index)
        self:clickAudio()
        if self.bRecommendState == true then
          self.bindComponents.moduleNormal:Play("anim_furnitureshop_list_in1")
          self.bRecommendState = false
        end
        for i = 1, #self.bind.listHeroHeads do
          self.bind.listHeroHeads:change(i, {selIndex = index})
        end
        self.selHeroIndex = index
        self:refreshPageStateRelatedUI()
        local targetCell = self.bind.goodList:getItemCls(1)
        if targetCell and targetCell.gameObject then
          local targetRectTransform = targetCell.gameObject.transform
          self.bindComponents.goodsItems:ScrollTo(targetRectTransform)
        end
      end
    },
    list_recommendLong = {
      onClick = function(self, data)
        L_UI:open("pageFurnitureShopTip", {
          goodsId = data.goodsId,
          slotId = data.slotId,
          owned = data.isOwned
        })
      end
    },
    list_recommendShort = {
      onClick = function(self, data)
        L_UI:open("pageFurnitureShopTip", {
          goodsId = data.goodsId,
          slotId = data.slotId,
          owned = data.isOwned
        })
      end
    }
  }
end

function this:preOpen(options)
  self.audioOpen = false
  self.isausio = false
  self.shopID = options.shopID
  self.selHeroIndex = -1
  L_ShopStore:listenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange, self)
end

function this:clickAudio()
  for i = 1, 6 do
    local str = tostring(i)
    L_TimerManager:newOrResetTimer(self, "audios" .. str, function()
      C_AudioManager.Play("Play_SFX_System_UI_DormShop_Cell")
    end, 0.066 * i)
  end
end

function this:open(options)
  self.bRecommendState = true
  self.recommendData = homeDormFurnitureRecommendTpl:getCurRecommendData()
  if self.recommendData and #self.recommendData > 0 then
    self.recommondHeroID = homeDormFurnitureRecommendTpl:getTplById(self.recommendData[1].key).param
  else
    self.recommondHeroID = -1
  end
  self:initFurnitureGoodsData()
  self:initHeadData()
  self:refreshPageStateRelatedUI()
  if self.bRecommendState then
    self.bindComponents.pageHomeFurnitureShop:Play("anim_furnitureshop_in")
    C_AudioManager.Play("Play_SFX_System_UI_DormShop_Menu_Open_107002")
  else
    self.bindComponents.pageHomeFurnitureShop:Play("anim_furnitureshop_list_in")
  end
end

function this:close(options)
  L_ShopStore:unListenCallFunc(L_ShopStore.event.refreshStock, self.onEvent_refreshStock)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshDayChange)
end

function this:refreshPageStateRelatedUI()
  if self.bRecommendState then
    self.bind.go_normal = false
    self.bind.go_recommend = true
    self.bCheckInDorm = false
    self:refreshRecommendUI()
  else
    self.bind.go_normal = true
    self.bind.go_recommend = false
    self:refreshNormalUI()
  end
end

function this:initHeadData()
  local AllheroIDs = homeDormFurnitureTpl:getHeroIDs()
  self.heroIDs = {}
  for key, value in ipairs(AllheroIDs) do
    local tpl_hero = _heroTpl:getTplById(value)
    local heroRarity = _heroTpl:getRarity(tpl_hero)
    local heroFavorLv = 0
    if L_HeroStore:getHasHero(value) then
      heroFavorLv = L_HeroStore:getHeroFavorAbilityLevel(L_HeroStore:getHero(L_HeroStore:getGuidByConfigId(value)))
    end
    table.insert(self.heroIDs, {
      id = value,
      state = self:getHeroState(value),
      heroFavorLv = heroFavorLv,
      heroRarity = heroRarity,
      ownNum = math.floor(self:getOwnNum(value)),
      allNum = #self.heroGoodsMap[value]
    })
  end
  table.sort(self.heroIDs, function(a, b)
    if a.state ~= b.state then
      return a.state < b.state
    end
    if a.heroFavorLv ~= b.heroFavorLv then
      return a.heroFavorLv > b.heroFavorLv
    end
    if a.heroRarity ~= b.heroRarity then
      return a.heroRarity > b.heroRarity
    end
    if a.id ~= b.id then
      return a.id < b.id
    end
  end)
  for key, value in ipairs(self.heroIDs) do
    value.index = key
    value.selIndex = self.selHeroIndex
  end
  self.bind.listHeroHeads:clear()
  self.bind.listHeroHeads:insert_array(self.heroIDs)
end

function this:getHeroState(value)
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  local bInDorm = csHomeStore:OnCheckPlayerIsInDormById(value)
  local state = EHeroState.canExchange
  local remainCanExchangeNum = 0
  for k, v in ipairs(self.heroGoodsMap[value]) do
    if v.soldOutMask == false then
      remainCanExchangeNum = remainCanExchangeNum + 1
    end
  end
  if remainCanExchangeNum == 0 then
    if not bInDorm then
      state = EHeroState.notInDorm
    else
      state = EHeroState.cannotExchange
    end
  end
  return state
end

function this:refreshRecommendUI()
  print("==========================refresh recommend")
  if self.recommendData == nil or #self.recommendData == 0 then
    return
  end
  self.bind.img_recommendBg = homeDormFurnitureRecommendTpl:getTplById(self.recommendData[1].key).pic
  local list1 = {}
  table.insert(list1, {
    goodsId = homeDormFurnitureRecommendTpl:getTplById(self.recommendData[2].key).param,
    isOwned = self:isOwned(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[2].key).param),
    price = self:getPrice(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[2].key).param),
    slotId = self:getSlotID(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[2].key).param)
  })
  local list2 = {}
  table.insert(list2, {
    goodsId = homeDormFurnitureRecommendTpl:getTplById(self.recommendData[3].key).param,
    isOwned = self:isOwned(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[3].key).param),
    price = self:getPrice(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[3].key).param),
    slotId = self:getSlotID(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[3].key).param)
  })
  table.insert(list2, {
    goodsId = homeDormFurnitureRecommendTpl:getTplById(self.recommendData[4].key).param,
    isOwned = self:isOwned(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[4].key).param),
    price = self:getPrice(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[4].key).param),
    slotId = self:getSlotID(homeDormFurnitureRecommendTpl:getTplById(self.recommendData[4].key).param)
  })
  self.bind.list_recommendLong:clear()
  self.bind.list_recommendLong:insert_array(list1)
  self.bind.list_recommendShort:clear()
  self.bind.list_recommendShort:insert_array(list2)
  local bJump = self:getRecRemainNumbyHeroID(self.recommondHeroID) ~= 0
  self.modules.moduleRecPrice:setData({
    bJump = bJump,
    txt = bJump == true and L_WordsTpl:getValue("residual_code_pagehomefurnitureshop_01") or "已全部兑换",
    imgCurrency = L_ItemTplManager:getCurrencyItem(2).icon
  }, function()
    self:clickAudio()
    self.bindComponents.moduleNormal:Play("anim_furnitureshop_list_in1")
    for key, value in pairs(self.heroIDs) do
      if value.id == self.recommondHeroID then
        self.bRecommendState = false
        for i = 1, #self.bind.listHeroHeads do
          self.bind.listHeroHeads:change(i, {selIndex = key})
        end
        self.selHeroIndex = key
        self:refreshPageStateRelatedUI()
        break
      end
    end
  end)
end

function this:refreshNormalUI()
  print("==========================refresh normal ")
  self.GoodsData = self.heroGoodsMap[self.heroIDs[self.selHeroIndex].id]
  table.sort(self.GoodsData, function(a, b)
    if a.stockNum ~= b.stockNum then
      return a.stockNum > b.stockNum
    end
    if a.order ~= b.order then
      return a.order > b.order
    end
    if a.itemId ~= b.itemId then
      return a.itemId > b.itemId
    end
  end)
  for key, value in ipairs(self.GoodsData) do
    value.index = key
  end
  self.bind.goodList:clear()
  self.bind.goodList:insert_array(self.GoodsData)
  self:refreshAllSoldUI()
end

function this:refreshAllSoldUI()
  local remainNum = self:getRemainNum(self.heroIDs[self.selHeroIndex].id)
  print("========================================remainNum", remainNum)
  if remainNum == 0 then
    self.bind.go_Exchange = false
  else
    self.bind.go_Exchange = true
  end
end

function this:initFurnitureGoodsData()
  self.heroGoodsMap = {}
  local List = L_ShopStore:getGoodsList(self.shopID)
  for _, v in pairs(List) do
    local goodsId = v.goodsId
    local tpl = _goodsTpl:getTplById(goodsId)
    local condition = true
    condition = L_ConditionManager:isComplete(_goodsTpl:getCommonCondition(tpl))
    local itemType = _goodsTpl:getItem(tpl)[1][1]
    local itemId = _goodsTpl:getItem(tpl)[1][2]
    local item = L_ItemTplManager:getItemConfig(itemType, itemId)
    local order = _goodsTpl:getOrder(tpl)
    local stockNum = L_ShopStore:getStock(self.shopID, v.slotId)
    local stockText = L_Lang:get(_goodsTpl:getLimitTxt(tpl), {
      [0] = stockNum
    })
    local heroId = homeDormFurnitureTpl:getTplById(itemId).heroId
    if self.heroGoodsMap[heroId] == nil then
      self.heroGoodsMap[heroId] = {}
    end
    table.insert(self.heroGoodsMap[heroId], {
      itemType = L_Const.resType.goods,
      goodsId = goodsId,
      itemId = itemId,
      quality = _commonItemTpl:getRarity(_commonItemTpl:getTplById(itemId)),
      parseData = item,
      slotId = v.slotId,
      curShopId = self.shopID,
      txt_name = _goodsTpl:getGoodsName(tpl),
      go_new = false,
      stockText = stockText,
      stock_box = L_ShopStore:getIsLimitGoods(self.shopID, v.slotId),
      soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.shopID, v.slotId),
      goodsData = v,
      lockActive = not condition,
      stockNum = stockNum,
      deadTime = v.deadTime,
      order = order,
      interact = homeDormFurnitureTpl:getTplById(itemId).type,
      bFurniture = true
    })
  end
end

function this:onEvent_refreshStock(entity)
  if not entity then
    return
  end
  self:updateFurnitureGoodsData(entity)
  for i = 1, #self.bind.listHeroHeads do
    self.bind.listHeroHeads:change(i, {
      ownNum = self:getOwnNum(self.heroIDs[i].id),
      state = self:getHeroState(self.heroIDs[i].id)
    })
  end
  for k1, v1 in pairs(self.heroGoodsMap) do
    for k2, v2 in ipairs(v1) do
      if entity.slotId == v2.slotId then
        v2.soldOutMask = true
        v2.stockNum = 0
      end
    end
  end
  if self.bRecommendState then
    self:refreshRecommendUI()
  else
    self:refreshAllSoldUI()
  end
end

function this:onEvent_refreshDayChange()
end

function this:updateFurnitureGoodsData(entity)
  for i, goods in pairs(self.modules.goodList) do
    local needUpdate = false
    if goods.bind.slotId == entity.slotId then
      needUpdate = true
      local stockNum = L_ShopStore:getStock(self.shopID, goods.bind.slotId)
      if stockNum <= 0 then
        goods.bind.deadTime = entity.deadTime
      end
      local tpl = _goodsTpl:getTplById(goods.bind.goodsId)
      local stockText = L_Lang:get(_goodsTpl:getLimitTxt(tpl), {
        [0] = stockNum
      })
      goods.bind.stockNum = stockNum
      goods.bind.stockText = stockText
      local condition = true
      condition = L_ConditionManager:isComplete(_goodsTpl:getCommonCondition(tpl))
      if goods.bind.lockActive and condition then
        needUpdate = true
      end
      goods.bind.lockActive = not condition
      goods.bind.soldOutMask = stockNum <= 0 and L_ShopStore:getIsLimitGoods(self.shopID, goods.bind.slotId)
    end
    if needUpdate then
      goods:refreshView()
    end
  end
end

function this:getRecRemainNumbyHeroID(heroid)
  local goodslist = {
    homeDormFurnitureRecommendTpl:getTplById(self.recommendData[2].key).param,
    homeDormFurnitureRecommendTpl:getTplById(self.recommendData[3].key).param,
    homeDormFurnitureRecommendTpl:getTplById(self.recommendData[4].key).param
  }
  local remainCanExchangeNum = 0
  for k, v in ipairs(self.heroGoodsMap[heroid]) do
    if v.soldOutMask == false then
      remainCanExchangeNum = remainCanExchangeNum + 1
    end
  end
  return remainCanExchangeNum
end

function this:getRemainNum(heroid)
  local Num = 0
  for k, v in ipairs(self.heroGoodsMap[heroid]) do
    if v.soldOutMask == false then
      Num = Num + 1
    end
  end
  return Num
end

function this:getOwnNum(heroid)
  local Num = 0
  for k, v in ipairs(self.heroGoodsMap[heroid]) do
    if v.soldOutMask == true then
      Num = Num + 1
    end
  end
  return Num
end

function this:isOwned(goodsId)
  for k1, v1 in pairs(self.heroGoodsMap) do
    for k2, v2 in ipairs(v1) do
      if goodsId == v2.goodsId then
        return v2.soldOutMask == true
      end
    end
  end
  return false
end

function this:getPrice(goodsId)
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local tpl = goodsTpl:getTplById(goodsId)
  local currency = goodsTpl:getCurrencyNum(tpl)
  local res = ""
  if currency <= 0 then
    res = L_GameTpl:getWordsTpl():getTplById("npc_shop_free")
  else
    res = tostring(currency)
  end
  return res
end

function this:getSlotID(goodsId)
  for k1, v1 in pairs(self.heroGoodsMap) do
    for k2, v2 in ipairs(v1) do
      if goodsId == v2.goodsId then
        return v2.slotId
      end
    end
  end
end

function this:getAudio()
  if self.audioOpen == false then
    self.audioOpen = true
    C_AudioManager.Play("Play_SFX_System_UI_DormShop_Menu_Switch_107002", nil, function()
    end)
    self:newOrResetTimer("audios", function()
      self.audioOpen = false
    end, 1.67)
  end
end

return this
