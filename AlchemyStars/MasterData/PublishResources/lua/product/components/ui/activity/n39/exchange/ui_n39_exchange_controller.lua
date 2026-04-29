_class("UIN39ExchangeController", UIController)
UIN39ExchangeController = UIN39ExchangeController

function UIN39ExchangeController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  
  local function closeCallback()
    if self._fromLine then
      local id, com, info = UIN39Helper.GetComponent(self._campaign, "line")
      local lineIsOpen = com and com:ComponentIsOpen()
      if lineIsOpen then
        self:CloseDialog()
      elseif self._campaign:CheckCampaignOpen() then
        self:SwitchState(UIStateType.UIN39MainController)
      else
        local strId = "str_activity_error_109"
        local errorStr = StringTable.Get(strId)
        ToastManager.ShowToast(errorStr)
        self:SwitchState(UIStateType.UIMain)
      end
    else
      self:CloseDialog()
    end
  end
  
  obj:SetData(function()
    if self._animTimer then
      GameGlobal.Timer():CancelEvent(self._animTimer)
    end
    local anim = self:GetUIComponent("Animation", "_anim")
    anim:Play("uieff_UIN39ExchangeController_out")
    self:Lock("uieff_UIN39ExchangeController_out")
    self._animTimer = GameGlobal.Timer():AddEvent(333, function()
      self:UnLock("uieff_UIN39ExchangeController_out")
      closeCallback()
    end)
  end, nil, nil, false)
end

function UIN39ExchangeController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIN39TimeExchange")
  obj:SetData(endTime)
end

function UIN39ExchangeController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UIN39Helper.GetCampaignType()
  local componentIds = {
    UIN39Helper.GetComponentId("exchange")
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._component = nil
  self._componentInfo = nil
  self._cmptId, self._component, self._componentInfo = UIN39Helper.GetComponent(self._campaign, "exchange")
end

function UIN39ExchangeController:OnShow(uiParams)
  self._fromLine = uiParams[1]
  self._UIN39ExchangeCellPool = self:GetUIComponent("UISelectObjectPath", "UIN39ExchangeCell")
  self._UIN39ExchangeCell = self._UIN39ExchangeCellPool:SpawnObject("UIN39ExchangeCell")
  self._costCountTex = self:GetUIComponent("UILocalizationText", "CostCount")
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetCommonTopButton()
  self:_SetNpc()
  local closeTime = self._componentInfo.m_close_time
  self:_SetRemainingTime("_time", "str_n39_exchange_remain_time", closeTime, true)
  self:_Refresh()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self._Refresh)
  self._timerHolder = UITimerHolder:New()
  local lockName = "UIN39ExchangeController_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 800, function()
    self:UnLock(lockName)
  end)
  UIN39Helper.ClearNew("exchange")
end

function UIN39ExchangeController:OnHide()
  self._timerHolder:Dispose()
  self:UnLock("uieff_UIN39ExchangeController_out")
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self._Refresh)
end

function UIN39ExchangeController:_Refresh()
  if not self.view then
    return
  end
  self:_SetList()
  self:_SetCostItem()
end

function UIN39ExchangeController:_GetListData()
  self._itemList = {}
  local shopList = self._componentInfo.m_exchange_item_list
  local insertIdx = 0
  local insertData
  local goOn = false
  for index, value in ipairs(shopList) do
    if value.m_is_special then
      insertIdx = insertIdx + 1
      insertData = UIN39ExchangeRowItemData:New()
      insertData:AddData(value)
      insertData.sin = true
      self._itemList[insertIdx] = insertData
      goOn = false
    elseif goOn then
      insertData:AddData(value)
      goOn = false
    else
      insertIdx = insertIdx + 1
      insertData = UIN39ExchangeRowItemData:New()
      insertData:AddData(value)
      insertData.sin = false
      self._itemList[insertIdx] = insertData
      goOn = true
    end
  end
end

function UIN39ExchangeController:_SetList()
  self:_GetListData()
  self._UIN39ExchangeCell:SetData(self._itemList, self._component, self._tipsCallback)
end

function UIN39ExchangeController:_SetNpc()
  local shopCfg = Cfg.cfg_activity_shop_common_client[self._campaign._id]
  if shopCfg then
    local spineName = shopCfg.NpcSpine
    if spineName then
    end
    UIWidgetHelper.SetSpineLoad(self, "_npcSpine", "duya_spine_idle")
    local name = shopCfg.NpcName
    if name then
      UIWidgetHelper.SetLocalizationText(self, "_npcName", StringTable.Get(name))
    end
    local word = shopCfg.NpcWord
    if word then
      self._npcWord = string.split(StringTable.Get(word), "|")
    end
  end
  self:NpcBtnOnClick()
end

function UIN39ExchangeController:NpcBtnOnClick(go)
  if not self._npcWord then
    Log.error("###[UIN39ExchangeController] NpcBtnOnClick _npcWord is nil !")
    return
  end
  if #self._npcWord == 0 then
    Log.error("###[UIN39ExchangeController] _npcWord len == 0")
    return
  end
  if not self._npcWordId or self._npcWord == 1 then
    self._npcWordId = 1
  elseif #self._npcWord == 1 then
    Log.debug("###[UIN39ExchangeController] _npcWord len == 1")
    self._npcWordId = 1
  else
    local randomPool = {}
    for i = 1, #self._npcWord do
      if self._npcWordId ~= i then
        table.insert(randomPool, i)
      end
    end
    local randomIdx = math.random(1, #randomPool)
    self._npcWordId = randomPool[randomIdx]
  end
  local txt = self._npcWord[self._npcWordId]
  UIWidgetHelper.SetLocalizationText(self, "_npcWord", txt)
end

function UIN39ExchangeController:CostItemOnClick(go)
  self:GetGameObject("CostTips"):SetActive(true)
end

function UIN39ExchangeController:CostTipsOnClick(go)
  self:GetGameObject("CostTips"):SetActive(false)
end

function UIN39ExchangeController:_SetCostItem()
  local itemId = self._component:GetCostItemId()
  local itemCount = GameGlobal.GetModule(ItemModule):GetItemCount(itemId)
  self._costCountTex:SetText(itemCount)
end

_class("UIN39ExchangeRowItemData", Object)
UIN39ExchangeRowItemData = UIN39ExchangeRowItemData

function UIN39ExchangeRowItemData:Constructor()
  self.sin = false
  self.list = {}
end

function UIN39ExchangeRowItemData:AddData(UIN39ExchangeData)
  table.insert(self.list, UIN39ExchangeData)
end

_class("UIN39ExchangeData", Object)
UIN39ExchangeData = UIN39ExchangeData

function UIN39ExchangeData:ShowRemain()
  return true
end

function UIN39ExchangeData:IsUnLimit()
  return self.cfg[ConfigKey.ConfigKey_SaleNum] == SpecialNum.MysteryGoodsUnlimitedNum
end

function UIN39ExchangeData:GetSeasonSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag]
  if saleTag and saleTag == 1 then
    return 1
  end
  return 0
end

function UIN39ExchangeData:GrandPrize()
  local cfg = Cfg.cfg_shop_season_goods[self.goodId]
  if cfg then
    local grandPrize = cfg.GrandPrize
    return grandPrize and grandPrize == 1
  end
  return false
end
