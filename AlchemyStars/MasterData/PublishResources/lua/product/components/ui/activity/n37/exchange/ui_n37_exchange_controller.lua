_class("UIN37ExchangeController", UIController)
UIN37ExchangeController = UIN37ExchangeController

function UIN37ExchangeController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  
  local function closeCallback()
    self:CloseDialog()
  end
  
  obj:SetData(closeCallback, nil, nil, false)
end

function UIN37ExchangeController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime)
end

function UIN37ExchangeController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UIN37Helper.GetCampaignType()
  local componentIds = {
    UIN37Helper.GetComponentId("exchange")
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._cmptId, self._component, self._componentInfo = UIN37Helper.GetComponent(self._campaign, "exchange")
end

function UIN37ExchangeController:OnShow(uiParams)
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetCommonTopButton()
  self:_SetNpc()
  local closeTime = self._componentInfo.m_close_time
  self:_SetRemainingTime("_time", "str_n37_exchange_remain_time", closeTime, true)
  self:_Refresh()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self._Refresh)
end

function UIN37ExchangeController:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self._Refresh)
end

function UIN37ExchangeController:_Refresh()
  if not self.view then
    return
  end
  self:_SetList()
  self:_SetCostItem()
end

function UIN37ExchangeController:_GetListData()
  local bigItemData, smallItemData = {}, {}
  local itemList = self._componentInfo.m_exchange_item_list
  for i, v in ipairs(itemList) do
    local tb = v.m_is_special and bigItemData or smallItemData
    table.insert(tb, v)
  end
  return bigItemData, smallItemData
end

function UIN37ExchangeController:_SetList()
  local bigItemData, smallItemData = self:_GetListData()
  local objs = UIWidgetHelper.SpawnObjects(self, "_cell", "UIN37ExchangeCell", 2)
  for _, v in ipairs(objs) do
    v:SetData(bigItemData, smallItemData, self._component, self._tipsCallback)
  end
  self._cell_objs = objs
  self:_CalcCellPage(bigItemData, smallItemData)
  self:_SetCellSelect(self._cell_index or 1)
end

function UIN37ExchangeController:_CalcCellPage(bigItemData, smallItemData)
  local totalCount = 8
  local len = #bigItemData * 2 + #smallItemData
  self._cell_max = math.ceil(len / totalCount)
end

function UIN37ExchangeController:_SetCellSelect(index)
  index = Mathf.Clamp(index, 1, self._cell_max)
  local playAnim = index ~= self._cell_index
  self._cell_index = index
  local isLeftShow = index ~= 1
  self:GetGameObject("LeftBtn"):SetActive(isLeftShow)
  local isRightShow = index ~= self._cell_max
  self:GetGameObject("RightBtn"):SetActive(isRightShow)
  self._nextShowIdx = self._nextShowIdx or 1
  self._curShowIdx = self._curShowIdx or 2
  local next, cur = self._nextShowIdx, self._curShowIdx
  if playAnim then
    local type = next == 1 and "showFirst" or "showSecond"
    local tb = {
      showSecond = {
        animName = "UIN37ExchangeController_page_h0s1",
        duration = 167
      },
      showFirst = {
        animName = "UIN37ExchangeController_page_h1s0",
        duration = 167
      }
    }
    local animName, duration = tb[type].animName, tb[type].duration
    UIWidgetHelper.PlayAnimation(self, "_cell", animName, duration, function()
      self._cell_objs[cur]:SetHide()
      self._cell_objs[next]:SetShow(index)
    end)
    self._nextShowIdx, self._curShowIdx = cur, next
  else
    self._cell_objs[cur]:SetShow(index)
  end
end

function UIN37ExchangeController:_SetNpc()
  local shopCfg = Cfg.cfg_activity_shop_common_client[self._campaign._id]
  if shopCfg then
    local spineName = shopCfg.NpcSpine
    if spineName then
      UIWidgetHelper.SetSpineLoad(self, "_npcSpine", spineName)
    end
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

function UIN37ExchangeController:NpcBtnOnClick(go)
  self._npcWordId = self._npcWordId or 1
  local index = math.random(1, #self._npcWord)
  self._npcWordId = index == self._npcWordId and index % #self._npcWord + 1 or index
  local txt = self._npcWord[self._npcWordId]
  UIWidgetHelper.SetLocalizationText(self, "_npcWord", txt)
end

function UIN37ExchangeController:LeftBtnOnClick()
  self:_SetCellSelect(self._cell_index - 1)
end

function UIN37ExchangeController:RightBtnOnClick()
  self:_SetCellSelect(self._cell_index + 1)
end

function UIN37ExchangeController:CostItemOnClick(go)
  self:GetGameObject("CostTips"):SetActive(true)
end

function UIN37ExchangeController:CostTipsOnClick(go)
  self:GetGameObject("CostTips"):SetActive(false)
end

function UIN37ExchangeController:_SetCostItem()
  local color1, color2 = "#727272", "#5dbfbb"
  UIN37Helper.SetExchangeCostItem_PreZero(self._component, self, "CostIcon", "CostCount", color1, color2)
end
