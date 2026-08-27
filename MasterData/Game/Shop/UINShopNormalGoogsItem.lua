local UINShopNormalGoogsItem = class("UINShopNormalGoogsItem", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local showPaidItemList = {
  ConstGlobalItem.DormCoin
}

function UINShopNormalGoogsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_shopItem, self, self.OnClick)
  self.__BuySucessFunc = BindCallback(self, self.__BuySucess)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.obj_itemWithCount)
  self.itemWithCount:EnableButton(false)
  self._RefreshGoodsRecharge = BindCallback(self, self.OnGoodsShopRechargeSuccess)
  MsgCenter:AddListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
  self.texItemList = {
    [1] = self.ui.tex_oldPrice,
    [2] = self.ui.tex_currPrice,
    [3] = self.ui.tex_Name
  }
end

function UINShopNormalGoogsItem:InitNormalGoodsItem(goodData, purchaseRoot)
  self.goodData = goodData
  self.purchaseRoot = purchaseRoot
  self.isRecharge = goodData.shopType == ShopEnum.eShopType.Recharge
  if self.isRecharge then
    self.ui.img_CustomPic.gameObject:SetActive(true)
    self.ui.img_CustomPic.sprite = CRH:GetSprite(goodData.goodCfg.icon)
    self.itemWithCount:Hide()
    self.ui.tex_Extra.gameObject:SetActive(true)
    self.payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(goodData.goodCfg.name)
    self.ui.img_Quality.gameObject:SetActive(false)
  else
    self.ui.img_CustomPic.gameObject:SetActive(false)
    self.itemWithCount:Show()
    self.ui.tex_Extra.gameObject:SetActive(false)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(goodData.itemCfg.name)
    self.itemWithCount:InitItemWithCount(goodData.itemCfg, goodData.itemNum)
    self.ui.img_Quality.color = ItemQualityColor[goodData.itemCfg.quality]
  end
  self:RefreshCurrencyUI(goodData)
  self:RefreshLimitUI(goodData)
  for i = 1, #self.texItemList do
    self.texItemList[i]:StartScrambleTypeWriter()
  end
  self.ui.obj_imgTimer:SetActive(false)
end

function UINShopNormalGoogsItem:BindNorShopAllRefreshCallback(callback)
  self._allRefreshCallback = callback
end

function UINShopNormalGoogsItem:RefreshCurrencyUI(goodData)
  if self.isRecharge then
    self.ui.tex_currPrice.text = self.payCtrl:GetPayPriceShow(self.goodData.goodCfg.pay_id)
    self.ui.img_priceIcon.gameObject:SetActive(false)
    local itemIdList, itemNumList = self.payCtrl:GetPayRewards(self.goodData.goodCfg.pay_id, self.goodData.hasDouble)
    local content
    for i = 2, #itemIdList do
      local id = itemIdList[i]
      local num = itemNumList[i]
      local itemCfg = ConfigData.item[id]
      if itemCfg == nil then
        error("itemCfg is nill id:" .. tostring(id))
      else
        local name = LanguageUtil.GetLocaleText(itemCfg.name)
        if string.IsNullOrEmpty(content) then
          content = self.ui.tex_Extra:GetIndex(0, name, tostring(num))
        else
          content = content .. "\n" .. self.ui.tex_Extra:GetIndex(0, name, tostring(num))
        end
      end
    end
    self.ui.tex_Extra.text.text = content
  else
    self.ui.tex_currPrice.text = goodData.newCurrencyNum
    local currencyItemCfg = ConfigData.item[goodData.currencyId]
    local smallIcon = currencyItemCfg.small_icon
    self.ui.img_priceIcon.gameObject:SetActive(true)
    self.ui.img_priceIcon.sprite = CRH:GetSprite(smallIcon)
  end
  if goodData.discount == 100 then
    self.ui.obj_discount:SetActive(false)
    self.ui.tex_oldPrice.gameObject:SetActive(false)
  else
    self.ui.tex_Discount:SetIndex(0, tostring(100 - goodData.discount))
    self.ui.tex_oldPrice.text = goodData.oldCurrencyNum
    self.ui.obj_discount:SetActive(true)
    self.ui.tex_oldPrice.gameObject:SetActive(true)
  end
end

function UINShopNormalGoogsItem:RefreshLimitUI(goodData)
  self.ui.obj_Times:SetActive(false)
  self.ui.obj_soldOut:SetActive(false)
  if goodData.isLimit and goodData.shopType ~= ShopEnum.eShopType.Charcter and goodData.shopType ~= ShopEnum.eShopType.Random then
    self.ui.obj_Times:SetActive(true)
    local timesTypeIndex = goodData.limitType
    self.ui.tex_Times_type:SetIndex(timesTypeIndex)
    local limitCount = goodData.totallimitTime ~= nil and goodData.totallimitTime or goodData.limitTime
    self.ui.tex_Times.text = tostring(limitCount - goodData.purchases) .. "/" .. tostring(limitCount)
  end
  local soldOutStageId = 0
  if self:__IsInHoldLimit() then
    soldOutStageId = 3
  elseif goodData.isSoldOut then
    local isRepley = goodData:IsReplenishGoodsAndCount()
    soldOutStageId = isRepley and 2 or 1
  end
  if 0 < soldOutStageId then
    self.ui.obj_soldOut:SetActive(true)
    self.ui.buttom.color = self.ui.colors_state[soldOutStageId]
    self.ui.textEN:SetIndex(soldOutStageId - 1)
    self.ui.texCN:SetIndex(soldOutStageId - 1)
  end
end

function UINShopNormalGoogsItem:OnClick()
  if self.goodData.isSoldOut then
    return
  end
  if self:__IsInHoldLimit() then
    return
  end
  
  local function Local_Buy()
    if self.isRecharge then
      ControllerManager:GetController(ControllerTypeId.Shop, true):ReqShopRecharge(self.goodData.goodCfg.pay_id)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        if win == nil then
          error("can't open QuickBuy win")
          return
        end
        local resIds = {}
        table.insert(resIds, self.goodData.currencyId)
        if table.contain(showPaidItemList, self.goodData.currencyId) then
          table.insert(resIds, 1, ConstGlobalItem.PaidSubItem)
          table.insert(resIds, 1, ConstGlobalItem.PaidItem)
        end
        if self.goodData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(resIds, ConstGlobalItem.PaidItem) then
          table.insert(resIds, 1, ConstGlobalItem.PaidItem)
        end
        win:SlideIn()
        win:InitBuyTarget(self.goodData, self.__BuySucessFunc, true, resIds)
        win:OnClickAdd(true)
      end)
    end
  end
  
  if self:IsHeroFragAndFull() then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(3010), Local_Buy, nil)
  else
    Local_Buy()
  end
end

function UINShopNormalGoogsItem:OnGoodsShopRechargeSuccess(shopId)
  if self.goodData.shopId == shopId then
    self:RefreshGoods()
  end
end

function UINShopNormalGoogsItem:__BuySucess()
  if self._allRefreshCallback ~= nil and (self:IsHeroFragAndFull() or self.goodData.isSoldOut or self:__IsInHoldLimit()) then
    self._allRefreshCallback()
    return
  end
  self:RefreshGoods()
end

function UINShopNormalGoogsItem:__IsInHoldLimit()
  return PlayerDataCenter:IsItemLimitHold(self.goodData.itemId)
end

function UINShopNormalGoogsItem:RefreshGoods()
  if IsNull(self.gameObject) then
    return
  end
  self:RefreshCurrencyUI(self.goodData)
  self:RefreshLimitUI(self.goodData)
  self:RefreshLeftSellTime()
end

function UINShopNormalGoogsItem:IsHeroFragAndFull()
  if self.goodData.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[self.goodData.itemCfg.arg[1]]
    return heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0
  end
  return false
end

function UINShopNormalGoogsItem:RefreshLeftSellTime()
  if self.goodData.isSoldOut then
    self.ui.obj_imgTimer:SetActive(false)
    return
  end
  local hasTimeLimit, inTime, startTime, endTime = self.goodData:GetStillTime()
  if not hasTimeLimit or endTime < 0 then
    self.ui.obj_imgTimer:SetActive(false)
    return
  end
  self.ui.obj_imgTimer:SetActive(true)
  local remaindTime = endTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.tex_leftTime:SetIndex(0, tostring(d), tostring(h))
    return
  end
  if 0 < h then
    self.ui.tex_leftTime:SetIndex(1, tostring(h), tostring(m))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_leftTime:SetIndex(2, tostring(m))
end

function UINShopNormalGoogsItem:OnDelete()
  base.OnDelete(self)
end

return UINShopNormalGoogsItem
