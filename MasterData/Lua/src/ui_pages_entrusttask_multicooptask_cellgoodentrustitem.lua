local module = class("cellGoodEntrustItem", G_UIModuleBase)
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _itemBgPath = "UI/Atlas/ShopPageSpecial/tex_mall_bg_%d.png"
local _heroTpl = L_GameTpl:getHeroTpl()

function module.bind()
  return {
    txt_name = "",
    img_currency = nil,
    currencyActive = true,
    txt_cost = "",
    stockText = "",
    go_item = true,
    itemIcon = "",
    itemBg = "",
    go_rect_pet = false,
    img_pet = "",
    go_rect_hero = false,
    img_texIconHeroM = nil,
    timeRefresh = false,
    txt_refreshTime = "",
    heroStarMask = false,
    soldOutMask = false,
    lockActive = false,
    specialTipsActive = false,
    txt_specialTips = "",
    specialPriceActive = false,
    txt_specialPrice = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      if self.bind.callBack then
        self.bind.callBack(self)
      end
    end
  }
end

function module:refresh()
  self.goodsCfg = _goodsTpl:getTplById(self.bind.goodsId)
  if not self.goodsCfg then
    errorf(string.format("不存在该商品, goodsId = ", tostring(self.bind.goodsId)))
    return
  end
  self.itemType = _goodsTpl:getItemType(self.goodsCfg)
  self.itemId = _goodsTpl:getItemId(self.goodsCfg)
  self.bind.go_item = false
  self.bind.go_rect_pet = false
  self.bind.go_rect_hero = false
  if self.itemType == L_Const.resType.hero then
    self.bind.go_rect_hero = true
    self.bind.img_texIconHeroM = L_GameUtil.getAvatarTexturePath(self.itemId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
  elseif self.itemType == L_Const.resType.pet then
    self.bind.go_rect_pet = true
    self.bind.img_pet = _goodsTpl:getIcon(self.goodsCfg)
  else
    self.bind.go_item = true
    self.bind.itemIcon = _goodsTpl:getIcon(self.goodsCfg)
  end
  self.bind.itemBg = string.format(_itemBgPath, _goodsTpl:getRarity(self.goodsCfg))
  self.bind.txt_name = _goodsTpl:getGoodsName(self.goodsCfg)
  self:refreshStatus()
end

function module:refreshStatus()
  local specialTips = _goodsTpl:getSpecialTips(self.goodsCfg)
  if not string.isEmpty(specialTips) then
    self.bind.specialTipsActive = true
    self.bind.txt_specialTips = specialTips
  else
    self.bind.specialTipsActive = false
  end
  local specialPrice = _goodsTpl:getSpecialPrice(self.goodsCfg)
  if not math.isEmpty(specialPrice) then
    self.bind.specialPriceActive = true
    self.bind.txt_specialPrice = tostring(specialPrice)
  else
    self.bind.specialPriceActive = false
  end
  local costId = _goodsTpl:getCostId(self.goodsCfg)
  self.bind.currencyActive = true
  if 1 < #costId or table.isEmpty(costId) then
    self.bind.currencyActive = false
  end
  if #costId == 1 then
    local currency = _goodsTpl:getCurrencyNum(self.goodsCfg)
    if currency <= 0 then
      self.bind.currencyActive = false
    else
      local currencyType = _goodsTpl:getCurrencyType(self.goodsCfg)
      local currencyId = _goodsTpl:getCurrencyId(self.goodsCfg)
      local hasNum = L_ItemTplManager:getItemNum(currencyType, currencyId)
      if currency > hasNum then
        self.bind.txt_cost = L_GameUtil.fillColor(currency, "#FFA6A6")
      else
        self.bind.txt_cost = tostring(currency)
      end
      local currencyInfo = L_ItemTplManager:getItemConfig(currencyType, currencyId)
      self.bind.img_currency = currencyInfo.icon
    end
  end
  self.bind.stockText = L_Lang:get(_goodsTpl:getLimitTxt(self.goodsCfg), {
    [0] = self.bind.stockNum
  })
  self:refreshHeroTypeStatus()
end

function module:refreshHeroTypeStatus()
  if self.itemType ~= L_Const.resType.hero then
    return
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
    self.bind.heroStarMask = true
  else
    self.bind.heroStarMask = false
  end
end

function module:checkRefreshTime(tpl)
  local refreshType = _goodsTpl:getRefreshType(tpl)
  if refreshType == 1 then
    self:closeRefreshGoods()
    self.bind.timeRefresh = false
  else
    self:openRefreshGoods()
  end
end

function module:openRefreshGoods()
  if self.goodsRefreshTimer then
    self:closeRefreshGoods()
  end
  local endTime = self.bind.deadTime
  self.bind.timeRefresh = true
  if math.isEmpty(endTime) or endTime <= 0 then
    self.bind.timeRefresh = false
    return
  end
  local frequency = 1
  
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

function module:closeRefreshGoods()
  if self.goodsRefreshTimer == nil then
    return
  end
  self.goodsRefreshTimer:destroy()
  self.goodsRefreshTimer = nil
end

function module:close()
  self:closeRefreshGoods()
end

return module
