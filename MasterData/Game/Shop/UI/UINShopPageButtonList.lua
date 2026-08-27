local UINShopPageButtonList = class("UINShopPageButtonList", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local UINShopLeftPage = require("Game.ShopMain.UINShopLeftPage")
local UINShopLeftPageWithSub = require("Game.ShopMain.UINShopLeftPageWithSub")

function UINShopPageButtonList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.shopCtrl = nil
  self.resloader = nil
  self.openPageCallback = nil
  self.groupItemDic = nil
  self.shopItemDic = nil
  self.leftPagePool = UIItemPool.New(UINShopLeftPage, self.ui.obj_btn_Page)
  self.ui.obj_btn_Page:SetActive(false)
  self.leftPageWithSubPool = UIItemPool.New(UINShopLeftPageWithSub, self.ui.obj_btn_PageHasSub)
  self.ui.obj_btn_PageHasSub:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Recommend, self, self.OnClickRecomand)
  self.__RedDotEvent = BindCallback(self, self.OnShopReddotRefresh)
  RedDotController:AddListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
end

function UINShopPageButtonList:InitPageBtnList(shopCtrl, resloader, openPageCallback, uishop)
  self.shopCtrl = shopCtrl
  self.resloader = resloader
  self.openPageCallback = openPageCallback
  self.uishop = uishop
end

function UINShopPageButtonList:RefreshPageBtns(isBeforeUnlockShop)
  self.leftPagePool:HideAll()
  self.leftPageWithSubPool:HideAll()
  self.groupItemDic = {}
  self.shopItemDic = {}
  local groups = {}
  for _, groupCfg in pairs(ConfigData.shop_classification) do
    if CS.ClientConsts.IsAudit then
      local temp = {
        [4] = true,
        [6] = true,
        [7] = true,
        [8] = true
      }
      if temp[groupCfg.id] then
        goto lbl_36
      end
    end
    table.insert(groups, groupCfg)
    ::lbl_36::
  end
  table.sort(groups, function(a, b)
    return a.id < b.id
  end)
  local showShopdic = {}
  for index, groupCfg in ipairs(groups) do
    local isOpen = false
    for _, shopId in ipairs(groupCfg.sub_ids) do
      if self.shopCtrl:ShopIsUnlock(shopId) then
        isOpen = true
        break
      end
    end
    local subIds = {}
    for _, shopId in ipairs(groupCfg.sub_ids) do
      table.insert(subIds, shopId)
    end
    if groupCfg.soldout == ShopEnum.ButtonListRule.gift then
      subIds = {}
      local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
      for _, pageId in ipairs(groupCfg.sub_ids) do
        if payGiftCtrl:CheckPageIdIsGiftShop(pageId) and #payGiftCtrl:GetShowPayGiftByPageId(pageId, false) > 0 then
          table.insert(subIds, pageId)
        else
          local shopCfg = ConfigData.shop[pageId]
          if shopCfg and shopCfg.shop_type == ShopEnum.eShopType.MonthCard and shopCfg.shop_para[1] and PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(shopCfg.shop_para[1]) then
            table.insert(subIds, pageId)
          end
        end
      end
    end
    if isOpen then
      local specialId
      if groupCfg.special_id ~= 0 and self.shopCtrl:CheckShopInTimePeriod(groupCfg.special_id) then
        specialId = groupCfg.special_id
      end
      subIds[1] = specialId or subIds[1]
      if #subIds == 1 then
        local shopId = subIds[1]
        if not isBeforeUnlockShop or ConfigData.game_config.shopShowBeforeUnlockDic[shopId] then
          local item = self.leftPagePool:GetOne(true)
          item:InitPage(groupCfg, self.openPageCallback, self.resloader, shopId)
          item.gameObject.name = tostring(shopId)
          local isHaveTime, _, limitTime = self.shopCtrl:GetIsThisShopHasTimeLimit(shopId)
          if isHaveTime and limitTime ~= nil and limitTime ~= -1 then
            self.uishop:SetNeedRefreshTm(limitTime)
          end
          self.shopItemDic[shopId] = item
        end
      else
        local item = self.leftPageWithSubPool:GetOne(true)
        local subItems = item:InitPage(groupCfg, self.openPageCallback, self.resloader, self.uishop, isBeforeUnlockShop, subIds)
        item.gameObject.name = tostring(groupCfg.id)
        self.groupItemDic[groupCfg.id] = item
        if subItems ~= nil then
          for _, subItem in pairs(subItems) do
            self.shopItemDic[subItem.shopId] = subItem
          end
        end
      end
    end
  end
  local recommendShopUnlock = self.shopCtrl:ShopIsUnlock(ShopEnum.ShopId.recomme)
  self.ui.btn_Recommend.gameObject:SetActive(recommendShopUnlock and not isBeforeUnlockShop)
end

function UINShopPageButtonList:Roll2SelectShopBtn(selectItem)
  if selectItem ~= nil then
    UIUtil.ScrollRectLocation(self.ui.scroll, selectItem, true, true)
  end
end

function UINShopPageButtonList:SelectShop(selectShopId)
  for shopId, item in pairs(self.shopItemDic) do
    item:RefreshState(selectShopId == shopId)
  end
  for groupId, groupItem in pairs(self.groupItemDic) do
    groupItem:RefreshState(false)
  end
  if self.shopItemDic[selectShopId] ~= nil then
    local selectGroupItem = self.shopItemDic[selectShopId].parentBtn
    if selectGroupItem ~= nil then
      selectGroupItem:RefreshState(true)
      self:Roll2SelectShopBtn(self.shopItemDic[selectShopId])
    else
      self:Roll2SelectShopBtn(self.shopItemDic[selectShopId])
    end
  end
end

function UINShopPageButtonList:OnClickRecomand()
  if self.openPageCallback ~= nil then
    self.openPageCallback(ShopEnum.ShopId.recomme)
  end
end

function UINShopPageButtonList:OnShopReddotRefresh()
  for _, groupItem in pairs(self.groupItemDic) do
    groupItem:RefreshRedDotState()
  end
  for _, shopItme in pairs(self.shopItemDic) do
    if shopItme.RefreshRedDotState ~= nil then
      shopItme:RefreshRedDotState()
    end
  end
end

function UINShopPageButtonList:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  base.OnDelete(self)
end

return UINShopPageButtonList
