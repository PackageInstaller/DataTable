_class("UIS3ExchangeConfirm", UIController)
UIS3ExchangeConfirm = UIS3ExchangeConfirm

function UIS3ExchangeConfirm:LoadDataOnEnter(TT, res, uiParams)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonId = uiParams and uiParams[1]
  self._component = uiParams and uiParams[2]
  self._info = uiParams and uiParams[3]
  if self._info == nil then
    Log.error("UIS3ExchangeConfirm:LoadDataOnEnter() param = nil")
    res:SetSucc(false)
    return
  end
end

function UIS3ExchangeConfirm:OnShow(uiParams)
  local roleAsset = self._info.m_reward
  local itemId, itemCount = roleAsset.assetid, roleAsset.count
  local canExchangeCount = self:_ConstMax()
  local state = 1 < canExchangeCount and 2 or 1
  self._buyCount = 1
  self:_SetState(state)
  self:_SetItem(itemId, itemCount)
  self:_SetPetDetail(itemId)
  self:_SetBuyCountGroup(state)
  self:_SetRemain()
  self:_SetCoin()
  self:_Refresh()
  self:_AttachEvents()
end

function UIS3ExchangeConfirm:OnHide()
  self:_DetachEvents()
end

function UIS3ExchangeConfirm:_Refresh()
  self:_SetBuyCount(self._buyCount)
  self:_SetCoinCount(self._buyCount)
end

function UIS3ExchangeConfirm:_UpdateBuyCount(newCount)
  local min, max = self:_ConstMin(), self:_CalcMaxCount()
  self._buyCount = Mathf.Clamp(newCount, min, max)
  self:_Refresh()
end

function UIS3ExchangeConfirm:_SetState(state)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_bgOne", "_imgOne"},
    {
      "_bgMulti",
      "_spaceMulti",
      "_imgMulti",
      "_spaceMulti2"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIS3ExchangeConfirm:_SetItem(itemId, itemCount)
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetItemCount(self, itemId, "_haveCount", function(havecount)
    local str = StringTable.Get("str_shop_current_item_count", havecount)
    return str
  end)
  UIWidgetHelper.SetItemText(self, itemId, "_name", "_desc")
  UIWidgetHelper.SetLocalizationText(self, "_count", "x" .. itemCount)
end

function UIS3ExchangeConfirm:_SetPetDetail(itemId)
  local cfg = Cfg.cfg_pet[itemId]
  local isPet = cfg ~= nil
  self:GetGameObject("_petDetail"):SetActive(isPet)
end

function UIS3ExchangeConfirm:_SetBuyCountGroup(state)
  local isShow = state == 2
  self:GetGameObject("_buyCountGroup"):SetActive(isShow)
end

function UIS3ExchangeConfirm:_SetBuyCount(count)
  UIWidgetHelper.SetLocalizationText(self, "_buyCount", count)
end

function UIS3ExchangeConfirm:_SetRemain()
  local inf = self._component:IsExchangeItemInfinity(self._info)
  self:GetGameObject("_remain"):SetActive(not inf)
  local remain = self:_ConstMax()
  local str = StringTable.Get("str_season_s1_exchange_remain", remain)
  UIWidgetHelper.SetLocalizationText(self, "_remain", str)
end

function UIS3ExchangeConfirm:_SetCoin()
  local itemId = self._info.m_cost_item_id
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, "_coin", atlasName, spriteName)
end

function UIS3ExchangeConfirm:_SetCoinCount(buyCount)
  local total = self:_CalcTotalPrice(buyCount)
  local enough = self:_CheckCoinEnough(buyCount)
  local color = enough and "#0D3347" or "#902222"
  local str = UIActivityHelper.GetColorText(color, total)
  UIWidgetHelper.SetLocalizationText(self, "_price", str)
end

function UIS3ExchangeConfirm:_ConstMin()
  return 1
end

function UIS3ExchangeConfirm:_ConstMax()
  local constMax = 99
  local max = self._component:GetCanExchangeCount(self._info, constMax)
  return Mathf.Max(max, 1)
end

function UIS3ExchangeConfirm:_CalcMinCount()
  local min, max = self:_ConstMin(), self:_ConstMax()
  return min
end

function UIS3ExchangeConfirm:_CalcMaxCount()
  local min, max = self:_ConstMin(), self:_ConstMax()
  local haveCount = self:_CalcHaveCount()
  local price = self:_CalcTotalPrice(1)
  local count = Mathf.Floor(haveCount / price)
  return Mathf.Clamp(count, min, max)
end

function UIS3ExchangeConfirm:_CalcHaveCount()
  local itemId = self._info.m_cost_item_id
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveCount = itemModule:GetItemCount(itemId)
  return haveCount
end

function UIS3ExchangeConfirm:_CalcTotalPrice(buyCount)
  local price = self._info.m_cost_count
  local total = price * buyCount
  return total
end

function UIS3ExchangeConfirm:_CheckCoinEnough(buyCount)
  local haveCount = self:_CalcHaveCount()
  local total = self:_CalcTotalPrice(buyCount)
  return haveCount >= total
end

function UIS3ExchangeConfirm:MinBtnOnClick()
  local newCount = self:_CalcMinCount()
  self:_UpdateBuyCount(newCount)
end

function UIS3ExchangeConfirm:SubBtnOnClick()
  local newCount = self._buyCount - 1
  self:_UpdateBuyCount(newCount)
end

function UIS3ExchangeConfirm:AddBtnOnClick()
  local newCount = self._buyCount + 1
  self:_UpdateBuyCount(newCount)
end

function UIS3ExchangeConfirm:MaxBtnOnClick()
  local newCount = self:_CalcMaxCount()
  self:_UpdateBuyCount(newCount)
end

function UIS3ExchangeConfirm:BuyBtnOnClick()
  if self:_CheckCoinEnough(self._buyCount) then
    local id = self._info.m_id
    local count = self._buyCount
    self._component:Start_HandleExchangeItem(id, count, function(res, rewards)
      self:_OnReceiveRewards(res, rewards)
    end)
  else
    ToastManager.ShowToast(StringTable.Get("str_pay_item_not_enough"))
  end
end

function UIS3ExchangeConfirm:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    self:_CloseDialogWithAnim()
    UISeasonHelper.ShowUIGetRewards(rewards)
  else
    self._seasonModule:CheckErrorCode(res.m_result, self._seasonId)
  end
end

function UIS3ExchangeConfirm:PetDetailBtnOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodData:GetItemId())
end

function UIS3ExchangeConfirm:CloseBtnOnClick(go)
  self:_CloseDialogWithAnim()
end

function UIS3ExchangeConfirm:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS3ExchangeConfirm:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS3ExchangeConfirm:_CloseDialogWithAnim(callback)
  self:CloseDialog()
end
