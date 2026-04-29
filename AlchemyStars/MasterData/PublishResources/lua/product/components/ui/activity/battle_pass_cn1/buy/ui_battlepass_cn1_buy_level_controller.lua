_class("UIBattlePassCN1BuyLevelController", UIController)
UIBattlePassCN1BuyLevelController = UIBattlePassCN1BuyLevelController

function UIBattlePassCN1BuyLevelController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
end

function UIBattlePassCN1BuyLevelController:_SetTopIcon()
  local topTipsContext = UIWidgetHelper.SpawnObject(self, "_topTipsContext", "UITopTipsContext")
  local topIcon = UIWidgetHelper.SpawnObject(self, "_topIcon", "UIMainLobbyTopIcon")
  topIcon:SetPanelShow(false, false, true)
  topIcon:SetData(topTipsContext)
end

function UIBattlePassCN1BuyLevelController:_GetGiftId()
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local giftId = component:GetFirstGiftIDByType(CampaignGiftType.ECGT_BPLEVEL)
  return giftId
end

function UIBattlePassCN1BuyLevelController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_LVReward(self._campaign)
end

function UIBattlePassCN1BuyLevelController:OnShow(uiParams)
  self.callback = uiParams and uiParams[1]
  self.saleType = RoleAssetID.RoleAssetGlow
  self._buyCount = 1
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetCommonTopButton()
  self:_SetTopIcon()
  self:_SetCoin()
  self:_Refresh()
  self:_AttachEvents()
end

function UIBattlePassCN1BuyLevelController:OnHide()
  self:_DetachEvents()
end

function UIBattlePassCN1BuyLevelController:_Refresh()
  if self.view then
    self:_SetTitle()
    self:_SetBuyCount()
    self:_SetBuyPrice()
    self:_SetSlider()
    self:_SetDynamicList()
  end
end

function UIBattlePassCN1BuyLevelController:_SetCoin()
  local atlasName = "UICommon.spriteatlas"
  local spriteName = ClientShop.GetCurrencyImageName(self.saleType)
  UIWidgetHelper.SetImageSprite(self, "_imgCoin", atlasName, spriteName)
end

function UIBattlePassCN1BuyLevelController:_SetTitle()
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_LVReward(self._campaign)
  local text = self._componentInfo.m_current_level + self._buyCount
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle2", text)
end

function UIBattlePassCN1BuyLevelController:_SetBuyCount()
  UIWidgetHelper.SetLocalizationText(self, "_txtBuyCount", tostring(self._buyCount))
end

function UIBattlePassCN1BuyLevelController:_SetBuyPrice()
  local giftId = self:_GetGiftId()
  local cfg = Cfg.cfg_shop_common_goods[giftId]
  local price = cfg and cfg.NewPrice or 0
  self._price = math.floor(price * self._buyCount)
  UIWidgetHelper.SetLocalizationText(self, "_txtBuyPrice", tostring(self._price))
end

function UIBattlePassCN1BuyLevelController:_SetSlider()
  if not self._slider then
    self._slider = self:GetUIComponent("Slider", "_slider")
    self._slider.onValueChanged:AddListener(function(value)
      self:_UpdateBuyNum(value)
    end)
    local min, max = self:_GetLevelMinMax()
    self._slider.minValue = min
    self._slider.maxValue = max
  end
  self._slider.value = self._buyCount
end

function UIBattlePassCN1BuyLevelController:_SetDynamicListData()
  local rewards
  local curLv = self._componentInfo.m_current_level
  if self._componentInfo.m_unlock_advanced_reward then
    rewards = self._component:GetSortAdvancedRewards(curLv + 1, curLv + self._buyCount)
  else
    rewards = self._component:GetSortNormalRewards(curLv + 1, curLv + self._buyCount)
  end
  self._dynamicListInfo = {}
  for i = 1, #rewards do
    table.insert(self._dynamicListInfo, rewards[i])
  end
end

function UIBattlePassCN1BuyLevelController:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIBattlePassCN1ItemIcon", function(listItem, itemIndex)
      self:_SetCellData(listItem, itemIndex)
    end)
  end
  local itemCount = #self._dynamicListInfo
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIBattlePassCN1BuyLevelController:_SetCellData(listItem, index)
  local info = self._dynamicListInfo[index]
  if info ~= nil then
    listItem:SetData(index, info, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end, UIItemScale.Level2)
  end
end

function UIBattlePassCN1BuyLevelController:_GetLevelMinMax()
  local max = self._componentInfo.m_max_level - self._componentInfo.m_current_level
  local min = 1
  return min, max
end

function UIBattlePassCN1BuyLevelController:_UpdateBuyNum(value)
  local min, max = self:_GetLevelMinMax()
  value = Mathf.Clamp(math.floor(value), min, max)
  self._buyCount = value
  self:_Refresh()
end

function UIBattlePassCN1BuyLevelController:DecBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  Log.info("UIBattlePassCN1BuyLevelController:DecBtnBtnOnClick")
  self:_UpdateBuyNum(self._buyCount - 1)
end

function UIBattlePassCN1BuyLevelController:IncBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  Log.info("UIBattlePassCN1BuyLevelController:IncBtnOnClick")
  self:_UpdateBuyNum(self._buyCount + 1)
end

function UIBattlePassCN1BuyLevelController:BuyBtnOnClick(go)
  Log.info("UIBattlePassCN1BuyLevelController:BuyBtnOnClick")
  self:_ShowBuyConfirm(self._price, self._buyCount)
end

function UIBattlePassCN1BuyLevelController:_ShowBuyConfirm(price, giftNum)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_activity_battlepass_pay_gb_2_lv_gift", price, giftNum), function(param)
    if not ClientShop.CheckBuy(self.saleType, price) then
      return
    end
    GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
    local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
    local giftId = self:_GetGiftId()
    component:BuyGift(giftId, self._buyCount)
  end, nil, nil, nil)
end

function UIBattlePassCN1BuyLevelController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UIBattlePassCN1BuyLevelController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UIBattlePassCN1BuyLevelController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIBattlePassCN1BuyLevelController:_OnNormalBuyResult(gift_id, res)
  if self.view == nil then
    return
  end
  local giftId = self:_GetGiftId()
  if giftId ~= gift_id then
    return
  end
  if res:GetSucc() then
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end
