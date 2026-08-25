local typeof = _ENV.typeof
local Z1ToggleGroup = CS.Z1Client.Z1ToggleGroup
local Z1Toggle = CS.Z1Client.Z1Toggle
local UIAnimationController = CS.Z1Client.UIAnimationController
local MainShopTypeTag = CommonDefine.MainShopTypeTag
local T_UIExport = typeof(CS.FrameWork.UIExport)
local T_ContentSizeFitter = typeof(CS.UnityEngine.UI.ContentSizeFitter)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local Vector2 = CS.UnityEngine.Vector2
local GameObjectUtil = CS.Framework.GameObjectUtil
local TOGGLE_ANIM_DURATION_FRAME = 2
local unopenedTipsId = 10207
local shopItemPrototypeMap = {}
local Illustrates = {
  [MainShopTypeTag.GoldShop] = "ExchangeShopRules",
  [MainShopTypeTag.AdvanceDC] = "ExchangeShopRules",
  [MainShopTypeTag.MainCopyShop] = "ExchangeShopRules",
  [MainShopTypeTag.TowerShop] = "ExchangeShopRules",
  [MainShopTypeTag.DailyChallenge] = "ExchangeShopRules"
}
local MainShopPanel, Super = System.NewClass("MainShopPanel", UIBasePanel)
MainShopPanel.uiResCls = UI_Recharge_Panel_MainResource

function MainShopPanel:ctor(jumpShopType, onClose)
  Super.ctor(self)
  self.jumpShopType = jumpShopType
  self.tabComponents = {}
  self.onClose = onClose
  self._limitGiftBoxActivityList = nil
end

function MainShopPanel:OnBind(binder)
  self.binder = binder
  ShopDataUtils.initMainAnim = false
  if self.jumpShopType and not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.jumpShopType) then
    self:CloseOfUnOpenedShopType()
    return
  end
  if self.jumpShopType and not MainShopDataUtils.GetShopDataByTag(self.jumpShopType) then
    self:CloseOfUnOpenedShopType()
    return
  end
  self.model = binder:createModel(MainShopPanelModel)
  local model = self.model
  self.goldShopModel = binder:createModel(MainShopGoldShopModel)
  model:SetGoldShopModel(self.goldShopModel)
  self.monthCardModel = binder:createModel(MonthCardModel)
  self.monthCardModel:RequestMonthCardInfo(nil, CommonDefine.MonthCardType.Diamond)
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:BindTitle(binder)
  binder:SetActive(self.ui.Image_Bg, false)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  self:BindMainTabs(binder)
  self:BindCoinInfo(binder)
  self:BindMonthCardGroup(binder)
  self:BindGoldShopGroup()
  self:BindBattlePassReviewGroup(binder)
  self:BindGoodsList()
  self:BindOnekeyPurchase()
  binder:BindEvent(EventMgr.Instance.MainShopUpdateEvent, System.fn(self, self.ResetGoodsList))
end

function MainShopPanel:BindTitle(binder)
  local DEFAULT_TITLE_WIDTH = 230
  binder:SetText(self.ui.Text_Title, LT.Text("ShopNameDefault"))
  local width = StrUtils.SetPreferredWidth(self.ui.Text_Title)
  local fitter = self.ui.Text_Title:GetComponent(T_ContentSizeFitter)
  if DEFAULT_TITLE_WIDTH < width then
    fitter.enabled = false
    self.ui.Text_Title.transform.sizeDelta = CS.UnityEngine.Vector2(DEFAULT_TITLE_WIDTH, self.ui.Text_Title.transform.sizeDelta.y)
  else
    fitter.enabled = true
  end
end

function MainShopPanel:ResetGoodsList()
  if self.resetListTimer ~= nil then
    return
  end
  self.resetListTimer = self.binder:BindTimer(0.05, 0, nil, function()
    self:BindShopItemToListView_Gift(self.binder)
    self.resetListTimer = nil
  end)
end

function MainShopPanel:BindGoodsList()
  self.binder:BindToRaw(function(cbinder)
    if self.ui.ScrollView_GiftBag.activeInHierarchy then
      self:BindShopItemToListView_Gift(cbinder)
    elseif self.ui.ScrollView_Bag_Material.activeInHierarchy then
      self:BindShopItemToListView_Nor(cbinder)
    elseif self.ui.ScrollView_Multi_Bag.activeInHierarchy then
      self:BindShopItemToListView_Multi(cbinder)
    end
  end, function()
    return self.model.curShopType
  end)
end

local QuickBuyShopTypes = {
  CommonDefine.MainShopTypeTag.GoldShop
}

function MainShopPanel:CloseOfUnOpenedShopType()
  Alert.Show(unopenedTipsId)
  self:SetRendered(false)
  self.binder:BindTimer(0, 0, nil, function()
    self:Close()
  end)
end

function MainShopPanel:BindShopItemToListView_Nor(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Bag_Material, function()
    return self.model.showShopItemList
  end, function(itemBinder, item, index)
    local shopItemData = self.model.showShopItemList[index]
    if type(shopItemData) ~= "table" then
      return
    end
    local compData = {
      shopItemData = shopItemData,
      shopType = self.model.curShopType,
      buyFunc = System.fn(self, self.OnSingleBuyCallback)
    }
    local prototype = shopItemPrototypeMap[self.model.curShopType] or MainShopItem
    itemBinder:BindComponent(prototype(item, compData))
  end)
end

function MainShopPanel:BindShopItemToListView_Gift(binder)
  if self.scroll2 then
    self.scroll2:Unbind()
  end
  self:SaveShopItemGameObjState(self.ui.UI_Recharge_Courtesy_Item)
  self.scroll2 = binder:BindToCircularListView(self.ui.ScrollView_GiftBag, function()
    return self.model.showShopItemList
  end, function(itemBinder, item, index)
    local shopItemData = self.model.showShopItemList[index]
    self:LoadShopItemGameObjState(item)
    if type(shopItemData) == "table" then
      local shopTid = shopItemData.tid
      local shopTypeTid = MainShopDataUtils.GetCfgByField("ShopType", shopTid)
      local shopTypeTag = DT.ShopType[shopTypeTid] and DT.ShopType[shopTypeTid].TypeTag
      local compData = {
        shopItemData = shopItemData,
        buyFunc = System.fn(self, self.OnSingleBuyCallback),
        shopType = shopTypeTag
      }
      if shopTypeTag and shopTypeTag == CommonDefine.MainShopTypeTag.DailyFreeGiftBagShop then
        itemBinder:BindComponent(MainShopDailyFreeGiftBagItem(item, compData, self.model))
      elseif ShopCfgUtils.IsClothShopType(shopTid) then
        itemBinder:BindComponent(MainShopClothGoodsItem(item, compData, self.model))
      else
        itemBinder:BindComponent(MainShopGiftBagItem(item, compData, self.model))
      end
    elseif type(shopItemData) == "string" and shopItemData == CommonDefine.MonthCardType.Energy then
      itemBinder:BindComponent(MainShopEnergyMonthCardItem(item))
    end
  end)
  self:BindGiftBagScrollContentSnap(self.scroll2)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_GiftBag)
end

function MainShopPanel:BindGiftBagScrollContentSnap(listBinder)
  if not listBinder then
    return
  end
  listBinder:BindToScrollRectValueChange(self.ui.ScrollView_GiftBag, function()
    self:SnapGiftBagScrollContentPos()
  end)
end

function MainShopPanel:SnapGiftBagScrollContentPos()
  local scrollRect = self.ui.ScrollView_GiftBag:GetComponent(T_ScrollRect)
  if not scrollRect or IsNil(scrollRect.content) then
    return
  end
  local contentRt = scrollRect.content
  local pos = contentRt.anchoredPosition
  local x = math.floor(pos.x + 0.5)
  if x == pos.x then
    return
  end
  contentRt.anchoredPosition = Vector2(x, pos.y)
end

function MainShopPanel:BindShopItemToListView_Multi(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Multi_Bag, function()
    return self.model.showShopItemList
  end, function(itemBinder, item, index)
    local shopItemData = self.model.showShopItemList[index]
    if type(shopItemData) ~= "table" then
      return
    end
    local compData = {
      shopItemData = shopItemData,
      shopType = self.model.curShopType,
      buyFunc = System.fn(self, self.OnSingleBuyCallback)
    }
    local prototype = shopItemPrototypeMap[self.model.curShopType] or MainShopItem
    itemBinder:BindComponent(prototype(item, compData))
  end)
end

function MainShopPanel:SaveShopItemGameObjState(baseGameObj)
  self._shopItemGameObjState = {}
  local uiExport = baseGameObj:GetComponent(T_UIExport)
  local uiNodeList = uiExport and uiExport.uiNodeList
  if uiNodeList then
    local uiNode, name, obj
    for i = 0, uiNodeList.Count - 1 do
      uiNode = uiNodeList[i]
      name, obj = uiNode.name, uiNode.obj
      self._shopItemGameObjState[name] = obj.activeSelf
    end
  end
end

function MainShopPanel:LoadShopItemGameObjState(gameObj)
  local uiExport = gameObj:GetComponent(T_UIExport)
  local uiNodeList = uiExport and uiExport.uiNodeList
  if uiNodeList then
    local uiNode, name, obj
    for i = 0, uiNodeList.Count - 1 do
      uiNode = uiNodeList[i]
      name, obj = uiNode.name, uiNode.obj
      if not IsNil(obj) and self._shopItemGameObjState[name] ~= nil then
        self.binder:SetActive(obj, self._shopItemGameObjState[name])
      end
    end
  end
end

function MainShopPanel:BindCoinInfo(binder)
  binder:BindToRaw(function(itemBinder)
    itemBinder:BindComponent(require("UI.Public.Item.CommonCurrencyGroupItem")(self.ui.Group_Coin, self.model.currencyList, false, false))
  end, function()
    return self.model.curShopType
  end)
end

function MainShopPanel:BindMainTabs(binder)
  local tRelativeUIs = {
    {
      MainShopTypeTag.MoonCard,
      self.ui.Group_Card,
      System.fn(self, self._OpenAnimMoonCard)
    },
    {
      MainShopTypeTag.BattlePassReview,
      self.ui.Group_Instructions,
      System.fn(self, self._OpenBattlePassReview)
    },
    {
      MainShopTypeTag.GiftBag,
      self.ui.Group_GiftBag,
      System.fn(self, self._OpenGiftBag)
    },
    {
      MainShopTypeTag.LimitedTimeGiftBox
    },
    {
      MainShopTypeTag.DiamondShop,
      self.ui.ScrollView_Bag_Material
    },
    {
      MainShopTypeTag.ChangeShop,
      self.ui.ScrollView_Multi_Bag
    },
    {
      MainShopTypeTag.ActivityShop,
      self.ui.ScrollView_Bag_Material
    },
    {
      MainShopTypeTag.ActivityShop1,
      self.ui.ScrollView_Bag_Material
    },
    {
      MainShopTypeTag.ClothersShop,
      self.ui.Group_GiftBag,
      System.fn(self, self._OpenGiftBag)
    }
  }
  local toggleNodes = {
    self.ui.Toggle_1,
    self.ui.Toggle_2
  }
  self.toggleUis = {
    self.ui.Toggle_Sub1,
    self.ui.Toggle_Sub2,
    self.ui.Toggle_Sub3,
    self.ui.Toggle_Sub4,
    self.ui.Toggle_Sub5
  }
  self.tabDict = {}
  for index = #tRelativeUIs, 1, -1 do
    local relativeDatas = tRelativeUIs[index]
    local tabType = relativeDatas[1]
    if not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(tabType) then
    elseif tabType ~= MainShopTypeTag.LimitedTimeGiftBox and MainShopDataUtils.GetShopDataByTag(tabType) == nil then
    elseif tabType == MainShopTypeTag.LimitedTimeGiftBox then
      local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
      if not table.next(giftList) then
      else
        self:_GetLimitGiftBoxActivityList()
        if 0 == #MainShopDataUtils.GetShopItemList(tabType) and tabType == MainShopTypeTag.ClothersShop then
        elseif MainShopDataUtils.GetShopTypeCfgByTypeTag(tabType).MainShopType and 0 ~= MainShopDataUtils.GetShopTypeCfgByTypeTag(tabType).MainShopType[1] then
        else
          local classifyGroup = self.model:GetShopTypeGroup(tabType)
          if not self.tabDict[classifyGroup] then
            self.tabDict[classifyGroup] = {}
          end
          table.insert(self.tabDict[classifyGroup], relativeDatas)
        end
      end
    end
  end
  for _, tRelaUIs in pairs(self.tabDict) do
    table.sort(tRelaUIs, function(a, b)
      local aTypeTag = a[1]
      local bTypeTag = b[1]
      local aUnlockWeight = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(aTypeTag) and 1 or 0
      local bUnlockWeight = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(bTypeTag) and 1 or 0
      local aBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(aTypeTag).BaseSortID
      local bBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(bTypeTag).BaseSortID
      if aUnlockWeight ~= bUnlockWeight then
        return aUnlockWeight > bUnlockWeight
      end
      return aBaseSortId < bBaseSortId
    end)
    for groupIndex, toggleUi in pairs(toggleNodes) do
      if toggleUi then
        binder:BindToZ1Toggle(toggleUi, nil, function()
          self.model:SetCurShopTypeGroup(groupIndex)
        end)
      end
    end
  end
  binder:SetActive(self.ui.Group_Reset, false)
  self.model:SetCurShopTypeGroup(self:GetDefaultSelectMainTag())
  self:BindChildTabs(binder)
  self:BindMultiTabs(binder)
  self.jumpShopType = nil
end

function MainShopPanel:BindMultiTabs(binder)
  for _, uiGroup in pairs(MainShopDataUtils.GetMultiUIGroups()) do
    for index, shopTypeTag in ipairs(uiGroup) do
      binder:BindToZ1Toggle(self.toggleUis[index], nil, function(isOn)
        if isOn then
          local isUnlock = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(shopTypeTag)
          if isUnlock then
            self.model:SetCurShopType(shopTypeTag)
            RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Shop, RedPointDataUtils.RedAttrType.IsNew, MainShopDataUtils.GetShopRealType(shopTypeTag))
          else
            binder:SetZ1Toggle(self.toggleUis[ShopDataUtils.indexOf(MainShopDataUtils.GetMultiUIGroups()[self.model:GetParentShopType(self.model.curShopType)], self.model.curShopType) or 1], true)
            Alert.Show(unopenedTipsId)
          end
        end
      end, function()
        return self.model.curShopType == shopTypeTag
      end)
      local toggleTf = self.toggleUis[index].transform
      binder:BindComponent(RedDotComponent(GameObjectUtil.DeepFindChild(toggleTf, "Com_RedDot").gameObject, CommonDefine.RedDotType.Dot, nil, function()
        do return RedPointDataUtils.GetShopTagRedData end
        return RedPointDataUtils.GetShopTagRedData, shopTypeTag
      end))
    end
  end
  for index, uis in ipairs(self.toggleUis) do
    binder:BindToVisible(uis, function()
      local curParentType = self.model:GetParentShopType(self.model.curShopType)
      local visible
      if curParentType and MainShopDataUtils.GetMultiUIGroups()[curParentType] then
        visible = index <= #MainShopDataUtils.GetMultiUIGroups()[curParentType]
      else
        visible = false
      end
      if index > 1 then
        binder:SetActive(self.ui["Toggle_Line" .. tostring(index - 1)], visible)
      end
      return visible
    end)
  end
end

function MainShopPanel:BindChildTabs(binder)
  local tTabComObjs = {}
  local toggleGroup = self.ui.Group_Toggle:GetComponent(typeof(Z1ToggleGroup))
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, function()
    return Illustrates[self.model.curShopType] ~= nil
  end)
  binder:BindToRaw(function(cBinder, nowGroupId, oldGroupId)
    local tRelativeUIs = self.tabDict[nowGroupId] or {}
    self.tabComponents = self.tabComponents or {}
    if (self.tabDict[oldGroupId] and #self.tabDict[oldGroupId] or 0) > #tRelativeUIs then
      for i = #tRelativeUIs + 1, #self.tabDict[oldGroupId] do
        if self.tabComponents[i] then
          self.tabComponents[i] = nil
        end
      end
    end
    if oldGroupId and self.tabDict[oldGroupId] and self.model.curShopType then
      for _, relativeDatas in ipairs(self.tabDict[oldGroupId]) do
        if self.model.curShopType == relativeDatas[1] then
          cBinder:SetActive(relativeDatas[2], false)
        end
      end
    end
    for idx, relativeDatas in ipairs(tRelativeUIs) do
      local tabType, relativeUI, openAnim = table.unpack(relativeDatas)
      
      local function openAnimFunc()
        self.uiAnimationController:StopPlayableGraph()
        if openAnim then
          openAnim()
        end
      end
      
      local tabItemCom = cBinder:BindNewComponent(self.ui.Group_Toggle, MainShopTabItem, UI_Shop_Item_ToggleResource, relativeUI, tabType, openAnimFunc)
      self.tabComponents[idx] = tabItemCom
      self:_PlayToggleAnim(tabItemCom, idx)
      local uiRoot = tabItemCom.rootUINode
      
      local function toggleFunc(typeTag)
        if typeTag == self.model.curShopTypethen then
          return
        end
        if typeTag == CommonDefine.MainShopTypeTag.ChangeShop and Illustrates[self.model.curShopType] then
          return
        end
        cBinder:SetZ1Toggle(uiRoot, true)
        if typeTag == tabType then
          if MainShopDataUtils.GetMultiUIGroups()[typeTag] then
            local nowTypeTag = self.jumpShopType or MainShopDataUtils.GetMultiShopFirstUnlockTypeTag(typeTag)
            for index, shopTypeTag in ipairs(MainShopDataUtils.GetMultiUIGroups()[typeTag]) do
              local shopCfg = DT.ShopType[MainShopDataUtils.GetShopTypeIDByTag(shopTypeTag)]
              local toggleTf = self.toggleUis[index].transform
              cBinder:SetText(GameObjectUtil.DeepFindChild(toggleTf, "Text_Toggle_Normal").gameObject, LT.Text(shopCfg.ShopName))
              cBinder:SetText(GameObjectUtil.DeepFindChild(toggleTf, "Text_Toggle_Select").gameObject, LT.Text(shopCfg.ShopName))
              cBinder:SetImage(GameObjectUtil.DeepFindChild(toggleTf, "Image_Icon_Toggle_Normal").gameObject, shopCfg.IconNormal)
              cBinder:SetImage(GameObjectUtil.DeepFindChild(toggleTf, "Image_Icon_Toggle_Select").gameObject, shopCfg.IconSelect)
            end
            cBinder:SetZ1Toggle(self.toggleUis[ShopDataUtils.indexOf(MainShopDataUtils.GetMultiUIGroups()[typeTag], nowTypeTag) or 1], true)
            self.model:SetCurShopType(nowTypeTag)
            self.jumpShopType = nil
          else
            self.model:SetCurShopType(typeTag)
          end
          cBinder:CircularScrollTo(self.ui.ScrollView_Bag_Material, 1)
          cBinder:CircularScrollTo(self.ui.ScrollView_Multi_Bag, 1)
          cBinder:CircularScrollTo(self.ui.ScrollView_GiftBag, 1)
          RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Shop, RedPointDataUtils.RedAttrType.IsNew, MainShopDataUtils.GetShopRealType(typeTag))
        end
        if typeTag == MainShopTypeTag.MoonCard then
          RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.MonthCardExpire, "red")
        end
        if typeTag ~= MainShopTypeTag.LimitedTimeGiftBox then
          UIManager.Instance:CloseByUrl(Urls.MainShopLimitPanel)
        else
          self:_OpenLimitedTimeGiftBox()
        end
        if Illustrates[typeTag] then
          PlayerDataUtils.OpenFirstTimeIllustrate(typeTag, nil, LT.Text(Illustrates[tabType]))
        end
      end
      
      uiRoot:GetComponent(typeof(Z1Toggle)).group = toggleGroup
      tabItemCom:SetCallBack(toggleFunc)
      tTabComObjs[tabType] = uiRoot
      self.tabComponents[tabType] = tabItemCom
    end
    local defaultType = self:GetDefaultSelectTag(tRelativeUIs)
    if defaultType then
      if tTabComObjs[defaultType] then
        cBinder:SetZ1Toggle(tTabComObjs[defaultType], true)
      else
        local parentType = self.model:GetParentShopType(defaultType)
        if parentType and tTabComObjs[parentType] then
          cBinder:SetZ1Toggle(tTabComObjs[parentType], true)
        end
      end
    end
  end, function()
    return self.model.curShopTypeGroup
  end)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Question, function()
    local typeTag = self.model.curShopType
    if Illustrates[typeTag] then
      PlayerDataUtils.OpenIllustrate(nil, LT.Text(Illustrates[typeTag]))
    end
  end)
end

function MainShopPanel:_OpenLimitedTimeGiftBox()
  local popupList = self:_GetLimitGiftBoxActivityList()
  if 0 == #popupList then
    return
  end
  UIManager.Instance:Reopen(Urls.MainShopLimitPanel, popupList)
end

function MainShopPanel:_GetLimitGiftBoxActivityList()
  local popupList = ActivityManager.Instance.model:GetPopupLimitGiftActivityList()
  if #popupList > 0 then
    self._limitGiftBoxActivityList = popupList
  end
  return self._limitGiftBoxActivityList or {}
end

function MainShopPanel:GetDefaultSelectMainTag()
  if self.jumpShopType and MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.jumpShopType) then
    do return self.model.GetShopTypeGroup, self.model end
    return self.model.GetShopTypeGroup, self.model, self.jumpShopType
  end
  return 1
end

function MainShopPanel:GetDefaultSelectTag(tRelativeUIs)
  if self.jumpShopType and MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.jumpShopType) then
    local retType = self.jumpShopType
    return retType
  end
  local defaultTag = tRelativeUIs and tRelativeUIs[1] and tRelativeUIs[1][1]
  return defaultTag or self.model:GetParentShopType(defaultTag)
end

function MainShopPanel:BindBattlePassReviewGroup(binder)
  binder:BindToText(self.ui.Text_Battle_Pass_Time, function()
    do return LT.Text end
    return LT.Text, self.model.battlePassCountDown
  end)
  binder:BindZ1Button(self.ui.Btn_To, function()
    local startCountDown = BattlePassDataUtils.GetStartCountDown()
    if startCountDown then
      Alert.ShowStr(LT.Text(startCountDown))
    else
      BattlePassDataUtils.OpenBattlePassPanel()
    end
  end)
  binder:UpdateLocalizedTextAndResouce(self.ui.UI_Recharge_Instructions)
end

function MainShopPanel:BindMonthCardGroup(binder)
  local typeTag = CommonDefine.MainShopTypeTag
  local tabComp = self.tabComponents[typeTag.MoonCard]
  if tabComp and tabComp.ui and tabComp.ui.Group_Recommend then
    binder:BindToVisible(tabComp.ui.Group_Recommend, function()
      return self.monthCardModel:GetState() == CommonDefine.MonthCardState.NeverPurchased and not RedPointDataUtils.IsMonthCardExpire()
    end)
  end
  binder:BindToVisible(self.ui.Group_Effecting, function()
    return self.monthCardModel:GetState() == CommonDefine.MonthCardState.InEffect
  end)
  binder:BindToVisible(self.ui.Text_C_Today, function()
    return self.monthCardModel:GetRewardsReceivedState() == CommonDefine.RewardState.Received
  end)
  binder:BindButtonClick(self.ui.Button_Question, function()
    local title = LT.Text("RuleTipsTitle")
    local content = LT.Text("MonthCardRuleText")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end)
  binder:BindZ1Button(self.ui.Btn_Buy_Moon_Card, function()
    self:_PurchaseMonthCard()
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "Shop_Buy_Btn"
  end)
  binder:BindToRaw(function(_, expiredTimestamp)
    self.monthCardCountdown = expiredTimestamp - TimeUtils.GetServerTime()
    self:_SetMonthCardCountdown(binder, self.monthCardCountdown)
  end, function()
    do return self.monthCardModel.GetExpiredTimestamp end
    return self.monthCardModel.GetExpiredTimestamp, self.monthCardModel
  end)
  self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
    self.monthCardCountdown = self.monthCardCountdown - 0.033
    self:_SetMonthCardCountdown(binder, self.monthCardCountdown)
  end)
  local itemInfo = self.monthCardModel:GetItemInfo()
  local itemCfg_1 = DT.Item[itemInfo.buyItem.tid]
  local itemCount_1 = itemInfo.buyItem.count
  local itemCfg_2 = DT.Item[itemInfo.dailyItem.tid]
  local itemCount_2 = itemInfo.dailyItem.count
  binder:SetText(self.ui.Text_Get1_Name, ItemNumUtils.GetNameStr(LT.Text(itemCfg_1.Name)))
  binder:SetText(self.ui.Text_Get1_Num, ItemNumUtils.GetStr(itemCount_1))
  binder:SetImage(self.ui.Image_Get1_Icon, itemCfg_1.Icon)
  binder:SetText(self.ui.Text_Get2_Name, ItemNumUtils.GetNameStr(LT.Text(itemCfg_2.Name)))
  binder:SetText(self.ui.Text_Get2_Num, ItemNumUtils.GetStr(itemCount_2))
  binder:SetImage(self.ui.Image_Get2_Icon, itemCfg_2.Icon)
  local priceCfg = DT.Constant.MonthlyCardPrice.Data
  local currencyCfg = DT.Item[priceCfg[1]]
  binder:SetImage(self.ui.Image_Awaker_Icon_2, currencyCfg.Icon)
  local price = priceCfg[2]
  binder:SetText(self.ui.Text_Awaker_Ten, ItemNumUtils.GetStr(price))
end

function MainShopPanel:BindGoldShopGroup()
  self:BindRefreshTimeAndCost()
end

function MainShopPanel:BindRefreshTimeAndCost()
  self.binder:BindToRaw(function(cbinder, shopTypeTag)
    local shopData = MainShopDataUtils.GetShopDataByTag(shopTypeTag) or {}
    cbinder:SetActive(self.ui.Group_CloseTime, false)
    cbinder:SetActive(self.ui.Image_Flushed_Mul, false)
    if shopTypeTag == MainShopTypeTag.GoldShop then
      cbinder:SetActive(self.ui.Image_Flushed_Mul, true)
    else
      local temp = table.clone(shopData)
      temp.goodsList = {}
      if shopData and (shopData.refreshTime or 0) > 0 or (shopData.closeTs or 0) > 0 then
        if (shopData.refreshTime or 0) > 0 then
          cbinder:SetActive(self.ui.Image_Flushed_Mul, true)
          cbinder:BindTimer(1, -1, nil, function()
            self:_UpdateGoldShopRefreshText(shopData.refreshTime)
          end)
          self:_UpdateGoldShopRefreshText(shopData.refreshTime)
        else
          cbinder:SetActive(self.ui.Image_Flushed_Mul, false)
          cbinder:BindTimer(1, -1, nil, function()
            self:_UpdateGoldShopCloseTime(shopData.closeTs)
          end)
          self:_UpdateGoldShopCloseTime(shopData.closeTs)
        end
      end
    end
  end, function()
    return self.model.curShopType
  end)
end

function MainShopPanel:_UpdateGoldShopRefreshText(refreshTime)
  local rst = ""
  local countDown = refreshTime - TimeUtils.GetServerTime()
  if countDown < 0 then
    return rst
  end
  local _, m, h, s = TimeUtils.ConvertTime(countDown)
  rst = LT.Textf("GoldShopRefreshDesc", m, h, s)
  self.binder:SetActive(self.ui.Group_CloseTime, false)
end

function MainShopPanel:BindOnekeyPurchase()
  self.binder:BindToRaw(function()
    local showBtn = table.contains(QuickBuyShopTypes, self.model.curShopType)
    self.ui.Btn_OnekeyPurchase_Mul:SetActive(showBtn)
  end, function()
    return self.model.curShopType
  end)
  self.binder:BindZ1Button(self.ui.Btn_OnekeyPurchase_Mul, function()
    local shopDataList = self.model:GetCanBuyShopDataList() or {}
    shopDataList = table.clone(shopDataList)
    ShopController.Instance:OpenShopOneKeyPurchaseView(shopDataList, self.model.shopTypeId)
  end)
end

function MainShopPanel:_SetMonthCardCountdown(binder, countdown)
  local remainingDays = 0
  if countdown > 0 then
    remainingDays = TimeUtils.SecsToDays(countdown)
  end
  local code = DT.ColorConfig.MonthCard.Light
  local str = string.format("<color=%s>%s</color>", code, remainingDays)
  binder:SetText(self.ui.Text_Effecting, LT.Textf("MonthCardLeftDaysText", str))
end

function MainShopPanel:_PurchaseMonthCard()
  local remainingDays = 0
  local expiredTimestamp = self.monthCardModel:GetExpiredTimestamp()
  local remainingSecs = expiredTimestamp - TimeUtils.GetServerTime()
  if remainingSecs > 0 then
    remainingDays = TimeUtils.SecsToDays(remainingSecs)
  end
  local daysLimit = DT.GetConstant("MonthlyCardBuyLimit")
  if remainingDays >= daysLimit then
    local tipCfg = DT.TipsType[10634]
    local desc = LT.Textf(tipCfg.Desc, daysLimit)
    Alert.Show(10634, nil, nil, nil, desc)
    return
  end
  local priceCfg = DT.Constant.MonthlyCardPrice.Data
  local totalCurrency = ItemDataUtils.GetItemNum(priceCfg[1])
  if totalCurrency < priceCfg[2] then
    Alert.SetMaskClickClose(true)
    Alert.Show(10635, nil, function()
      UIManager.Instance:Reopen(Urls.ChargeMainPanel)
    end)
    return
  end
  local costNum = DT.Constant.MonthlyCardPrice.Data[2]
  Alert.ShowPayMoneyBuyConfirm(costNum, function()
    self.monthCardModel:PurchaseMonthCard(function()
      local itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
      local buyItemTid = itemInfo.buyItem.tid
      local buyItemCount = itemInfo.buyItem.count
      ItemDataUtils.ShowItemGain({
        {tid = buyItemTid, changedNum = buyItemCount}
      }, function()
        self:_ShowMonthCardReceiveRewardsPanel()
      end)
    end, CommonDefine.MonthCardType.Diamond)
  end)
  local costData = {
    tid = CommonDefine.CurrencyType.PayMoney,
    num = DT.Constant.MonthlyCardPrice.Data[2]
  }
  Alert.ShowCoin({
    CommonDefine.CurrencyType.PayMoney
  }, true, costData)
end

function MainShopPanel:_ShowMonthCardReceiveRewardsPanel()
  self.monthCardModel:RequestMonthCardInfo(function()
    local rewardsReceivedState = self.monthCardModel:GetRewardsReceivedState()
    if rewardsReceivedState == CommonDefine.RewardState.Available then
      local expiredTimestamp = self.monthCardModel:GetExpiredTimestamp()
      UIManager.Instance:Reopen(Urls.MainShopMonthCardRewardPanel, expiredTimestamp, function()
        self.monthCardModel:ReceiveRewards(function()
          local itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
          local dailyItemTid = itemInfo.dailyItem.tid
          local dailyItemCount = itemInfo.dailyItem.count
          ItemDataUtils.ShowItemGain({
            {tid = dailyItemTid, changedNum = dailyItemCount}
          })
        end)
      end)
    end
  end, CommonDefine.MonthCardType.Diamond)
end

function MainShopPanel:OnSingleBuyCallback(shopItemData, isAlert)
  local maxNum = shopItemData.maxBuyCount
  local goodsConfig = DT.Shop[shopItemData.tid]
  local costItemId = goodsConfig.Price[1]
  local singleSellItemTid = 2 == #(goodsConfig.Item or {}) and goodsConfig.Item[1]
  local singleSellItemType = singleSellItemTid and ItemDataUtils.GetItemConfigByField("Type", singleSellItemTid)
  local singleSellItemSubType = singleSellItemTid and ItemDataUtils.GetItemConfigByField("SubType", singleSellItemTid)
  if (isAlert or nil == isAlert) and (ItemDataUtils.IsHaveMaxLevelWeapon(singleSellItemTid) or MainShopDataUtils.IsMaxPotencyByShopId(shopItemData.tid)) then
    local remainNum = MainShopDataUtils.GetGoodRemaining(shopItemData)
    if remainNum > 0 then
      Alert.ShowWithParams(20229, {
        ItemDataUtils.GetItemName(singleSellItemTid),
        remainNum
      }, nil, function()
        self:OnSingleBuyCallback(shopItemData, false)
      end)
      return
    end
  end
  if goodsConfig.ShopType == MainShopDataUtils.GetShopTypeIDByTag(MainShopTypeTag.GiftBag) then
    if singleSellItemSubType == CommonDefine.ItemSubType.MultiSelectChest then
      UIManager.Instance:Reopen(Urls.ChristmasFreeChooseGiftView, singleSellItemTid, goodsConfig, shopItemData.isSell)
      return
    end
    local typeTag = MainShopDataUtils.GetShopRealType(self.model.curShopType)
    UIManager.Instance:Reopen(Urls.MainShopGiftBagBuyConfirmPanel, shopItemData, typeTag, self.model.currencyList)
  elseif singleSellItemType == cd.ItemType.SkinItem then
    UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, shopItemData, nil)
  else
    UIManager.Instance:Reopen(Urls.MainShopSingleBuyConfirmPanel, {
      itemId = costItemId,
      shopItemData = shopItemData,
      shopType = MainShopDataUtils.GetShopRealType(self.model.curShopType),
      maxNum = maxNum,
      currencyList = self.model.currencyList
    })
  end
end

function MainShopPanel:CheckIsUnlock(typeTag, isShowLockTip)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, typeTag)
  if not unlocked and isShowLockTip then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Shop, typeTag)
  end
  return unlocked
end

function MainShopPanel.OnCustomerService()
  SdkMgr.GetCustomerService()
end

function MainShopPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

function MainShopPanel:_PlayToggleAnim(tabItemCom, idx)
  tabItemCom.ui.uiNode:SetActive(false)
  FrameWaiter.OnNextFrame(function()
    if not tabItemCom.ui then
      return
    end
    tabItemCom.ui.uiNode:SetActive(true)
    tabItemCom:_PlayCtorAnim()
  end, TOGGLE_ANIM_DURATION_FRAME * idx)
end

function MainShopPanel:_OpenAnimMoonCard()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_Card_Open")
end

function MainShopPanel:_OpenBattlePassReview()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_Instructions_Open")
end

function MainShopPanel:_OpenGiftBag()
end

function MainShopPanel:_OpenAnimRecharge()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_Rest_Open")
end

function MainShopPanel:_UpdateGoldShopCloseTime(closeTs)
  local rst = ""
  local countDown = closeTs - TimeUtils.GetServerTime()
  if countDown < 0 then
    return rst
  end
  self.binder:SetActive(self.ui.Group_CloseTime, true)
  self.binder:SetText(self.ui.Text_CloseTime, TimeUtils.ActivityCountDownFormat(countDown))
end

function MainShopPanel:OnUnbind(binder)
  Super.OnUnbind(self, binder)
  self._limitGiftBoxActivityList = nil
end

function MainShopPanel:Close()
  Super.Close(self)
  UIManager.Instance:CloseByUrl(Urls.MainShopLimitPanel)
  if self.onClose then
    self.onClose()
  end
end

return MainShopPanel
