_class("UIActivityBattlePassBuyController", UIController)
UIActivityBattlePassBuyController = UIActivityBattlePassBuyController

function UIActivityBattlePassBuyController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassBuyController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassBuyController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassBuyController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassBuyController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
  end)
  local eliteBoardPool = self:GetUIComponent("UISelectObjectPath", "eliteBoardPool")
  self._eliteBoard = eliteBoardPool:SpawnObject("UIActivityBattlePassBoard")
  local deluxeBoardPool = self:GetUIComponent("UISelectObjectPath", "deluxeBoardPool")
  self._deluxeBoard = deluxeBoardPool:SpawnObject("UIActivityBattlePassBoard")
end

function UIActivityBattlePassBuyController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityBattlePassBuyController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  if uiParams then
    self.callback = uiParams[1]
  end
  self:_GetComponents()
  UIActivityBattlePassHelper.SetSpecialImg(self._campaign, self:GetGameObject("imgRoot"), self:GetUIComponent("RawImageLoader", "img"), self:GetName())
  self:_SetBoard()
end

function UIActivityBattlePassBuyController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassBuyController:_SetBoard()
  local component = self:_GetBuyGiftComponent()
  local componentInfo = self:_GetBuyGiftComponentInfo()
  local type = CampaignGiftType.ECGT_ADVANCED
  local giftId = component:GetFirstGiftIDByType(type)
  local price = component:GetGiftPriceForShowById(giftId)
  self._eliteBoard:SetData(self._campaign, type, price, function(type)
    self:BuyBtnOnClick(type)
  end)
  type = CampaignGiftType.ECGT_LUXURY
  local buyState = componentInfo.m_buy_state
  if buyState == BuyGiftStateType.EBGST_ADVANCED then
    type = CampaignGiftType.ECGT_ADDITIONALBUY
  end
  giftId = component:GetFirstGiftIDByType(type)
  price = component:GetGiftPriceForShowById(giftId)
  self._deluxeBoard:SetData(self._campaign, type, price, function(type)
    self:BuyBtnOnClick(type)
  end)
end

function UIActivityBattlePassBuyController:BuyBtnOnClick(type)
  local component = self:_GetBuyGiftComponent()
  local giftId = component:GetFirstGiftIDByType(type)
  component:BuyGift(giftId, 1, type)
end

function UIActivityBattlePassBuyController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
end

function UIActivityBattlePassBuyController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
end

function UIActivityBattlePassBuyController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityBattlePassBuyController:_OnCurrencyBuySuccess(id)
  local component = self:_GetBuyGiftComponent()
  local type
  for t = CampaignGiftType.ECGT_ADVANCED, CampaignGiftType.ECGT_ADDITIONALBUY do
    if component:GetFirstGiftIDByType(t) == id then
      type = t
      break
    end
  end
  if type then
    self:ShowDialog("UIActivityBattlePassAwardController", type, function()
      if self.callback then
        self.callback(type == CampaignGiftType.ECGT_LUXURY or type == CampaignGiftType.ECGT_ADDITIONALBUY)
      end
      self:CloseDialog()
    end)
  else
    Log.fatal("UIActivityBattlePassBuyController:_OnCurrencyBuySuccess(id) CampaignGiftType Wrong! id = ", id)
  end
end
