local ItemAddSpeed = DT.GetConstant("ItemAddSpeed")
local ExchangeCostItemLimitNum = DT.GetConstant("ExchangeCostItemLimitNum")
local CompAclhemyExhcangeCostBagItem, Super = NewViewComponent("CompAclhemyExhcangeCostBagItem", CompPublicIconItemType1)
local deltaNum = 0

function CompAclhemyExhcangeCostBagItem:ctor(uiNode, view, data, selectCostItemFunc)
  Super.ctor(self, uiNode, view, data)
  self.selectCostItemFunc = selectCostItemFunc
  self.model = AlchemyExchangeExtModel.Instance
end

function CompAclhemyExhcangeCostBagItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TouchEndEvent, function()
    deltaNum = 0
  end)
end

function CompAclhemyExhcangeCostBagItem:InitBtnClick()
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Click, tonumber(DT.GetConstant("ItemAddPressTime")))
  self:AddLongPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnLongPress))
  self:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnLongPress))
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Sub_Subtract, tonumber(DT.GetConstant("ItemAddPressTime")))
  self:AddLongPressButtonListener(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick))
  self:AddShortPressButtonListener(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick))
end

function CompAclhemyExhcangeCostBagItem:OnLongPress()
  if not self.selectCostItemFunc then
    self.model:Set_selectCostTid(self.tid)
    self.model:AddExchangePlan(self.tid)
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Click, nil, self.tid, nil, {posX = 382})
  else
    ItemDataUtils.ReqRemoveNew(self.uid)
    local haveNum = ItemDataUtils.GetItemNum(self.tid)
    local curSelectCostItem = self.model:GetCurSelectCostItemByTid(self.tid)
    local curSelectNum = curSelectCostItem and curSelectCostItem.num or 0
    if self.selectCostItemFunc and (0 == haveNum or haveNum < curSelectNum) then
      return
    end
    local curSelectAllNum = self.model:GetCurSelectNum()
    local addNum = self:_GetDeltaNumWhenTrigger()
    addNum = math.min(addNum, ExchangeCostItemLimitNum - curSelectAllNum)
    addNum = math.min(addNum, haveNum - curSelectNum)
    if curSelectAllNum >= ExchangeCostItemLimitNum then
      Alert.ShowStr(LT.Text("ExchangeCostItemNumReachLimitTips"))
      return
    end
    if curSelectCostItem and haveNum >= curSelectCostItem.num + addNum then
      self.model:Set_selectCostTid(self.tid)
      self.model:UpdateCurSelectCostItemGroup(self.tid, curSelectCostItem.num + addNum)
    else
      if #self.model.curSelectCostItemGroup >= self.model.maxSelectTypeNum then
        Alert.ShowStr(LT.Text("ExchangeCostSelectLimitTips"))
        return
      end
      if haveNum >= addNum then
        self.model:Set_selectCostTid(self.tid)
        self.model:AddCurSelectCostItemGroup({
          tid = self.tid,
          num = addNum
        })
      end
    end
  end
  if not self:IsCanLongPress() then
    self.binder:CancelRepeatButtonPress(self.ui.Btn_Click)
  end
end

function CompAclhemyExhcangeCostBagItem:OnSubClick(triggeredTimes)
  if not self.selectCostItemFunc then
    self.model:DeleteExchangePlan(self.tid)
    self.model:Set_selectCostTid(0)
  else
    local curSelectCostItem = self.model:GetCurSelectCostItemByTid(self.tid)
    if not curSelectCostItem then
      return
    end
    local remainNum = curSelectCostItem.num
    local minusNum = self:_GetDeltaNumWhenTrigger()
    minusNum = math.min(minusNum, remainNum)
    if remainNum == minusNum then
      self.model:RemoveCurSelectCostItemGroup(self.tid)
    else
      self.model:UpdateCurSelectCostItemGroup(self.tid, remainNum - minusNum)
    end
  end
end

function CompAclhemyExhcangeCostBagItem:InitImageDis()
  self.ui.Image_Dis:SetActive((not self.uid or 0 == self.uid) and self.selectCostItemFunc)
  self.ui.Image_Get_Frame:SetActive(false)
  self.ui.Image_Get_Icon:SetActive(false)
end

function CompAclhemyExhcangeCostBagItem:IsCanLongPress()
  if not self.selectCostItemFunc then
    return false
  end
  local curSelectCostItem = self.selectCostItemFunc and self.selectCostItemFunc()
  local costNum = curSelectCostItem and curSelectCostItem.num or 0
  local haveNum = ItemDataUtils.GetItemNum(self.tid)
  return costNum <= haveNum
end

function CompAclhemyExhcangeCostBagItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompAclhemyExhcangeCostBagItem:_GetDeltaNumWhenTrigger()
  if 0 == deltaNum then
    deltaNum = 1
  else
    deltaNum = math.ceil(deltaNum * ItemAddSpeed)
  end
  return deltaNum
end

return CompAclhemyExhcangeCostBagItem
