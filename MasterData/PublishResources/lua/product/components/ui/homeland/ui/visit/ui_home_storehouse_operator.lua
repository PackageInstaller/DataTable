_class("UIHomeStorehouseOperator", UICustomWidget)
UIHomeStorehouseOperator = UIHomeStorehouseOperator

function UIHomeStorehouseOperator:OnShow(uiParams)
  self:InitWidget()
  self._countPerRaw = 4
  local uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._buildMng = uiModule:GetClient():BuildManager()
  self._itemModule = self:GetModule(ItemModule)
  local listAll = GameGlobal.GetModule(ItemModule):GetAllItemInfos()
  self._minCount = 20
  self._itemData = {}
  for _, item in ipairs(listAll) do
    local tpl = item:GetTemplate()
    local showType = tpl.ShowType or 1
    local tplId = item:GetTemplateID()
    local filter = tpl.TabType
    local giftCfg = Cfg.cfg_homeland_gift_item[tplId]
    if giftCfg then
      local isBuilding = Cfg.cfg_item_architecture[tplId] ~= nil
      if isBuilding then
        local count = self:_GetItemCount(tplId)
        if 0 < count then
          table.insert(self._itemData, item)
        end
      else
        table.insert(self._itemData, item)
      end
    end
  end
  table.sort(self._itemData, function(a, b)
    local cfga = a:GetTemplate()
    local cfgb = b:GetTemplate()
    if cfga.BagSortIndex ~= b.BagSortIndex then
      return cfga.BagSortIndex > cfgb.BagSortIndex
    end
    if cfga.Color ~= b.Color then
      return cfga.Color > cfgb.Color
    end
    return cfga.ID < cfgb.ID
  end)
  local count = math.max(#self._itemData, self._minCount)
  local raws = math.ceil(count / self._countPerRaw)
  self.list:InitListView(raws, function(scrollview, index)
    return self:_NewItem(scrollview, index)
  end)
  self:AttachEvent(GameEventType.HomeStorehouseGiftItemOnSelect, self._OnSelectGift)
end

function UIHomeStorehouseOperator:InitWidget()
  self.list = self:GetUIComponent("UIDynamicScrollView", "list")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.giftName = self:GetUIComponent("UILocalizationText", "giftName")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self._itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self._itemDes = self:GetUIComponent("UILocalizationText", "itemDes")
  self._empty = self:GetGameObject("empty")
  self._cur = self:GetGameObject("cur")
end

function UIHomeStorehouseOperator:SetData(onConfirm)
  self._onConfirm = onConfirm
  if #self._itemData > 0 then
    self._curGiftIdx = 1
  end
  self.list:RefreshAllShownItem()
  self:_ResetCur()
end

function UIHomeStorehouseOperator:_NewItem(scrollview, idx)
  if idx < 0 then
    return
  end
  local rowItem = scrollview:NewListViewItem("item")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", rowItem.gameObject)
  local gifts = rowPool:SpawnObjects("UIHomeStorehouseGiftItem", self._countPerRaw)
  for i = 1, self._countPerRaw do
    local index = idx * self._countPerRaw + i
    gifts[i]:SetData(index, self._itemData[index], self._curGiftIdx, index <= self._minCount)
  end
  return rowItem
end

function UIHomeStorehouseOperator:_OnSelectGift(idx)
  if self._curGiftIdx == idx then
    return
  end
  self._curGiftIdx = idx
  self:_ResetCur()
end

function UIHomeStorehouseOperator:_ResetCur()
  if self._curGiftIdx then
    local data = self._itemData[self._curGiftIdx]
    local id = data:GetTemplateID()
    local cfg = data:GetTemplate()
    self.icon:LoadImage(cfg.Icon)
    self.giftName:SetText(StringTable.Get(cfg.Name))
    local have = self:_GetItemCount(id)
    local max = Cfg.cfg_homeland_gift_item[id].PutMaxNum
    self._max = math.min(have, max)
    self._min = 1
    self._count = 1
    self._itemCount:SetText(have)
    self._itemDes:SetText(StringTable.Get(cfg.Intro))
    self.count:SetText(self._count)
    self._empty:SetActive(false)
    self._cur:SetActive(true)
  else
    self._empty:SetActive(true)
    self._cur:SetActive(false)
  end
end

function UIHomeStorehouseOperator:AddOnClick(go)
  if self._count >= self._max then
    return
  end
  self._count = self._count + 1
  self.count:SetText(self._count)
end

function UIHomeStorehouseOperator:RemoveOnClick(go)
  if self._count <= self._min then
    return
  end
  self._count = self._count - 1
  self.count:SetText(self._count)
end

function UIHomeStorehouseOperator:MaxOnClick(go)
  if self._count >= self._max then
    return
  end
  self._count = self._max
  self.count:SetText(self._count)
end

function UIHomeStorehouseOperator:PutOnClick(go)
  self._onConfirm(self._itemData[self._curGiftIdx]:GetTemplateID(), self._count)
end

function UIHomeStorehouseOperator:_GetItemCount(tmpID)
  local isBuilding = Cfg.cfg_item_architecture[tmpID] ~= nil
  if isBuilding then
    return self._buildMng:GetBuildCount(tmpID)
  end
  return self._itemModule:GetItemCount(tmpID)
end
