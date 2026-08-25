local AlchemyDecomposeTrinketView, Super = NewClass("AlchemyDecomposeTrinketView", AlchemyDecomposeBaseView)
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local T_ContentSizeFitter = typeof(CS.UnityEngine.UI.ContentSizeFitter)

function AlchemyDecomposeTrinketView:ctor()
  Super.ctor(self)
  AlchemyDecomposeTrinketView.uiResCls = UI_Alchemy_Popup_ResolveMaterials_OptimizeResource
  self.model = AlchemyDecomposeTrinketExtModel.Instance
  self.model:OnInit()
end

function AlchemyDecomposeTrinketView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnAlchemyDecomposeSortChanged, self.RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketSortOrderChanged, self.RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketFiltersChanged, self.RefreshTrinketDecompose, self)
end

function AlchemyDecomposeTrinketView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, System.fn(self, self.OnToggleLitre))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Level, System.fn(self, self.OnToggleLevel))
  self:AddButtonClickListener(self.ui.Btn_Trinket_Filter, System.fn(self, self.OnTrinketFilter))
  self:AddButtonClickListener(self.ui.Btn_Sort_Group_Mask, System.fn(self, self.OnSortGroupMaskClick))
  self:AddButtonClickListener(self.ui.Btn_Role, System.fn(self, self._OnClickRule))
end

function AlchemyDecomposeTrinketView:_OnClickRule()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("AlchemyDecomposeTrinketRuleContent"))
end

function AlchemyDecomposeTrinketView:RefreshRewardGroup()
  local decompositeCnt = #self.model.curDecompositeList
  local scrollView_QuantityTrans = self.ui.ScrollView_Quantity:GetComponent(TYPEOF_RectTransform)
  local contentTrans = self.ui.Content:GetComponent(TYPEOF_RectTransform)
  local contentSizer = self.ui.Content:GetComponent(T_ContentSizeFitter)
  contentTrans.sizeDelta = scrollView_QuantityTrans.sizeDelta
  contentSizer.enabled = decompositeCnt >= 4
  self.ui.Group_Quantity_Null:SetActive(decompositeCnt <= 0)
  Super.RefreshRewardGroup(self)
end

function AlchemyDecomposeTrinketView:OnEnterView()
  self.model:InitFilters()
  self:SetZ1Toggle(self.ui.Btn_Trinket_Litre, true)
  Super.OnEnterView(self)
end

function AlchemyDecomposeTrinketView:RefreshOnRendered()
  self.model:SetCurSelectItemUidGroup({})
  self.model:SetIsSelectAll(false)
  self.model:Set_curSelectUid(0, true)
  self.model:Update_curDecompositeList()
  self:RefreshView()
end

function AlchemyDecomposeTrinketView:RefreshView()
  Super.RefreshView(self)
  self:RefreshTrinketDecompose()
end

function AlchemyDecomposeTrinketView:RefreshTrinketDecompose()
  local hasFilter = self.model:IsExistedTrinketFilter()
  local btnState = CommonDefine.BtnType.Normal
  if hasFilter then
    btnState = CommonDefine.BtnType.High
  end
  self:SetButtonState(self.ui.Btn_Trinket_Filter, btnState)
  self:SetText(self.ui.Text_Trinket_SortType_1, self.model:GetTrinketSortTypeName())
  self:SetText(self.ui.Text_Trinket_SortType_2, self.model:GetTrinketSortTypeName())
end

function AlchemyDecomposeTrinketView:GetBagCapacity()
  local limitList = DT.GetOriginalConstant("BagCapacity")
  return limitList and limitList[2] or 0
end

function AlchemyDecomposeTrinketView:OnTrinketFilter()
  TrinketFilterController.Instance:OpenTrinkFilterView(self.model, self.ui.TrinketFilterPos.transform.position, function(isChanged)
    if isChanged then
      self.model:Update_oriLit()
      local oriLit = self.model.oriLit
      local deComposeData = oriLit and oriLit[1] or nil
      local uid = deComposeData and deComposeData.itemUid or 0
      self.model:Set_curSelectUid(uid or 0)
      self:RefreshView()
    end
  end)
end

function AlchemyDecomposeTrinketView:OnToggleLitre(isOn)
  local order = isOn and CommonDefine.SortOrder.Descend or CommonDefine.SortOrder.Ascend
  self.model:SetTrinketSortOrder(order)
  self.model:Update_oriLit()
  self:RefreshView()
end

function AlchemyDecomposeTrinketView:OnSortGroupMaskClick()
  self.ui.Btn_Sort_Group_Mask:SetActive(false)
  self:SetZ1Toggle(self.ui.Btn_Trinket_Level, false)
end

function AlchemyDecomposeTrinketView:OnToggleLevel()
  local sortTypeList = self.model:GetTrinketSortTypeList()
  local curType = self.model.trinketSortType
  TrinketFilterController.Instance:OpenCommonFilterView(self.ui.Trinket_Filter_List_Level_Pos.transform.position, curType, sortTypeList, function(t)
    self.model:SetTrinketSortType(t)
    self.model:Update_oriLit()
    self:RefreshView()
  end)
end

function AlchemyDecomposeTrinketView:CheckCanAddDecompose(uid)
  do return self.model.IsTrinketUsing, self.model end
  return self.model.IsTrinketUsing, self.model, uid
end

return AlchemyDecomposeTrinketView
