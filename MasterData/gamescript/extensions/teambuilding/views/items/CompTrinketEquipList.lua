local TrinketEquipViewType = CommonDefine.TrinketEquipViewType
local MAX_TRINKET_POS_NUM = 6
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local CompTrinketEquipList, Super = NewViewComponent("CompTrinketEquipList")

function CompTrinketEquipList:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Suit_BookmarkResource(uiNode)
  self.page = data.page
  self.viewType2InitFuncMap = {
    [TrinketEquipViewType.PartSelect] = {
      initFunc = System.fn(self, self._InitPartSelect)
    },
    [TrinketEquipViewType.SuitSelect] = {
      initFunc = System.fn(self, self._InitSuitSelect)
    },
    [TrinketEquipViewType.SuitEdit] = {
      initFunc = System.fn(self, self._InitSuitEdit)
    }
  }
  self.model = TeamTrinketModel.Instance
end

function CompTrinketEquipList:OnEnterComponent()
  self:_InitToggle()
  self:SetZ1Toggle(self.page == TrinketEquipViewType.SuitSelect and self.ui.Btn_Suit or self.ui.Btn_Parts, true)
  self:SetZ1Toggle(self.ui.Toggle_1, true)
  local cellRT = self.ui.UI_Common_Item_WuPin_Type1:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.trinketsTableView = self:CreateTableview(self.ui.ScrollView_Parts, function()
    if not self.model.trinketShowList then
      return 0
    end
    return #self.model.trinketShowList
  end, function(view, index)
    do return self._TrinketCellAtIndex, self, view end
    return self._TrinketCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self:_RefreshView()
  self:RegisterLocalNotify(NotifyId.OnTeamTrinketListChanged, self._RefreshList, self)
  self:RegisterLocalNotify(NotifyId.OnTeamTrinketEquiped, self._RefreshBtnGroup, self)
  self:RegisterLocalNotify(NotifyId.OnTeamTrinketSelectUidChange, self._RefreshBtnGroup, self)
end

function CompTrinketEquipList:_RefreshView()
  self:SetText(self.ui.Text_Quantity, 0)
  self:SetText(self.ui.Text_Base, "/100")
  self:SetText(self.ui.Text_Title, self.viewType2InitFuncMap[self.page].title)
  self:_RefreshList()
  self:_RefreshBtnGroup()
end

function CompTrinketEquipList:_RefreshBtnGroup()
  self.viewType2InitFuncMap[self.page].initFunc()
end

function CompTrinketEquipList:_RefreshList()
  self.trinketsTableView:ReloadData()
  self:_RefressEmptyShow()
  self:_RefreshSortGroup()
  if table.next(self.model.trinketShowList) then
    self.model:SetSelectTrinketUid(self.model.trinketShowList[1])
  end
end

function CompTrinketEquipList:_RefreshSortGroup()
  for i = 0, self.ui.Content.transform.childCount - 1 do
    local obj = self.ui.Content.transform:GetChild(i)
    CS.UnityEngine.GameObject.Destroy(obj.gameObject)
  end
  for index, sortTypeInfo in ipairs(AwakerTrinketDataUtils.GetSortDataTable()) do
    local sortTypeName = sortTypeInfo.name
    
    local function IsSelected()
      return self.model.sortType == index
    end
    
    local function OnClick(sortType)
      if not sortType then
        return
      end
      self.model:SetSortType(sortType)
      self:PlaySortTypeGroupAnim(self.ui.UI_Common_Filter_List, false)
    end
    
    local itemData = {
      tid = index,
      name = sortTypeName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    self.binder:BindNewComponent(self.ui.Content, CommonFilterListItem, UI_Common_Filter_List_ItemResource, itemData)
  end
  local sortTypeName = AwakerTrinketDataUtils.GetSortTypeName(self.model.sortType)
  self:SetText(self.ui.Text_Trinket_SortType_1, sortTypeName)
  self:SetText(self.ui.Text_Trinket_SortType_2, sortTypeName)
end

function CompTrinketEquipList:_RefressEmptyShow()
  self.ui.Btn_Strengthen:SetActive(0 ~= #self.model.trinketShowList)
  self.ui.Btn_Remove:SetActive(0 ~= #self.model.trinketShowList)
  self.ui.Text_C_Null:SetActive(0 == #self.model.trinketShowList)
end

function CompTrinketEquipList:_TrinketCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local trinketUid = self.model.trinketShowList[index]
  local data = ItemDataUtils.GetItemByUid(trinketUid)
  
  local function OnClick(tid, uid)
    if not tid or not uid then
      return
    end
    self.model:SetSelectTrinketUid(uid)
    ItemDataUtils.ReqRemoveNew(uid)
    self.trinketsTableView:ReloadData()
  end
  
  local function IsSelected()
    return trinketUid == self.model.selectTrinketUid
  end
  
  local itemData = {
    tid = data.tid,
    uid = data.uid,
    callback = OnClick,
    clickFrameShowFunc = IsSelected
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType1, itemData)
  return cell
end

function CompTrinketEquipList:_InitToggle()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Parts, function(isOn)
    if isOn then
      self.model:SetCurPage(TrinketEquipViewType.PartSelect)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Suit, function(isOn)
    if isOn then
      self.model:SetCurPage(TrinketEquipViewType.SuitSelect)
    end
  end)
  for i = 1, MAX_TRINKET_POS_NUM do
    self:AddZ1ToggleValueChangedListener(self.ui["Toggle_" .. i], function(isOn)
      if isOn then
        self.model:SetSelectPos(i)
      end
    end)
  end
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, function(isOn)
    if isOn then
      self.model:SetSortOrder(CommonDefine.SortOrder.Descend)
    else
      self.model:SetSortOrder(CommonDefine.SortOrder.Ascend)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Level, function(isOn)
    self:PlaySortTypeGroupAnim(self.ui.UI_Common_Filter_List, isOn)
  end)
end

function CompTrinketEquipList:PlaySortTypeGroupAnim(ui, isOn)
  self.ui.UI_Common_Filter_List:SetActive(isOn)
  local animator = ui:GetComponent(typeof(CS.UnityEngine.Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
    self.ui.UI_Common_Filter_List:SetActive(false)
  end)
  local name = isOn and "Open" or "Close"
  if "Open" == name then
    return
  end
  local state = string.format("Base Layer.%s", name)
  AnimatorUtils.PlayState(animator, state)
  if not isOn then
    self:SetZ1Toggle(self.ui.Btn_Trinket_Level, false)
  end
end

function CompTrinketEquipList:GetTrinketLevelUpUnlock()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  return unlocked
end

function CompTrinketEquipList:_Btn_Strengthen_Click()
  local unlocked = self:GetTrinketLevelUpUnlock()
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketLevelUp, 0)
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketStrengthenPanel, nil, self.model.selectTrinketUid)
end

function CompTrinketEquipList:_Btn_Remove_Click()
  local equippedTrinketData = self.model:GetCurPosEquipTrinket()
  local selectTrinketUid = self.model.selectTrinketUid
  local selectPos = self.model.selectPos
  local selectTrinketData = ItemDataUtils.GetItemByUid(self.model.selectTrinketUid)
  if not equippedTrinketData then
    self.model:SetSelectTrinketDataByPos(selectPos, selectTrinketData)
    return
  end
  local equippedTrinketUid = equippedTrinketData and equippedTrinketData.uid or 0
  if equippedTrinketUid == selectTrinketUid then
    self.model:SetSelectTrinketDataByPos(selectPos, nil)
    return
  end
  self.model:SetSelectTrinketDataByPos(selectPos, selectTrinketData)
end

function CompTrinketEquipList:_Btn_Remove_Text()
  local equippedTrinketData = self.model:GetCurPosEquipTrinket()
  local name = LT.Text("RoleDetailsEquipDetails_Btn_PutOn")
  if not equippedTrinketData then
    return name
  end
  local equippedTrinketUid = equippedTrinketData and equippedTrinketData.uid or 0
  local selectTrinketUid = self.model.selectTrinketUid
  local selectHasAwaker = self.model:GetTrinketWeaponedAwakerTid(selectTrinketUid)
  if equippedTrinketUid > 0 and selectHasAwaker then
    name = LT.Text("RoleDetailsEquipDetails_Btn_Replace")
    if equippedTrinketUid == selectTrinketUid then
      name = LT.Text("RoleDetailsEquipDetails_Btn_Remove")
    end
  end
  return name
end

function CompTrinketEquipList:_InitPartSelect()
  self.ui.Image_Suit:SetActive(false)
  self.ui.Image_Parts:SetActive(true)
  self.ui.Image_Quantity:SetActive(false)
  self.ui.Group_Btn_Location:SetActive(true)
  self:AddButtonClickListener(self.ui.Btn_Remove, System.fn(self, self._Btn_Remove_Click))
  self:SetButtonState(self.ui.Btn_Remove, CommonDefine.BtnType.High)
  self:SetButtonText(self.ui.Btn_Remove, self:_Btn_Remove_Text())
  self:AddButtonClickListener(self.ui.Btn_Strengthen, System.fn(self, self._Btn_Strengthen_Click))
  self:SetButtonState(self.ui.Btn_Strengthen, self:GetTrinketLevelUpUnlock() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  self:SetButtonText(self.ui.Btn_Strengthen, LT.Text("RoleDetailsEquipDetails_Btn_LevelUp"))
end

function CompTrinketEquipList:_InitSuitSelect()
  self.ui.Image_Suit:SetActive(true)
  self.ui.Image_Parts:SetActive(false)
  self.ui.Image_Quantity:SetActive(true)
  self.ui.Group_Btn_Location:SetActive(false)
end

function CompTrinketEquipList:_InitSuitEdit()
  self.ui.Image_Suit:SetActive(false)
  self.ui.Image_Parts:SetActive(true)
  self.ui.Image_Quantity:SetActive(false)
  self.ui.Group_Btn_Location:SetActive(true)
end

function CompTrinketEquipList:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompTrinketEquipList
