local ItemPublicGetApproachPanel, Super = System.NewComponent("ItemPublicGetApproachPanel")

function ItemPublicGetApproachPanel:ctor(uiNode, itemTid, jumpCallBack)
  Super.ctor(self)
  self.ui = Func_Goods_Gain_TipsResource(uiNode)
  self.itemTid = itemTid
  self.jumpCallBack = jumpCallBack
  self.gets = {}
end

function ItemPublicGetApproachPanel:OnBind(binder)
  self.binder = binder
  self:SetItemGetApproachDetails(self.itemTid)
end

function ItemPublicGetApproachPanel:SetItemGetApproachDetails(itemTid)
  local gets = {}
  for _, tid in ipairs(ItemDataUtils.GetItemConfig(itemTid).Gets) do
    local temp = {}
    temp.tid = tonumber(tid)
    temp.cfg = DT.ItemGets[tonumber(tid)]
    temp.isUnlock, temp.timeOpen = self:CheckIsFuncUnlock(temp.cfg.JumpFunc, temp.cfg.Param1)
    table.insert(gets, temp)
  end
  table.sort(gets, function(a, b)
    local availableA = a.isUnlock and a.timeOpen
    local availableB = b.isUnlock and b.timeOpen
    if availableA == availableB then
      return a.cfg.Order > b.cfg.Order
    else
      return availableA
    end
  end)
  self.gets = gets
  self:AddApproachItem(self.gets)
end

function ItemPublicGetApproachPanel:CheckIsFuncUnlock(_, _)
  local unlock = false
  local timeOpen = true
  return unlock, timeOpen
end

function ItemPublicGetApproachPanel:AddApproachItem(itemList)
  self.binder:BindToCircularListView(self.ui.ScrollView, function()
    return itemList
  end, function(itemBinder, item, index)
    local info = itemList[index]
    itemBinder:BindComponent(ItemPublicGetBtnComponent(item, info, System.fn(self, self.JumpToGetApproachFuncPanel)))
  end)
end

function ItemPublicGetApproachPanel:JumpToGetApproachFuncPanel(approachInfo)
  FuncJumpManager.Instance:JumpFunc(approachInfo.tid)
end

return ItemPublicGetApproachPanel
