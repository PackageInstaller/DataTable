local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AlchemyCompositeView, Super = NewClass("AlchemyCompositeView", BaseView)
AlchemyCompositeView.uiResCls = UI_Alchemy_Popup_Compound_OptimizeResource

function AlchemyCompositeView:ctor()
  Super.ctor(self)
  self.model = AlchemyCompositeExtModel.Instance
  self.mainModel = AlchemyMainExtModel.Instance
  self.model:UpdateData()
end

function AlchemyCompositeView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAlchemyCompositeSelectChanged, self.RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnAlchemyCompositeNumChanged, self.RefreshRightPartUI, self)
end

function AlchemyCompositeView:RegisterEvents()
  self:_OnInitCompositeListView()
  self:_OnInitConsumeListView()
  self:AddButtonClickListener(self.ui.Btn_Slider_D_Add, System.fn(self, self.OnAddClick))
  self:AddButtonClickListener(self.ui.Btn_Slider_D_Subtract, System.fn(self, self.OnSubClick))
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, function()
    self.model:UpdateData()
    local isNotExist = true
    for _, itemData in pairs(self.model.compositeItemList) do
      if itemData.itemTid == self.model.curSelectTid then
        isNotExist = false
        break
      end
    end
    if isNotExist then
      self:_CompositeListViewSelectFirst()
    end
    self:RefreshView()
  end)
end

function AlchemyCompositeView:RefreshOnRendered()
  self:RefreshView()
end

function AlchemyCompositeView:_OnInitConsumeListView()
  local cellTrans = self.ui.UI_Common_Item_WuPin_Type1.transform
  local width, height = cellTrans.sizeDelta.x, cellTrans.sizeDelta.y
  self.consumeListView = self:CreateTableview(self.ui.ScrollView_Quantity, function()
    if not self.model:GetShowConsumeList() then
      return 0
    end
    return #self.model:GetShowConsumeList()
  end, function(view, index)
    do return self._ConsumeItemCellAtIndex, self, view end
    return self._ConsumeItemCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.consumeListView:ReloadData()
end

function AlchemyCompositeView:_OnInitCompositeListView()
  self.compositeListView = self:CreateTableview(self.ui.ScrollView_Item, function()
    if not self.model.compositeItemList then
      return 0
    end
    return #self.model.compositeItemList
  end, function(view, index)
    do return self._CompositeItemCellAtIndex, self, view end
    return self._CompositeItemCellAtIndex, self, view, index
  end)
  self.compositeListView:ReloadData()
end

function AlchemyCompositeView:_ConsumeItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local tid = self.model:GetShowConsumeList()[index].tid
  local num = self.model:GetShowConsumeList()[index].num
  
  local function clickCb()
    ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, tid)
  end
  
  local viewData = {
    tid = tid,
    num = num,
    clickCb = clickCb,
    alchemyItemType = AlchemyDefine.AlchemyItemType.CompositeCostItem
  }
  self:AddViewComponentOnce(cell.gameObject, CompAlchemyBaseItem, viewData)
  return cell
end

function AlchemyCompositeView:_CompositeItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.IconNode)
  local tid = self.model.compositeItemList[index].itemTid
  local conversionId = self.model.compositeItemList[index].conversionId
  
  local function clickCb()
    self.model:Set_curSelectTid(tid)
  end
  
  local function itemLockFunc()
    if AlchemyCompositeExtModel.Instance:IsMaxCompositeNumNotEnough(tid, conversionId) then
      return true
    end
    if not AlchemyCompositeExtModel.Instance:IsHaveRemainCompositeTime(conversionId) then
      return true
    end
    return false
  end
  
  local function selectFunc()
    return tid == self.model:Get_curSelectTid()
  end
  
  local itemData = {
    model = self.model,
    tid = tid,
    clickCb = clickCb,
    itemLockFunc = itemLockFunc,
    selectFunc = selectFunc,
    alchemyItemType = AlchemyDefine.AlchemyItemType.Formula,
    remainTimes = AlchemyCompositeExtModel.Instance:GetRemainCompositeTime(conversionId),
    refreshTime = AlchemyCompositeExtModel.Instance:GetRefreshTime(conversionId),
    conversionId = conversionId
  }
  self:SetIcon(MaterialIconType.AlchemyIcon, cell.gameObject, itemData)
  return cell
end

function AlchemyCompositeView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimationControl = self.ui.uiNode:GetComponent(TYPEOF_UIAnimationController)
  self:_CompositeListViewDefaultSelect()
  if self.compositeListView.isReady then
    self:_CompositeListViewDefaultJump()
  else
    function self.compositeListView.reloadFinishCallback()
      self.compositeListView.reloadFinishCallback = nil
      
      self:_CompositeListViewDefaultJump()
    end
  end
  self:InitSliderComp()
  self:SetImage(self.ui.Image_Money, self:GetMoneyImage())
  self:SetText(self.ui.Text_Need, LT.Text("ItemNeed"))
  self:SetText(self.ui.Text_Title, LT.Text("ItemForCompose"))
  self:SetText(self.ui.Text_Possess_Tips, LT.Text("AboutToCompose"))
  self:SetButtonText(self.ui.Btn_Resolve, LT.Text("ComposeButtonText"))
  self.sliderComp.onValueChanged:AddListener(function()
    local newVal = math.floor(self.sliderComp.value)
    self.model:Set_curCompositeNum(newVal)
  end)
  self:RefreshView()
end

function AlchemyCompositeView:RefreshView()
  self.model:Set_curCompositeNum(1)
  self.compositeListView:ReloadData()
  self:RefreshSliderComp()
  self:RefreshRightPartUI()
end

function AlchemyCompositeView:RefreshRightPartUI()
  self.consumeListView:ReloadData()
  local curSelectTid = self.model.curSelectTid
  local num = ItemDataUtils.GetItemNum(curSelectTid)
  local compositeData = self.model:GetCompositeDataByTid(curSelectTid)
  local conversionId = compositeData and compositeData.conversionId
  self.ui.Text_Pay:SetActive(self.model.curCompositeCurrencyTid)
  self.ui.Text_Slider_Frequency:SetActive(self:_IsCanComposite(conversionId))
  self.ui.Text_Slider_Min:SetActive(self.model.maxCompositeNum >= 1)
  self.ui.Text_Slider_Max:SetActive(self.model.maxCompositeNum >= 1)
  self.ui.Btn_Slider_D_Add:SetActive(self.model.maxCompositeNum > 1)
  self.ui.Btn_Slider_D_Subtract:SetActive(self.model.maxCompositeNum > 1)
  self.ui.Group_Cost_Currency:SetActive(0 ~= self.model.curCompositeCurrencyCostNum)
  self:SetImage(self.ui.Btn_Slider_D_Add, self.model.curCompositeNum == self.model.maxCompositeNum and "UIResources/AtlasSource/UI_Shop_Image/UI_Shop_Image_Popup_Add_Unclickable.png" or "UIResources/AtlasSource/UI_Shop_Image/UI_Shop_Image_Popup_Add.png")
  self:SetImage(self.ui.Btn_Slider_D_Subtract, self.model.curCompositeNum == self.model.minCompositeNum and "UIResources/AtlasSource/UI_Shop_Image/UI_Shop_Image_Popup_Subtract_Unclickable.png" or "UIResources/AtlasSource/UI_Shop_Image/UI_Shop_Image_Popup_Subtract.png")
  self:SetText(self.ui.Text_Possess, LT.Textf("QuantityHeld", num))
  self:SetText(self.ui.Text_Pay, self:GetPayText())
  self:SetText(self.ui.Text_Slider_Frequency, self.model.curCompositeNum)
  self:SetText(self.ui.Text_Slider_Min, self.model.minCompositeNum)
  self:SetText(self.ui.Text_Slider_Max, self.model.maxCompositeNum)
  local remainTimes = AlchemyCompositeExtModel.Instance:GetRemainCompositeTime(conversionId)
  if remainTimes then
    self:SetActive(self.ui.Text_RemainTimes, true)
    self:SetText(self.ui.Text_RemainTimes, LT.Textf("CompositeRemainTips", remainTimes))
  else
    self:SetActive(self.ui.Text_RemainTimes, false)
  end
  local sliderTips = LT.Text("ComposeTimes")
  if not AlchemyCompositeExtModel.Instance:IsHaveRemainCompositeTime(conversionId) then
    sliderTips = LT.Textf("<color=#FA3A50>{s1}</color>", LT.Text("ReachLimitForCompose"))
  elseif not self.model:CanComposite() then
    sliderTips = LT.Textf("<color=#FA3A50>{s1}</color>", LT.Text("LackOfItemForCompose"))
  end
  self:SetText(self.ui.Text_Slider_Tips, sliderTips)
  self:AddButtonClickListener(self.ui.Btn_Resolve, System.fn(self, self.OnCompositeClick))
  self:SetButtonState(self.ui.Btn_Resolve, self:_IsCanComposite(conversionId) and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  local viewData = {
    itemTid = curSelectTid,
    clickFunc = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Choose_Click, nil, curSelectTid)
    end
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, viewData)
end

function AlchemyCompositeView:RefreshSliderComp()
  if not self.sliderComp then
    self:InitSliderComp()
  end
  self.sliderComp.value = math.floor(self.model.curCompositeNum)
  self.sliderComp.maxValue = 0 == self.model.maxCompositeNum and self.model.maxCompositeNum + 1 or self.model.maxCompositeNum
  self.sliderComp.minValue = self.model.maxCompositeNum <= 1 and self.model.minCompositeNum - 1 or self.model.minCompositeNum
  self.sliderComp.interactable = self.model.maxCompositeNum > 1
end

function AlchemyCompositeView:OnCompositeClick()
  local compositeDataEarly = self.model:GetCompositeDataByTid(self.model.curSelectTid)
  local conversionIdEarly = compositeDataEarly and compositeDataEarly.conversionId
  if not AlchemyCompositeExtModel.Instance:IsHaveRemainCompositeTime(conversionIdEarly) then
    Alert.ShowStr(LT.Text("ReachLimitForCompose"))
    return
  end
  if not self.model:CanComposite() then
    Alert.ShowStr(LT.Text("LackOfItemForCompose"))
    return
  end
  
  local function confirmCb()
    local compositeData = self.model:GetCompositeDataByTid(self.model.curSelectTid)
    local conversionId = compositeData and compositeData.conversionId
    
    local function callback()
      if self.model:IsMultiComposite() and not self.model:IsForceDirectComposeByConversionId(conversionId) then
        local id = DT.ItemConversion[compositeData.conversionId].ItemsGet[1]
        local curCompositeItems = {
          {
            id = id,
            count = self.model.curCompositeNum
          }
        }
        AlchemyDataUtils.ReqMultiCompose(curCompositeItems)
      else
        AlchemyDataUtils.ComposeItem(compositeData.conversionId, self.model.curCompositeNum)
      end
      self.model:Set_curCompositeNum(1)
      self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(self.model.curCompositeNum))
      EventMgr.Instance.CloseAnimMask:Dispatch()
    end
    
    EventMgr.Instance.OpenAnimMask:Dispatch()
    self.uiAnimationControl:PlayState("UI_Alchemy_Vx_Popup_Compound01", callback, 1.5)
  end
  
  UIManager.Instance:Reopen(Urls.AlchemyCompositeConfirmView, confirmCb)
end

function AlchemyCompositeView:GetPayText()
  if not self.model.curCompositeCurrencyTid then
    return ""
  end
  local haveNum = ItemDataUtils.GetItemNum(self.model.curCompositeCurrencyTid)
  local costNum = self.model.curCompositeCurrencyCostNum
  if haveNum < costNum then
    do return string.format, "<color=#FA3A50>%s</color>/%s", haveNum end
    return string.format, "<color=#FA3A50>%s</color>/%s", haveNum, costNum
  end
  do return string.format, "%s/%s", haveNum end
  return string.format, "%s/%s", haveNum, costNum
end

function AlchemyCompositeView:GetMoneyImage()
  if not self.model.curCompositeCurrencyTid then
    return ""
  end
  local config = DT.Item[self.model.curCompositeCurrencyTid]
  return config and config.Icon or ""
end

function AlchemyCompositeView:_GetJumpIdx()
  local jumpIdx = 1
  for idx, itemData in pairs(self.model.compositeItemList) do
    if itemData.itemTid == self.mainModel:Get_jumpToItemTid() then
      jumpIdx = idx
      break
    end
  end
  return jumpIdx
end

function AlchemyCompositeView:_CompositeListViewDefaultSelect()
  local jumpIdx = self:_GetJumpIdx()
  local jumpToItemTid = self.mainModel:Get_jumpToItemTid()
  if jumpToItemTid and 0 ~= jumpToItemTid and 0 ~= jumpIdx then
    self.model:Set_curSelectTid(jumpToItemTid)
    return
  end
  self:_CompositeListViewSelectFirst()
end

function AlchemyCompositeView:_CompositeListViewSelectFirst()
  local selectTid = self.model.compositeItemList[1] and self.model.compositeItemList[1].itemTid or 0
  self.model:Set_curSelectTid(selectTid)
end

function AlchemyCompositeView:_CompositeListViewDefaultJump()
  local jumpIdx = self:_GetJumpIdx()
  local offset = self.compositeListView:GetOffsetByIndex(jumpIdx - 1)
  self.compositeListView:SetOffset(offset, false)
  self.mainModel:Set_jumpToItemTid(nil)
end

function AlchemyCompositeView:OnAddClick()
  local nextNum = math.min(self.model.maxCompositeNum, self.model.curCompositeNum + 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.model:Set_curCompositeNum(nextNum)
end

function AlchemyCompositeView:OnSubClick()
  local nextNum = math.max(self.model.minCompositeNum, self.model.curCompositeNum - 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.model:Set_curCompositeNum(nextNum)
end

function AlchemyCompositeView:InitSliderComp()
  self.sliderComp = self.ui.Slider_Buy:GetComponent(TYPEOF_Slider)
end

function AlchemyCompositeView:_IsCanComposite(conversionId)
  return self.model:CanComposite() and AlchemyCompositeExtModel.Instance:IsHaveRemainCompositeTime(conversionId)
end

function AlchemyCompositeView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyCompositeView
