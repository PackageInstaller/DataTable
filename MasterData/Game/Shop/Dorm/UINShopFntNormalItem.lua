local UINShopNormalGoogsItem = require("Game.Shop.UINShopNormalGoogsItem")
local base = UINShopNormalGoogsItem
local UINShopFntNormalItem = class("UINShopFntNormalItem", base)
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopFntNormalItem:OnInit()
  base.OnInit(self)
end

function UINShopFntNormalItem:InitFntItem(goodData, baseObj)
  self.goodData = goodData
  self.baseObj = baseObj
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(goodData.itemCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSprite(goodData.itemCfg.icon)
  self:RefreshCurrencyUI(goodData)
  self:RefreshLimitUI(goodData)
  self:RefreshLeftSellTime()
  self.ui.soldOut:SetActive(self.goodData.isSoldOut)
  for i = 1, #self.texItemList do
    self.texItemList[i]:StartScrambleTypeWriter()
  end
  self:InitDormFntInfo(goodData)
end

function UINShopFntNormalItem:InitDormFntInfo(goodData)
  local fntCfg = ConfigData.dorm_furniture[goodData.itemCfg.id]
  if fntCfg == nil then
    error("can't not find dorm fnt cfg,id:" .. tostring(goodData.itemCfg.id))
    return
  end
  self.ui.tex_Comfort.text = tostring(fntCfg.comfort)
  self.ui.obj_img_ThemeFurniture:SetActive(fntCfg.is_theme)
  self.ui.obj_img_CheckIn:SetActive(fntCfg.can_binding)
  self.ui.obj_img_OnlyBig:SetActive(fntCfg.only_big)
end

function UINShopFntNormalItem:RefreshLimitUI(goodData)
  self.ui.obj_Times:SetActive(false)
  if goodData.isLimit and goodData.shopType ~= ShopEnum.eShopType.Random then
    self.ui.obj_Times:SetActive(true)
    local timesTypeIndex = goodData.shopType == ShopEnum.eShopType.ResourceRefresh and 0 or goodData.limitType
    self.ui.tex_Times_type:SetIndex(timesTypeIndex)
    local limitCount = goodData.totallimitTime ~= nil and goodData.totallimitTime or goodData.limitTime
    self.ui.tex_Times.text = tostring(limitCount - goodData.purchases) .. "/" .. tostring(limitCount)
  end
end

function UINShopFntNormalItem:RefreshLeftSellTime()
  self.ui.obj_BuyTime:SetActive(false)
  if self.goodData.isSoldOut then
    return
  end
  local hasTimeLimit, inTime, startTime, endTime = self.goodData:GetStillTime()
  if hasTimeLimit then
    if not inTime then
      return true
    end
  else
    return
  end
  if endTime == -1 then
    return
  end
  self.ui.obj_BuyTime:SetActive(true)
  local remaindTime = endTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.tex_BuyLeftTime:SetIndex(0, tostring(d), tostring(h))
    return
  end
  if 0 < h then
    self.ui.tex_BuyLeftTime:SetIndex(1, tostring(h), tostring(m))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_BuyLeftTime:SetIndex(2, tostring(m))
end

function UINShopFntNormalItem:RefreshGoods()
  if self.baseObj ~= nil then
    self.baseObj:RefreshGoods()
  end
end

return UINShopFntNormalItem
