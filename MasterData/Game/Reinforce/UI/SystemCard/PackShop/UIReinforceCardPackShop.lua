local base = UIBaseWindow
local UIReinforceCardPackShop = class("UIReinforceCardPackShop", base)
local ReinforceCardDataSystem = require("Game.Reinforce.Data.ReinforceCardDataSystem")
local UIReinForceCardHandBookCardItem = require("Game.Reinforce.UI.SystemCard.HandBook.UIReinforceCardHandBookCardItem")
local UIReinforceCardPackShopItem = require("Game.Reinforce.UI.SystemCard.PackShop.UIReinforceCardPackShopItem")
local UIReinforceCardPackShopCountItem = require("Game.Reinforce.UI.SystemCard.PackShop.UIReinforceCardPackShopCountItem")
local CS_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon

function UIReinforceCardPackShop:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_HandBook, self, self.OnBtnHandBookClicked)
  UIUtil.AddButtonListener(self.ui.btn_Draw, self, self.OnBtnBuyClicked)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnBtnRulesClicked)
  self._packItemPool = UIItemPool.New(UIReinforceCardPackShopItem, self.ui.packItem, false)
  self._cardItemPool = UIItemPool.New(UIReinForceCardHandBookCardItem, self.ui.cardItem, false)
  self._resLoader = CS_ResLoader.Create()
  self._onCardPackToggleClicked = BindCallback(self, self.OnSwitchReinforceCardGroup)
  self._onBuyCountChanged = BindCallback(self, self.OnBuyCountChanged)
  self.countItem = UIReinforceCardPackShopCountItem.New()
  self.countItem:Init(self.ui.countItem)
  self._tempOrderPoodCardList = {}
end

function UIReinforceCardPackShop:InitReinforceCardPackShop(actId, actFrameId, closeCallback)
  self.actId = actId
  self.actFrameId = actFrameId
  local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  local rfDataAll = actAn24Ctrl:GetActFirstData():GetActAnv24RfCardDataAll()
  self.rfDataAll = rfDataAll
  self.closeCallback = closeCallback
  self.poolMainCfg = ConfigData.reinforce_pool_card_main[actId][actFrameId]
  UIUtil.RefreshTopResId(self.poolMainCfg.item_id)
  self:RefreshTitle()
  self.cardPackList = ConfigData.reinforce_pool_card_set[actId]
  self:UpdateCardPackList(self.cardPackList)
  self.countItem:InitReinforceCardPackShopCountItem(self._onBuyCountChanged, 1, self.poolMainCfg.draw_max)
  self:InitCount()
  local guideId = ConfigData.reinforce_pool_card_main[actId][actFrameId].pool_guide_id
  GuideManager:StartNewTriggerGuide(guideId)
end

function UIReinforceCardPackShop:RefreshTitle()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.poolMainCfg.draw_name)
end

function UIReinforceCardPackShop:OnSwitchReinforceCardGroup(poolId)
  self.currentPoolId = poolId
  local cardSetCfg = self.cardPackList[poolId]
  local poodCardList = ConfigData.reinforce_pool_card_pool[poolId]
  self:UpdatePackImage(cardSetCfg.pool_image)
  self:UpdatePackName(LanguageUtil.GetLocaleText(cardSetCfg.pool_name))
  self:UpdateCardItemInPackList(poodCardList)
  local collectionRate = self.rfDataAll:GetShopCardCollectionPackRate(poolId, self.actId)
  self:UpdatePackCollectionRate(collectionRate)
end

function UIReinforceCardPackShop:UpdatePackImage(texturePath)
  if texturePath == nil then
    return
  end
  self._resLoader:LoadABAssetAsync(texturePath, function(texture)
    if texture ~= nil and not IsNull(self.ui.img_PackagePic) then
      self.ui.img_PackagePic.texture = texture
    end
  end)
end

function UIReinforceCardPackShop:UpdatePackName(packName)
  self.ui.tex_PackageName.text = packName
end

function UIReinforceCardPackShop:UpdatePackCollectionRate(collectionRate)
  self.ui.tex_Rate:SetIndex(0, string.format("%.1f", collectionRate * 100))
end

function UIReinforceCardPackShop:UpdateCardPackList(cardPackList)
  self._packItemPool:HideAll()
  local defaultSelect
  for poolId, cardPackCfg in pairs(cardPackList) do
    local packItem = self._packItemPool:GetOne()
    local collectRate = cardPackCfg.lock and 0 or self.rfDataAll:GetShopCardCollectionPackRate(poolId, self.actId)
    packItem:InitReinforceCardPackShopItem(cardPackCfg.pool_id, LanguageUtil.GetLocaleText(cardPackCfg.pool_name), collectRate, cardPackCfg.lock, self._onCardPackToggleClicked)
    if defaultSelect == nil then
      defaultSelect = packItem
    end
  end
  defaultSelect:SetComRankPageItemIsOn()
end

function UIReinforceCardPackShop:UpdateCardItemInPackList(poodCardList)
  self._cardItemPool:HideAll()
  if poodCardList == nil then
    return
  end
  table.clearmap(self._tempOrderPoodCardList)
  for id, poodCardCfg in pairs(poodCardList) do
    table.insert(self._tempOrderPoodCardList, poodCardCfg)
  end
  table.sort(self._tempOrderPoodCardList, function(a, b)
    return a.order < b.order
  end)
  for index, poodCardCfg in ipairs(self._tempOrderPoodCardList) do
    for cardId, count in pairs(poodCardCfg.card) do
      local cardCfg = ConfigData.reinforce_card_card_main[cardId]
      local reinforceCardData = ReinforceCardDataSystem.New()
      reinforceCardData:InitRfCardDataSys(cardCfg.id, nil, poodCardCfg.card_star)
      local cardItem = self._cardItemPool:GetOne()
      cardItem:InitReinForceCardHandBookCardItem(reinforceCardData, self._resLoader)
    end
  end
end

function UIReinforceCardPackShop:InitCount()
  local costNum = self:GetCostItemCount()
  local count = costNum // self:GetpoolCfg().item_num[self:GetCostItemId()]
  self.countItem:SetCurrentNum(count)
end

function UIReinforceCardPackShop:GetpoolCfg()
  return ConfigData.reinforce_pool_card_set[self.actId][self.currentPoolId]
end

function UIReinforceCardPackShop:GetCostItemId()
  return self.poolMainCfg.item_id[1]
end

function UIReinforceCardPackShop:GetCostItemCount()
  return PlayerDataCenter:GetItemCount(self:GetCostItemId())
end

function UIReinforceCardPackShop:OnBuyCountChanged(num)
  local price = self:GetPrice()
  self:RefreshPrice(price)
end

function UIReinforceCardPackShop:GetPrice()
  return self.countItem:GetCurrentNum() * self:GetpoolCfg().item_num[self:GetCostItemId()]
end

function UIReinforceCardPackShop:RefreshPrice(price)
  self.ui.tex_Price.text = tostring(price)
end

function UIReinforceCardPackShop:OnBtnBuyClicked()
  if self:GetCostItemCount() < self:GetPrice() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59004))
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_Reinforce_Drawcards(self.actFrameId, self.currentPoolId, self.countItem:GetCurrentNum(), function(result)
    if IsNull(result) or result.Count == 0 then
      return
    end
    local msg = result[0]
    if msg == nil then
      return
    end
    self:InitCount()
    local collectionRate = self.rfDataAll:GetShopCardCollectionPackRate(self.currentPoolId, self.actId)
    self:UpdatePackCollectionRate(collectionRate)
    for poolId, cardPackCfg in pairs(self.cardPackList) do
      for index, item in pairs(self._packItemPool.listItem) do
        if item.themeId == poolId then
          local collectRate = cardPackCfg.lock and 0 or self.rfDataAll:GetShopCardCollectionPackRate(poolId, self.actId)
          item:RefreshCollectionRate(cardPackCfg.lock, collectRate)
        end
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDrawShow, function(drawShowwindow)
      drawShowwindow:InitLotteryShow(self.ui.img_PackagePic.texture, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewardCards):SetCRItemCustomTransDic(msg.syncUpdateDiff.resource.backpack.overflow)
          window:SetColseCallback(function()
            if drawShowwindow ~= nil and drawShowwindow.active then
              drawShowwindow:Delete()
            end
          end)
          window:AddAndTryShowReward(CRData)
        end)
      end)
    end)
  end)
end

function UIReinforceCardPackShop:OnBtnHandBookClicked()
  if UIManager:GetWindow(UIWindowTypeID.UIReinforceCardHandBook) ~= nil then
    self:Delete()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardHandBook, function(window)
    window:InitReinforceCardHandBook(self.actId, self.actFrameId)
  end)
end

function UIReinforceCardPackShop:OnBtnRulesClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self.poolMainCfg.draw_rule, false)
  end)
end

function UIReinforceCardPackShop:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIReinforceCardPackShop:OnDelete()
  self._packItemPool:DeleteAll()
  self._packItemPool = nil
  self._cardItemPool:DeleteAll()
  self._cardItemPool = nil
  self.countItem:Delete()
  self.countItem = nil
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  base.OnDelete(self)
end

return UIReinforceCardPackShop
