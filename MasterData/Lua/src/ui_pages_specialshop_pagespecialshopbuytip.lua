local page = class("pageSpecialShopBuyTip", G_UIPageBase)
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _goodsPurchaseTpl = L_GameTpl:getGoodsPurchaseTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
end

function page.bind()
  return {
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    active_item = false,
    active_selectNum = false,
    active_selectNumMobile = false,
    module_selectNum = {
      moduleName = "modulePages/moduleSelectNum"
    },
    module_selectNumModule = {
      moduleName = "modulePages/moduleSelectNum"
    },
    active_itemBtnBuy = false,
    active_itemBtnBuyMobile = false,
    module_itemBtnBuy = L_Const.ModuleInfo.ModuleBtn,
    module_itemBtnBuyMobile = L_Const.ModuleInfo.ModuleBtn,
    txt_goodsDes = "",
    active_gift = false,
    txt_giftTitle = "",
    active_giftBtnBuy = false,
    module_giftBtnBuy = {
      moduleName = "modulePages/moduleButtonSingle"
    },
    scrollList_goods = L_Const.ModuleInfo.CellIconBag,
    active_txt_oldPrice = false,
    txt_oldPrice = "",
    active_lockedBtn = false,
    txt_unlockTips = "",
    active_soldOutBtn = false,
    active_leftTime = false,
    txt_leftTime = "",
    txt_itemNum = "",
    active_icon = false,
    img_itemIcon = "",
    active_rect_Pet = false,
    img_petIcon = nil,
    active_rect_hero = false,
    img_texIconHeroL = nil,
    specialTipsActive = false,
    txt_specialTips = "",
    active_limitNode = false,
    txt_limitTips = "",
    txt_firstName = "",
    txt_leftName = "",
    active_qualityEft_5 = false,
    active_qualityEft_4 = false,
    active_qualityEft_3 = false,
    active_qualityEft_2 = false,
    active_qualityEft_1 = false
  }
end

function page.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end,
    onClickBg = function(self)
      L_UI:close(self.pageName)
    end,
    onClickItem = function(self)
      self:OnBtnItem()
    end,
    onClickPetIcon = function(self)
      self:OnBtnItem()
    end,
    onClickHeroIcon = function(self)
      self:OnBtnItem()
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.isPc = L_DeviceTpl:getIsPc()
  self.itemData = options.cellData
  self.resBarItemTplIdList = options.cellData.resBarItemTplIdList
  self.isPurchase = self.itemData.isPurchase == true
  if self.isPurchase then
    self.goodsCfg = _goodsPurchaseTpl:getTplById(self.itemData.goodsId)
    self.itemType = _goodsPurchaseTpl:getItem(self.goodsCfg)[1][1]
    self.itemId = _goodsPurchaseTpl:getItem(self.goodsCfg)[1][2]
    self.currencyType = L_Const.resType.currency
    self.currencyId = L_Const.currencyType.trueCash
    self.costIdValid = false
  else
    self.goodsCfg = _goodsTpl:getTplById(self.itemData.goodsId)
    self.itemType = _goodsTpl:getItemType(self.goodsCfg)
    self.itemId = _goodsTpl:getItemId(self.goodsCfg)
    local costId = _goodsTpl:getCostId(self.goodsCfg)
    if not costId or table.isEmpty(costId) or #costId ~= 1 then
      self.currencyType = 0
      self.currencyId = 0
      self.costIdValid = false
    else
      self.currencyType = _goodsTpl:getCurrencyType(self.goodsCfg)
      self.currencyId = _goodsTpl:getCurrencyId(self.goodsCfg)
      self.costIdValid = true
    end
  end
  self:init()
end

function page:getGoodsTpl()
  return self.isPurchase and _goodsPurchaseTpl or _goodsTpl
end

function page:getPrice()
  if self.isPurchase then
    return _goodsPurchaseTpl:getCostNum(self.goodsCfg)
  end
  if not self.costIdValid then
    return 0
  end
  return _goodsTpl:getCurrencyNum(self.goodsCfg)
end

function page:checkIsGift()
  if self.itemType ~= L_Const.resType.commonItem then
    return false
  end
  local commonItemCfg = _commonItemTpl:getTplById(self.itemId)
  return L_DataUtil.parseRewardConfig(_commonItemTpl:getGiftBagReward(commonItemCfg))
end

function page:init()
  self:initCurrencyList()
  local goodsInfo = self:checkIsGift()
  if goodsInfo and not table.isEmpty(goodsInfo) then
    self:initGiftInfo(goodsInfo)
  else
    self:initItemInfo()
  end
  self:initCommonInfo()
end

function page:initCurrencyList()
  if self.resBarItemTplIdList then
    self.modules.module_currency:refreshResByResBarTplIdList(self.resBarItemTplIdList)
    return
  end
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.specialShop)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function page:getMaxNum()
  if self.isPurchase then
    return 1
  end
  local max1 = self.itemData.stockNum
  local price = self:getPrice()
  if price <= 0 then
    return max1
  end
  local itemNum = L_ItemTplManager:getItemNum(self.currencyType, self.currencyId)
  local max2 = math.floor(itemNum / price)
  if max2 < 1 then
    max2 = 1
  end
  return math.min(max1, max2)
end

function page:initItemInfo()
  self.bind.active_gift = false
  self.bind.active_item = true
  self.bind.txt_goodsDes = self:getGoodsTpl():getGoodsDesc(self.goodsCfg)
  local showBtnBuy = not self.itemData.soldOutMask and not self.itemData.lockActive
  self.bind.active_itemBtnBuy = showBtnBuy and self.isPc
  self.bind.active_itemBtnBuyMobile = showBtnBuy and not self.isPc
  self.bind.active_selectNum = showBtnBuy and self.isPc and not self.isPurchase
  self.bind.active_selectNumMobile = showBtnBuy and not self.isPc and not self.isPurchase
  if not showBtnBuy then
    return
  end
  
  local function callBack(num)
    self.curBuyNum = num
    if self.isPc then
      self.modules.module_itemBtnBuy:setData({
        txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
        callback = function()
          self:OnBtnBuyCallBack()
        end,
        itemNumTxt = tostring(self.curBuyNum * self:getPrice()),
        itemType = self.currencyType,
        itemId = self.currencyId,
        itemNum = num * self:getPrice()
      })
    else
      self.modules.module_itemBtnBuyMobile:setData({
        txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
        callback = function()
          self:OnBtnBuyCallBack()
        end,
        itemNumTxt = tostring(self.curBuyNum * self:getPrice()),
        itemType = self.currencyType,
        itemId = self.currencyId,
        itemNum = num * self:getPrice()
      })
    end
  end
  
  self.curBuyNum = 1
  if self.isPc then
    self.modules.module_selectNum:initModule(callBack, self:getMaxNum(), 1, 1)
    self.modules.module_itemBtnBuy:setData({
      txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
      callback = function()
        self:OnBtnBuyCallBack()
      end,
      itemNumTxt = tostring(self.curBuyNum * self:getPrice()),
      itemType = self.currencyType,
      itemId = self.currencyId,
      itemNum = self.curBuyNum * self:getPrice()
    })
  else
    self.modules.module_selectNumModule:initModule(callBack, self:getMaxNum(), 1, 1)
    self.modules.module_itemBtnBuyMobile:setData({
      txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
      callback = function()
        self:OnBtnBuyCallBack()
      end,
      itemNumTxt = tostring(self.curBuyNum * self:getPrice()),
      itemType = self.currencyType,
      itemId = self.currencyId,
      itemNum = self.curBuyNum * self:getPrice()
    })
  end
end

function page:OnBtnBuyCallBack()
  if self.isPurchase then
    local param = {
      productId = self.itemData.goodsId,
      times = 1
    }
    L_MoneyShopStore:req_purchaseCashItem(param, function(success)
      if success then
        L_UI:close(self.pageName)
      end
    end)
    return
  end
  local consumeNum = self.curBuyNum * self:getPrice()
  local hasNum = L_ItemTplManager:getItemNum(self.currencyType, self.currencyId)
  if consumeNum > hasNum then
    local itemInfo = L_ItemTplManager:getItemConfig(self.currencyType, self.currencyId)
    L_FlyMsgManager:showNormalMsgByKey("notice_pageSpecialShopBuyTip_03", {
      [0] = itemInfo.name
    })
    return
  end
  
  local function buyFunc()
    local sign = L_ShopStore:getEndTime(self.itemData.curShopId)
    if sign == nil then
      return
    end
    local data = {
      slot_id = self.itemData.slotId,
      times = self.curBuyNum,
      sign = sign
    }
    L_ShopManager:buyGoods({
      items = {data}
    }, function()
      L_UI:close(self.pageName)
    end)
  end
  
  local isHeroMaxStar, heroName = self:checkHeroMaxStar()
  if isHeroMaxStar then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_01", {
        [0] = heroName
      }),
      confirmCallback = function()
        buyFunc()
      end
    })
    return
  end
  buyFunc()
end

function page:checkHeroMaxStar()
  if self.itemType ~= L_Const.resType.hero then
    return false
  end
  local curHeroStar = 0
  if L_HeroStore:getHasHero(self.itemId) then
    local heroGuid = L_HeroStore:getGuidByConfigId(self.itemId)
    local hero = L_HeroStore:getHero(heroGuid, false)
    curHeroStar = L_HeroStore:getHeroStar(hero)
  end
  local heroGradeUpCfg = _heroTpl:getGradeUpItem(self.itemId, curHeroStar)
  local hasNum = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, heroGradeUpCfg[1])
  if math.floor(hasNum / heroGradeUpCfg[2]) + curHeroStar >= L_GameTpl:getGameConstTpl():getData("HERO_MAX_GRADE", L_Const.GameTplType.int) then
    local heroCfg = _heroTpl:getTplById(self.itemId)
    return true, _heroTpl:getName(heroCfg)
  end
  return false
end

function page:initGiftInfo(goodsInfo)
  self.bind.active_gift = true
  self.bind.active_item = false
  self.bind.txt_giftTitle = self:getGoodsTpl():getGoodsDesc(self.goodsCfg)
  local temp = {}
  for _, v in ipairs(goodsInfo) do
    table.insert(temp, {
      itemId = v.itemId,
      itemNum = v.itemNum,
      itemType = v.itemType
    })
  end
  self.bind.scrollList_goods:clear()
  self.bind.scrollList_goods:insert_array(temp)
  local showBtnBuy = not self.itemData.soldOutMask and not self.itemData.lockActive
  self.bind.active_giftBtnBuy = showBtnBuy
  if not showBtnBuy then
    return
  end
  self.curBuyNum = 1
  local price = self.curBuyNum * self:getPrice()
  local txtName = price == 0 and L_WordsTpl:getValue("免费获取") or L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02")
  if self.isPurchase then
  end
  local params = {
    txtNum = price,
    itemType = self.currencyType,
    itemId = self.currencyId,
    showIcon = nil
  }
  self.modules.module_giftBtnBuy:setData(txtName, function()
    self:OnBtnBuyCallBack()
  end, params)
  local specialPrice = self:getGoodsTpl():getSpecialPrice(self.goodsCfg)
  if math.isEmpty(specialPrice) then
    self.bind.active_txt_oldPrice = false
  else
    self.bind.active_txt_oldPrice = true
    self.bind.txt_oldPrice = tostring(specialPrice)
  end
end

function page:initCommonInfo()
  self.bind.active_soldOutBtn = self.itemData.soldOutMask
  self.bind.active_lockedBtn = self.itemData.lockActive
  if self.itemData.lockActive then
    local unlockDesc = self:getGoodsTpl():getUnlockDesc(self.goodsCfg)
    if type(unlockDesc) == "table" then
      if 0 < #unlockDesc then
        self.bind.txt_unlockTips = L_Config:provider(unlockDesc[1])
      else
        self.bind.txt_unlockTips = ""
      end
    else
      self.bind.txt_unlockTips = unlockDesc or ""
    end
  end
  local goodsName = self:getGoodsTpl():getGoodsName(self.goodsCfg)
  self.bind.txt_firstName = string.sub(goodsName, 1, utf8.offset(goodsName, 2) - 1)
  self.bind.txt_leftName = string.sub(goodsName, utf8.offset(goodsName, 2))
  local itemNum = L_ItemTplManager:getItemNum(self.itemType, self.itemId)
  self.bind.txt_itemNum = tostring(itemNum)
  self:setTargetItemIconByItemTypeAndGoodsCfg(self.itemType, self.goodsCfg, self.itemId)
  local specialTips = self:getGoodsTpl():getSpecialTips(self.goodsCfg)
  if not string.isEmpty(specialTips) then
    self.bind.specialTipsActive = true
    self.bind.txt_specialTips = specialTips
  else
    self.bind.specialTipsActive = false
  end
  local limitTxt = self:getGoodsTpl():getLimitTxt(self.goodsCfg)
  if not string.isEmpty(limitTxt) then
    self.bind.active_limitNode = true
    self.bind.txt_limitTips = L_Lang:get(limitTxt, {
      [0] = self.itemData.stockNum
    })
  else
    self.bind.active_limitNode = false
  end
  local itemInfo = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  itemInfo.quality = itemInfo.quality or 0
  for i = 1, 5 do
    self.bind[string.format("active_qualityEft_%d", i)] = itemInfo.quality + 1 == i
  end
end

function page:setTargetItemIconByItemTypeAndGoodsCfg(itemType, goodsCfg, itemId)
  self.bind.active_icon = false
  self.bind.active_rect_Pet = false
  self.bind.active_rect_hero = false
  if itemType == L_Const.resType.pet then
    self.bind.active_rect_Pet = true
    self.bind.img_petIcon = self:getGoodsTpl():getIcon(goodsCfg)
  elseif itemType == L_Const.resType.hero then
    self.bind.active_rect_hero = true
    local heroConfigId = self:getGoodsTpl():getItemId(goodsCfg)
    self.bind.img_texIconHeroL = L_GameUtil.getAvatarTexturePath(heroConfigId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.large)
  elseif itemType == L_Const.resType.soulEssence then
    self.bind.active_icon = true
    local tpl = _soulessenceTpl:getTplById(itemId)
    self.bind.img_itemIcon = _soulessenceTpl:getAvatarTexture(tpl, 1)
  else
    self.bind.active_icon = true
    self.bind.img_itemIcon = self:getGoodsTpl():getIcon(self.goodsCfg)
  end
end

function page:checkRefreshTime(tpl)
  local refreshType = self:getGoodsTpl():getRefreshType(tpl)
  if refreshType == 1 then
    self:closeRefreshGoods()
    self.bind.active_leftTime = false
  else
    self:openRefreshGoods()
  end
end

function page:openRefreshGoods()
  if self.goodsRefreshTimer then
    self:closeRefreshGoods()
  end
  local endTime = self.itemData.deadTime
  if math.isEmpty(endTime) or endTime <= 0 then
    self.bind.active_leftTime = false
    return
  end
  local frequency = 1
  
  local function _run()
    self.bind.txt_leftTime = L_TimeUtil.getLeftTimeString(self.itemData.deadTime)
    if self.itemData.deadTime < L_TimeUtil.getServerTime() then
      self:closeRefreshGoods()
      self.bind.active_leftTime = false
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
      L_UI:close(self.pageName)
    end
  end
  
  self.bind.txt_leftTime = L_TimeUtil.getLeftTimeString(endTime)
  if endTime and endTime >= L_TimeUtil.getServerTime() then
    self.goodsRefreshTimer = Timer.repeated(frequency, _run)
    self.bind.active_leftTime = true
  else
    self.bind.active_leftTime = false
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
    L_UI:close(self.pageName)
  end
end

function page:closeRefreshGoods()
  if self.goodsRefreshTimer == nil then
    return
  end
  self.goodsRefreshTimer:destroy()
  self.goodsRefreshTimer = nil
end

function page:OnBtnItem()
  if self.itemType == L_Const.resType.hero then
    local entityId = self.itemId
    local list = {}
    table.insert(list, entityId)
    L_UI:open("pageHero", {
      heroIdList = list,
      pageType = L_Const.heroPageType.PreviewMode
    })
    return
  end
  if self.itemType == L_Const.resType.soulEssence then
    local entityId = self.itemId
    local list = {}
    table.insert(list, entityId)
    L_UI:open("pageSoulEssencelPreview", {
      heroGuid = entityId,
      soulEssenceGuid = entityId,
      pageType = L_Const.heroPageType.SpritronPreviewMode
    })
    return
  end
  L_ItemTplManager:showInfoTip(self.itemType, self.itemId)
end

function page:close(options)
  page.super.close(self, options)
  self:closeRefreshGoods()
end

return page
