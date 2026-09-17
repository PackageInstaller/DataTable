local page = class("pageEntrurstShopBuyTip", G_UIPageBase)
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
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
    module_selectNum = {
      moduleName = "modulePages/moduleSelectNum"
    },
    active_itemBtnBuy = false,
    module_itemBtnBuy = L_Const.ModuleInfo.ModuleBtn,
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
  self.itemData = options.cellData
  self.resBarItemTplIdList = options.cellData.resBarItemTplIdList
  self.goodsCfg = _goodsTpl:getTplById(self.itemData.goodsId)
  self.itemType = _goodsTpl:getItemType(self.goodsCfg)
  self.itemId = _goodsTpl:getItemId(self.goodsCfg)
  self.currencyType = _goodsTpl:getCurrencyType(self.goodsCfg)
  self.currencyId = _goodsTpl:getCurrencyId(self.goodsCfg)
  self:init()
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
  local max1 = self.itemData.stockNum
  local price = _goodsTpl:getCurrencyNum(self.goodsCfg)
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
  self.bind.txt_goodsDes = _goodsTpl:getGoodsDesc(self.goodsCfg)
  local showBtnBuy = not self.itemData.soldOutMask and not self.itemData.lockActive
  self.bind.active_itemBtnBuy = showBtnBuy
  self.bind.active_selectNum = showBtnBuy
  if not showBtnBuy then
    return
  end
  
  local function callBack(num)
    self.curBuyNum = num
    self.modules.module_itemBtnBuy:setData({
      txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
      callback = function()
        self:OnBtnBuyCallBack()
      end,
      itemNumTxt = tostring(self.curBuyNum * _goodsTpl:getCurrencyNum(self.goodsCfg)),
      itemType = self.currencyType,
      itemId = self.currencyId
    })
  end
  
  self.curBuyNum = 1
  self.modules.module_selectNum:initModule(callBack, self:getMaxNum(), 1, 1)
  self.modules.module_itemBtnBuy:setData({
    txtName = L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"),
    callback = function()
      self:OnBtnBuyCallBack()
    end,
    itemNumTxt = tostring(self.curBuyNum * _goodsTpl:getCurrencyNum(self.goodsCfg)),
    itemType = self.currencyType,
    itemId = self.currencyId
  })
end

function page:OnBtnBuyCallBack()
  local consumeNum = self.curBuyNum * _goodsTpl:getCurrencyNum(self.goodsCfg)
  local hasNum = L_ItemTplManager:getItemNum(self.currencyType, self.currencyId)
  if consumeNum > hasNum then
    local itemInfo = L_ItemTplManager:getItemConfig(self.currencyType, self.currencyId)
    L_FlyMsgManager:showNormalMsgByKey("notice_pageSpecialShopBuyTip_03", {
      [0] = itemInfo.name
    })
    return
  end
  
  local function buyFunc()
    local data = {
      slot_id = self.itemData.slotId,
      times = self.curBuyNum,
      sign = L_ShopStore:getEndTime(self.itemData.curShopId)
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
  self.bind.txt_giftTitle = _goodsTpl:getGoodsDesc(self.goodsCfg)
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
  self.modules.module_giftBtnBuy:setData(L_WordsTpl:getValue("notice_pageSpecialShopBuyTip_02"), function()
    self:OnBtnBuyCallBack()
  end, {
    txtNum = self.curBuyNum * _goodsTpl:getCurrencyNum(self.goodsCfg),
    itemType = self.currencyType,
    itemId = self.currencyId
  })
  local specialPrice = _goodsTpl:getSpecialPrice(self.goodsCfg)
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
    self.bind.txt_unlockTips = _goodsTpl:getUnlockDesc(self.goodsCfg)
  end
  local goodsName = _goodsTpl:getGoodsName(self.goodsCfg)
  self.bind.txt_firstName = string.sub(goodsName, 1, utf8.offset(goodsName, 2) - 1)
  self.bind.txt_leftName = string.sub(goodsName, utf8.offset(goodsName, 2))
  local itemNum = L_ItemTplManager:getItemNum(self.itemType, self.itemId)
  self.bind.txt_itemNum = tostring(itemNum)
  self:setTargetItemIconByItemTypeAndGoodsCfg(self.itemType, self.goodsCfg)
  local specialTips = _goodsTpl:getSpecialTips(self.goodsCfg)
  if not string.isEmpty(specialTips) then
    self.bind.specialTipsActive = true
    self.bind.txt_specialTips = specialTips
  else
    self.bind.specialTipsActive = false
  end
  local limitTxt = _goodsTpl:getLimitTxt(self.goodsCfg)
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

function page:setTargetItemIconByItemTypeAndGoodsCfg(itemType, goodsCfg)
  self.bind.active_icon = false
  self.bind.active_rect_Pet = false
  self.bind.active_rect_hero = false
  if itemType == L_Const.resType.pet then
    self.bind.active_rect_Pet = true
    self.bind.img_petIcon = _goodsTpl:getIcon(goodsCfg)
  elseif itemType == L_Const.resType.hero then
    self.bind.active_rect_hero = true
    local heroConfigId = _goodsTpl:getItemId(goodsCfg)
    self.bind.img_texIconHeroL = L_GameUtil.getAvatarTexturePath(heroConfigId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.large)
  else
    self.bind.active_icon = true
    self.bind.img_itemIcon = _goodsTpl:getIcon(self.goodsCfg)
  end
end

function page:checkRefreshTime(tpl)
  local refreshType = _goodsTpl:getRefreshType(tpl)
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
    L_UI:open("pageHero", {
      soulEssenceId = self.itemId,
      heroIdList = list,
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
