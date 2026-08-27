local UINQuickPurchasePayGift = class("UINQuickPurchasePayGift", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local CS_ClientConsts = CS.ClientConsts
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")
local UINCustomHeroGiftNode = require("Game.PayGift.UINCustomHeroGiftNode")

function UINQuickPurchasePayGift:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy_Normal, self, self.OnClickBuyNormal)
  UIUtil.AddButtonListener(self.ui.btn_Buy_Super, self, self.OnClickBuySuper)
  UIUtil.AddButtonListener(self.ui.btn_GiftPageDetail, self, self.OnClickGiftPageDetial)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self.__OnPayGiftChange = BindCallback(self, self.OnPayGiftChange)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__OnPayGiftChange)
  self.__OnPayGiftCondition = BindCallback(self, self.OnPayGiftCondition)
  MsgCenter:AddListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
end

function UINQuickPurchasePayGift:OnInitPayGift(payGiftInfo, parentWin)
  self.quickBuyWindow = parentWin
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = cs_ResLoader.Create()
  self.payGiftInfo = payGiftInfo
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.payGiftInfo.groupCfg.name)
  local giftCount = #self.payGiftInfo.giftCfgList
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  if self._heroSelectNode ~= nil then
    self._heroSelectNode:Hide()
  end
  local isUseItemPay = self.payGiftInfo:IsUseItemPay()
  local isSelfSelectGift = self.payGiftInfo:IsSelfSelectGift()
  local isSelfSelectChipGift = isSelfSelectGift and self.payGiftInfo:IsSelfSelectChipGift()
  local isSelfSelectGiftSelected = self.payGiftInfo:GetSelfSelectGiftIsSelected()
  self.ui.tex_Cny_Normal.gameObject:SetActive(not isUseItemPay)
  self.ui.normal_cost:SetActive(isUseItemPay)
  local showOldPrice, oldPrice = self.payGiftInfo:TryGetPayGiftOldPrice()
  self.ui.tex_oldPrice.gameObject:SetActive(showOldPrice and not isUseItemPay)
  if isUseItemPay then
    local giftCfg = self.payGiftInfo.giftCfgList[1]
    local itemCfg = ConfigData.item[giftCfg.costId]
    self.ui.Normal_img_Item.sprite = CRH:GetSprite(itemCfg.small_icon)
    self.ui.Normal_tex_Cost.text = tostring(giftCfg.costCount)
  else
    local payId = self.payGiftInfo.giftCfgList[1].payId
    local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
    if priceNum ~= 0 then
      self.ui.tex_Cny_Normal:SetIndex(0, priceStr)
    else
      self.ui.tex_Cny_Normal:SetIndex(1)
    end
    if showOldPrice then
      local priceUnit = payCtrl:GetPayShowUnitStr()
      local oldPriceStr = priceUnit .. oldPrice
      self.ui.tex_oldPrice.text = oldPriceStr
    end
  end
  local isTwoGift = 1 < giftCount
  self.ui.btn_Buy_Super.gameObject:SetActive(isTwoGift)
  self.ui.texDes_Normal.gameObject:SetActive(isTwoGift)
  if isTwoGift then
    self.ui.tex_Cny_Super.gameObject:SetActive(not isUseItemPay)
    self.ui.super_cost:SetActive(isUseItemPay)
    if isUseItemPay then
      local giftCfg = self.payGiftInfo.giftCfgList[2]
      local itemCfg = ConfigData.item[giftCfg.costId]
      self.ui.Super_img_Item.sprite = CRH:GetSprite(itemCfg.small_icon)
      self.ui.Super_tex_Cost.text = tostring(giftCfg.costCount)
    else
      local payId = self.payGiftInfo.giftCfgList[2].payId
      local priceStr = payCtrl:GetPayPriceShow(payId)
      self.ui.tex_Cny_Super.text = priceStr
    end
  end
  local defaultCfg = self.payGiftInfo.defaultCfg
  self.ui.obj_BtnDis:SetActive(false)
  self.ui.obj_ItemDis:SetActive(false)
  self.ui.img_tag.gameObject:SetActive(false)
  if not CS_ClientConsts.IsAudit and not ConfigData.game_config.payGiftdiscountHide and isTwoGift then
    local giftCfg = self.payGiftInfo.giftCfgList[2]
    self.ui.tex_BtnDis.text = "-" .. tostring(giftCfg.discount) .. "%"
    self.ui.obj_BtnDis:SetActive(giftCfg.discount ~= 0)
  end
  if not CS_ClientConsts.IsAudit and not ConfigData.game_config.payGiftdiscountHide and 0 < self.payGiftInfo.groupCfg.tagType then
    local groupCfg = self.payGiftInfo.groupCfg
    if groupCfg.tagType == ShopEnum.ePayGiftTag.Discount then
      self.ui.obj_ItemDis:SetActive(true)
      if Consts.GameChannelType.IsInland() then
        self.ui.tex_ItemDis:SetIndex(1, tostring(10 - groupCfg.tagValue / 10), "\n")
      else
        self.ui.tex_ItemDis:SetIndex(0, tostring(groupCfg.tagValue), "\n")
      end
    else
      self.ui.img_tag.gameObject:SetActive(true)
      self.ui.img_tag:SetIndex(groupCfg.tagValue - 1)
      self.ui.tex_Tag:SetIndex(groupCfg.tagType - 2)
    end
  end
  local hasQz = false
  if isSelfSelectGift then
    self.ui.obj_rewardsNode:SetActive(true)
    self.itemPool:HideAll()
    for k, v in pairs(defaultCfg.awardIds) do
      local itemCfg = ConfigData.item[v]
      local count = defaultCfg.awardCounts[k]
      local item = self.itemPool:GetOne()
      item:InitItemWithCount(itemCfg, count)
      if itemCfg.id == ConstGlobalItem.PaidQZ or itemCfg.id == ConstGlobalItem.PaidItem then
        hasQz = true
      end
    end
    if self._heroSelectNode == nil then
      self.ui.btn_SelectHero:SetActive(true)
      self._heroSelectNode = UINCustomHeroGiftNode.New()
      self._heroSelectNode:Init(self.ui.btn_SelectHero)
      self._heroSelectNode:BindGiftHeroSelectCallback(function()
        local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
        payGiftCtrl:SelfSelectGift(self.payGiftInfo.defaultCfg, self.payGiftInfo, function(selfSelectCfg)
          if self.payGiftInfo:GetSelfSelectGiftIsSelected() then
            self.selfSelectCfg = selfSelectCfg
            self:OnInitPayGift(self.payGiftInfo, self.quickBuyWindow)
          end
        end)
      end)
      self._heroSelectNode.transform:SetAsFirstSibling()
      local params = self.payGiftInfo:GetSelfSelectGiftParams()
      local heroId = params ~= nil and params[1].param or nil
      if isSelfSelectChipGift then
        self._heroSelectNode:RefreshCustomChipGiftSelect(heroId, self.selfSelectCfg)
      else
        self._heroSelectNode:RefreshCustomHeroGiftSelect(heroId)
      end
    else
      self._heroSelectNode:Show()
      self._heroSelectNode.transform:SetAsFirstSibling()
      local params = self.payGiftInfo:GetSelfSelectGiftParams()
      local heroId = params ~= nil and params[1].param or nil
      if isSelfSelectChipGift then
        self._heroSelectNode:RefreshCustomChipGiftSelect(heroId, self.selfSelectCfg)
      else
        self._heroSelectNode:RefreshCustomHeroGiftSelect(heroId)
      end
    end
  else
    self.ui.obj_rewardsNode:SetActive(true)
    self.itemPool:HideAll()
    for k, v in pairs(defaultCfg.awardIds) do
      local itemCfg = ConfigData.item[v]
      local count = defaultCfg.awardCounts[k]
      local item = self.itemPool:GetOne()
      item:InitItemWithCount(itemCfg, count)
      if itemCfg.id == ConstGlobalItem.PaidQZ or itemCfg.id == ConstGlobalItem.PaidItem then
        hasQz = true
      end
    end
  end
  self.ui.obj_JpQZ:SetActive(hasQz and Consts.GameChannelType.IsJp())
  local textureName = self.payGiftInfo.groupCfg.icon
  self.resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_GiftBag.texture = texture
    end
  end)
  self:RefreshGiftPageDetail()
  self:RefreshPurchasePayGift()
end

function UINQuickPurchasePayGift:RefreshGiftPageDetail()
  local isSubscription, giftCfg, allDay = self.payGiftInfo:TryGetGiftSubscriptionCfg()
  self.ui.btn_GiftPageDetail.gameObject:SetActive(isSubscription)
  self.ui.tex_GiftPageDetail.transform.parent.gameObject:SetActive(isSubscription)
  if isSubscription then
    if self.payGiftInfo:IsCheckNextGift() then
      self.ui.tex_GiftPageDetail:SetIndex(1)
    elseif self.payGiftInfo:IsOrderOfManyTypeGift() then
      self.ui.tex_GiftPageDetail:SetIndex(2, tostring(allDay))
    else
      self.ui.tex_GiftPageDetail:SetIndex(0, tostring(allDay))
    end
    return
  end
  local isRandom, giftCfg = self.payGiftInfo:TryGetGiftRaffleCfg()
  self.ui.btn_GiftPageDetail.gameObject:SetActive(isRandom)
  self.ui.tex_GiftPageDetail.transform.parent.gameObject:SetActive(isRandom)
  self.ui.tex_GiftPageDetail:SetIndex(3)
end

function UINQuickPurchasePayGift:RefreshPurchasePayGift()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local isCanBuy, tipId = payGiftCtrl:GetCanBuyGiftAndTipId(self.payGiftInfo)
  local isLimit, times, limitTimes = self.payGiftInfo:GetLimitBuyCount()
  self.ui.btnGroup:SetActive(isCanBuy)
  self.ui.soldOut:SetActive(not isCanBuy)
  if not isCanBuy then
    self.ui.tex_cantBuy:SetIndex(tipId)
  end
  self.ui.obj_limit:SetActive(isLimit)
  if isLimit then
    local index = self.payGiftInfo.needRefresh and 1 or 0
    self.ui.text_limit:SetIndex(index, tostring(limitTimes - times))
  end
  self.ui.obj_time:SetActive(false)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.payGiftInfo:NeedRefreshTime() then
    self.ui.obj_time:SetActive(true)
    self.lastRefreshTime = math.floor(self.payGiftInfo:GetPayGiftNextTime())
    self.timerId = TimerManager:StartTimer(1, self.ShowGiftCutDown, self, false, false, false)
    self:ShowGiftCutDown()
  else
    local flag, startTime, endTime = self.payGiftInfo:IsUnlockTimeCondition()
    if flag and endTime > PlayerDataCenter.timestamp then
      self.ui.obj_time:SetActive(true)
      self.lastRefreshTime = endTime
      self.timerId = TimerManager:StartTimer(1, self.ShowGiftCutDown, self, false, false, false)
      self:ShowGiftCutDown()
    end
  end
end

function UINQuickPurchasePayGift:ShowGiftCutDown()
  local time = self.lastRefreshTime - PlayerDataCenter.timestamp
  if time < 0 then
    if self.payGiftInfo:IsUnlock() and self.payGiftInfo.initPreGroupId == self.payGiftInfo.groupCfg.id then
      self:RefreshPurchasePayGift()
    end
    return
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(time, false, true)
  if 0 < d then
    self.ui.text_time:SetIndex(0, tostring(d), tostring(h))
  elseif 0 < h then
    self.ui.text_time:SetIndex(1, tostring(h), tostring(m))
  elseif 0 < m then
    self.ui.text_time:SetIndex(2, tostring(m))
  else
    self.ui.text_time:SetIndex(2, tostring(1))
  end
end

function UINQuickPurchasePayGift:OnPayGiftChange(id)
  if id ~= self.payGiftInfo.groupCfg.id then
    return
  end
  local otherPayGiftInfo = ControllerManager:GetController(ControllerTypeId.PayGift).dataDic[self.payGiftInfo.initPreGroupId]
  if self.quickBuyWindow.active and self.active and self.payGiftInfo.initPreGroupId ~= self.payGiftInfo.groupCfg.id and not otherPayGiftInfo:IsSoldOut() then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.QuickBuy, true)
  else
    self:RefreshPurchasePayGift()
  end
end

function UINQuickPurchasePayGift:OnPayGiftCondition()
  if self.quickBuyWindow.active and self.active and not self.payGiftInfo:IsUnlock() then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.QuickBuy, true)
  end
end

function UINQuickPurchasePayGift:OnClickBuyNormal()
  if self.quickBuyWindow.isSlideOuting then
    return
  end
  if not self.payGiftInfo:IsUnlock() then
    return
  end
  local giftCfg = self.payGiftInfo.giftCfgList[1]
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local isSelfSelectGift = self.payGiftInfo:IsSelfSelectGift()
  local isSelfSelectGiftSelected = self.payGiftInfo:GetSelfSelectGiftIsSelected()
  if isSelfSelectGift then
    if not isSelfSelectGiftSelected then
      if self.payGiftInfo:IsSelfSelectChipGift() then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(419))
      elseif self.payGiftInfo:IsSelfSelectHeroGift() then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(418))
      end
      return
    end
    payGiftCtrl:SendBuyGifit(giftCfg, self.payGiftInfo:GetSelfSelectGiftParams(), function()
      UIUtil.OnClickBackByWinId(UIWindowTypeID.QuickBuy)
    end)
    return
  end
  payGiftCtrl:SendBuyGifit(giftCfg, nil, function()
    UIUtil.OnClickBackByWinId(UIWindowTypeID.QuickBuy)
  end)
end

function UINQuickPurchasePayGift:OnClickBuySuper()
  if self.quickBuyWindow.isSlideOuting then
    return
  end
  if not self.payGiftInfo:IsUnlock() then
    return
  end
  local giftCfg = self.payGiftInfo.giftCfgList[2]
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  payGiftCtrl:SendBuyGifit(giftCfg, nil, function()
    UIUtil.OnClickBackByWinId(UIWindowTypeID.QuickBuy)
  end)
end

function UINQuickPurchasePayGift:OnClickGiftPageDetial()
  UIManager:ShowWindowAsync(UIWindowTypeID.GiftPageDetail, function(win)
    win:InitGiftPageDetail(self.payGiftInfo)
  end)
end

function UINQuickPurchasePayGift:OnHide()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnHide(self)
end

function UINQuickPurchasePayGift:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__OnPayGiftChange)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self._heroSelectNode ~= nil then
    self._heroSelectNode:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UINQuickPurchasePayGift
