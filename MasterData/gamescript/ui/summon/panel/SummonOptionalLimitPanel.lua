local SummonOptionalLimitPanel, Super = System.NewClass("SummonOptionalLimitPanel", UIBasePanel)
SummonOptionalLimitPanel.uiResCls = UI_Summon_Popup_OptionalLimitResource

function SummonOptionalLimitPanel:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData
  self.poolTid = viewData.poolTid
  self.confirmFunc = viewData.confirmFunc
  self.maxSelect = viewData.maxSelect or 1
  self.miniSelect = viewData.miniSelect or 1
  self.awakerItemTidList = viewData.awakerItemTidList or {}
  self.isCategorySelect = viewData.isCategorySelect == true
  self.slot = viewData.slot
  self._selectSet = {}
  if self.isCategorySelect and self.slot then
    local draftItemTid = SummonCategorySelectModel.Instance:GetDraftItemTid(self.slot)
    if draftItemTid then
      self._selectSet[draftItemTid] = true
    end
  end
end

function SummonOptionalLimitPanel:OnBind(binder)
  self.binder = binder
  self:_RefreshTitle()
  self:_BindEvent()
  self:_RefreshView()
end

function SummonOptionalLimitPanel:_RefreshTitle()
  if not self.ui.Text_Title then
    return
  end
  if self.isCategorySelect then
    self.binder:SetText(self.ui.Text_Title, LT.Textf("SummonType_17SelectTitle", SummonCategorySelectDataUtils.GetSelectTypeText(self.poolTid, self.slot)))
    return
  end
  local wishSelectNum = SummonDataUtils.GetWishAwakerSelectNum(self.poolTid)
  self.binder:SetText(self.ui.Text_Title, LT.Textf("SummonType_14SelectTitle", wishSelectNum))
end

function SummonOptionalLimitPanel:_ReloadCategoryList()
  if not self.isCategorySelect then
    return
  end
  local poolId = self.poolTid
  local draftSlotMap = SummonCategorySelectModel.Instance:CopyDraftSlotMap()
  local itemTidList = SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, self.slot)
  self.awakerItemTidList = SummonCategorySelectDataUtils.SortCategoryItemList(poolId, self.slot, draftSlotMap, itemTidList)
  self._selectSet = {}
  local draftItemTid = SummonCategorySelectModel.Instance:GetDraftItemTid(self.slot)
  if draftItemTid then
    self._selectSet[draftItemTid] = true
  end
end

function SummonOptionalLimitPanel:SwitchCategorySlot(slot)
  if not self.isCategorySelect or not slot then
    return
  end
  self.slot = slot
  SummonCategorySelectModel.Instance:SetActiveSlot(slot)
  self._awakerListDirty = true
  self:_ReloadCategoryList()
  self:_RefreshTitle()
  self:_RefreshView()
end

function SummonOptionalLimitPanel:_BindEvent()
  if self.ui.UI_Common_Btn_Back1 then
    self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  end
  self.binder:BindZ1Button(self:_GetConfirmBtnGO(), System.fn(self, self._OnClickConfirm), function()
    do return self._GetConfirmBtnType end
    return self._GetConfirmBtnType, self
  end, function()
    do return self._GetConfirmBtnText end
    return self._GetConfirmBtnText, self
  end)
  self.binder:BindEvent(EventMgr.Instance.OnChooseWishAwaker, System.fn(self, self._OnChooseWishAwaker))
  self.binder:BindEvent(EventMgr.Instance.OnChooseCategorySelectAwaker, System.fn(self, self._OnChooseCategorySelectAwaker))
  self.binder:BindEvent(EventMgr.Instance.OnCategorySelectDraftChanged, System.fn(self, self._OnCategoryDraftChanged))
end

function SummonOptionalLimitPanel:_OnCategoryDraftChanged(poolId)
  if not self.isCategorySelect or poolId ~= self.poolTid then
    return
  end
  self:_RefreshView()
end

function SummonOptionalLimitPanel:_OnChooseWishAwaker()
  self:Close()
end

function SummonOptionalLimitPanel:_OnChooseCategorySelectAwaker()
  if self.isCategorySelect then
    self:Close()
  end
end

function SummonOptionalLimitPanel:_OnClickConfirm()
  if self.isCategorySelect then
    if self:_GetSelectedCount() < self.maxSelect then
      return
    end
    self:_ConfirmCategorySelection()
    return
  end
  local count = self:_GetSelectedCount()
  if count < self.maxSelect then
    return
  end
  local tipsTypeTid = "SummonType_14SelectConfirm"
  local tipsTypeCfg = DT.TipsType[tipsTypeTid]
  if not tipsTypeCfg then
    self:_DoConfirm()
    return
  end
  local nameList = self:_GetSelectedAwakerNamesList()
  local desc = LT.Textf(tipsTypeCfg.Desc, table.unpack(nameList))
  Alert.Show(tipsTypeTid, nil, System.fn(self, self._DoConfirm), nil, desc)
end

function SummonOptionalLimitPanel:_DoConfirm()
  local list = self:_GetSelectedItemTidList()
  if self.confirmFunc then
    self.confirmFunc(list)
  end
  if self.isCategorySelect then
    return
  end
end

function SummonOptionalLimitPanel:_ConfirmCategorySelection()
  local list = self:_GetSelectedItemTidList()
  if self.confirmFunc then
    self.confirmFunc(list)
  end
  if self:_IsCategoryDraftFull() then
    self:Close()
    return
  end
  local nextSlot = SummonCategorySelectModel.Instance:GetFirstEmptySlot()
  if nextSlot then
    self:SwitchCategorySlot(nextSlot)
  end
end

function SummonOptionalLimitPanel:_GetConfirmBtnGO()
  return self.ui.Btn_Receive or self.ui.Btn_Confirm
end

function SummonOptionalLimitPanel:_IsCategoryDraftFull()
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(self.poolTid)
  return selectNum <= SummonCategorySelectModel.Instance:GetDraftSelectedCount() and selectNum > 0
end

function SummonOptionalLimitPanel:_IsLastCategoryStep()
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(self.poolTid)
  if selectNum <= 0 then
    return false
  end
  local model = SummonCategorySelectModel.Instance
  for slot = 1, selectNum do
    if slot ~= self.slot and not model:GetDraftItemTid(slot) then
      return false
    end
  end
  return true
end

function SummonOptionalLimitPanel:_GetConfirmBtnText()
  if self.isCategorySelect then
    if self:_IsLastCategoryStep() then
      do return LT.PanelText end
      return LT.PanelText, "UI_Summon_Popup_OptionalLimit_Text_C_Confirm"
    end
    do return LT.Text end
    return LT.Text, "NextStep"
  end
  do return LT.PanelText end
  return LT.PanelText, "UI_Summon_Popup_OptionalLimit_Text_C_Confirm"
end

function SummonOptionalLimitPanel:_RefreshConfirmBtn()
  local btnGO = self:_GetConfirmBtnGO()
  if not btnGO then
    return
  end
  self.binder:SetButtonState(btnGO, self:_GetConfirmBtnType())
  local buttonComp = self:GetButton(btnGO)
  if buttonComp and buttonComp.buttonTextComp then
    self.binder:SetText(buttonComp.buttonTextComp, self:_GetConfirmBtnText())
  end
end

function SummonOptionalLimitPanel:_GetConfirmBtnType()
  if self.isCategorySelect then
    if self:_GetSelectedCount() >= self.maxSelect then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Unclickable
  end
  if self:_GetSelectedCount() >= self.maxSelect then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function SummonOptionalLimitPanel:_SortAwakerItemTidList()
  if self.isCategorySelect then
    local draftSlotMap = SummonCategorySelectModel.Instance:CopyDraftSlotMap()
    self.awakerItemTidList = SummonCategorySelectDataUtils.SortCategoryItemList(self.poolTid, self.slot, draftSlotMap, self.awakerItemTidList)
    return self.awakerItemTidList
  end
  table.sort(self.awakerItemTidList, function(a, b)
    local awakerTidA = ItemDataUtils.GetAwakerTidByItemTid(a)
    local awakerTidB = ItemDataUtils.GetAwakerTidByItemTid(b)
    local awakerCfgA = DT.AwakerConfig[awakerTidA]
    local awakerCfgB = DT.AwakerConfig[awakerTidB]
    local fullA = ItemDataUtils.IsAwakerChipOverFlow(a) and 1 or 0
    local fullB = ItemDataUtils.IsAwakerChipOverFlow(b) and 1 or 0
    if fullA ~= fullB then
      return fullA < fullB
    end
    local ownedWeightA = AwakerDataUtils.HasOwnedAwaker(awakerTidA) and 0 or 1
    local ownedWeightB = AwakerDataUtils.HasOwnedAwaker(awakerTidB) and 0 or 1
    if ownedWeightA ~= ownedWeightB then
      return ownedWeightA > ownedWeightB
    end
    local qualitSortWeightA = CommonDefine.QualitySortID[awakerCfgA.Quality]
    local qualitSortWeightB = CommonDefine.QualitySortID[awakerCfgB.Quality]
    if qualitSortWeightA ~= qualitSortWeightB then
      return qualitSortWeightA > qualitSortWeightB
    end
    local schoolTypeA = AwakerCfgUtils.GetAwakerSchoolType(awakerTidA)
    local schoolTypeB = AwakerCfgUtils.GetAwakerSchoolType(awakerTidB)
    local schoolTypeWeightA = CommonDefine.ShoolTypeSortWeight[schoolTypeA]
    local schoolTypeWeightB = CommonDefine.ShoolTypeSortWeight[schoolTypeB]
    if schoolTypeWeightA ~= schoolTypeWeightB then
      return schoolTypeWeightA > schoolTypeWeightB
    end
    local potencyLevelA = AwakerDataUtils.GetAwakerPotencyLevel(awakerTidA)
    local potencyLevelB = AwakerDataUtils.GetAwakerPotencyLevel(awakerTidB)
    if potencyLevelA ~= potencyLevelB then
      return potencyLevelA > potencyLevelB
    end
    return (awakerCfgA.BaseSortID or 0) < (awakerCfgB.BaseSortID or 0)
  end)
  return self.awakerItemTidList
end

function SummonOptionalLimitPanel:_IsSelected(itemTid)
  return self._selectSet[itemTid] == true
end

function SummonOptionalLimitPanel:_GetSelectedCount()
  local n = 0
  for _ in pairs(self._selectSet) do
    n = n + 1
  end
  return n
end

function SummonOptionalLimitPanel:_GetSelectedItemTidList()
  local list = {}
  for _, itemTid in ipairs(self.awakerItemTidList) do
    if self:_IsSelected(itemTid) then
      list[#list + 1] = itemTid
    end
  end
  return list
end

function SummonOptionalLimitPanel:_GetSelectedAwakerNamesList()
  local list = self:_GetSelectedItemTidList()
  local names = {}
  for _, itemTid in ipairs(list) do
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    names[#names + 1] = LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerTid))
  end
  return names
end

function SummonOptionalLimitPanel:_IsConflictItem(itemTid)
  if not self.isCategorySelect then
    return false
  end
  local draftSlotMap = SummonCategorySelectModel.Instance:CopyDraftSlotMap()
  return SummonCategorySelectDataUtils.GetConflictSlot(self.poolTid, itemTid, draftSlotMap, self.slot) ~= nil
end

function SummonOptionalLimitPanel:_SaveCurrentSlotDraft()
  if not self.isCategorySelect or not self.slot then
    return
  end
  local itemTid = SummonCategorySelectDataUtils.GetListItemTid(self:_GetSelectedItemTidList(), 1)
  if itemTid then
    SummonCategorySelectController.Instance:OnSelectForSlot(self.slot, itemTid)
    return
  end
  SummonCategorySelectModel.Instance:ClearSlot(self.slot)
end

function SummonOptionalLimitPanel:_SyncCategorySlotDraft(itemTid)
  if not (self.isCategorySelect and self.slot) or not itemTid then
    return
  end
  SummonCategorySelectController.Instance:OnSelectForSlot(self.slot, itemTid)
end

function SummonOptionalLimitPanel:Close(...)
  if self.isCategorySelect then
    self:_SaveCurrentSlotDraft()
  end
  Super.Close(self, ...)
end

function SummonOptionalLimitPanel:_OnClickAwakerItem(itemTid)
  if self.isCategorySelect and self:_IsConflictItem(itemTid) then
    local draftSlotMap = SummonCategorySelectModel.Instance:CopyDraftSlotMap()
    local tips = SummonCategorySelectDataUtils.GetConflictTips(self.poolTid, itemTid, draftSlotMap, self.slot)
    if tips then
      Alert.ShowStr(tips)
    end
    return
  end
  if self._selectSet[itemTid] then
    self._selectSet[itemTid] = nil
    if self.isCategorySelect then
      SummonCategorySelectModel.Instance:ClearSlot(self.slot)
    end
    self:_RefreshView()
    return
  end
  if self:_GetSelectedCount() >= self.maxSelect then
    if self.isCategorySelect then
      self._selectSet = {}
      self._selectSet[itemTid] = true
      self:_SyncCategorySlotDraft(itemTid)
      self:_RefreshView()
      return
    end
    Alert.Show("SummonType_14SelectLimitTips")
    return
  end
  self._selectSet[itemTid] = true
  if self.isCategorySelect then
    self:_SyncCategorySlotDraft(itemTid)
  end
  self:_RefreshView()
end

function SummonOptionalLimitPanel:_RefreshView()
  self:_SortAwakerItemTidList()
  if not self._awakerTableView then
    self:_InitAwakerTableView()
    if not self._awakerTableView then
      return
    end
    self._awakerTableView:ReloadData()
  elseif self._awakerListDirty then
    self._awakerListDirty = false
    self._awakerTableView:ReloadData()
  else
    self._awakerTableView:Refresh()
  end
  if self.isCategorySelect then
    local model = SummonCategorySelectModel.Instance
    local selectNum = SummonCategorySelectDataUtils.GetSelectNum(self.poolTid)
    self:_RefreshConfirmBtn()
    self.binder:SetText(self.ui.Text_Count, LT.Textf("SummonType_17SelectionProgress", model:GetDraftSelectedCount(), selectNum))
    return
  end
  local selectCount = self:_GetSelectedCount()
  if selectCount >= self.miniSelect and selectCount <= self.maxSelect then
    self.binder:SetButtonState(self:_GetConfirmBtnGO(), CommonDefine.BtnType.High)
  else
    self.binder:SetButtonState(self:_GetConfirmBtnGO(), CommonDefine.BtnType.Unclickable)
  end
  self.binder:SetText(self.ui.Text_Count, LT.Textf("SummonOptionCountDesc", selectCount, self.maxSelect))
end

function SummonOptionalLimitPanel:_InitAwakerTableView()
  local owner = self.ui.ScrollView
  local baseGameObj = self.ui.UI_Summon_Item_OptionalLimit
  if not baseGameObj then
    return
  end
  local itemComps = {}
  self._awakerTableView = self:CreateTableview(owner, function()
    return #self.awakerItemTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemTid = SummonCategorySelectDataUtils.GetListItemTid(self.awakerItemTidList, index)
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    local itemData = {
      itemTid = itemTid,
      awakerTid = awakerTid,
      awakerData = awakerData,
      clickFunc = function()
        self:_OnClickAwakerItem(itemTid)
      end,
      selectBgFunc = function()
        do return self._IsSelected, self end
        return self._IsSelected, self, itemTid
      end,
      conflictTipsFunc = function()
        if not self.isCategorySelect then
          return nil
        end
        local draftSlotMap = SummonCategorySelectModel.Instance:CopyDraftSlotMap()
        do return SummonCategorySelectDataUtils.GetConflictTips, self.poolTid, itemTid, draftSlotMap end
        return SummonCategorySelectDataUtils.GetConflictTips, self.poolTid, itemTid, draftSlotMap, self.slot
      end
    }
    itemComps[gameObj] = self.binder:BindComponent(SummonChoiceAwakerItem(gameObj, itemData))
    return cell
  end, nil, function()
    itemComps = nil
  end)
  local offset = self._awakerTableView.cellOffset
  self._awakerTableView.cellOffset = CS.UnityEngine.Vector2(offset.x, -4)
  self._awakerTableView.contentSizeAdjustment = CS.UnityEngine.Vector2(0, 10)
end

return SummonOptionalLimitPanel
