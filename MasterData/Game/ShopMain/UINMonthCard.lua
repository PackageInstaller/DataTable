local UINMonthCard = class("UINMonthCard", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ShopEnum = require("Game.Shop.ShopEnum")
local CS_MessageCommon = CS.MessageCommon

function UINMonthCard:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.extrRewardList = {}
  self.__Refresh = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__Refresh)
  self.__CountDownExpire = BindCallback(self, self.CountDownExpire)
  if Consts.GameChannelType.IsJp() then
    self.ui.obj_JpQz:SetActive(true)
  end
end

function UINMonthCard:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINMonthCard:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  UIUtil.RefreshTopResId({
    ConstGlobalItem.PaidItem,
    ConstGlobalItem.PaidSubItem
  })
  self:InitMonthCard()
  self:RefreshSpecailReddot(shopId)
  self.uiShop:RefreshHeadBar(nil)
end

function UINMonthCard:InitMonthCardCfg(monthCardId)
  self.monthCardId = monthCardId
  self.monthCardCfg = ConfigData.month_card[self.monthCardId]
end

function UINMonthCard:InitMonthCard()
  self.rewardPool:HideAll()
  for i = 1, #self.monthCardCfg.first_award_ids do
    local itemCfg = ConfigData.item[self.monthCardCfg.first_award_ids[i]]
    local count = self.monthCardCfg.first_award_nums[i]
    local item = self.rewardPool:GetOne(true)
    item.gameObject:SetActive(true)
    item.transform:SetParent(self.ui.obj_CurrentItemList.transform)
    item:InitItemWithCount(itemCfg, count, nil, false)
  end
  for i = 1, #self.monthCardCfg.daily_award_ids do
    local itemCfg = ConfigData.item[self.monthCardCfg.daily_award_ids[i]]
    local count = self.monthCardCfg.daily_award_nums[i]
    local item = self.rewardPool:GetOne(true)
    item.gameObject:SetActive(true)
    item.transform:SetParent(self.ui.obj_DailyItemList.transform)
    item:InitItemWithCount(itemCfg, count, nil, false)
    table.insert(self.extrRewardList, item)
  end
  self:Refresh()
end

function UINMonthCard:RefreshSpecailReddot(shopId)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
  if ok then
    shopNode:SetRedDotCount(0)
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId), true)
  saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId) .. "discount", true)
  local leftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(self.monthCardId)
  if 0 < leftday and leftday <= ConfigData.game_config.monthCardReddot then
    local showTime = math.floor(PlayerDataCenter.timestamp)
    saveUserData:SetLastMonthCardRenew(showTime)
  end
end

function UINMonthCard:Refresh()
  local dailySignInData = PlayerDataCenter.dailySignInData
  local dayCount = dailySignInData:GetMonthCardLeftCount(self.monthCardId)
  local isCanBuy = not dailySignInData:IsLimitMonthCardBuy(self.monthCardId)
  local isDiscount, discountDuration = dailySignInData:IsCardDiscount(self.monthCardId)
  self.isDiscount = isDiscount
  local priceId = self.monthCardCfg.price
  if isDiscount then
    priceId = self.monthCardCfg.discount_price
    self.ui.obj_discount:SetActive(true)
    self:RefreshDiscountTimeLimit(discountDuration)
  else
    self.ui.obj_discount:SetActive(false)
  end
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local priceStr, price = payCtr:GetPayPriceShow(priceId)
  self.ui.tex_Price.text = priceStr
  self.ui.btn_Buy.enabled = isCanBuy
  self.ui.obj_GetLimited:SetActive(not isCanBuy)
  if isCanBuy then
    self.ui.obj_Price:SetActive(true)
    local hasMonthCard = dailySignInData:IsHaveCard(self.monthCardId)
    local idx = hasMonthCard and 1 or 0
    self.ui.tex_PriceInfo:SetIndex(idx)
  else
    self.ui.obj_Price:SetActive(false)
  end
  if dailySignInData:IsHaveCard(self.monthCardId) then
    self.ui.tex_Time:SetIndex(0, tostring(dayCount))
    self.ui.tex_Time.text.color = self.ui.color_hasCardText
  else
    self.ui.tex_Time:SetIndex(1)
    self.ui.tex_Time.text.color = self.ui.color_noHaveCardText
  end
  for i, v in ipairs(self.extrRewardList) do
    v:SetPickedUIActive(dailySignInData:IsHaveCard(self.monthCardId))
  end
  if self.waitingMonthCardreward then
    local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
    local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(true, true, true)
    if 0 < #notPickedSinginMailUIDList then
      self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, 1)
    end
    self.waitingMonthCardreward = nil
  end
  local cardData = PlayerDataCenter.dailySignInData:GetMonthCardData(self.monthCardId)
  if PlayerDataCenter.timestamp <= cardData.expireAt or 0 or PlayerDataCenter.dailySignInData:IsCardDiscount(self.monthCardId) then
    self.shopCtrl:AddShopTimerCallback(self.__CountDownExpire, "monthCard")
  end
end

function UINMonthCard:RefreshDiscountTimeLimit(discountDuration)
  local timeStr = ""
  local diff = discountDuration - PlayerDataCenter.timestamp
  if diff < 0 then
    timeStr = string.format(ConfigData:GetTipContent(6045), "0")
  end
  local d, h, m = TimeUtil:TimestampToTimeInter(diff, false, true)
  if 0 < d then
    timeStr = string.format(ConfigData:GetTipContent(6043), tostring(d))
  elseif 0 < h then
    timeStr = string.format(ConfigData:GetTipContent(6044), tostring(h))
  else
    timeStr = string.format(ConfigData:GetTipContent(6045), tostring(m))
  end
  self.ui.tex_discount.text = timeStr
end

function UINMonthCard:CountDownExpire()
  local cardData = PlayerDataCenter.dailySignInData:GetMonthCardData(self.monthCardId)
  if PlayerDataCenter.timestamp > cardData.expireAt or 0 or self.isDiscount then
    self.shopCtrl:RemoveShopTimerCallback(self.__CountDownExpire)
    self:Refresh()
  end
end

function UINMonthCard:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
  local mailUid = notPickedSinginMailUIDList[index]
  if mailController == nil or mailController.mailDataDic[mailUid] == nil then
    error("can't get mail data with UID:" .. tostring(mailUid))
    return
  end
  local win = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if win ~= nil and win.active then
    win:BindCommonRewardExit(function()
      self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
    end)
    return
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  NetworkManager:GetNetwork(NetworkTypeID.Mail):CS_MAIL_ReceiveAttachment(mailUid, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      local rewardIds = {}
      local rewardNums = {}
      local _, rewardDic, _ = mailController.mailDataDic[mailUid]:IsHaveAtt()
      for id, num in pairs(rewardDic) do
        table.insert(rewardIds, id)
        table.insert(rewardNums, num)
      end
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRTitle(ConfigData:GetTipContent(14024)):SetCRShowOverFunc(function()
        local index = index
        if index < #notPickedSinginMailUIDList then
          index = index + 1
          self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
        end
      end)
      window:AddAndTryShowReward(CRData)
      mailController:ReqDeleteOneMail(mailUid)
    end)
  end)
end

function UINMonthCard:OnClickBuy()
  if PlayerDataCenter.dailySignInData:IsLimitMonthCardBuy(self.monthCardId) then
    return
  end
  if not PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(self.monthCardId) then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(425))
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.DailySignIn)
  if self.isDiscount then
    network:CS_MONTH_CARD_BUY(self.monthCardId, self.monthCardCfg.discount_price)
  else
    network:CS_MONTH_CARD_BUY(self.monthCardId, self.monthCardCfg.price)
  end
  self.waitingMonthCardreward = true
end

function UINMonthCard:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__Refresh)
  self.shopCtrl:RemoveShopTimerCallback(self.__CountDownExpire)
  base.OnDelete(self)
end

return UINMonthCard
