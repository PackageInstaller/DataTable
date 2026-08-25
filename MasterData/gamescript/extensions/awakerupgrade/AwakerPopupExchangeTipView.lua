local AwakerPopupExchangeTipView, Super = NewClass("AwakerPopupExchangeTipView", BaseView)
AwakerPopupExchangeTipView.uiResCls = UI_Awaker_Popup_Exchange_TipResource

function AwakerPopupExchangeTipView:ctor(consumeItemsNoMoney, compositeItems, costMoney, reqFuc)
  Super.ctor(self)
  self.consumeItemsNoMoney = consumeItemsNoMoney
  self.compositeItems = compositeItems
  self.costMoney = costMoney
  self.reqFuc = reqFuc
end

function AwakerPopupExchangeTipView.OpenThisView(consumeItemsNoMoney, compositeItems, costMoney, reqFuc)
  UIManager.Instance:Reopen(Urls.AwakerPopupExchangeTipView, consumeItemsNoMoney, compositeItems, costMoney, reqFuc)
end

function AwakerPopupExchangeTipView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._ConfirmCompose))
end

function AwakerPopupExchangeTipView:_ConfirmCompose()
  self:_ReqCompose()
end

function AwakerPopupExchangeTipView:_ReqCompose()
  if self.reqFuc then
    self:Close()
    self.reqFuc()
    return
  end
  local composeList = {}
  for _, data in pairs(self.compositeItems) do
    if ItemAlchemyUtils.IsExchangeItem(data.id) then
      local formatId = ItemAlchemyUtils.format[ItemAlchemyUtils.SeasonS1SmallMtrl][1]
      local itemData = ItemDataUtils.GetItemByTid(ItemAlchemyUtils.SeasonS1BigMtrl)
      local uid = itemData and itemData.uid or 0
      AlchemyDataUtils.ExchangeItem(formatId, {
        {
          uid = uid,
          num = math.floor(data.count / 3)
        }
      })
    else
      composeList[data.id] = data.count
    end
  end
  if composeList == {} then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnAutoComposeList", function()
    print("一键合成同步成功！")
    self:Close()
    local items = {}
    for awardTid, awardNum in pairs(composeList) do
      table.insert(items, {tid = awardTid, changedNum = awardNum})
    end
    ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle"), "", items)
  end, function(_, code)
    Logger.Error("一键合成同步失败！错误码: %s", code.code)
  end, composeList)
end

function AwakerPopupExchangeTipView:_SetCostMoneyText(count)
  if count <= 0 then
    self:SetActive(self.ui.Group_Need, false)
  else
    self:SetActive(self.ui.Group_Need, true)
    self:SetText(self.ui.Text_Need_Count, ItemDataUtils.GetItemNum(DT.GetConstant("GoldItemTid")) .. "/" .. math.ceil(count))
  end
end

function AwakerPopupExchangeTipView:OnEnterView()
  self:_InitTableview()
  self:_SetCostMoneyText(self.costMoney)
end

function AwakerPopupExchangeTipView:_InitTableview()
  local w = self.ui.UI_Common_Item_WuPin_Type1.transform.sizeDelta.x
  local h = self.ui.UI_Common_Item_WuPin_Type1.transform.sizeDelta.y
  self.consumeTableView = self:CreateTableview(self.ui.ScrollView_Consume, function()
    return self.consumeItemsNoMoney and #self.consumeItemsNoMoney or 0
  end, function(view, index)
    do return self._ItemCellAtIndex, self, view, index, self.consumeItemsNoMoney end
    return self._ItemCellAtIndex, self, view, index, self.consumeItemsNoMoney, true
  end, function()
    return w, h
  end)
  self.compositeTableView = self:CreateTableview(self.ui.ScrollView_Composite, function()
    return self.compositeItems and #self.compositeItems or 0
  end, function(view, index)
    do return self._ItemCellAtIndex, self, view, index end
    return self._ItemCellAtIndex, self, view, index, self.compositeItems
  end, function()
    return w, h
  end)
  self.consumeTableView:ReloadData()
  self.compositeTableView:ReloadData()
  local consumeViewport = self.ui.ScrollView_Consume.transform:Find("Viewport")
  local compositeViewport = self.ui.ScrollView_Composite.transform:Find("Viewport")
  local MAX_ITEM_COUNT = 3
  consumeViewport:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)).enabled = MAX_ITEM_COUNT >= #self.consumeItemsNoMoney
  compositeViewport:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)).enabled = MAX_ITEM_COUNT >= #self.compositeItems
  self.timerUpdateLineId = self.binder:BindTimer(0.01, 1, nil, function()
    consumeViewport:GetComponent(typeof(CS.UnityEngine.UI.RectMask2D)).enabled = true
    compositeViewport:GetComponent(typeof(CS.UnityEngine.UI.RectMask2D)).enabled = true
  end)
end

function AwakerPopupExchangeTipView:_ItemCellAtIndex(view, index, items, isShowHave)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local itemCount = items[index].count
  local itemTid = items[index].id
  
  local function clickCb()
    ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, itemTid, true)
  end
  
  local showNum
  if isShowHave then
    showNum = ItemDataUtils.GetItemNum(itemTid) .. "/" .. itemCount
  else
    showNum = itemCount
  end
  local viewData = {
    tid = itemTid,
    num = showNum,
    clickCb = clickCb
  }
  self:AddViewComponentOnce(cell.gameObject, CompAlchemyBaseItem, viewData)
  return cell
end

return AwakerPopupExchangeTipView
