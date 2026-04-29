_class("UIHomeStorehouse", UIController)
UIHomeStorehouse = UIHomeStorehouse

function UIHomeStorehouse:OnShow(uiParams)
  self:InitWidget()
  self._module = self:GetModule(HomelandModule)
  self._maxCount = 10
  self._gifts = self.content:SpawnObjects("UIHomeVisitGiftItem", self._maxCount)
  
  function self._onRemoveGift(idx)
    self:StartTask(self._Remove, self, idx)
  end
  
  function self._onClickGift(idx, go)
    if self._giftData[idx] then
      local id = self._giftData[idx].assetid
      self:ShowDialog("UIItemTipsHomeland", id, go)
    else
      self._curAddIdx = idx
      self:ShowOperator()
    end
  end
  
  self:_RefreshList()
  self:AttachEvent(GameEventType.UIHomeVisitAddGift, self._OnAddGift)
end

function UIHomeStorehouse:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._helpTip = self:GetUIComponent("UISelectObjectPath", "UIHomeCommonTips")
  self:ShowHelpTip()
end

function UIHomeStorehouse:ShowOperator()
  self:ShowDialog("UIHomeGiftSelector")
end

function UIHomeStorehouse:_RefreshList()
  local gifts = self._module:GetHomelandInfo().visit_int_info.item_map
  self._giftData = {}
  for i = 1, self._maxCount do
    local data = gifts[i - 1]
    if self:_GiftExist(data) then
      self._giftData[i] = data
    end
  end
  for i = 1, self._maxCount do
    self._gifts[i]:SetData(i, self._giftData[i], self._onRemoveGift, self._onClickGift)
  end
end

function UIHomeStorehouse:_GiftExist(gift)
  if gift == nil or gift.count == nil then
    return false
  end
  return gift.count > 0
end

function UIHomeStorehouse:_OnAddGift(id, count)
  self:StartTask(self._Add, self, id, count)
end

function UIHomeStorehouse:_Remove(TT, idx)
  local data = self._giftData[idx]
  if not data then
    Log.exception("该位置为空，不能移除")
    return
  end
  local item = RoleAsset:New()
  item.assetid = data.assetid
  item.count = 0
  idx = idx - 1
  self:Lock("UIHomeStorehouse_remove")
  local res, _ = self._module:HomelandMoveItemReq(TT, idx, item)
  self:UnLock("UIHomeStorehouse_remove")
  if not res:GetSucc() then
    ToastManager.ShowHomeToast(self._module:GetVisitErrorMsg(res:GetResult()))
    return
  end
  self:_RefreshList()
end

function UIHomeStorehouse:_Add(TT, id, count)
  if not self._curAddIdx then
    Log.exception("当前没有选中槽位，不能添加")
    return
  end
  if self:_GiftExist(self._giftData[self._curAddIdx]) then
    Log.exception("该位置有礼物不能添加:", self._curAddIdx)
    return
  end
  local item = RoleAsset:New()
  item.assetid = id
  item.count = count
  local idx = self._curAddIdx - 1
  self:Lock("UIHomeStorehouse_add")
  local res, _ = self._module:HomelandMoveItemReq(TT, idx, item)
  self:UnLock("UIHomeStorehouse_add")
  if not res:GetSucc() then
    ToastManager.ShowHomeToast(self._module:GetVisitErrorMsg(res:GetResult()))
    return
  end
  self:_RefreshList()
end

function UIHomeStorehouse:CloseBtnOnClick()
  self:CloseDialog()
end

function UIHomeStorehouse:ShowHelpTip()
  local tip = self._helpTip:SpawnObject("UIHomelandCommonHelp")
  tip:SetData("UIHomeStorehouse")
end
