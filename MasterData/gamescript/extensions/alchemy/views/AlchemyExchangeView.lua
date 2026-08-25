local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local SHOW_MAX_NUM = 6
local AlchemyExchangeView, Super = NewClass("AlchemyExchangeView", BaseView)
AlchemyExchangeView.uiResCls = UI_Alchemy_Popup_Permute_OptimizeResource

function AlchemyExchangeView:ctor()
  Super.ctor(self)
  self.mainModel = AlchemyMainExtModel.Instance
  self.model = AlchemyExchangeExtModel.Instance
  self.model:UpdateData()
end

function AlchemyExchangeView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAlchemyExchangeSelectChanged, self.RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged, self._RefreshRightPartUI, self)
end

function AlchemyExchangeView:RegisterEvents()
  self:_OnInitExchangeListView()
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, function()
    self:RefreshView()
  end)
end

function AlchemyExchangeView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimationControl = self.ui.uiNode:GetComponent(TYPEOF_UIAnimationController)
  self:_ClearCostItemGroup()
  self:_OnInitDefaultSelectTid()
  self:SetText(self.ui.Text_Possess_Tips, LT.Text("ExchangeCostItemEnoughTips"))
end

function AlchemyExchangeView:_ClearCostItemGroup()
  self.model:SetCurSelectCostItemGroup({})
  self.model:Set_selectCostTid(0)
  self.model:Set_selectCostUid(0)
  self.model:Set_selectUid(0)
  self.model.oldSelectTid = 0
end

function AlchemyExchangeView:RefreshOnRendered()
  self:_ClearCostItemGroup()
  self:RefreshView()
end

function AlchemyExchangeView:_ExchangeSelectChanged()
  self.exchangeListView:ReloadData()
  self.ui.Group_No_Trinket:SetActive(0 == #self.model.exchangeItemList)
  local newSelectTid = self.model.selectTid
  local oldSelectTid = self.model.oldSelectTid
  if 0 ~= oldSelectTid and newSelectTid ~= oldSelectTid then
    local newExchangeItem = self.model:GetExchangeItemByItemTid(newSelectTid)
    local oldExchangeItem = self.model:GetExchangeItemByItemTid(oldSelectTid)
    self.model:RemoveCurSelectCostItemGroup(newSelectTid)
    if newExchangeItem.costItemMainType ~= oldExchangeItem.costItemMainType or newExchangeItem.costItemSubType ~= oldExchangeItem.costItemSubType then
      self.model:SetCurSelectCostItemGroup({})
    end
  end
  self:_RefreshRightPartUI()
end

function AlchemyExchangeView:RefreshView()
  self:_ExchangeSelectChanged()
end

function AlchemyExchangeView:_RefreshRightPartUI()
  local newSelectTid = self.model.selectTid
  if newSelectTid and 0 ~= newSelectTid then
    local viewData = {itemTid = newSelectTid}
    self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, viewData)
    self.ui.UI_Common_Item_WuPin_Type2:SetActive(true)
  else
    self.ui.UI_Common_Item_WuPin_Type2:SetActive(false)
  end
  local num = ItemDataUtils.GetItemNum(newSelectTid)
  local selectNum = self.model:GetCurSelectNum()
  local selectExchangeData = self.model:GetExchangeItemByItemTid(newSelectTid)
  print("alc exchangeid", newSelectTid)
  local exchangePerCost = selectExchangeData.costItemNum
  local curExchangeItemNum = self.model:GetCurExchangeItemNum()
  local nextNum = math.ceil(selectNum / exchangePerCost) * exchangePerCost
  local btnState = CommonDefine.BtnType.Unclickable
  if self.model:CheckItemExchangeEnough(selectExchangeData) and curExchangeItemNum > 0 then
    btnState = CommonDefine.BtnType.High
  end
  self:SetText(self.ui.Text_Possess, LT.Textf("QuantityHeld", num))
  self:SetText(self.ui.Text_Number, LT.Textf("UniversalProgressDisplay", selectNum, nextNum))
  self:SetText(self.ui.Text_None_Tips, LT.Textf("ExchangeCostInfoPreviewTips", curExchangeItemNum, LT.Text(ItemDataUtils.GetName(newSelectTid))))
  self:SetTextColorType(self.ui.Text_Possess_Tips, CommonDefine.ColorType.Light)
  self:AddButtonClickListener(self.ui.Btn_Resolve, System.fn(self, self.OnExchangeClick))
  self:SetButtonState(self.ui.Btn_Resolve, btnState)
  self:SetButtonText(self.ui.Btn_Resolve, LT.Text("Exchange_Start"))
  self:_RefreshCostItemGroup()
end

function AlchemyExchangeView:_RefreshCostItemGroup()
  local costItemLen = #self.model.curSelectCostItemGroup
  local len = costItemLen < SHOW_MAX_NUM and costItemLen + 1 or costItemLen
  for i = 1, SHOW_MAX_NUM do
    local obj = self.ui["UI_Alchemy_Popup_Permute_Item" .. i]
    obj:SetActive(i <= len)
    if i <= len then
      local uid, tid
      local selectCostItem = self.model.curSelectCostItemGroup[i]
      if selectCostItem then
        tid = selectCostItem.tid
        uid = ItemDataUtils.GetItemByTid(tid).uid
      end
      
      local function clickCb()
        UIManager.Instance:Reopen(Urls.AlchemyExchangeItemBagView)
      end
      
      local itemData = {
        uid = uid,
        tid = tid,
        clickCb = clickCb,
        model = self.model
      }
      self:AddViewComponentOnce(obj, CompAlchemyExchangeCostItem, itemData)
    end
  end
end

function AlchemyExchangeView:_OnInitExchangeListView()
  self.exchangeListView = self:CreateTableview(self.ui.ScrollView_Item, function()
    if not self.model.exchangeItemList then
      return 0
    end
    return #self.model.exchangeItemList
  end, function(view, index)
    do return self._ExchangeItemCellAtIndex, self, view end
    return self._ExchangeItemCellAtIndex, self, view, index
  end)
  self.exchangeListView:ReloadData()
end

function AlchemyExchangeView:_ExchangeItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.IconNode)
  local exchangeData = self.model.exchangeItemList[index]
  local tid = exchangeData.convertItemTid
  
  local function clickCb()
    self.model:Set_selectTid(tid)
  end
  
  local function selectFunc()
    return self.model.selectTid == tid
  end
  
  local function itemLockFunc()
    return not self.model:CheckCanExchangeItem(exchangeData)
  end
  
  local itemData = {
    tid = tid,
    clickCb = clickCb,
    selectFunc = selectFunc,
    itemLockFunc = itemLockFunc,
    alchemyItemType = AlchemyDefine.AlchemyItemType.Formula
  }
  self:SetIcon(MaterialIconType.AlchemyIcon, cell.gameObject, itemData)
  return cell
end

function AlchemyExchangeView:_OnInitDefaultSelectTid()
  local firstExchangeData = self.model.exchangeItemList[1]
  local targetTid = firstExchangeData and firstExchangeData.convertItemTid or 0
  local jumpToItemTid = self.mainModel:Get_jumpToItemTid()
  if jumpToItemTid and 0 ~= jumpToItemTid then
    targetTid = jumpToItemTid
  end
  self.model:Set_selectTid(targetTid)
  self.mainModel:Set_jumpToItemTid(nil)
end

function AlchemyExchangeView:OnExchangeClick()
  local curSelectExchangeData = self.model:GetCurSelectExchangeData()
  if not self.model:CheckItemExchangeEnough(curSelectExchangeData) then
    Alert.ShowStr(LT.Text("ExchangeCostItemNotEnoughTips"))
    return
  end
  local curExchangeItemNum = self.model:GetCurExchangeItemNum()
  if curExchangeItemNum <= 0 then
    Alert.ShowStr(LT.Textf("ExchangeCostItemNumNotEnoughTips", curSelectExchangeData.costItemNum))
    return
  end
  self.model:ParseCostItemGroup()
  
  local function AnimEndCallback()
    local exchangeId = curSelectExchangeData.conversionId
    local sendExchangeGroup = {}
    for _, tbl in pairs(self.model.realCostItemGroup) do
      local itemData = ItemDataUtils.GetItemByTid(tbl.tid)
      local uid = itemData and itemData.uid or 0
      table.insert(sendExchangeGroup, {
        uid = uid,
        num = tbl.num
      })
    end
    AlchemyDataUtils.ExchangeItem(exchangeId, sendExchangeGroup)
    self.model:SetCurSelectCostItemGroup(table.deepclone(self.model.remainCostItemGroup))
    self.model:SetRealCostItemGroup({})
    self.model:SetRemainCostItemGroup({})
    EventMgr.Instance.CloseAnimMask:Dispatch()
  end
  
  local function ConfirmFunc()
    EventMgr.Instance.OpenAnimMask:Dispatch()
    self.uiAnimationControl:PlayState("UI_Alchemy_Popup_Permute", AnimEndCallback, 1.5)
  end
  
  UIManager.Instance:Reopen(Urls.AlchemyExchangeConfirmView, ConfirmFunc)
end

function AlchemyExchangeView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyExchangeView
