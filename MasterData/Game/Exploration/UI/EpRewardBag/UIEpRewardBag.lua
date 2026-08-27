local UIEpRewardBag = class("UIEpRewardBag", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UICommonRewardItem")
local EpRewardBagUtil = require("Game.Exploration.UI.EpRewardBag.EpRewardBagUtil")
local UINEpRewardBagItem = require("Game.Exploration.UI.EpRewardBag.UINEpRewardBagItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UIEpRewardBag:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self._OnClickGetReward)
  UIUtil.AddButtonListener(self.ui.btn_SelectAll, self, self._OnClickSelectAll)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancelSelect)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickGiveup)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_TipsInfo, self, self._OnClickInfo)
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.gameResourceGroup)
  self.ui.obj_rewardItem:SetActive(false)
  self.firstClearRewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_rewardItem)
  self.ui.rewardBagItem:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINEpRewardBagItem, self.ui.rewardBagItem)
  self._selectRewardFunc = BindCallback(self, self._OnSelectReward)
end

function UIEpRewardBag:InitEpRewardBag(rewardList, stageCfg, inEp, firstClearRewardDic, canGetReward, epModuleId, stageId)
  self.inEp = inEp
  self.epModuleId = epModuleId
  self.stageCfg = stageCfg
  self._stageId = stageId
  local currencyId = EpRewardBagUtil:GetEpRewardCurrencyId(epModuleId, stageId)
  self._currencyId = currencyId
  self.resourceGroup:SetResourceIds({currencyId})
  local moneyIcon
  local isKey = ConstGlobalItem.SKey == currencyId
  if not isKey then
    self.ui.img_Key:SetActive(false)
    self.ui.img_CurrencyIcon.gameObject:SetActive(true)
    local itemCfg = ConfigData.item[currencyId]
    if itemCfg ~= nil then
      moneyIcon = CRH:GetSprite(itemCfg.small_icon)
      self.ui.img_CurrencyIcon.sprite = moneyIcon
    end
  end
  local containAth = false
  local curSectorId = stageCfg ~= nil and stageCfg.sector or nil
  local msg
  if stageCfg ~= nil and stageCfg.endlessCfg ~= nil then
    msg = ConfigData:GetEndlessInfoMsg(stageCfg.endlessCfg, stageCfg.endlessCfg.index * 10)
  elseif epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess or epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason then
    msg = ""
    self.ui.btn_TipsInfo.gameObject:SetActive(false)
  else
    msg = ConfigData:GetSectorInfoMsg(stageCfg.sector, stageCfg.num, stageCfg.difficulty)
  end
  if not IsNull(self.ui.tex_LevelName) then
    self.ui.tex_LevelName.text = msg
  end
  local unlockSelect = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_RewardPurchase)
  local selectable = unlockSelect and canGetReward
  self.selectable = selectable
  self.ui.btn_Get.gameObject:SetActive(canGetReward)
  self.ui.btn_SelectAll.gameObject:SetActive(selectable)
  self.ui.btn_Cancel.gameObject:SetActive(selectable)
  if not IsNull(self.ui.btn_Back) then
    self.ui.btn_Back.gameObject:SetActive(not canGetReward)
  end
  local selectDefault = true
  if ConfigData.sector[curSectorId] ~= nil then
    local sectorCfg = ConfigData.sector[curSectorId]
    if not sectorCfg.is_special then
      local lastSectorId = PlayerDataCenter.sectorStage:GetEpStageCfg4UserInfo()
      if lastSectorId ~= nil and curSectorId < lastSectorId then
        selectDefault = false
      end
    end
  end
  self.rewardItemPool:HideAll()
  local rewardDataList = {}
  for k, v in ipairs(rewardList) do
    local itemCfg = ConfigData.item[v.itemId]
    if itemCfg == nil then
      error("Cant get item cfg, id = " .. tostring(v.itemId))
    else
      if not containAth and itemCfg.type == eItemType.Arithmetic then
        containAth = true
      end
      local rewardData = {
        itemId = v.itemId,
        itemNum = v.num,
        itemCfg = itemCfg,
        price = EpRewardBagUtil.GetEpRewardItemPrice(v.itemId, self.epModuleId, stageId, v.num),
        originalPrice = EpRewardBagUtil.GetEpRewardItemPrice(v.itemId, self.epModuleId, stageId, v.num, true),
        index = k - 1,
        SetRewardDataSelected = function(self, selected)
          if self.price == 0 then
            self.selected = true
            return
          end
          self.selected = selected
        end
      }
      rewardData:SetRewardDataSelected(selectDefault)
      table.insert(rewardDataList, rewardData)
    end
  end
  ExplorationManager:RewardSort(rewardDataList)
  self.rewardDataList = rewardDataList
  for k, rewardData in ipairs(rewardDataList) do
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem:InitEpRewardBagItem(k, rewardData.itemCfg, rewardData.itemNum, rewardData.price, rewardData.originalPrice, self._selectRewardFunc, selectable)
    rewardItem:SetEpRewardBagItemSelected(rewardData.selected)
    if moneyIcon ~= nil then
      rewardItem:SetEpRewardBagItemCurrencyIcon(moneyIcon)
    end
  end
  local firstClearRewardList
  if firstClearRewardDic == nil then
    firstClearRewardList = {}
  else
    firstClearRewardList = self:_InitRewardData(firstClearRewardDic)
  end
  self.firstClearRewardList = firstClearRewardList
  if #firstClearRewardList == 0 then
    if self.ui.firstRewardList ~= nil then
      self.ui.firstRewardList:SetActive(false)
    end
  else
    self.ui.firstRewardList:SetActive(true)
    self.firstClearRewardItemPool:HideAll()
    for k, v in ipairs(firstClearRewardList) do
      if not containAth and v.itemCfg.type == eItemType.Arithmetic then
        containAth = true
      end
      local rewardItem = self.firstClearRewardItemPool:GetOne()
      local num = 0
      if v.itemCfg.overflow_type == eItemTransType.actMoneyX then
        num = PlayerDataCenter:GetItemOverflowNum(v.itemCfg.id, v.num)
      end
      if num ~= 0 then
        rewardItem:SetItemTranNum(num)
      end
      rewardItem:InitCommonRewardItem(v.itemCfg, v.num, nil, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
          if win ~= nil then
            win:InitListDetail(self.firstClearRewardList, k)
          end
        end)
      end)
      rewardItem:SetItemNameShow(false)
    end
  end
  if canGetReward and containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
  end
  self:_RefreshTotalPrice()
  local showClose = false
  if unlockSelect then
    showClose = true
  elseif not unlockSelect and self.totalPrice > PlayerDataCenter.stamina:GetCurrentStamina() then
    showClose = true
  end
  self.ui.btn_Close.gameObject:SetActive(showClose and canGetReward)
  GuideManager:TryTriggerGuide(eGuideCondition.InEpRewardBagSettle)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
end

function UIEpRewardBag:_InitRewardData(rewardDic)
  local rewardList = {}
  for itemId, itemNum in pairs(rewardDic) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("can't get itemCfg with id=" .. tostring(itemId))
    else
      table.insert(rewardList, {num = itemNum, itemCfg = itemCfg})
    end
  end
  ExplorationManager:RewardSort(rewardList)
  return rewardList
end

function UIEpRewardBag:_RefreshTotalPrice()
  local selectAll = false
  local selectedNum = 0
  local totalPrice = 0
  local tPriceOriginal = 0
  for k, rewardData in ipairs(self.rewardDataList) do
    if rewardData.selected then
      totalPrice = totalPrice + rewardData.price
      tPriceOriginal = tPriceOriginal + rewardData.originalPrice
      selectedNum = selectedNum + 1
    end
  end
  local selectedAll = selectedNum == #self.rewardDataList
  self.selectedAll = selectedAll
  if selectedAll then
    totalPrice = totalPrice * ConfigData.game_config.staminaShopAllDiscount / 100
  end
  totalPrice = self:_GetTotalPrice(totalPrice)
  tPriceOriginal = self:_GetTotalPrice(tPriceOriginal)
  self.totalPrice = totalPrice
  self.ui.tex_Consume.text = tostring(totalPrice)
  self.ui.tex_OrignConsume.text = tostring(tPriceOriginal)
  self.ui.tex_OrignConsume.gameObject:SetActive(totalPrice ~= tPriceOriginal)
  local canGet = 0 < selectedNum or 0 < #self.firstClearRewardList
  self.canClickGetReward = canGet
  self.ui.img_Get.color = canGet and self.ui.color_get or Color.gray
end

function UIEpRewardBag:_OnSelectReward(rewardItem, index)
  local rewardData = self.rewardDataList[index]
  rewardData:SetRewardDataSelected(not rewardData.selected)
  rewardItem:SetEpRewardBagItemSelected(rewardData.selected)
  self:_RefreshTotalPrice()
end

function UIEpRewardBag:_OnClickGetReward()
  if not self.canClickGetReward then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(757))
    return
  end
  local isKey = ConstGlobalItem.SKey == self._currencyId
  if isKey then
    if self.totalPrice > PlayerDataCenter.stamina:GetCurrentStamina() then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina, nil, nil, {
        self.totalPrice - PlayerDataCenter.stamina:GetCurrentStamina()
      })
      return
    end
  elseif PlayerDataCenter:GetItemCount(self._currencyId) < self.totalPrice then
    local itemCfg = ConfigData.item[self._currencyId]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(7120), itemName, itemName))
    return
  end
  self.pickInfo = {}
  self.rewardDic = table.GetDefaulValueTable(0)
  if self.selectedAll then
    self.pickInfo.pickState = proto_csmsg_stmStorePickInfoPickState.stmStorePickInfoPickStatePickAll
    for k, rewardData in ipairs(self.rewardDataList) do
      self.rewardDic[rewardData.itemId] = self.rewardDic[rewardData.itemId] + rewardData.itemNum
    end
  else
    self.pickInfo.pickState = proto_csmsg_stmStorePickInfoPickState.stmStorePickInfoPickStatePickPartial
    local choiceDic = {}
    for k, rewardData in ipairs(self.rewardDataList) do
      if rewardData.selected then
        choiceDic[rewardData.index] = true
        self.rewardDic[rewardData.itemId] = self.rewardDic[rewardData.itemId] + rewardData.itemNum
      end
    end
    self.pickInfo.choices = choiceDic
  end
  self:_OnClickClose()
end

function UIEpRewardBag:_OnClickSelectAll()
  for k, rewardData in ipairs(self.rewardDataList) do
    rewardData:SetRewardDataSelected(true)
    local rewardItem = self.rewardItemPool.listItem[k]
    rewardItem:SetEpRewardBagItemSelected(rewardData.selected)
  end
  self:_RefreshTotalPrice()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(754))
end

function UIEpRewardBag:_OnClickCancelSelect()
  for k, rewardData in ipairs(self.rewardDataList) do
    rewardData:SetRewardDataSelected(false)
    local rewardItem = self.rewardItemPool.listItem[k]
    rewardItem:SetEpRewardBagItemSelected(rewardData.selected)
  end
  self:_RefreshTotalPrice()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(755))
end

function UIEpRewardBag:_OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local infoStr, titleStr
    if ExplorationManager.IsCarnivalEp(self._stageId) then
      titleStr = ConfigData:GetTipContent(7118)
      infoStr = ConfigData:GetTipContent(7119)
    else
      local discount = FormatNum(ConfigData.game_config.staminaShopAllDiscount / 10)
      infoStr = string.format(ConfigData:GetTipContent(761), discount)
      titleStr = ConfigData:GetTipContent(760)
    end
    window:InitCommonInfo(infoStr, titleStr)
  end)
end

function UIEpRewardBag:BackAction()
  local function exitFunc()
    self.pickInfo = {}
    
    self.pickInfo.pickState = proto_csmsg_stmStorePickInfoPickState.stmStorePickInfoPickStateAbandon
    self.rewardDic = table.GetDefaulValueTable(0)
    self:_OnClickClose()
  end
  
  local enableConfirm = PlayerDataCenter.cacheSaveData:GetEnableEpRewardBagExitConfirm()
  if enableConfirm then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    local itemCfg = ConfigData.item[self._currencyId]
    local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
    window:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(756), itemName, itemName), exitFunc, function()
      UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
    end)
    window:ShowDontRemindTog(function(isOn)
      PlayerDataCenter.cacheSaveData:SetEnableEpRewardBagExitConfirm(not isOn)
    end)
  else
    exitFunc()
  end
end

function UIEpRewardBag:_OnClickClose()
  UIUtil.PopFromBackStackByUiTab(self)
  if self.closeFunc ~= nil then
    self.closeFunc(self.rewardDic, self.pickInfo)
    self.closeFunc = nil
    return
  end
  if self.inEp then
    self:Hide()
  else
    self:Delete()
  end
end

function UIEpRewardBag:_OnClickGiveup()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpRewardBag:SetEpRewardBagCloseFunc(closeFunc)
  self.closeFunc = closeFunc
end

function UIEpRewardBag:_IsCanShowAth()
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
end

function UIEpRewardBag:_GetTotalPrice(price)
  local value = math.ceil(price / ConfigData.game_config.staminaDividend)
  return value
end

function UIEpRewardBag:__GetSinglePriceStr(price)
  local dividend = ConfigData.game_config.staminaDividend / 10
  local value = math.ceil(price / dividend)
  value = FormatNum(value / 10)
  return tostring(value)
end

function UIEpRewardBag:_SetModifier(inEp)
  local num = inEp and 5 or 0
  self.ui.modifier.rotation = Vector3.New(num, 0, 0)
  self.ui.modifier:RefreshGraphics()
end

function UIEpRewardBag:OnDelete()
  if self.firstClearRewardItemPool ~= nil then
    self.firstClearRewardItemPool:DeleteAll()
  end
  self.rewardItemPool:DeleteAll()
  self.resourceGroup:Delete()
  base.OnDelete(self)
end

return UIEpRewardBag
