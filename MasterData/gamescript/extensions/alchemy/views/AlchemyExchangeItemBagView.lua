local AlchemyExchangeItemBagView, Super = NewClass("AlchemyExchangeItemBagView", BaseView)
AlchemyExchangeItemBagView.uiResCls = UI_Alchemy_Popup_MyTeam_Awaker_List_OptimizeResource

function AlchemyExchangeItemBagView:ctor(isSettingExchange)
  Super.ctor(self)
  self.model = AlchemyExchangeExtModel.Instance
  self.isSetting = isSettingExchange
  self.model:UpdateData()
  self.model:Update_curCanCostItemGroup(self.isSetting)
  self.model:Set_selectCostTid(0)
end

function AlchemyExchangeItemBagView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged, self.RefreshView, self)
end

function AlchemyExchangeItemBagView:RegisterEvents()
  self:_OnInitCostListView()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  if self.isSetting then
    self.ui.Btn_Save:SetActive(true)
    self:AddButtonClickListener(self.ui.Btn_Save, System.fn(self, self._SaveExchange))
  else
    self.ui.Btn_Save:SetActive(false)
  end
end

function AlchemyExchangeItemBagView:_SaveExchange()
  local function saveCB()
    EventMgr.Instance.OnExchangePlanChanged:Dispatch()
    
    Alert.ShowStr(LT.Text("ExchangePlanSaveTips"))
    self:Close()
  end
  
  AlchemyDataUtils.ReqSaveExchangePlan(saveCB)
end

function AlchemyExchangeItemBagView:_OnInitCostListView()
  self.costListView = self:CreateTableview(self.ui.ScrollView_Team, function()
    if not self.model.curCanCostItemGroup then
      return 0
    end
    return #self.model.curCanCostItemGroup
  end, function(view, index)
    do return self._CostItemCellAtIndex, self, view end
    return self._CostItemCellAtIndex, self, view, index
  end)
  self.costListView:ReloadData()
end

function AlchemyExchangeItemBagView:_CostItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local tid = self.model.curCanCostItemGroup[index]
  local itemData = ItemDataUtils.GetItemByTid(tid)
  local uid = itemData and itemData.uid or 0
  
  local function selectedFunc()
    do return self.model.GetCurSelectCostItemByTid, self.model end
    return self.model.GetCurSelectCostItemByTid, self.model, tid
  end
  
  local function selectNumFunc()
    local costItemData = self.model:GetCurSelectCostItemByTid(tid)
    return costItemData and costItemData.num or 0
  end
  
  local function clickFrameShowFunc()
    return tid == self.model:Get_selectCostTid()
  end
  
  local function selectedPlanFunc()
    do return self.model.GetExchangePlan, self.model end
    return self.model.GetExchangePlan, self.model, tid
  end
  
  local function selectedPlanNumFunc()
    if self.model:GetExchangePlan(tid) then
      return 1
    else
      return 0
    end
  end
  
  local viewData, selectCostItemFunc
  if self.isSetting then
    viewData = {
      tid = tid,
      uid = uid,
      model = self.itemModel,
      selectedFunc = selectedPlanFunc,
      selectNumFunc = selectedPlanNumFunc,
      clickFrameShowFunc = clickFrameShowFunc,
      btnSubFunc = function()
      end,
      redFunc = function()
        return false
      end
    }
  else
    viewData = {
      tid = tid,
      uid = uid,
      model = self.itemModel,
      showMultiSelect = true,
      selectedFunc = selectedFunc,
      selectNumFunc = selectNumFunc,
      clickFrameShowFunc = clickFrameShowFunc,
      btnSubFunc = function()
      end
    }
    
    function selectCostItemFunc()
      do return self.model.GetCurSelectCostItemByTid, self.model end
      return self.model.GetCurSelectCostItemByTid, self.model, tid
    end
  end
  self:AddViewComponentOnce(cell.gameObject, CompAclhemyExhcangeCostBagItem, viewData, selectCostItemFunc)
  return cell
end

function AlchemyExchangeItemBagView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitDetailTipItem()
  if self.isSetting then
    self:SetText(self.ui.Text_Title, LT.Text("AutocConversion_Title"))
  else
    self:SetText(self.ui.Text_Title, LT.Text("ExchangeCostSelectPanelTitle"))
  end
  self.model:ClearExchangePlan()
  self.model:Update_curCanCostItemGroup(self.isSetting)
  self:RefreshView()
end

function AlchemyExchangeItemBagView:RefreshView()
  self.costListView:ReloadData()
  if not self.isSetting then
    local curSelectUid = self.model:Get_selectCostUid()
    local curSelectTid = self.model:Get_selectCostTid()
    local showTip = 0 ~= curSelectUid or curSelectTid and 0 ~= curSelectTid
    print("merge alc tid test", showTip, curSelectUid, curSelectTid)
    self.ui.UI_Awaker_Popup_Trinket_Tip:SetActive(showTip)
    if self.commonItemDetailTipItem and showTip then
      if 0 ~= curSelectTid then
        self.commonItemDetailTipItem:SetItemTid(curSelectTid)
      else
        self.commonItemDetailTipItem:SetItemUid(curSelectUid)
      end
    end
    self:SetText(self.ui.Text_Tips, LT.Text("ExchangeCostSelectPanelTitle"))
  else
    self:SetText(self.ui.Text_Tips, LT.Text("AutocConversion_Title"))
  end
end

function AlchemyExchangeItemBagView:_InitDetailTipItem()
  if not self.commonItemDetailTipItem and not self.isSetting then
    self.commonItemDetailTipItem = self:AddViewComponent(self.ui.UI_Awaker_Popup_Trinket_Tip, UICompTrinketDetailTipsItem)
  end
end

function AlchemyExchangeItemBagView:RefreshOnRendered()
end

function AlchemyExchangeItemBagView:OnEnterViewFinished()
end

function AlchemyExchangeItemBagView:OnExitView()
  Super.OnExitView(self)
  self.model:ClearExchangePlan()
end

return AlchemyExchangeItemBagView
