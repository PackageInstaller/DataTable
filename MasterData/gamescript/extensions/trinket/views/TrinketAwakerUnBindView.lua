local TrinketAwakerUnBindView, Super = NewClass("TrinketAwakerUnBindView", BaseView)
TrinketAwakerUnBindView.uiResCls = UI_Awaker_Popup_UnBindTrinketResource
local GroupItemNode = {
  Icon = "Icon_Require",
  TextCount = "Text_Count",
  GroupNotEnough = "Group_Not_Enough",
  BtnAutoSelect = "Btn_Auto_Select"
}
local PlaceholderText = {
  SingleTitle = LT.Text("TrinketUnbindMaterialTitle"),
  BatchTitle = LT.Text("TrinketBatchUnbindTitle"),
  NotEnough = LT.Text("TrinketMaterialNotEnough"),
  AutoSelectTips = LT.Text("TrinketAutoSelectTips"),
  LockedTips = LT.Text("TrinketLockedCannotSelectTips")
}
local HighLevelTipsKeyMap = {
  TrinketUnbindTips = "TrinketHighLevelUnbindTips",
  TrinketChangeBindTips = "TrinketHighLevelChangeBindTips",
  TrinketBatchUnbindTips = "TrinketHighLevelBatchUnbindTips"
}

function TrinketAwakerUnBindView:ctor(awakerTid, pos, newUid)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.pos = pos
  self.newUid = newUid
  self.needNum = AwakerDataUtils.GetUnbindMaterialNum()
  self.groupData = {}
  self.groupPosList = {}
  self.selectedPool = {}
  self.candidateUids = {}
  self.autoSelectOn = false
  self:_InitSelectData()
end

function TrinketAwakerUnBindView:_InitSelectData()
  local excludeUids
  if self.newUid then
    excludeUids = {
      self.newUid
    }
  end
  if self.pos then
    self.groupPosList = {
      self.pos
    }
  else
    local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.awakerTid)
    for slot = 1, CommonDefine.MaxEquipTrinketsNum do
      local boundUid = boundTrinkets[slot]
      if boundUid and 0 ~= boundUid then
        table.insert(self.groupPosList, slot)
      end
    end
  end
  for _, slot in ipairs(self.groupPosList) do
    self.groupData[slot] = self:_BuildGroupData(slot, excludeUids)
  end
  self.candidateUids = self:_BuildCandidateList()
end

function TrinketAwakerUnBindView:_BuildGroupData(slot, excludeUids)
  local candidateUids = AwakerDataUtils.GetUnbindMaterialCandidates(self.awakerTid, slot, excludeUids)
  AwakerDataUtils.SortUnbindMaterialUids(candidateUids)
  return {
    needNum = self.needNum,
    candidateUids = candidateUids,
    selectedUids = {},
    selectedSet = {}
  }
end

function TrinketAwakerUnBindView:_BuildCandidateList()
  local candidates = {}
  local seen = {}
  for _, slot in ipairs(self.groupPosList) do
    local group = self.groupData[slot]
    for _, uid in ipairs(group.candidateUids) do
      if not seen[uid] then
        seen[uid] = true
        table.insert(candidates, uid)
      end
    end
  end
  return candidates
end

function TrinketAwakerUnBindView:_SafeSetActive(go, state)
  if not go or IsNil(go) then
    return
  end
  go:SetActive(state)
end

function TrinketAwakerUnBindView:_SafeSetText(go, text)
  if not go or IsNil(go) then
    return
  end
  self:SetText(go, text)
end

function TrinketAwakerUnBindView:_SafeAddBtnClick(go, onClick)
  if not go or IsNil(go) then
    return
  end
  self:AddButtonClickListener(go, onClick)
end

function TrinketAwakerUnBindView:OnBuildView()
  Super.OnBuildView(self)
  self:_InitCandidateListView()
end

function TrinketAwakerUnBindView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnItemDetailLockStates, self)
end

function TrinketAwakerUnBindView:RegisterEvents()
  self:_SafeAddBtnClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:_SafeAddBtnClick(self.ui.Btn_Confirm, System.fn(self, self._OnClickBtnConfirm))
  self:_SafeAddBtnClick(self.ui.Btn_Tips, System.fn(self, self._OnClickBtnAutoSelectTips))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_AutoSelect, System.fn(self, self._OnToggleAutoSelect))
end

function TrinketAwakerUnBindView:OnEnterView()
  Super.OnEnterView(self)
  self.autoSelectOn = false
  self:_RefreshView()
end

function TrinketAwakerUnBindView:OnExitView()
  Super.OnExitView(self)
end

function TrinketAwakerUnBindView:_InitCandidateListView()
  self.candidateListView = self:CreateTableview(self.ui.TrinketView, function()
    return #self.candidateUids
  end, function(view, index)
    do return self._CandidateCellAtIndex, self, view end
    return self._CandidateCellAtIndex, self, view, index
  end)
  self.candidateListView:ReloadData()
end

function TrinketAwakerUnBindView:_RefreshView()
  self:_RefreshTitle()
  self:_RefreshCandidateList()
  self:_RefreshRequireArea()
  self:_RefreshSuitsProgress()
  self:_RefreshAutoSelectToggle(self.autoSelectOn)
  self:_RefreshConfirmBtn()
end

function TrinketAwakerUnBindView:_RefreshTitle()
  local title = PlaceholderText.SingleTitle
  if #self.groupPosList > 1 then
    title = PlaceholderText.BatchTitle
  end
  self:_SafeSetText(self.ui.Text_Title, title)
end

function TrinketAwakerUnBindView:_RefreshCandidateList()
  if self.candidateListView then
    self.candidateListView:ReloadData()
  end
  self:_SafeSetActive(self.ui.Group_Candidate_Empty, 0 == #self.candidateUids)
end

function TrinketAwakerUnBindView:_RefreshRequireArea()
  self:_SafeSetActive(self.ui.Group_Require_Single, false)
  local contentGo = self.ui.Content_Batch
  local content = contentGo and contentGo.transform
  if not content or 0 == content.childCount then
    return
  end
  local total = self:ReserveChildren(content, #self.groupPosList)
  for i, slot in ipairs(self.groupPosList) do
    local itemGo = content:GetChild(i - 1).gameObject
    itemGo:SetActive(true)
    self:_RefreshRequireItem(itemGo.transform, slot)
  end
  for i = #self.groupPosList + 1, total do
    content:GetChild(i - 1).gameObject:SetActive(false)
  end
end

function TrinketAwakerUnBindView:_RefreshRequireItem(itemTrans, slot)
  local group = self.groupData[slot]
  if not group then
    return
  end
  local iconTrans = itemTrans:Find(GroupItemNode.Icon)
  if iconTrans then
    self:_SetRequireIcon(iconTrans.gameObject, slot)
  end
  local countTrans = itemTrans:Find(GroupItemNode.TextCount)
  if countTrans then
    self:_SafeSetText(countTrans.gameObject, string.format("%s/%s", #group.selectedUids, group.needNum))
  end
  local notEnoughTrans = itemTrans:Find(GroupItemNode.GroupNotEnough)
  if notEnoughTrans then
    notEnoughTrans.gameObject:SetActive(#group.selectedUids < group.needNum)
  end
  local btnAutoTrans = itemTrans:Find(GroupItemNode.BtnAutoSelect)
  if btnAutoTrans then
    self:AddButtonClickListener(btnAutoTrans.gameObject, function()
      self:_SelectGroupAuto(slot)
    end)
  end
end

function TrinketAwakerUnBindView:_RefreshSuitsProgress()
  local groupTrinkets = self.ui.Group_Trinkets
  if not groupTrinkets or IsNil(groupTrinkets) then
    return
  end
  local content = groupTrinkets.transform
  if 0 == content.childCount then
    return
  end
  local viewDatas = self:_BuildSuitsProgressDatas()
  local total = self:ReserveChildren(content, #viewDatas)
  for i, viewData in ipairs(viewDatas) do
    local itemGo = content:GetChild(i - 1).gameObject
    itemGo:SetActive(true)
    self:_RefreshSuitProgressItem(itemGo, viewData)
  end
  for i = #viewDatas + 1, total do
    content:GetChild(i - 1).gameObject:SetActive(false)
  end
end

function TrinketAwakerUnBindView:_RefreshSuitProgressItem(itemGo, viewData)
  local selectedNum = self:_GetSlotSelectedNum(viewData.slot)
  local numText
  if viewData.isShort then
    numText = StrUtils.GetColorText(PlaceholderText.NotEnough, DT.ColorConfig.Red.Light)
  else
    local xText = tostring(selectedNum)
    if selectedNum < self.needNum then
      xText = StrUtils.GetColorText(xText, DT.ColorConfig.Red.Light)
    end
    numText = string.format("%s/%s", xText, self.needNum)
  end
  local dropItemTid = ItemDataUtils.GetTrinketDropItemTidBySuit(viewData.suitId)
  local iconData = {
    tid = dropItemTid,
    num = numText,
    ShowOwnAwaker = false,
    ShowRedDot = false,
    ShowLockImg = false,
    longPressCallback = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, itemGo, nil, dropItemTid)
    end
  }
  self:AddViewComponentOnce(itemGo, CompPublicIconItemType1, iconData)
  local dropItemCfg = dropItemTid and DT.Item[dropItemTid] or nil
  local itemUi = UI_Common_Item_WuPin_Type1Resource(itemGo)
  if dropItemCfg and itemUi.Icon_Article then
    self:SetImage(itemUi.Icon_Article, dropItemCfg.Icon)
  end
  if itemUi.Image_Michi then
    itemUi.Image_Michi:SetActive(false)
  end
end

function TrinketAwakerUnBindView:_BuildSuitsProgressDatas()
  local shortSlotSet = self:_CalShortSlotSet()
  local viewDatas = {}
  for _, slot in ipairs(self.groupPosList) do
    local boundUid = AwakerDataUtils.GetBoundTrinketUid(self.awakerTid, slot)
    local itemData = 0 ~= boundUid and ItemDataUtils.GetItemByUid(boundUid) or nil
    local suitId = itemData and AwakerTrinketDataUtils.GetSuitIdByItemTid(itemData.tid) or nil
    if suitId then
      local suitCfg = DT.TrinketSuitEffect[suitId]
      table.insert(viewDatas, {
        slot = slot,
        boundUid = boundUid,
        tid = itemData.tid,
        suitId = suitId,
        isShort = true == shortSlotSet[slot],
        baseSortId = suitCfg and suitCfg.BaseSortID or 0
      })
    end
  end
  table.sort(viewDatas, function(a, b)
    if a.baseSortId ~= b.baseSortId then
      return a.baseSortId < b.baseSortId
    end
    return a.slot < b.slot
  end)
  return viewDatas
end

function TrinketAwakerUnBindView:_GetSlotSelectedNum(slot)
  local group = self.groupData[slot]
  return group and #group.selectedUids or 0
end

function TrinketAwakerUnBindView:_CalShortSlotSet()
  local shortSet = {}
  local suitSlots = {}
  local suitPool = {}
  for _, slot in ipairs(self.groupPosList) do
    local suitId = self:_GetSlotSuitId(slot)
    if suitId then
      suitSlots[suitId] = suitSlots[suitId] or {}
      table.insert(suitSlots[suitId], slot)
      if not suitPool[suitId] then
        local group = self.groupData[slot]
        suitPool[suitId] = group and #group.candidateUids or 0
      end
    end
  end
  for suitId, slots in pairs(suitSlots) do
    local pool = suitPool[suitId] or 0
    for j, slot in ipairs(slots) do
      if pool < j * self.needNum then
        shortSet[slot] = true
      end
    end
  end
  return shortSet
end

function TrinketAwakerUnBindView:_SetRequireIcon(iconGo, slot)
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(self.awakerTid, slot)
  if 0 == boundUid then
    return
  end
  local itemData = ItemDataUtils.GetItemByUid(boundUid)
  if not itemData then
    return
  end
  self:SetIcon(MaterialIconType.CommonIcon, iconGo, {
    tid = itemData.tid,
    uid = boundUid,
    hideIsNew = true,
    onClick = function(tid, uid)
      ItemDataUtils.ShowItemDetailTips(self.binder, iconGo, uid, tid)
    end
  })
end

function TrinketAwakerUnBindView:_RefreshAutoSelectToggle(state)
  self:SetZ1Toggle(self.ui.Toggle_AutoSelect, state, true)
end

function TrinketAwakerUnBindView:_RefreshConfirmBtn()
  local btnState = self:_IsAllGroupsSatisfied() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  self:SetButtonState(self.ui.Btn_Confirm, btnState)
end

function TrinketAwakerUnBindView:_OnItemDetailLockStates()
  self:_RefreshView()
end

function TrinketAwakerUnBindView:_CandidateCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local uid = self.candidateUids[index]
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return cell
  end
  local isSelected = self:_IsUidSelected(uid)
  local iconData = {
    tid = itemData.tid,
    uid = uid,
    hideIsNew = true,
    callback = function()
      self:_OnClickCandidateUid(uid)
    end,
    selectedFunc = function()
      do return self._IsUidSelected, self end
      return self._IsUidSelected, self, uid
    end,
    showSubBtn = isSelected,
    btnSubFunc = function()
      self:_OnSubClickCandidateUid(uid)
    end,
    longPressCallback = function(tid, uidVal)
      ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, uidVal, tid)
    end
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType1, iconData)
  return cell
end

function TrinketAwakerUnBindView:_IsUidSelected(uid)
  return self.selectedPool[uid] ~= nil
end

function TrinketAwakerUnBindView:_GetPosOfUid(uid)
  if 1 == #self.groupPosList then
    return self.groupPosList[1]
  end
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return nil
  end
  local suitId = AwakerTrinketDataUtils.GetSuitIdByItemTid(itemData.tid)
  if not suitId then
    return nil
  end
  local fallbackSlot
  for _, slot in ipairs(self.groupPosList) do
    if self:_GetSlotSuitId(slot) == suitId then
      if not self:_IsGroupSatisfied(slot) then
        return slot
      end
      fallbackSlot = fallbackSlot or slot
    end
  end
  return fallbackSlot
end

function TrinketAwakerUnBindView:_GetSlotSuitId(slot)
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(self.awakerTid, slot)
  if 0 == boundUid then
    return nil
  end
  local itemData = ItemDataUtils.GetItemByUid(boundUid)
  return itemData and AwakerTrinketDataUtils.GetSuitIdByItemTid(itemData.tid) or nil
end

function TrinketAwakerUnBindView:_OnSubClickCandidateUid(uid)
  local selectedSlot = self.selectedPool[uid]
  if not selectedSlot then
    return
  end
  self.autoSelectOn = false
  self:_RemoveFromSelection(selectedSlot, uid)
  self:_RefreshView()
end

function TrinketAwakerUnBindView:_OnClickCandidateUid(uid)
  if ItemDataUtils.GetItemLocked(uid) then
    Alert.ShowStr(PlaceholderText.LockedTips)
    return
  end
  if self.autoSelectOn then
    self.autoSelectOn = false
  end
  local selectedSlot = self.selectedPool[uid]
  if selectedSlot then
    self:_RemoveFromSelection(selectedSlot, uid)
  else
    local slot = self:_GetPosOfUid(uid)
    if not slot then
      return
    end
    local group = self.groupData[slot]
    if not group then
      return
    end
    if #group.selectedUids >= group.needNum then
      return
    end
    table.insert(group.selectedUids, uid)
    group.selectedSet[uid] = true
    self.selectedPool[uid] = slot
  end
  self:_RefreshView()
end

function TrinketAwakerUnBindView:_RemoveFromSelection(slot, uid)
  local group = self.groupData[slot]
  if not group or not group.selectedSet[uid] then
    return
  end
  group.selectedSet[uid] = nil
  self.selectedPool[uid] = nil
  table.removeByValue(group.selectedUids, uid)
end

function TrinketAwakerUnBindView:_ReplaceGroupSelection(slot, uids)
  local group = self.groupData[slot]
  if not group then
    return
  end
  for _, oldUid in ipairs(group.selectedUids) do
    self.selectedPool[oldUid] = nil
  end
  group.selectedUids = {}
  group.selectedSet = {}
  for _, uid in ipairs(uids) do
    if #group.selectedUids >= group.needNum then
      break
    end
    if not self.selectedPool[uid] then
      table.insert(group.selectedUids, uid)
      group.selectedSet[uid] = true
      self.selectedPool[uid] = slot
    end
  end
end

function TrinketAwakerUnBindView:_IsGroupSatisfied(slot)
  local group = self.groupData[slot]
  if not group then
    return false
  end
  return #group.selectedUids >= group.needNum
end

function TrinketAwakerUnBindView:_IsAllGroupsSatisfied()
  if not table.next(self.groupData) then
    return false
  end
  for _, slot in ipairs(self.groupPosList) do
    if not self:_IsGroupSatisfied(slot) then
      return false
    end
  end
  return true
end

function TrinketAwakerUnBindView:_OnToggleAutoSelect(isOn)
  self.autoSelectOn = isOn
  if isOn then
    self:_AutoSelectAllGroups()
  else
    for _, slot in ipairs(self.groupPosList) do
      self:_ReplaceGroupSelection(slot, {})
    end
  end
  self:_RefreshView()
end

function TrinketAwakerUnBindView:_OnClickBtnAutoSelectTips()
  Alert.ShowStr(PlaceholderText.AutoSelectTips)
end

function TrinketAwakerUnBindView:_AutoSelectAllGroups()
  local excludeUids = {}
  if self.newUid then
    table.insert(excludeUids, self.newUid)
  end
  for _, slot in ipairs(self.groupPosList) do
    self:_ReplaceGroupSelection(slot, {})
  end
  for _, slot in ipairs(self.groupPosList) do
    local uids = AwakerDataUtils.AutoSelectUnbindMaterials(self.awakerTid, slot, self.needNum, excludeUids)
    self:_ReplaceGroupSelection(slot, uids)
    for _, uid in ipairs(uids) do
      table.insert(excludeUids, uid)
    end
  end
end

function TrinketAwakerUnBindView:_SelectGroupAuto(slot)
  local excludeUids
  if self.newUid then
    excludeUids = {
      self.newUid
    }
  end
  self:_ReplaceGroupSelection(slot, {})
  local uids = AwakerDataUtils.AutoSelectUnbindMaterials(self.awakerTid, slot, self.needNum, excludeUids)
  self:_ReplaceGroupSelection(slot, uids)
  self:_RefreshView()
end

function TrinketAwakerUnBindView:_OnClickBtnConfirm()
  if not self:_IsAllGroupsSatisfied() then
    Alert.ShowStr(PlaceholderText.NotEnough)
    return
  end
  local hasMaxLevelMaterial = false
  local maxLevel = AwakerTrinketDataUtils.GetTrinketMaxLevel()
  for _, slot in ipairs(self.groupPosList) do
    local group = self.groupData[slot]
    for _, uid in ipairs(group and group.selectedUids or {}) do
      if maxLevel <= ItemDataUtils.GetTrinketLevelByUid(uid) then
        hasMaxLevelMaterial = true
        break
      end
    end
    if hasMaxLevelMaterial then
      break
    end
  end
  local tipsKey = "TrinketUnbindTips"
  if self.newUid then
    tipsKey = "TrinketChangeBindTips"
  elseif #self.groupPosList > 1 then
    tipsKey = "TrinketBatchUnbindTips"
  end
  tipsKey = hasMaxLevelMaterial and HighLevelTipsKeyMap[tipsKey] or tipsKey
  Alert.Show(tipsKey, nil, function()
    self:_SendUnbindRequest()
  end)
end

function TrinketAwakerUnBindView:_SendUnbindRequest()
  if self.newUid then
    local group = self.groupData[self.groupPosList[1]]
    local materialUids = group and table.deepclone(group.selectedUids) or {}
    AwakerTrinketController.Instance:ReqChangeBindTrinket(self.awakerTid, self.groupPosList[1], self.newUid, materialUids, function()
      Alert.ShowStr(LT.Text("TrinketChangeBindSuccessTips"))
    end)
  else
    local materialUidsMap = {}
    for _, slot in ipairs(self.groupPosList) do
      local group = self.groupData[slot]
      if group then
        materialUidsMap[slot] = table.deepclone(group.selectedUids)
      end
    end
    AwakerTrinketController.Instance:ReqBatchUnbindTrinket(self.awakerTid, materialUidsMap, function()
      Alert.ShowStr(LT.Text("TrinketUnBindSuccessTips"))
    end)
  end
  self:Close()
end

return TrinketAwakerUnBindView
