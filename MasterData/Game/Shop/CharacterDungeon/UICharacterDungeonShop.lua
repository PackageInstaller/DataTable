local UICharacterDungeonShop = class("UICharacterDungeonShop", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINCharDungeonShopItem = require("Game.Shop.CharacterDungeon.UINCharDungeonShopItem")
local UINCharDungeonShopPage = require("Game.Shop.CharacterDungeon.UINCharDungeonShopPage")
local ShopUtil = require("Game.Shop.ShopUtil")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")

function UICharacterDungeonShop:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_token, self, self.__OnClickCoin)
  self.ui.pageItem:SetActive(false)
  self.__onPageItemValueChanged = BindCallback(self, self.OnPageItemValueChanged)
  self.__shopPageList = {}
  self.ui.loop_shopList.onInstantiateItem = BindCallback(self, self.__OnShopNewItem)
  self.ui.loop_shopList.onChangeItem = BindCallback(self, self.__OnShopItemChanged)
  self.__shopItemDic = {}
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.__OnCharDungeonItemClicked = BindCallback(self, self.OnCharDungeonItemClicked)
  self.__conditionListener = ConditionListener.New()
  self.__OnCharShopUnlockEvent = BindCallback(self, self.__OnCharShopUnlock)
  self.__updateTopCurrencys = BindCallback(self, self.__UpdateShopCurrencys)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  self.__heroGrowActivityEvent = BindCallback(self, self.__RefreshCurShopUnlockInfo)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__heroGrowActivityEvent)
  self.resLoader = cs_ResLoader.Create()
  self.ui.recommendTitle.gameObject:SetActive(false)
end

function UICharacterDungeonShop:InitCharacterDungeonShop(heroGrowAct)
  self.heroGrowAct = heroGrowAct
  self.__ShopRedDotNode = heroGrowAct:GetActivityHeroShopReddotNode()
  self.__shopRedDotNodePath = heroGrowAct:GetActivityHeroShopPath()
  self.activityHeroCfg = heroGrowAct:GetHeroGrowCfg()
  self.__destoryTime = heroGrowAct:GetActivityDestroyTime()
  self.__bornTime = heroGrowAct:GetActivityBornTime()
  self.__shopCurrencyId = heroGrowAct:GetHeroGrowCostId()
  self.shop_name = self.activityHeroCfg.shop_name
  self.shop_bg = self.activityHeroCfg.shop_bg
  self.shop_bgfullPath = nil
  self.actFrameId = heroGrowAct.actInfo:GetActivityFrameId()
  self.tagCol = self:__GetColor(self.activityHeroCfg.color_shop)
  self.selCol = self:__GetColor(self.activityHeroCfg.color_shoplist)
  self:InitCharShopBaseInfo()
  self:__InitCharacterShopReddot()
  self:__InitShopPage(self.activityHeroCfg.shop_list)
  self:RefreshShopLastDay()
  TimerManager:StopTimer(self.__refrehsDayTimerId)
  self.__refrehsDayTimerId = TimerManager:StartTimer(2, self.RefreshShopLastDay, self, false, false, true)
end

function UICharacterDungeonShop:ExtraInitCharacterDungeonShop(extrData)
  self.__shopCurrencyId = extrData.currencyId
  self.__destoryTime = extrData.destoryTime
  self.__bornTime = extrData.bornTime
  self.tagCol = self:__GetColor(extrData.color_shop)
  self.selCol = self:__GetColor(extrData.color_shoplist)
  self.shop_name = extrData.shop_name
  self.shop_bg = nil
  self.shop_bgfullPath = extrData.shop_bgfullPath
  self.actFrameId = extrData.actFrameId
  local shopList = extrData.shop_list
  self:InitCharShopBaseInfo()
  self:__InitShopPage(shopList)
  self:RefreshShopLastDay()
  TimerManager:StopTimer(self.__refrehsDayTimerId)
  self.__refrehsDayTimerId = TimerManager:StartTimer(2, self.RefreshShopLastDay, self, false, false, true)
end

function UICharacterDungeonShop:__InitCharacterShopReddot()
  function self.__shopReddotFunc(node)
    local shopId = node.nodeId
    
    local pageItem = self.__shopPageList[shopId]
    if pageItem ~= nil then
      pageItem:SetCharDungeonShopPageReddot(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(self.__shopRedDotNodePath, self.__shopReddotFunc)
end

function UICharacterDungeonShop:RefreshShopLastDay()
  local futureOpen = PlayerDataCenter.timestamp < self.__bornTime
  if self.__lastFutureOpen ~= futureOpen then
    self.__lastFutureOpen = futureOpen
    local date
    if futureOpen then
      date = TimeUtil:TimestampToDate(self.__bornTime, false, true)
      self.ui.tex_DateType:SetIndex(1)
    else
      date = TimeUtil:TimestampToDate(self.__destoryTime, false, true)
      self.ui.tex_DateType:SetIndex(0)
    end
    self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  end
  if futureOpen then
    self.ui.tex_Day.text = ActivityFrameUtil.GetCountdownTimeStr(self.__bornTime)
  else
    self.ui.tex_Day.text = ActivityFrameUtil.GetCountdownTimeStr(self.__destoryTime)
  end
end

function UICharacterDungeonShop:InitCharShopBaseInfo()
  self:__InitBackground()
  self:__InitTag()
  self:__InitCurrencySprite()
  self:__UpdateShopCurrencys()
end

function UICharacterDungeonShop:__InitBackground()
  self.ui.img_background.enabled = false
  local path
  if self.shop_bgfullPath ~= nil then
    path = self.shop_bgfullPath
  else
    path = PathConsts:GetCharDunPath(self.shop_bg)
  end
  self.resLoader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_background.enabled = true
    self.ui.img_background.texture = texture
  end)
end

function UICharacterDungeonShop:__InitTag()
  self.ui.img_HeadTile.color = self.tagCol
  self.ui.tex_TileName.text = LanguageUtil.GetLocaleText(self.shop_name) or ""
end

function UICharacterDungeonShop:__InitCurrencySprite()
  local itemCfg = ConfigData.item[self.__shopCurrencyId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(self.__shopCurrencyId))
    return
  end
  self.ui.img_Token.sprite = CRH:GetSprite(itemCfg.icon)
end

function UICharacterDungeonShop:__UpdateShopCurrencys()
  local itemCount = PlayerDataCenter:GetItemCount(self.__shopCurrencyId)
  self.ui.tex_Token.text = tostring(itemCount)
end

function UICharacterDungeonShop:__InitShopPage(shopList)
  if shopList == nil and #shopList == 0 then
    return
  end
  for _, shopId in pairs(shopList) do
    local go = self.ui.pageItem:Instantiate()
    go:SetActive(true)
    local pageItem = UINCharDungeonShopPage.New()
    pageItem:Init(go)
    local isUnlock = self.shopCtrl:ShopIsUnlockOnly(shopId)
    if not isUnlock then
      local shopCfg = ConfigData.shop[shopId]
      self.__conditionListener:AddConditionChangeListener(shopId, self.__OnCharShopUnlockEvent, shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2)
    end
    pageItem:InitCharDungeonShopPage(shopId, isUnlock, self.__onPageItemValueChanged)
    pageItem:SetSelectColor(self.selCol)
    if self.__ShopRedDotNode ~= nil then
      local shopNode = self.__ShopRedDotNode:GetChild(shopId)
      pageItem:SetCharDungeonShopPageReddot(shopNode ~= nil and 0 < shopNode:GetRedDotCount())
    end
    self.__shopPageList[shopId] = pageItem
  end
  local firstShopId = shopList[1]
  self.__shopPageList[firstShopId]:SetDungeonShopPageIsOn(true)
end

function UICharacterDungeonShop:OnPageItemValueChanged(pageItem, value)
  if not value then
    return
  end
  self.ui.loop_shopList.gameObject:SetActive(false)
  self.__isRefeshData = true
  local shopId = pageItem:GetCharDungeonShopId()
  self.shopCtrl:GetShopData(shopId, function(shopData)
    self.__isRefeshData = false
    self:ShowCharDungeonShop(shopData)
  end, true)
  if self.shopCtrl:ShopIsUnlockOnly(shopId) then
    if self.heroGrowAct ~= nil then
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      saveUserData:SetActivityHeroShopReaded(self.heroGrowAct:GetActId(), shopId)
    end
    if self.__ShopRedDotNode ~= nil then
      local shopNode = self.__ShopRedDotNode:GetChild(shopId)
      if shopNode ~= nil then
        shopNode:SetRedDotCount(0)
      end
    end
  end
  self:SetRecommend(pageItem)
end

function UICharacterDungeonShop:SetRecommend(pageItem)
  local IsRecommendShop = pageItem:IsItemRecommendShop()
  self.ui.recommendTitle:SetActive(IsRecommendShop)
end

function UICharacterDungeonShop:ShowCharDungeonShop(shopData)
  self.__shopData = shopData
  self.__shopDataList = {}
  for shelfId, goodData in pairs(shopData.shopGoodsDic) do
    table.insert(self.__shopDataList, goodData)
  end
  ShopUtil.CommonSortGoodList(self.__shopDataList)
  self.ui.loop_shopList.gameObject:SetActive(true)
  self.ui.loop_shopList.totalCount = #self.__shopDataList
  self.ui.loop_shopList:RefillCells()
  self:__RefreshCurShopUnlockInfo()
end

function UICharacterDungeonShop:__RefreshCurShopUnlockInfo()
  if self.__shopData == nil then
    return
  end
  if self.shopCtrl:ShopIsUnlockOnly(self.__shopData.shopId) then
    self.ui.cg_shopList.alpha = 1
    self.ui.conditionHead:SetActive(false)
  else
    self.ui.cg_shopList.alpha = 0.8
    self.ui.conditionHead:SetActive(true)
    local isConsumeUnlock = self.__shopData.shopCfg.pre_condition[1] == CheckerTypeId.CharDungeonConsume
    self.ui.obj_withIcon:SetActive(isConsumeUnlock)
    self.ui.tex_Condition.gameObject:SetActive(not isConsumeUnlock)
    if isConsumeUnlock then
      if self.heroGrowAct == nil then
        error("consume unlock not fit extra shop init")
        return
      end
      self.ui.tex_Costs.text = string.format("%d/%d", self.heroGrowAct:GetHeroGrowCostNum(), self.__shopData.shopCfg.pre_para2[1])
    else
      local lockInfo = CheckCondition.GetUnlockInfoLua(self.__shopData.shopCfg.pre_condition, self.__shopData.shopCfg.pre_para1, self.__shopData.shopCfg.pre_para2)
      self.ui.tex_Condition.text = lockInfo
    end
  end
end

function UICharacterDungeonShop:__OnCharShopUnlock(shopId)
  local pageItem = self.__shopPageList[shopId]
  pageItem:RefreshCharDungeonUnlock(true)
  if self.__isRefeshData then
    return
  end
  if self.__shopData == nil then
    return
  end
  if self.__shopData.shopId == shopId then
    self:__RefreshCurShopUnlockInfo()
  end
end

function UICharacterDungeonShop:__OnShopNewItem(go)
  local shopItem = UINCharDungeonShopItem.New()
  shopItem:Init(go)
  self.__shopItemDic[go] = shopItem
end

function UICharacterDungeonShop:__OnShopItemChanged(go, index)
  local shopItem = self.__shopItemDic[go]
  index = index + 1
  local shopGoodData = self.__shopDataList[index]
  shopItem:InitCharDungeonShopItem(shopGoodData, index, self.__OnCharDungeonItemClicked)
end

function UICharacterDungeonShop:__GetItemByIndex(index)
  local go = self.ui.loop_shopList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local shopItem = self.__shopItemDic[go]
    return shopItem
  end
  return nil
end

function UICharacterDungeonShop:OnCharDungeonItemClicked(index, shopItem)
  local shopGoodData = shopItem:GetDungeonShopItemData()
  if not self.shopCtrl:ShopIsUnlockOnly(shopGoodData.shopId) then
    return
  end
  if shopGoodData.isSoldOut then
    return
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
      local tmpShopItem = self:__GetItemByIndex(index)
      tmpShopItem:RefreshCharDungeonShopItem()
    end, true, resIds)
    win:OnClickAdd(true)
  end)
end

function UICharacterDungeonShop:__OnClickReturn()
  self:Delete()
end

function UICharacterDungeonShop:__OnClickCoin()
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

function UICharacterDungeonShop:__GetColor(colCfg)
  local colR = colCfg[1] / 255
  local colG = colCfg[2] / 255
  local colB = colCfg[3] / 255
  return Color.New(colR, colG, colB, 1)
end

function UICharacterDungeonShop:OnDelete()
  if self.__shopReddotFunc ~= nil then
    RedDotController:RemoveListener(self.__shopRedDotNodePath, self.__shopReddotFunc)
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__heroGrowActivityEvent)
  TimerManager:StopTimer(self.__refrehsDayTimerId)
  self.__conditionListener:Delete()
  self.__conditionListener = nil
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UICharacterDungeonShop
