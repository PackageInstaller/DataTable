_class("UIHomeVisitGetGift", UIController)
UIHomeVisitGetGift = UIHomeVisitGetGift

function UIHomeVisitGetGift:LoadDataOnEnter(TT, res, uiParams)
  self._module = GameGlobal.GetModule(HomelandModule)
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  local host = self._uiModule:GetVisitInfo().pstid
  local got = table.icontains(self._module:GetHomelandInfo().visit_info.item_list, host)
  if got then
    res:SetSucc(false)
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_visit_got_gift_today"))
    return
  end
  res:SetSucc(true)
end

function UIHomeVisitGetGift:OnShow(uiParams)
  self:InitWidget()
  self._maxCount = 10
  self._gifts = self.content:SpawnObjects("UIHomeVisitGetGiftItem", self._maxCount)
  self:_Refresh()
end

function UIHomeVisitGetGift:_Refresh()
  local gifts = self._uiModule:GetVisitInfo().item_list
  self._giftData = {}
  for i = 1, self._maxCount do
    local data = gifts[i - 1]
    if self:_GiftExist(data) then
      self._giftData[i] = data
    end
  end
  
  local function onSelect(idx)
    self:_OnSelect(idx)
  end
  
  for i = 1, self._maxCount do
    self._gifts[i]:SetData(i, self._giftData[i], onSelect)
  end
  if table.count(self._giftData) > 0 then
    self:_OnSelect(1)
  end
  local gotCount = table.count(self._module:GetHomelandInfo().visit_info.item_list)
  self.tip:SetText(StringTable.Get("str_homeland_visit_get_gift_tip2", self._maxCount - gotCount, self._maxCount))
end

function UIHomeVisitGetGift:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.tip = self:GetUIComponent("UILocalizationText", "tip")
end

function UIHomeVisitGetGift:GetOnClick(go)
  if not self._curSelect then
    return
  end
  self:StartTask(self._GetGift, self)
end

function UIHomeVisitGetGift:CloseOnClick(go)
  self:CloseDialog()
end

function UIHomeVisitGetGift:_OnSelect(idx)
  if self._curSelect == idx or self._giftData[idx] == nil then
    return
  end
  if self._curSelect then
    self._gifts[self._curSelect]:Select(false)
  end
  self._curSelect = idx
  self._gifts[self._curSelect]:Select(true)
end

function UIHomeVisitGetGift:_GiftExist(gift)
  if gift == nil or gift.count == nil then
    return false
  end
  return gift.count > 0
end

function UIHomeVisitGetGift:_GetGift(TT)
  local gift = self._giftData[self._curSelect]
  if not self:_GiftExist(gift) then
    Log.exception("礼品不存在:", self._curSelect)
    return
  end
  local host = self._uiModule:GetVisitInfo().pstid
  self:Lock(self:GetName())
  local res, data
  res, data = self._module:HomelandTakeItemReq(TT, host, self._curSelect - 1, gift.pstid)
  self:UnLock(self:GetName())
  if not res:GetSucc() then
    if res:GetResult() == HomeLandErrorType.E_HET_VISIT_TAKE_NO_ITEM or res:GetResult() == HomeLandErrorType.E_HET_VISIT_TAKE_NO_SAME then
      self._uiModule:GetVisitInfo().item_list = data.newInfo
    end
    self._curSelect = nil
    self:_Refresh()
    ToastManager.ShowHomeToast(self._module:GetVisitErrorMsg(res:GetResult()))
    return
  end
  self._curSelect = nil
  self:_Refresh()
  local asset = RoleAsset:New()
  asset.assetid = gift.assetid
  asset.count = gift.count
  self:ShowDialog("UIHomeShowAwards", {asset}, function()
    self:CloseDialog()
  end)
end
