local AppearancePreviewView, Super = NewClass("AppearancePreviewView", BaseView)
AppearancePreviewView.uiResCls = UI_Bag_Panel_AppearancePreviewResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TAB_INDEX_HEAD = 1
local TAB_INDEX_EMOJ = 2

function AppearancePreviewView:ctor(itemTid, interactable)
  Super.ctor(self)
  self._itemTid = itemTid
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  assert(itemCfg and itemCfg.SpParam and itemCfg.SpParam[1], string.format("道具 %s[%s] 没有配置SpParam", itemTid, itemCfg and itemCfg.CnID))
  self._dropId = itemCfg.SpParam[1]
  self._tabIndex = TAB_INDEX_HEAD
  self._interactable = interactable
  self._selectedIdList = {}
end

function AppearancePreviewView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.AppearanceChoose, System.fn(self, self._OnAppearanceChoose))
end

function AppearancePreviewView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Back, System.fn(self, self.Close))
  if self.ui.Btn_Receive then
    self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickReceive))
  end
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Head, function()
    self:_OnTabClick(TAB_INDEX_HEAD)
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Emoji, function()
    self:_OnTabClick(TAB_INDEX_EMOJ)
  end)
end

function AppearancePreviewView:OnEnterView()
  Super.OnEnterView(self)
  self._headList, self._emojList, self._headGroupList, self._emojGroupList, self._headGroupKeyList, self._emojGroupKeyList = self:_GetHeadAndEmoj(self._dropId)
  self:_InitShowContentTab()
  self:_RefreshReceiveButton()
  if self.ui.Btn_RatePreview then
    self.ui.Btn_RatePreview:SetActive(false)
  end
  if self._initShowTab then
    self:_OnTabClick(self._initShowTab)
  end
end

function AppearancePreviewView:OnExitView()
  Super.OnExitView(self)
end

function AppearancePreviewView:_InitShowContentTab()
  self._initShowTab = TAB_INDEX_HEAD
  self.ui.Btn_Head:SetActive(true)
  self.ui.Btn_Emoji:SetActive(true)
  local hideNum = 0
  local dataList = self:_GetDataKeyList(TAB_INDEX_HEAD)
  if not dataList or 0 == #dataList then
    self.ui.Btn_Head:SetActive(false)
    hideNum = hideNum + 1
    self._initShowTab = TAB_INDEX_EMOJ
  end
  dataList = self:_GetDataKeyList(TAB_INDEX_EMOJ)
  if not dataList or 0 == #dataList then
    self.ui.Btn_Emoji:SetActive(false)
    hideNum = hideNum + 1
    if self._initShowTab == TAB_INDEX_EMOJ then
      self._initShowTab = nil
    end
  end
  self:SetActive(self.ui.Image_Line_Middle, 0 == hideNum)
  self:SetActive(self.ui.Group_Null_Black, hideNum >= 2)
  if self.ui.Btn_Receive then
    self:SetActive(self.ui.Btn_Receive, hideNum < 2 and self._interactable)
  end
end

function AppearancePreviewView:_RefreshReceiveButton()
  if not self.ui.Btn_Receive then
    return
  end
  if self._interactable then
    self.ui.Text_Head_Collection:SetActive(false)
    self.ui.Text_Emoji_Collection:SetActive(false)
  else
    self.ui.Text_Head_Collection:SetActive(true)
    self.ui.Text_Emoji_Collection:SetActive(true)
    self:SetText(self.ui.Text_Head_Collection, self:_GetCollectionProgressText(self._headList))
    self:SetText(self.ui.Text_Emoji_Collection, self:_GetCollectionProgressText(self._emojList))
  end
end

function AppearancePreviewView:_OnTabClick(tabIndex)
  if self._tabIndex ~= tabIndex then
    self._tabIndex = tabIndex
  end
  self:_EnsureTableView(tabIndex)
  self:SetActive(self.ui.ScrollView_HeadList, tabIndex == TAB_INDEX_HEAD)
  self:SetActive(self.ui.ScrollView_EmojList, tabIndex == TAB_INDEX_EMOJ)
  if self._content then
    self._content.anchoredPosition = CS.UnityEngine.Vector2(self._content.anchoredPosition.x, -10)
    self._content.sizeDelta = CS.UnityEngine.Vector2(self._content.sizeDelta.x, self._contentLen[tabIndex])
  end
  self:_CheckIsNoData(tabIndex)
end

function AppearancePreviewView:_CheckIsNoData(tabIndex)
  local dataList = self:_GetDataList()
  if self.ui.Group_Null_Black then
    self:SetActive(self.ui.Group_Null_Black, 0 == #dataList)
    local timeText = tabIndex == TAB_INDEX_HEAD and LT.Text("PickCosmeticsAllPlayerAvatarsGot") or LT.Text("PickCosmeticsAllEmojiGot")
    self:SetText(self.ui.Text_Time, timeText)
  end
end

function AppearancePreviewView:_EnsureTableView(tabIndex)
  local scrollList = tabIndex == TAB_INDEX_HEAD and self.ui.ScrollView_HeadList or self.ui.ScrollView_EmojList
  self._content = scrollList:GetComponent(T_ScrollRect).content.transform
  local tableViews = self._tableViews or {}
  self._tableViews = tableViews
  if not tableViews[tabIndex] then
    local outerScrollRect = scrollList:GetComponent(T_ScrollRect)
    tableViews[tabIndex] = self:CreateTableview(scrollList, function()
      local keys = self:_GetDataKeyList(tabIndex)
      return keys and #keys or 0
    end, function(view, idx)
      local keys = self:_GetDataKeyList(tabIndex)
      local groupId = keys[idx]
      local cell = self:DequeueCellByTag(view, idx, self.ui.UI_Bag_Item_EmojGroup)
      self:RemoveViewComponentOnce(cell.gameObject, EmojGroupComp)
      local comp = self:AddViewComponent(cell.gameObject, EmojGroupComp)
      comp:Refresh(groupId, self:_GetDataList(groupId), tabIndex, self.ui.UI_Bag_Item_Appearance, self._selectedIdList[self._tabIndex], self._interactable, outerScrollRect)
      return cell
    end, function(_, idx)
      local keys = self:_GetDataKeyList(tabIndex)
      local groupId = keys[idx]
      local dataList = self:_GetDataList(groupId)
      return 1619, 242 * math.ceil((dataList and #dataList or 0) / 6) + 55
    end, function()
    end)
  end
  tableViews[tabIndex]:ReloadData()
end

function AppearancePreviewView:_GetCollectionProgressText(itemList)
  local total = #itemList
  local ownerNum = 0
  for _, itemId in ipairs(itemList) do
    local realId = ItemDataUtils.GetGenderDifferenceRealItem(itemId)
    if ItemDataUtils.GetItemNum(realId) > 0 then
      ownerNum = ownerNum + 1
    end
  end
  do return string.format, "%s/%s", ownerNum end
  return string.format, "%s/%s", ownerNum, total, nil, nil, ItemDataUtils.GetGenderDifferenceRealItem(itemId), ItemDataUtils.GetItemNum(realId), realId
end

function AppearancePreviewView:_GetGroupId(itemId)
  itemId = ItemDataUtils.GetGenderDifferenceRealItem(itemId)
  local config = ItemDataUtils.GetItemConfig(itemId)
  return config.ClassificationParam[1]
end

function AppearancePreviewView:_GetHeadAndEmoj(dropId)
  local list = ItemDataUtils.GetDropItemList(dropId)
  local headList, emojList = {}, {}
  local headGroupList, emojGroupList = {}, {}
  local headGroupKeyList, emojGroupKeyList = {}, {}
  local Type_Head = cd.ItemSubType.PlayerAvatar
  local Type_Emoji = cd.ItemSubType.Emoji
  local Type_GenderDifference = cd.ItemSubType.GenderDifference
  for _, itemId in ipairs(list) do
    local itemCfg = ItemDataUtils.GetItemConfig(itemId)
    if itemCfg then
      if self._interactable then
        local realId = ItemDataUtils.GetGenderDifferenceRealItem(itemId)
        if ItemDataUtils.GetItemNum(realId) > 0 then
      end
      else
        local realItemId, realCfg = itemId, itemCfg
        if itemCfg.SubType == Type_GenderDifference then
          realItemId = ItemDataUtils.GetGenderDifferenceRealItem(itemId)
          realCfg = ItemDataUtils.GetItemConfig(realItemId)
        end
        if realCfg.SubType == Type_Head then
          table.insert(headList, itemId)
          local tmpGroupId = self:_GetGroupId(itemId)
          if not headGroupList[tmpGroupId] then
            headGroupList[tmpGroupId] = {}
            table.insert(headGroupKeyList, tmpGroupId)
          end
          table.insert(headGroupList[tmpGroupId], itemId)
        elseif realCfg.SubType == Type_Emoji then
          table.insert(emojList, itemId)
          local tmpGroupId = self:_GetGroupId(itemId)
          if not emojGroupList[tmpGroupId] then
            emojGroupList[tmpGroupId] = {}
            table.insert(emojGroupKeyList, tmpGroupId)
          end
          table.insert(emojGroupList[tmpGroupId], itemId)
        end
      end
    end
  end
  table.sort(headGroupKeyList, function(a, b)
    return DT.CommonID[a].BaseSortID < DT.CommonID[b].BaseSortID
  end)
  table.sort(emojGroupKeyList, function(a, b)
    return DT.CommonID[a].BaseSortID < DT.CommonID[b].BaseSortID
  end)
  local headLen, emojLen = 0, 0
  for _, groupList in pairs(headGroupList) do
    headLen = headLen + 55 + math.ceil(#groupList / 6) * 242
    table.sort(groupList, function(a, b)
      local aGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(a)) > 0
      local bGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(b)) > 0
      if aGot ~= bGot then
        return bGot
      end
      return ItemDataUtils.GetItemConfig(a).BaseSortID < ItemDataUtils.GetItemConfig(b).BaseSortID
    end)
  end
  for _, groupList in pairs(emojGroupList) do
    emojLen = emojLen + 55 + math.ceil(#groupList / 6) * 242
    table.sort(groupList, function(a, b)
      local aGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(a)) > 0
      local bGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(b)) > 0
      if aGot ~= bGot then
        return bGot
      end
      return ItemDataUtils.GetItemConfig(a).BaseSortID < ItemDataUtils.GetItemConfig(b).BaseSortID
    end)
  end
  self._contentLen = {headLen, emojLen}
  return headList, emojList, headGroupList, emojGroupList, headGroupKeyList, emojGroupKeyList
end

function AppearancePreviewView:_GetDataList(groupId)
  if not groupId then
    if self._tabIndex == TAB_INDEX_EMOJ then
      return self._emojList
    else
      return self._headList
    end
  elseif self._tabIndex == TAB_INDEX_EMOJ then
    return self._emojGroupList[groupId]
  else
    return self._headGroupList[groupId]
  end
end

function AppearancePreviewView:_GetDataKeyList(tabIndex)
  if tabIndex == TAB_INDEX_EMOJ then
    return self._emojGroupKeyList
  else
    return self._headGroupKeyList
  end
end

function AppearancePreviewView:_OnAppearanceChoose(id, extraData)
  if extraData and extraData.tabIndex then
    local tabIndex = extraData.tabIndex
    self._selectedIdList[tabIndex] = id
  end
end

function AppearancePreviewView:_OnClickReceive()
  local selectedId = self._selectedIdList[self._tabIndex]
  if selectedId then
    ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
    end, function()
    end, self._itemTid, selectedId, 1)
    self:Close()
  end
end

return AppearancePreviewView
