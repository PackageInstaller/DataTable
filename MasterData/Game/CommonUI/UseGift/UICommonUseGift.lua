local UICommonUseGift = class("UICommonUseGift", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINCmUseGiftItem = require("Game.CommonUI.UseGift.UINCmUseGiftItem")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local factory = require("LuaConfigs.factory")
local cs_Canvas = CS.UnityEngine.Canvas
local cs_MessageCommon = CS.MessageCommon

function UICommonUseGift:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickCancle)
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self.OnClickCancle)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.OnClickReduce)
  UIUtil.AddValueChangedListener(self.ui.scrollbar, self, self.OnScrollbarValueChange)
  self.itemSelectPool = UIItemPool.New(UINCmUseGiftItem, self.ui.obj_choseItem)
  self.ui.obj_choseItem:SetActive(false)
  self.itemFixed = UINBaseItem.New()
  self.itemFixed:Init(self.ui.obj_itemGiftSub)
  self.__OnSelectItemCallback = BindCallback(self, self.OnSelectItemCallback)
  self.__OnUseGiftSuccess = BindCallback(self, self.__UseGiftSuccess)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdateUseGift)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

function UICommonUseGift:InitCommonUseGift(itemCfg, defalutSelectItemId, closeFunc)
  self.itemCfg = itemCfg
  self.closeFunc = closeFunc
  if not ConfigData:IsManualOpenGiftItem(self.itemCfg) then
    error("道具不是礼包却打开了礼包使用界面")
    return
  end
  local itemData = PlayerDataCenter.itemDic[self.itemCfg.id]
  local itemMaxCount = 0
  if itemData ~= nil then
    itemMaxCount = itemData:GetCount()
  end
  self:_UpdItemMaxCount(itemMaxCount)
  self:_UpdItemCountUse(self.itemCountMax == 0 and 0 or 1)
  self.selectItem = nil
  self:_ResetOutOfLimitTip()
  self:RefreshUseGiftView(defalutSelectItemId)
end

function UICommonUseGift:RefreshUseGiftView(defalutSelectItemId)
  self.isMultSelect = false
  self.multSelectMaxNum = 0
  self.mutSelectItemList = nil
  if self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    self:__RefreshUseGiftViewWithSelect(defalutSelectItemId)
  elseif self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2 then
    self:__RefreshUseGiftViewWithSkin(defalutSelectItemId)
  elseif self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin then
    self:__RefreshUseGiftViewWithResidentBPSkin(defalutSelectItemId)
  elseif self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup then
    self:__RefreshUseGiftViewWithResidentBPFurniture()
    self.isMultSelect = true
    self.multSelectMaxNum = 3
    self.mutSelectItemList = {}
  else
    self:__RefreshUseGiftViewWithNormal()
  end
  self:__UseCountChangeUpdate(self.itemCountUse, true)
  if self.itemCfg.auto_max then
    self.ui.scrollbar.value = self.itemCountMax
  else
    self.ui.scrollbar.value = self.itemCountUse
  end
end

function UICommonUseGift:__RefreshUseGiftViewWithSelect(defalutSelectItemId)
  self.ui.obj_itemList:SetActive(true)
  self.ui.obj_itemGift:SetActive(false)
  self.ui.obj_ItemInfo:SetActive(false)
  local itemList = {}
  for k, v in pairs(self.itemCfg.giftOptainDic) do
    table.insert(itemList, k)
  end
  table.sort(itemList, function(a, b)
    return a < b
  end)
  self.itemSelectPool:HideAll()
  local selectIndex = 0
  for index, id in ipairs(itemList) do
    local item = self.itemSelectPool:GetOne()
    local itemCfg = ConfigData.item[id]
    item:InitCmUseGiftItem(itemCfg, self.itemCfg.giftOptainDic[id] * self.itemCountUse, self.__OnSelectItemCallback)
    if id == defalutSelectItemId then
      selectIndex = index
    end
  end
  cs_Canvas.ForceUpdateCanvases()
  if selectIndex == 0 then
    self.ui.obj_Select:SetActive(false)
  else
    self:__SelectItemStateUpdate(self.itemSelectPool.listItem[selectIndex])
  end
end

function UICommonUseGift:__RefreshUseGiftViewWithSkin(defalutSelectItemId)
  self.ui.obj_itemList:SetActive(true)
  self.ui.obj_itemGift:SetActive(false)
  self.ui.obj_ItemInfo:SetActive(false)
  local itemList = {}
  for k, v in pairs(self.itemCfg.giftOptainDic) do
    table.insert(itemList, k)
  end
  table.sort(itemList, function(a, b)
    return a < b
  end)
  self.itemSelectPool:HideAll()
  local selectIndex = 0
  for index, id in ipairs(itemList) do
    local item = self.itemSelectPool:GetOne()
    local itemCfg = ConfigData.item[id]
    local isHas = false
    if itemCfg.type == eItemType.Skin and PlayerDataCenter.skinData:IsHaveSkin(id) then
      isHas = true
    end
    item:InitCmUseGiftItem(itemCfg, self.itemCfg.giftOptainDic[id] * self.itemCountUse, self.__OnSelectItemCallback)
    item:SetHasFlagObjActive(isHas)
    if id == defalutSelectItemId then
      selectIndex = index
    end
  end
  cs_Canvas.ForceUpdateCanvases()
  if selectIndex == 0 then
    self.ui.obj_Select:SetActive(false)
  else
    self:__SelectItemStateUpdate(self.itemSelectPool.listItem[selectIndex])
  end
end

function UICommonUseGift:__RefreshUseGiftViewWithResidentBPSkin()
  self.ui.obj_itemList:SetActive(true)
  self.ui.obj_itemGift:SetActive(false)
  self.ui.obj_ItemInfo:SetActive(false)
  local itemList = {}
  for skinId, _ in pairs(ConfigData.battlepass_skin[self.itemCfg.id]) do
    local isHas = PlayerDataCenter.skinData:IsHaveSkin(skinId)
    local skinCfg = ConfigData.skin[skinId]
    local themId = skinCfg ~= nil and skinCfg.theme or ConfigData.game_config.defaultSkinThemId
    table.insert(itemList, {
      skinId = skinId,
      themId = themId,
      isHas = isHas
    })
  end
  table.sort(itemList, function(a, b)
    if a.isHas ~= b.isHas then
      return not a.isHas
    end
    if a.themId ~= b.themId then
      return a.themId < b.themId
    end
    return a.skinId < b.skinId
  end)
  self.itemSelectPool:HideAll()
  local selectIndex = 0
  for index, data in ipairs(itemList) do
    local item = self.itemSelectPool:GetOne()
    local itemCfg = ConfigData.item[data.skinId]
    local isHas = data.isHas
    item:InitCmUseGiftItem(itemCfg, 1, self.__OnSelectItemCallback)
    item:SetHasFlagObjActive(isHas)
  end
  cs_Canvas.ForceUpdateCanvases()
  self.ui.obj_Select:SetActive(false)
end

function UICommonUseGift:__RefreshUseGiftViewWithResidentBPFurniture()
  self.ui.obj_itemList:SetActive(true)
  self.ui.obj_itemGift:SetActive(false)
  self.ui.obj_ItemInfo:SetActive(false)
  local itemList = {}
  for itemId, _ in pairs(ConfigData.battlepass_spitem) do
    local isHas = PlayerDataCenter:GetItemCount(itemId) > 0
    local order
    local itemCfg = ConfigData.item[itemId]
    if itemCfg.type == eItemType.AvatarFrame then
      order = 1
    elseif itemCfg.type == eItemType.BackgroudPlate then
      order = 2
    elseif itemCfg.type == eItemType.DormFurniture then
      local furnitureNum = PlayerDataCenter:GetItemCount(itemId) + PlayerDataCenter.dormBriefData:GetFurnitureItemCountInDorm(itemId)
      isHas = 0 < furnitureNum
      order = 3
    else
      order = 9
    end
    table.insert(itemList, {
      itemCfg = itemCfg,
      itemId = itemId,
      isHas = isHas,
      order = order
    })
  end
  table.sort(itemList, function(a, b)
    if a.isHas ~= b.isHas then
      return not a.isHas
    end
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a.itemId < b.itemId
  end)
  self.itemSelectPool:HideAll()
  for index, data in ipairs(itemList) do
    local item = self.itemSelectPool:GetOne()
    item:InitCmUseGiftItem(data.itemCfg, 1, self.__OnSelectItemCallback)
    item:SetHasFlagObjActive(data.isHas)
  end
  cs_Canvas.ForceUpdateCanvases()
  self.ui.obj_Select:SetActive(false)
end

function UICommonUseGift:__RefreshUseGiftViewWithNormal()
  self.ui.obj_itemList:SetActive(false)
  self.ui.obj_itemGift:SetActive(true)
  local itemCfg = self.itemCfg
  self.itemFixed:InitBaseItem(itemCfg, self.__OnSelectItemCallback)
  self.ui.tex_GiftName.text = LanguageUtil.GetLocaleText(itemCfg.name)
end

function UICommonUseGift:OnClickUse()
  if self.itemCountUse < 0 then
    return
  end
  local isRadioChoiceGift = self.itemCfg.action_type ~= proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift or self.itemCfg.action_type ~= proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2
  if isRadioChoiceGift then
    local athMaxCoulHaveNum = ConfigData.item.athGiftDic[self.itemCfg.id]
    if athMaxCoulHaveNum ~= nil and 0 < athMaxCoulHaveNum and #PlayerDataCenter.allAthData:GetAllAthList() + athMaxCoulHaveNum * self.itemCountUse > ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.WearhouseOpenAthPackageFull))
      return
    end
  end
  local warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
  
  local function selectItemFunc()
    local selectId = self.selectItem.itemCfg.id
    warehouseNetwork:CS_BACKPACK_SelectItem(self.itemCfg.id, self.itemCountUse, {selectId}, self.__OnUseGiftSuccess)
  end
  
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  if self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2 or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin then
    if self.selectItem == nil then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(146))
      return
    end
    if self.selectItem.itemCfg.type == eItemType.Arithmetic and #PlayerDataCenter.allAthData:GetAllAthList() + self.selectItem.count * self.itemCountUse > ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.WearhouseOpenAthPackageFull))
      return
    end
    if self.selectItem.itemCfg.action_type == eItemActionType.HeroCardFrag then
      local limitNum = self:_GetFragLimitNum(self.selectItem.itemCfg.arg[1])
      local getNum = self.itemCfg.giftOptainDic[self.selectItem.itemCfg.id] * self.itemCountUse
      if 0 <= limitNum and limitNum < getNum then
        local msg = ConfigData:GetTipContent(3010)
        local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        msgWindow:ShowTextBoxWithYesAndNo(msg, function()
          selectItemFunc()
          UIUtil.OnClickBackByUiTab(self)
        end)
        return
      end
    end
    selectItemFunc()
  elseif self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup then
    if #self.mutSelectItemList < self.multSelectMaxNum then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(423))
      return
    end
    local selectIds = {}
    for _, selectItem in ipairs(self.mutSelectItemList) do
      table.insert(selectIds, selectItem.itemCfg.id)
    end
    warehouseNetwork:CS_BACKPACK_SelectItem(self.itemCfg.id, self.itemCountUse, selectIds, self.__OnUseGiftSuccess)
  else
    warehouseNetwork:CS_BACKPACK_UseItem(self.itemCfg.id, self.itemCountUse, self.__OnUseGiftSuccess)
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonUseGift:BackAction()
  if self.closeFunc ~= nil then
    self.closeFunc(false)
  end
  self:Delete()
end

function UICommonUseGift:OnClickCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonUseGift:OnClickAdd()
  if self.selectItem ~= nil and self.selectItem.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local limitNum = self:_GetFragLimitNum(self.selectItem.itemCfg.arg[1], 1)
    local getNum = self.itemCfg.giftOptainDic[self.selectItem.itemCfg.id] * self.itemCountUse
    if 0 <= limitNum and limitNum <= getNum then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(3015))
      return
    end
  end
  if self.itemCountUse < self.itemCountMax then
    self:__UseCountChangeUpdate(self.itemCountUse + 1, true)
  end
end

function UICommonUseGift:OnClickReduce()
  if self.itemCountUse > 1 then
    self:__UseCountChangeUpdate(self.itemCountUse - 1, true)
  end
end

function UICommonUseGift:OnScrollbarValueChange(value)
  if self.scrollbarValueCallbackEnable then
    if self.selectItem ~= nil and self.selectItem.itemCfg.action_type == eItemActionType.HeroCardFrag then
      local limitNum = self:_GetFragLimitNum(self.selectItem.itemCfg.arg[1], 1)
      local perNum = self.itemCfg.giftOptainDic[self.selectItem.itemCfg.id]
      local getNum = perNum * value
      if 0 <= limitNum and limitNum < getNum then
        self:__UseCountChangeUpdate(math.ceil(limitNum / perNum), true)
        self:_TryShowOutOfLimitTip()
        return
      end
    end
    self:_ResetOutOfLimitTip()
    local num = math.tointeger(self.ui.scrollbar.value)
    if num ~= self.itemCountUse then
      self:__UseCountChangeUpdate(num, false)
    end
  end
end

function UICommonUseGift:_ResetOutOfLimitTip()
  self._showedLimitTip = false
end

function UICommonUseGift:_TryShowOutOfLimitTip()
  if self._showedLimitTip then
    return
  end
  self._showedLimitTip = true
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(3015))
end

function UICommonUseGift:OnSelectItemCallback(itemCfg)
  self:_ResetOutOfLimitTip()
  if self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2 or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup then
    for i, v in ipairs(self.itemSelectPool.listItem) do
      if v.itemCfg == itemCfg then
        self:__SelectItemStateUpdate(v)
        break
      end
    end
  end
end

function UICommonUseGift:__UseCountChangeUpdate(num, updateScrollbar)
  self:_UpdItemCountUse(num)
  self.ui.scrollbar.minValue = 1
  self.ui.scrollbar.maxValue = self.itemCountMax
  if updateScrollbar then
    self.scrollbarValueCallbackEnable = false
    self.ui.scrollbar.value = self.itemCountUse
    self.scrollbarValueCallbackEnable = true
  end
  local itemCfg = self.itemCfg
  if itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeFixedItem then
    local des
    for id, count in pairs(itemCfg.giftOptainDic) do
      local itemCfg = ConfigData.item[id]
      local tempDes = tostring(count * self.itemCountUse) .. LanguageUtil.GetLocaleText(itemCfg.name)
      if des == nil then
        des = tempDes
      else
        des = des .. "," .. tempDes
      end
    end
    self.ui.tex_GiftInfo:SetIndex(0, des)
  else
    local num = self.itemCountUse
    self.ui.tex_GiftInfo:SetIndex(1, LanguageUtil.GetLocaleText(itemCfg.describe))
  end
end

function UICommonUseGift:__SelectItemStateUpdate(selectItem)
  if self.isMultSelect then
    local function ChangeSelectObj(selectItem, isSelect)
      if self.unusetSelectlist == nil then
        self.unusetSelectlist = {}
        
        self.unusetSelectlist[1] = self.ui.obj_Select
        self.selectObjDic = {}
      end
      if isSelect then
        if #self.unusetSelectlist == 0 then
          local newSelectItem = self.ui.obj_Select:Instantiate()
          table.insert(self.unusetSelectlist, newSelectItem)
        end
        local item = table.remove(self.unusetSelectlist, 1)
        self.selectObjDic[selectItem] = item
        item.transform:SetParent(selectItem.transform)
        item.transform.localPosition = Vector3.zero
        item:SetActive(true)
      else
        local item = self.selectObjDic[selectItem]
        item:SetActive(false)
        self.selectObjDic[selectItem] = nil
      end
    end
    
    if table.contain(self.mutSelectItemList, selectItem) then
      table.removebyvalue(self.mutSelectItemList, selectItem)
      ChangeSelectObj(selectItem, false)
    elseif #self.mutSelectItemList >= self.multSelectMaxNum then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(428))
    else
      table.insert(self.mutSelectItemList, selectItem)
      ChangeSelectObj(selectItem, true)
    end
    return
  end
  self.selectItem = selectItem
  self.ui.obj_Select.transform:SetParent(self.selectItem.transform)
  self.ui.obj_Select.transform.localPosition = Vector3.zero
  self.ui.obj_Select:SetActive(true)
  if self.selectItem ~= nil and self.selectItem.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local limitNum = self:_GetFragLimitNum(self.selectItem.itemCfg.arg[1], 1)
    local perNum = self.itemCfg.giftOptainDic[self.selectItem.itemCfg.id]
    local getNum = perNum * self.itemCountUse
    if 0 <= limitNum and limitNum < getNum then
      self:__UseCountChangeUpdate(math.ceil(limitNum / perNum), true)
    end
  end
end

function UICommonUseGift:__UseGiftSuccess(dataList)
  local isSkin = self.selectItem ~= nil and self.selectItem.itemCfg.type == eItemType.Skin
  if dataList.Count <= 0 and not isSkin then
    return
  end
  local rewardCache = dataList[0]
  local rewardIds = {}
  local rewardCounts = {}
  local heroIdSnapShoot = self._heroIdSnapShoot
  for id, count in pairs(rewardCache) do
    table.insert(rewardIds, id)
    table.insert(rewardCounts, count)
  end
  if isSkin then
    table.insert(rewardIds, self.selectItem.itemCfg.id)
    table.insert(rewardCounts, 1)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if window ~= nil then
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts):SetCRHeroSnapshoot(heroIdSnapShoot)
    window:AddAndTryShowReward(CRData)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts):SetCRHeroSnapshoot(heroIdSnapShoot)
      window:AddAndTryShowReward(CRData)
    end)
  end
  if self.closeFunc ~= nil then
    self.closeFunc(true)
  end
  self:Delete()
end

function UICommonUseGift:OnItemUpdateUseGift(itemUpdate, resourceData)
  if self.itemCfg == nil then
    return
  end
  local itemData = PlayerDataCenter.itemDic[self.itemCfg.id]
  local currrentMaxCount = itemData == nil and 0 or itemData:GetCount()
  if currrentMaxCount ~= self.itemCountMax then
    self:_UpdItemMaxCount(currrentMaxCount)
    if self.itemCountUse > self.itemCountMax then
      self:_UpdItemCountUse(self.itemCountMax)
    end
    self:__UseCountChangeUpdate(self.itemCountUse, true)
  end
end

function UICommonUseGift:_UpdItemCountUse(itemCountUse)
  self.itemCountUse = itemCountUse
  self.ui.tex_CurCount.text = tostring(itemCountUse)
  if self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    for k, item in ipairs(self.itemSelectPool.listItem) do
      local itemCfg = item.itemCfg
      local num = self.itemCfg.giftOptainDic[itemCfg.id] * self.itemCountUse
      item.baseItem:SetNum(num)
    end
  end
end

function UICommonUseGift:_UpdItemMaxCount(itemCountMax)
  self.itemCountMax = itemCountMax
  self.ui.tex_count.text = tostring(itemCountMax)
  if self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin or self.itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup then
    self.ui.obj_sliderNode:SetActive(false)
  else
    self.ui.obj_sliderNode:SetActive(1 < itemCountMax)
  end
end

function UICommonUseGift:_GetFragLimitNum(heroId, minNum)
  local heroData = PlayerDataCenter.heroDic[heroId]
  minNum = minNum or 0
  if heroData == nil then
    local heroCfg = ConfigData.hero_data[heroId]
    heroData = HeroData.New({
      basic = {
        id = heroId,
        level = 1,
        exp = 0,
        star = heroCfg.rank,
        potentialLvl = 0,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
      }
    })
  end
  local needMaxNum = heroData:GetMaxNeedFragNum(true)
  if minNum > needMaxNum then
    needMaxNum = minNum
  end
  return needMaxNum
end

function UICommonUseGift:OnDelete()
  self.itemFixed:Delete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  base.OnDelete(self)
end

return UICommonUseGift
