local UIWin21Shop = class("UIWin21Shop", UIBaseWindow)
local base = UIBaseWindow
local UINCharDungeonShopItem = require("Game.Shop.CharacterDungeon.UINCharDungeonShopItem")
local UINCharDungeonShopPage = require("Game.Shop.CharacterDungeon.UINCharDungeonShopPage")
local ShopUtil = require("Game.Shop.ShopUtil")

function UIWin21Shop:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_token, self, self.__OnClickCoin)
  self.ui.pageItem:SetActive(false)
  self.__onPageItemValueChanged = BindCallback(self, self.OnPageItemValueChanged)
  self.__shopPageList = {}
  self.ui.loop_shopList.onInstantiateItem = BindCallback(self, self.__OnShopNewItem)
  self.ui.loop_shopList.onChangeItem = BindCallback(self, self.__OnShopItemChanged)
  self.__shopItemDic = {}
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.__updateTopCurrencys = BindCallback(self, self.__UpdateShopCurrencys)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  self.__OnCharDungeonItemClicked = BindCallback(self, self.OnActShopItemClicked)
end

function UIWin21Shop:InitActivityWinterShop(activtySector)
  self.__activtySector = activtySector
  self.__destoryTime = activtySector:GetActivityDestroyTime()
  self.__shopCurrencyId = activtySector:GetSectorIITokenId()
  self.__shopIdList = activtySector:GetSectorIIIShopList()
  self.__saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  self:InitActivityShopBaseInfo()
  self:__InitShopPage(self.__shopIdList)
  if self.__activtySector:GetSectorIIActivityIsRemaster() then
    self.ui.obj_remasterTag:SetActive(true)
  else
    self.ui.obj_remasterTag:SetActive(false)
  end
  if self.__destoryTime < 0 then
    self.ui.obj_timer:SetActive(false)
  else
    local date = TimeUtil:TimestampToDate(self.__destoryTime, false, true)
    self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  end
  local infoId = self.__activtySector:GetSectorIIStoreInfo()
  self.ui.tex_Des.gameObject:SetActive(false)
  if infoId ~= 0 then
    self.ui.tex_Des.gameObject:SetActive(true)
    self.ui.tex_Des.text = ConfigData:GetTipContent(infoId)
  end
end

function UIWin21Shop:InitActivityShopBaseInfo()
  self:__InitCurrencySprite()
  self:__UpdateShopCurrencys()
end

function UIWin21Shop:__InitCurrencySprite()
  local itemCfg = ConfigData.item[self.__shopCurrencyId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(self.__shopCurrencyId))
    return
  end
  self.ui.img_Token.sprite = CRH:GetSprite(itemCfg.small_icon)
end

function UIWin21Shop:__UpdateShopCurrencys()
  local itemCount = PlayerDataCenter:GetItemCount(self.__shopCurrencyId)
  self.ui.tex_Token.text = tostring(itemCount)
end

function UIWin21Shop:__InitShopPage(shopList)
  if shopList == nil and #shopList == 0 then
    return
  end
  for _, shopId in pairs(shopList) do
    local go = self.ui.pageItem:Instantiate()
    go:SetActive(true)
    local pageItem = UINCharDungeonShopPage.New()
    pageItem:Init(go)
    pageItem:InitCharDungeonShopPage(shopId, true, self.__onPageItemValueChanged)
    self:__RefreshBlueDot(shopId, pageItem)
    self.__shopPageList[shopId] = pageItem
  end
  local firstShopId = shopList[1]
  self.__shopPageList[firstShopId]:SetDungeonShopPageIsOn(true)
end

function UIWin21Shop:__RefreshBlueDot(shopId, pageItem)
  local isNeedBlue = false
  local isLooked = self.__saveUserData:GetSectorIIRecommendShopIsLooked(shopId)
  if not isLooked then
    local shopCfg = ConfigData.shop[shopId]
    local isRecommend = shopCfg.is_recommended
    local isHaveRecommendGood
    if not isRecommend then
      local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      shopCtrl:GetShopData(shopId, function(shopData)
        for shelfId, goodData in pairs(shopData.shopGoodsDic) do
          if goodData.isRecommendGood and not goodData.isSoldOut then
            isHaveRecommendGood = true
            break
          end
        end
      end, true)
    end
    if isRecommend or isHaveRecommendGood then
      isNeedBlue = true
    end
  end
  pageItem:SetCharDungeonShopPageReddot(isNeedBlue)
end

function UIWin21Shop:OnPageItemValueChanged(pageItem, value)
  if not value then
    pageItem:SetCharDungeonShopPageReddot(false)
    return
  end
  self.ui.loop_shopList.gameObject:SetActive(false)
  self.__isRefeshData = true
  local shopId = pageItem:GetCharDungeonShopId()
  local IsRecommendShop = pageItem:IsItemRecommendShop()
  self.ui.obj_RecommendBG:SetActive(IsRecommendShop)
  self.ui.obj_Title:SetActive(IsRecommendShop)
  self.shopCtrl:GetShopData(shopId, function(shopData)
    self.__isRefeshData = false
    self:ShowActivtySectorShop(shopData)
    self.__saveUserData:SetSectorIIRecommendShopIsLooked(shopId, true)
    self.__activtySector:RefreshSectorIIShopReddot()
  end, true)
end

function UIWin21Shop:ShowActivtySectorShop(shopData)
  self.__shopData = shopData
  self.__shopDataList = {}
  for shelfId, goodData in pairs(shopData.shopGoodsDic) do
    table.insert(self.__shopDataList, goodData)
  end
  ShopUtil.CommonSortGoodList(self.__shopDataList)
  self.ui.loop_shopList.gameObject:SetActive(true)
  self.ui.loop_shopList.totalCount = #self.__shopDataList
  self.ui.loop_shopList:RefillCells()
end

function UIWin21Shop:__OnShopNewItem(go)
  local shopItem = UINCharDungeonShopItem.New()
  shopItem:Init(go)
  self.__shopItemDic[go] = shopItem
end

function UIWin21Shop:__OnShopItemChanged(go, index)
  local shopItem = self.__shopItemDic[go]
  index = index + 1
  local shopGoodData = self.__shopDataList[index]
  shopItem:InitCharDungeonShopItem(shopGoodData, index, self.__OnCharDungeonItemClicked)
end

function UIWin21Shop:__GetItemByIndex(index)
  local go = self.ui.loop_shopList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local shopItem = self.__shopItemDic[go]
    return shopItem
  end
  return nil
end

function UIWin21Shop:__RefreshAllItem()
  for i, v in pairs(self.__shopItemDic) do
    v:RefreshCharDungeonShopItem()
  end
end

function UIWin21Shop:OnActShopItemClicked(index, shopItem)
  local shopGoodData = shopItem:GetDungeonShopItemData()
  if not self.shopCtrl:ShopIsUnlockOnly(shopGoodData.shopId) then
    return
  end
  if shopGoodData.isSoldOut then
    return
  end
  local isOverflow = false
  if shopGoodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
    local num = PlayerDataCenter:GetItemOverflowNum(shopGoodData.itemId, 1)
    if num ~= 0 then
      isOverflow = true
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    if win == nil then
      error("can't open QuickBuy win")
      return
    end
    local resIds = {}
    table.insert(resIds, shopGoodData.currencyId)
    if shopGoodData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(resIds, ConstGlobalItem.PaidItem) then
      table.insert(resIds, 1, ConstGlobalItem.PaidItem)
    end
    win:SlideIn()
    win:InitBuyTarget(shopGoodData, function()
      self:__RefreshAllItem()
    end, true, resIds, nil, isOverflow)
    win:OnClickAdd(true)
  end)
end

function UIWin21Shop:__OnClickReturn()
  self:Delete()
end

function UIWin21Shop:__OnClickCoin()
  local itemCfg = ConfigData.item[self.__shopCurrencyId]
  if itemCfg == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

function UIWin21Shop:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  base.OnDelete(self)
end

return UIWin21Shop
