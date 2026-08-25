local UI_Bag_Panel_AppearancePreview, Super = System.NewClass("UI_Bag_Panel_AppearancePreview", UIBasePanel)
UI_Bag_Panel_AppearancePreview.uiResCls = UI_Bag_Panel_AppearancePreviewResource
local ScrollRect = CS.UnityEngine.UI.ScrollRect
local TAB_INDEX_HEAD = 1
local TAB_INDEX_EMOJ = 2

function UI_Bag_Panel_AppearancePreview:ctor(itemTid, interactable, isRand)
  Super.ctor(self)
  self.itemTid = itemTid
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  assert(itemCfg and itemCfg.SpParam and itemCfg.SpParam[1], string.format("道具 %s[%s] 没有配置SpParam", itemTid, itemCfg and itemCfg.CnID))
  self.dropId = itemCfg.SpParam[1]
  self.tabIndex = 1
  self.interactable = interactable
  self.selectedIdList = {}
  self.isRand = isRand or false
end

function UI_Bag_Panel_AppearancePreview:OnBind(binder)
  self.binder = binder
  self.headList, self.emojList, self.headGroupList, self.emojGroupList, self.headGroupKeyList, self.emojGroupKeyList = self:GetHeadAndEmoj(self.dropId)
  binder:BindButtonClick(self.ui.Btn_Back, System.fn(self, self.Close))
  binder:BindEvent(EventMgr.Instance.AppearanceChoose, System.fn(self, self.OnAppearanceChoose))
  self:CreateTableView(self.ui.ScrollView_HeadList, TAB_INDEX_HEAD)
  self:CreateTableView(self.ui.ScrollView_EmojList, TAB_INDEX_EMOJ)
  self:InitShowContentTab()
  if self.ui.Btn_Receive then
    self.binder:BindTimer(0.01, 0, nil, function()
      if self.interactable then
        self.ui.Btn_Receive:SetActive(true)
        self.ui.Text_Head_Collection:SetActive(false)
        self.ui.Text_Emoji_Collection:SetActive(false)
        binder:BindZ1Button(self.ui.Btn_Receive, System.fn(self, self.OnUseBtnClick))
      else
        self.ui.Btn_Receive:SetActive(false)
        self.ui.Text_Head_Collection:SetActive(true)
        self.ui.Text_Emoji_Collection:SetActive(true)
        binder:BindToText(self.ui.Text_Head_Collection, function()
          do return self.GetCollectionProgressText, self end
          return self.GetCollectionProgressText, self, self.headList
        end)
        binder:BindToText(self.ui.Text_Emoji_Collection, function()
          do return self.GetCollectionProgressText, self end
          return self.GetCollectionProgressText, self, self.emojList
        end)
      end
    end)
  end
  if self.ui.Btn_RatePreview then
    self.ui.Btn_RatePreview:SetActive(self.isRand)
    binder:BindButtonClick(self.ui.Btn_RatePreview, System.fn(self, self.OnRatePreview))
  end
  self.binder:BindToZ1Toggle(self.ui.Btn_Head, nil, System.bind(self.OnTabClick, self, TAB_INDEX_HEAD))
  self.binder:BindToZ1Toggle(self.ui.Btn_Emoji, nil, System.bind(self.OnTabClick, self, TAB_INDEX_EMOJ))
  if self._initShowTab then
    self:OnTabClick(self._initShowTab)
  end
end

function UI_Bag_Panel_AppearancePreview:InitShowContentTab()
  self._initShowTab = TAB_INDEX_HEAD
  self.binder:SetActive(self.ui.Btn_Head, true)
  self.binder:SetActive(self.ui.Btn_Emoji, true)
  local hideNum = 0
  local dataList = self:GetDataKeyList(TAB_INDEX_HEAD)
  if not dataList or 0 == #dataList then
    self.binder:SetActive(self.ui.Btn_Head, false)
    hideNum = hideNum + 1
    self._initShowTab = TAB_INDEX_EMOJ
  end
  dataList = self:GetDataKeyList(TAB_INDEX_EMOJ)
  if not dataList or 0 == #dataList then
    self.binder:SetActive(self.ui.Btn_Emoji, false)
    hideNum = hideNum + 1
    if self._initShowTab == TAB_INDEX_EMOJ then
      self._initShowTab = nil
    end
  end
  self.binder:SetActive(self.ui.Image_Line_Middle, 0 == hideNum)
  self.binder:SetActive(self.ui.Group_Null_Black, hideNum >= 2)
end

function UI_Bag_Panel_AppearancePreview:GetCollectionProgressText(itemList)
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

function UI_Bag_Panel_AppearancePreview:OnTabClick(tabIndex)
  if self.tabIndex ~= tabIndex then
    self.tabIndex = tabIndex
    if tabIndex == TAB_INDEX_HEAD then
      self:CreateTableView(self.ui.ScrollView_HeadList, TAB_INDEX_HEAD)
    else
      self:CreateTableView(self.ui.ScrollView_EmojList, TAB_INDEX_EMOJ)
    end
  end
  self.binder:SetActive(self.ui.ScrollView_HeadList, tabIndex == TAB_INDEX_HEAD)
  self.binder:SetActive(self.ui.ScrollView_EmojList, tabIndex == TAB_INDEX_EMOJ)
  if self.content then
    self.content.transform.anchoredPosition = CS.UnityEngine.Vector2(self.content.transform.anchoredPosition.x, -10)
    self.content.transform.sizeDelta = CS.UnityEngine.Vector2(self.content.transform.sizeDelta.x, self.contentLen[tabIndex])
  end
  self:CheckIsNoData(tabIndex)
end

function UI_Bag_Panel_AppearancePreview:CheckIsNoData(tabIndex)
  local dataList = self:GetDataList()
  if self.ui.Group_Null_Black then
    self.binder:SetActive(self.ui.Group_Null_Black, 0 == #dataList)
    self.binder:BindToText(self.ui.Text_Time, function()
      return tabIndex == TAB_INDEX_HEAD and LT.Text("PickCosmeticsAllPlayerAvatarsGot") or LT.Text("PickCosmeticsAllEmojiGot")
    end)
  end
  self.binder:SetActive(self.ui.Btn_Receive, #dataList > 0 and self.interactable)
end

function UI_Bag_Panel_AppearancePreview:OnAppearanceChoose(id, extraData)
  if extraData and extraData.tabIndex then
    local tabIndex = extraData.tabIndex
    self.selectedIdList[tabIndex] = id
  end
end

function UI_Bag_Panel_AppearancePreview:OnUseBtnClick()
  local selectedId = self.selectedIdList[self.tabIndex]
  if selectedId then
    ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
    end, function()
    end, self.itemTid, selectedId, 1)
    self:Close()
    if self.afterUseCallback then
      self.afterUseCallback()
    end
  end
end

function UI_Bag_Panel_AppearancePreview:OnRatePreview()
  UIManager.Instance:SetTempPanelLayer(Urls.CommonillustrateView, UIManager.Instance:GetLayerName(self))
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("CosmeticsRandChestRateTitle"), LT.Text("CosmeticsRandChestRateText"))
end

function UI_Bag_Panel_AppearancePreview:GetGroupId(itemId)
  itemId = ItemDataUtils.GetGenderDifferenceRealItem(itemId)
  local config = ItemDataUtils.GetItemConfig(itemId)
  return config.ClassificationParam[1]
end

function UI_Bag_Panel_AppearancePreview:GetHeadAndEmoj(dropId)
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
      if self.interactable then
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
          local tmpGroupId = self:GetGroupId(itemId)
          if not headGroupList[tmpGroupId] then
            headGroupList[tmpGroupId] = {}
            table.insert(headGroupKeyList, tmpGroupId)
          end
          table.insert(headGroupList[tmpGroupId], itemId)
        elseif realCfg.SubType == Type_Emoji then
          table.insert(emojList, itemId)
          local tmpGroupId = self:GetGroupId(itemId)
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
    headLen = headLen + 100 + math.ceil(#groupList / 6) * 242
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
    emojLen = emojLen + 100 + math.ceil(#groupList / 6) * 242
    table.sort(groupList, function(a, b)
      local aGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(a)) > 0
      local bGot = ItemDataUtils.GetItemNum(ItemDataUtils.GetGenderDifferenceRealItem(b)) > 0
      if aGot ~= bGot then
        return bGot
      end
      return ItemDataUtils.GetItemConfig(a).BaseSortID < ItemDataUtils.GetItemConfig(b).BaseSortID
    end)
  end
  self.contentLen = {headLen, emojLen}
  return headList, emojList, headGroupList, emojGroupList, headGroupKeyList, emojGroupKeyList
end

function UI_Bag_Panel_AppearancePreview:IsFilterOwned()
  return false
end

function UI_Bag_Panel_AppearancePreview:GetDataList(groupId)
  if not groupId then
    if self.tabIndex == TAB_INDEX_EMOJ then
      return self.emojList
    else
      return self.headList
    end
  elseif self.tabIndex == TAB_INDEX_EMOJ then
    return self.emojGroupList[groupId]
  else
    return self.headGroupList[groupId]
  end
end

function UI_Bag_Panel_AppearancePreview:GetDataKeyList(tabIndex)
  if tabIndex == TAB_INDEX_EMOJ then
    return self.emojGroupKeyList
  else
    return self.headGroupKeyList
  end
end

function UI_Bag_Panel_AppearancePreview:CreateTableView(scrollList, tabIndex)
  local dataKeyList = self:GetDataKeyList(tabIndex)
  self.content = scrollList:GetComponent(typeof(ScrollRect)).content.transform
  local itemComps = {}
  self.tableView = self:CreateTableview(scrollList, function()
    return dataKeyList and #dataKeyList or 0
  end, function(view, idx)
    local cell
    print("emoji debug", xpcall(function()
      cell = self:DequeueCellByTag(view, idx, self.ui.UI_Bag_Item_EmojGroup)
      local gameObj = cell.gameObject
      if itemComps[gameObj] and itemComps[gameObj].binder then
        itemComps[gameObj].binder:teardown()
      end
      local groupId = dataKeyList[idx]
      itemComps[gameObj] = self.binder:BindComponent(UI_Bag_Item_EmojGroup(cell, groupId, self:GetDataList(groupId), tabIndex, self.ui.UI_Bag_Item_Appearance, self.selectedIdList[self.tabIndex], self.interactable))
    end, function()
      print("emoji error")
    end))
    return cell
  end, function(_, idx)
    local groupId = dataKeyList[idx]
    local dataList = self:GetDataList(groupId)
    return 1619, 242 * math.ceil((dataList and #dataList or 0) / 6) + 60
  end, function()
    itemComps = nil
  end)
  self.tableView:ReloadData()
end

return UI_Bag_Panel_AppearancePreview
