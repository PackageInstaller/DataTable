local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local TrinketAwakerBindView, Super = NewClass("TrinketAwakerBindView", BaseView)
TrinketAwakerBindView.uiResCls = UI_Awaker_Panel_Trinket_BindDetailResource

function TrinketAwakerBindView:ctor(awakerData, initPart)
  Super.ctor(self)
  self.awakerData = awakerData
  self.initPart = initPart
end

function TrinketAwakerBindView:OnBuildView()
  Super.OnBuildView(self)
  self:_InitCloseBtn()
  self:_InitChoosenList()
  self:_InitEquipedTrinketsInfo()
  self:_InitDetails()
  self:_InitItemDetailTips()
  self:_HideRemovedFeatures()
end

function TrinketAwakerBindView:_InitCloseBtn()
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self.Close))
end

function TrinketAwakerBindView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosenPartTypeChanged, self._OnTrinketPartTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosen, self._OnTrinketChoosen, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosenTypeChanged, self._OnTrinketChoosenTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketFiltersChanged, self._RefreshTrinketSortEditor, self)
  self:RegisterNotify(NotifyId.OnTrinketEquiped, self._OnTrinketDataChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketUnequiped, self._OnTrinketDataChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketDataChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketConversioned, self._OnTrinketDataChanged, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketsDeleted, self._OnTrinketsDeleted, self)
  self:RegisterNotify(NotifyId.OnTrinketBoundDataChanged, self._OnTrinketBoundDataChanged, self)
  self:RegisterLocalNotify(NotifyId.OnCloseTrinketDetailsTips, self._CloseItemDetailTips, self)
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnItemDetailLockStates, self)
end

function TrinketAwakerBindView:RegisterEvents()
  Super.RegisterEvents(self)
  BagExtModel.Instance:InitFilters()
  self:_RegisterPartsTogglesListener()
  self:_InitFilterBtns()
  self:_InitBtnBind()
  self:_InitBtnStrengthen()
  self:_InitBtnUnbindAll()
  self:_InitItemDetailTipsEvents()
end

function TrinketAwakerBindView:OnEnterView()
  Super.OnEnterView(self)
  TrinketBindModel.Instance:ResetFilters()
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.awakerData.tid)
  TrinketBindModel.Instance:ResetByAwakerData(self.awakerData, boundTrinkets)
  if self.initPart and self.initPart > 0 then
    TrinketBindModel.Instance:SetCurPartType(self.initPart)
  end
  self:_RefreshAwaker()
  self:_RefreshView(true)
end

function TrinketAwakerBindView:OnExitView()
  self.waitingBindSuccessTips = false
  if self.clickScrollViewParts then
    self.clickScrollViewParts:Dispose()
  end
  if self.trinketDetailTipsCompSV then
    self.trinketDetailTipsCompSV:Dispose()
  end
  if self.trinketDetailContractTipsSV then
    self.trinketDetailContractTipsSV:Dispose()
  end
  if self.clickPanelRootForTips then
    self.clickPanelRootForTips:Dispose()
  end
  Super.OnExitView(self)
end

function TrinketAwakerBindView:_InitChoosenList()
  self:_CreateTrinketListTableview()
end

function TrinketAwakerBindView:_RegisterPartsTogglesListener()
  for i = 1, MaxEquipTrinketsNum do
    local partNode = self.ui["Toggle_" .. i]
    if partNode then
      self:AddZ1ToggleValueChangedListener(partNode, function(isOn)
        if isOn then
          self:OnClickTrinketPartType(i)
        end
      end)
    end
  end
end

function TrinketAwakerBindView:_CreateTrinketListTableview()
  if self.trinketListView then
    return
  end
  self.trinketListView = self:CreateTableview(self.ui.ScrollView_Parts, function()
    return self.trinketViewDatas and #self.trinketViewDatas or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.IconEmpty)
    local itemData = self.trinketViewDatas[index]
    self:SetIcon(MaterialIconType.CommonIcon, cell.gameObject, itemData)
    return cell
  end)
end

function TrinketAwakerBindView:_InitFilterBtns()
  local btnFilter = self:_GetUiNode("Btn_Trinket_Filter")
  if btnFilter then
    self:AddButtonClickListener(btnFilter, System.fn(self, self._OnClickTrinketFilter))
  end
  local btnLevel = self:_GetUiNode("Btn_Trinket_Level")
  if btnLevel then
    self:AddButtonClickListener(btnLevel, System.fn(self, self._OnClickTrinketCommonFilter))
  end
  local btnLitre = self:_GetUiNode("Btn_Trinket_Litre")
  if btnLitre then
    self:AddZ1ToggleValueChangedListener(btnLitre, System.fn(self, self._OnClickTrinketLitre))
  end
end

function TrinketAwakerBindView:_GetUiNode(nodeName)
  self.uiNodesCache = self.uiNodesCache or {}
  local cached = self.uiNodesCache[nodeName]
  if nil ~= cached then
    return cached or nil
  end
  local node = self.ui[nodeName]
  if not node and self.ui.uiNode then
    node = self:FindChildRecursively(self.ui.uiNode, nodeName)
  end
  self.uiNodesCache[nodeName] = node or false
  return node
end

function TrinketAwakerBindView:_InitEquipedTrinketsInfo()
  local rootNode = self.ui.Group_Parts
  self.trinketsIconInfoComp = self:AddViewComponent(rootNode, UICompEquipedTrinketsInfo, true)
  self.trinketsIconInfoComp:SetDelegate(self)
end

function TrinketAwakerBindView:_InitDetails()
  local detailNode = self.ui.UI_Team_Item_Trinket_Detail
  self.trinketDetailsComp = self:AddViewComponent(detailNode, UICompTrinketDetails, self.ui.NodeEffectLink)
end

function TrinketAwakerBindView:_InitItemDetailTips()
  local detailNode = self:_GetUiNode("Image_Detail_1")
  local contractNode = self:_GetUiNode("Image_Detail_2")
  self.trinketDetailTipsComp = self:AddViewComponent(detailNode, UICompTrinketDetailTipsItem)
  self.trinketDetailContractTipsComp = self:AddViewComponent(contractNode, UICompTrinketDetailTipsItem)
end

function TrinketAwakerBindView:_InitItemDetailTipsEvents()
  if not self.trinketDetailTipsComp then
    return
  end
  local btnEmptyPos = self:_GetUiNode("Btn_EmptyPosition")
  if btnEmptyPos then
    self:AddButtonClickListener(btnEmptyPos, System.fn(self, self._CloseItemDetailTips))
  elseif self.ui.uiNode then
    self.clickPanelRootForTips = UIClickableScrollView(self.ui.uiNode, System.fn(self, self._CloseItemDetailTips))
  end
  self.trinketDetailTipsCompSV = UIClickableScrollView(self.trinketDetailTipsComp.ui.ScrollView, System.fn(self, self._CloseItemDetailTips))
  self.trinketDetailContractTipsSV = UIClickableScrollView(self.trinketDetailContractTipsComp.ui.ScrollView, System.fn(self, self._CloseItemDetailTips))
end

function TrinketAwakerBindView:_HideRemovedFeatures()
  local removedNodes = {
    "Btn_Recommend",
    "Btn_Save",
    "Btn_New_SuitPlan",
    "Btn_Add_SuitPlan",
    "Btn_Delete",
    "Btn_Edit",
    "Text_CurPlanName"
  }
  for _, nodeName in ipairs(removedNodes) do
    self:_SafeSetActive(self:_GetUiNode(nodeName), false)
  end
  local listRoot = self.ui.ScrollView_Parts
  if not listRoot then
    return
  end
  local removedInList = {
    "Btn_Suit",
    "Image_Suit",
    "Image_Quantity",
    "ScrollView_Suit",
    "Btn_Added",
    "Btn_Equipment_2",
    "Text_C_Suit",
    "Text_Quantity",
    "Text_Base"
  }
  for _, nodeName in ipairs(removedInList) do
    self:_SafeSetActive(self:FindChild(listRoot, nodeName), false)
  end
end

function TrinketAwakerBindView:_InitBtnBind()
  local btnBind = self:_GetUiNode("Btn_Bind")
  self.btnBind = btnBind
  self:AddButtonClickListener(self.btnBind, System.fn(self, self._OnClickBtnBind))
end

function TrinketAwakerBindView:_InitBtnStrengthen()
  local btnStrengthen = self.ui.Btn_Strengthen
  self.btnStrengthen = btnStrengthen
  self:SetButtonText(self.btnStrengthen, LT.Text("RoleDetailsEquipDetails_Btn_LevelUp"))
  self:AddButtonClickListener(self.btnStrengthen, System.fn(self, self._OnClickBtnStrengthen))
end

function TrinketAwakerBindView:_InitBtnUnbindAll()
  self:AddButtonClickListener(self.ui.Btn_UnBindAll, System.fn(self, self._OnClickBtnUnbindAll))
end

function TrinketAwakerBindView:_RefreshView(reloadData)
  self:_RefreshChoosenList(reloadData)
  self:_RefreshEquipedTrinketsInfo()
  self:_RefreshCompletionRate()
  self:_RefreshDetails()
  self:_RefreshBtnBind()
  self:_RefreshBtnStrengthen()
  self:_RefreshBtnUnbindAll()
end

function TrinketAwakerBindView:_RefreshAwaker()
  local curAwakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if not curAwakerTid or 0 == curAwakerTid then
    self:_SafeSetActive(self.ui.Group_Awaker, false)
    return
  end
  self:_SafeSetActive(self.ui.Group_Awaker, true)
  if self.ui.Icon_Awaker then
    local awakerIconPath = AwakerDataUtils.GetLittleIcon(curAwakerTid)
    self:SetImage(self.ui.Icon_Awaker, awakerIconPath)
  end
end

function TrinketAwakerBindView:_RefreshChoosenList(reloadData)
  self:_RefreshChoosenParts()
  if reloadData then
    self:_ReloadTrinketListData()
  end
  self:_RefreshTrinketSortEditor()
  if self.trinketListView then
    self.trinketListView:Refresh()
  end
  local isExistTrinkets = self.trinketViewDatas and #self.trinketViewDatas > 0
  self:_SafeSetActive(self.ui.Text_C_Null, not isExistTrinkets)
  self:_SafeSetActive(self.ui.Group_Trinket_Bag_Toggle, TrinketModel.Instance:HasAnyTrinketsInBag(TrinketBindModel.Instance:GetCurPartType()))
end

function TrinketAwakerBindView:_RefreshEquipedTrinketsInfo()
  if not self.trinketsIconInfoComp then
    return
  end
  local model = TrinketBindModel.Instance
  self.trinketsIconInfoComp:SetTrinkets(model:GetCurBoundTrinketsUidList())
  self.trinketsIconInfoComp:SelectPart(model:GetCurPartType())
end

function TrinketAwakerBindView:_RefreshCompletionRate()
  local boundTrinkets = TrinketBindModel.Instance:GetCurBoundTrinketsUidList()
  local hasAny = TrinketModel.Instance:ExistsAnyTrinkets(boundTrinkets)
  local completenessNode = self:_GetUiNode("Image_Completeness")
  if completenessNode then
    completenessNode:SetActive(hasAny)
  end
  if not hasAny then
    return
  end
  local rateText = self:_GetUiNode("Text_CompletRate")
  if rateText then
    self:SetText(rateText, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(boundTrinkets) .. "%")
  end
  local rateTitle = self:_GetUiNode("Text_CompletRate_Title")
  if rateTitle then
    self:SetText(rateTitle, LT.Text("TrinketCompletionRate"))
  end
end

function TrinketAwakerBindView:_RefreshChoosenParts()
  local partType = TrinketBindModel.Instance:GetCurPartType()
  for i = 1, MaxEquipTrinketsNum do
    local partNode = self.ui["Toggle_" .. i]
    if partNode then
      self:SetZ1Toggle(partNode, i == partType, true)
      self:_RefreshPartBoundTrinketTag(partNode, i)
    end
  end
end

function TrinketAwakerBindView:_RefreshPartBoundTrinketTag(partNode, partType)
  local tagTrans = partNode.transform:Find("Image_Trinket_Bind")
  if not tagTrans then
    return
  end
  tagTrans.gameObject:SetActive(self:_IsPartBoundTrinketValid(partType))
end

function TrinketAwakerBindView:_IsPartBoundTrinketValid(partType)
  local awakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid then
    return false
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, partType)
  if 0 == boundUid then
    return false
  end
  return ItemDataUtils.GetItemByUid(boundUid) ~= nil
end

function TrinketAwakerBindView:_ReloadTrinketListData()
  if not self.trinketListView then
    return
  end
  self.trinketViewDatas = TrinketBindModel.Instance:GetFilterTrinksList()
  if self.trinketViewDatas then
    local function onChoosed(tid, uid)
      self:_OnClickTrinketItem(tid, uid)
    end
    
    local function isChoosed(uid)
      do return self._IsTrinketChoosenItem, self end
      return self._IsTrinketChoosenItem, self, uid
    end
    
    local function getOwnerTid(uid)
      do return self._GetTrinketOwnerTid, self end
      return self._GetTrinketOwnerTid, self, uid
    end
    
    for i = 1, #self.trinketViewDatas do
      local itemData = self.trinketViewDatas[i]
      itemData.onClick = onChoosed
      itemData.isChoosed = isChoosed
      itemData.getOwnerTid = getOwnerTid
      itemData.isBoundTrinketTag = true
      itemData.boundTrinketUrQuality = true
    end
  end
  self.trinketListView:SetOffsetWithoutRefresh(0)
  self.trinketListView:ReloadData()
end

function TrinketAwakerBindView:_OnClickTrinketItem(tid, uid)
  TrinketBindModel.Instance:SetCurChoosenTrinketUid(uid)
  self:_ShowItemDetailTips(uid)
end

function TrinketAwakerBindView:_IsTrinketChoosenItem(uid)
  return TrinketBindModel.Instance:GetCurChoosenTrinketUid() == uid
end

function TrinketAwakerBindView:_GetTrinketOwnerTid(uid)
  do return TrinketBindModel.Instance.GetTrinketOwnerTid, TrinketBindModel.Instance end
  return TrinketBindModel.Instance.GetTrinketOwnerTid, TrinketBindModel.Instance, uid
end

function TrinketAwakerBindView:_RefreshTrinketSortEditor()
  local model = TrinketBindModel.Instance
  local hasFilter = model:IsExistedTrinketFilter()
  local btnState = CommonDefine.BtnType.Normal
  if hasFilter then
    btnState = CommonDefine.BtnType.High
  end
  local btnFilter = self:_GetUiNode("Btn_Trinket_Filter")
  if btnFilter then
    self:SetButtonState(btnFilter, btnState)
  end
  local sortTypeText = self:_GetUiNode("Text_Trinket_SortType_1")
  if sortTypeText then
    self:SetText(sortTypeText, model:GetTrinketSortTypeName())
  end
  local btnLitre = self:_GetUiNode("Btn_Trinket_Litre")
  if btnLitre then
    self:SetZ1Toggle(btnLitre, model.trinketSortOrder == CommonDefine.SortOrder.Descend, true)
  end
end

function TrinketAwakerBindView:_RefreshDetails()
  if not self.trinketDetailsComp then
    return
  end
  local model = TrinketBindModel.Instance
  local boundTrinkets = model:GetCurBoundTrinketsUidList()
  local showTrinkets = {}
  for pos, uid in pairs(boundTrinkets or {}) do
    showTrinkets[pos] = uid
  end
  local selectUid = model:GetCurChoosenTrinketUid()
  local forceBonusUid = 0
  if 0 ~= selectUid then
    showTrinkets[model:GetCurPartType()] = selectUid
    forceBonusUid = selectUid
  end
  self.trinketDetailsComp:RefreshDetails(showTrinkets, boundTrinkets, true, forceBonusUid)
end

function TrinketAwakerBindView:_RefreshBtnBind()
  if not self.btnBind then
    return
  end
  local selectUid = TrinketBindModel.Instance:GetCurChoosenTrinketUid()
  if 0 == selectUid then
    self:SetButtonText(self.btnBind, LT.Text("TrinketBind"))
    return
  end
  local boundUid = TrinketBindModel.Instance:GetCurPartBoundTrinketUid()
  if 0 == boundUid then
    self:SetButtonText(self.btnBind, LT.Text("TrinketBind"))
  elseif boundUid == selectUid then
    self:SetButtonText(self.btnBind, LT.Text("TrinketUnbind"))
  else
    self:SetButtonText(self.btnBind, LT.Text("TrinketChangeBind"))
  end
end

function TrinketAwakerBindView:_RefreshBtnStrengthen()
  if not self.btnStrengthen then
    return
  end
  local selectUid = TrinketBindModel.Instance:GetCurChoosenTrinketUid()
  if 0 == selectUid then
    self.btnStrengthen:SetActive(false)
    return
  end
  self.btnStrengthen:SetActive(true)
  local btnState = CommonDefine.BtnType.High
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  if not unlocked then
    btnState = CommonDefine.BtnType.Unclickable
  end
  self:SetButtonState(self.btnStrengthen, btnState)
end

function TrinketAwakerBindView:_RefreshBtnUnbindAll()
  self:SetActive(self.ui.Btn_UnBindAll, self:_HasAnyBoundTrinkets())
end

function TrinketAwakerBindView:_HasAnyBoundTrinkets()
  local awakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid then
    return false
  end
  do return AwakerTrinketDataUtils.HasAnyValidBoundTrinket end
  return AwakerTrinketDataUtils.HasAnyValidBoundTrinket, awakerTid
end

function TrinketAwakerBindView:_ShowItemDetailTips(uid)
  if not self.trinketDetailTipsComp then
    return
  end
  local boundUid = TrinketBindModel.Instance:GetCurPartBoundTrinketUid()
  self.trinketDetailContractTipsComp:SetItemUid(0)
  self.trinketDetailTipsComp:SetItemUid(uid)
  if boundUid == uid then
    self.trinketDetailTipsComp:SetBeingEquiped(true)
    self.trinketDetailTipsComp:SetContrast(nil)
  else
    self.trinketDetailTipsComp:SetBeingEquiped(false)
    self.trinketDetailTipsComp:SetContrast(nil)
    self.trinketDetailContractTipsComp:SetItemUid(boundUid)
    self.trinketDetailContractTipsComp:SetBeingEquiped(true)
    self.trinketDetailContractTipsComp:SetContrast(nil)
  end
  self:_SafeSetActive(self:_GetUiNode("Image_Compared"), true)
  self:_SafeSetActive(self:_GetUiNode("Btn_EmptyPosition"), true)
end

function TrinketAwakerBindView:_CloseItemDetailTips()
  if self.trinketDetailTipsComp then
    self.trinketDetailTipsComp:SetItemUid(0)
    self.trinketDetailContractTipsComp:SetItemUid(0)
  end
  self:_SafeSetActive(self:_GetUiNode("Btn_EmptyPosition"), false)
  self:_SafeSetActive(self:_GetUiNode("Image_Compared"), false)
end

function TrinketAwakerBindView:_SafeSetActive(go, state)
  if not go or IsNil(go) then
    return
  end
  go:SetActive(state)
end

function TrinketAwakerBindView:_OnTrinketChoosenTypeChanged()
  self:_RefreshView(true)
end

function TrinketAwakerBindView:_OnTrinketPartTypeChanged()
  self:_RefreshView(true)
end

function TrinketAwakerBindView:_OnTrinketChoosen(uid, lastUid)
  if uid ~= lastUid then
    self:_RefreshView(false)
  else
    self:_RefreshDetails()
  end
end

function TrinketAwakerBindView:_OnTrinketDataChanged()
  self:_RefreshView(false)
end

function TrinketAwakerBindView:_OnBagItemDataChanged(uid, tid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    if tid and ItemDataUtils.GetItemType(tid) == CommonDefine.ItemType.Trinket then
      TrinketBindModel.Instance:DeleteTrinketFromTrinketsList({uid})
      self:_RefreshView(true)
    end
    return
  end
  if ItemDataUtils.GetItemType(itemData.tid) ~= CommonDefine.ItemType.Trinket then
    return
  end
  self:_RefreshView(false)
end

function TrinketAwakerBindView:_OnTrinketsDeleted(uids)
  TrinketBindModel.Instance:DeleteTrinketFromTrinketsList(uids)
  self:_RefreshView(true)
end

function TrinketAwakerBindView:_OnItemDetailLockStates()
  self:_RefreshView(false)
end

function TrinketAwakerBindView:_OnTrinketBoundDataChanged(awakerTid)
  local curAwakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if awakerTid ~= curAwakerTid then
    return
  end
  if self.waitingBindSuccessTips then
    self.waitingBindSuccessTips = false
    self:_ShowBindSuccessTips()
  end
  local model = TrinketBindModel.Instance
  model:ReloadAllTrinketsList()
  model:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketAwakerBindView:_ShowBindSuccessTips()
  Alert.ShowStr(LT.Text("TrinketBindSuccessTips"))
end

function TrinketAwakerBindView:OnClickTrinketPartType(partType, fromPartsBtn)
  self:_CloseItemDetailTips()
  TrinketBindModel.Instance:SetCurPartType(partType)
  if not fromPartsBtn then
    return
  end
  local boundUid = TrinketBindModel.Instance:GetCurPartBoundTrinketUid()
  if 0 ~= boundUid then
    self:_ShowItemDetailTips(boundUid)
  end
end

function TrinketAwakerBindView:_OnClickBtnStrengthen()
  self:_CloseItemDetailTips()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketLevelUp, 0)
    return
  end
  local selectUid = TrinketBindModel.Instance:GetCurChoosenTrinketUid()
  UIManager.Instance:Reopen(Urls.TrinketStrengthenPanel, nil, selectUid)
end

function TrinketAwakerBindView:_OnClickTrinketFilter()
  self:_CloseItemDetailTips()
  local filterPos = self:_GetUiNode("TrinkFilterPos")
  if not filterPos then
    return
  end
  local model = TrinketBindModel.Instance
  model.lockTrinketPos = model:GetCurPartType()
  TrinketFilterController.Instance:OpenTrinkFilterView(model, filterPos.transform.position, function(isChanged)
    if isChanged then
      model:CalFilterTrinketsList()
      self:_RefreshView(true)
    end
  end)
end

function TrinketAwakerBindView:_OnClickTrinketCommonFilter()
  local filterPos = self:_GetUiNode("Trinke_Filter_List_Level_Pos")
  if not filterPos then
    return
  end
  local model = TrinketBindModel.Instance
  local sortTypeList = BagExtModel.Instance:GetTrinketSortTypeList()
  local curType = BagExtModel.Instance:GetTrinketSortType()
  TrinketFilterController.Instance:OpenCommonFilterView(filterPos.transform.position, curType, sortTypeList, function(t)
    model:SetTrinketSortType(t)
    BagExtModel.Instance:SetTrinketSortType(t)
    model:CalFilterTrinketsList()
    self:_RefreshView(true)
  end)
end

function TrinketAwakerBindView:_OnClickTrinketLitre(isOn)
  local model = TrinketBindModel.Instance
  local order = isOn and CommonDefine.SortOrder.Descend or CommonDefine.SortOrder.Ascend
  model:SetTrinketSortOrder(order)
  model:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketAwakerBindView:_OnClickBtnBind()
  self:_CloseItemDetailTips()
  local model = TrinketBindModel.Instance
  local selectUid = model:GetCurChoosenTrinketUid()
  if 0 == selectUid then
    Alert.ShowStr(LT.Text("TrinketBindNoneSelectedTips"))
    return
  end
  local pos = model:GetCurPartType()
  local boundUid = model:GetCurPartBoundTrinketUid()
  if 0 == boundUid then
    self:_ShowBindConfirm(pos, selectUid)
    return
  end
  if selectUid == boundUid then
    self:_OpenUnbindMaterialView(pos, nil)
  else
    self:_OpenUnbindMaterialView(pos, selectUid)
  end
end

function TrinketAwakerBindView:_ShowBindConfirm(pos, uid)
  local awakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid then
    return
  end
  
  local function onConfirm()
    self.waitingBindSuccessTips = true
  end
  
  UIManager.Instance:Reopen(Urls.TrinketBindConfirmView, awakerTid, pos, uid, nil, onConfirm)
end

function TrinketAwakerBindView:_OpenUnbindMaterialView(pos, newUid)
  local awakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid then
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerUnBindView, awakerTid, pos, newUid)
end

function TrinketAwakerBindView:_OpenBatchUnbindView()
  local awakerTid = TrinketBindModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid then
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerUnBindView, awakerTid, nil)
end

function TrinketAwakerBindView:_OnClickBtnUnbindAll()
  self:_CloseItemDetailTips()
  self:_OpenBatchUnbindView()
end

return TrinketAwakerBindView
