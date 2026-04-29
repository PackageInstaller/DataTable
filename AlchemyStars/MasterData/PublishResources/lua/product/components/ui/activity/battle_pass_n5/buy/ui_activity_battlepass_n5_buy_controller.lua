_class("UIActivityBattlePassN5BuyController", UIController)
UIActivityBattlePassN5BuyController = UIActivityBattlePassN5BuyController

function UIActivityBattlePassN5BuyController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5BuyController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5BuyController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5BuyController:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5BuyController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local hideHomeBtn = self._homeLandModule:IsRunning()
  self._backBtns:SetData(function()
    self:_PlayAnimOut()
  end, nil, nil, hideHomeBtn)
  local eliteBoardPool = self:GetUIComponent("UISelectObjectPath", "eliteBoardPool")
  self._eliteBoard = eliteBoardPool:SpawnObject("UIActivityBattlePassN5Board")
  local deluxeBoardPool = self:GetUIComponent("UISelectObjectPath", "deluxeBoardPool")
  self._deluxeBoard = deluxeBoardPool:SpawnObject("UIActivityBattlePassN5Board")
end

function UIActivityBattlePassN5BuyController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    self._campaign._campaign_module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  local component = self:_GetBuyGiftComponent()
  component:GetAllGiftLocalPrice()
end

function UIActivityBattlePassN5BuyController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  if uiParams then
    self.callback = uiParams[1]
  end
  self:_GetComponents()
  UIActivityBattlePassHelper.SetSpecialImg(self._campaign, self:GetGameObject("imgRoot"), self:GetUIComponent("RawImageLoader", "img"), self:GetName())
  self:_SetBoard()
  self:_PlayAnimIn()
end

function UIActivityBattlePassN5BuyController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassN5BuyController:_SetBoard()
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

function UIActivityBattlePassN5BuyController:BuyBtnOnClick(type)
  local component = self:_GetBuyGiftComponent()
  local giftId = component:GetFirstGiftIDByType(type)
  component:BuyGift(giftId, 1, type)
end

function UIActivityBattlePassN5BuyController:PreviewBtnOnClick(go)
  Log.info("UIActivityBattlePassN5BuyController:PreviewBtnOnClick")
  self:ShowDialog("UIActivityBattlePassN5PreviewController")
end

function UIActivityBattlePassN5BuyController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.PayGetLocalPriceFinished, self._SetBoard)
end

function UIActivityBattlePassN5BuyController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:DetachEvent(GameEventType.PayGetLocalPriceFinished, self._SetBoard)
end

function UIActivityBattlePassN5BuyController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityBattlePassN5BuyController:_OnCurrencyBuySuccess(id)
  local component = self:_GetBuyGiftComponent()
  local type
  for t = CampaignGiftType.ECGT_ADVANCED, CampaignGiftType.ECGT_ADDITIONALBUY do
    if component:GetFirstGiftIDByType(t) == id then
      type = t
      break
    end
  end
  if type then
    self:ShowDialog("UIActivityBattlePassN5AwardController", type, function()
      if self.callback then
        self.callback(type == CampaignGiftType.ECGT_LUXURY or type == CampaignGiftType.ECGT_ADDITIONALBUY)
      end
      self:_PlayAnimOut()
    end)
  else
    Log.fatal("UIActivityBattlePassN5BuyController:_OnCurrencyBuySuccess(id) CampaignGiftType Wrong! id = ", id)
  end
end

function UIActivityBattlePassN5BuyController:_PlayAnimIn()
  local animName = "UIeff_UIActivityBattlePassN5BuyController_in"
  UIWidgetHelper.PlayAnimation(self, "animation", animName, 767)
end

function UIActivityBattlePassN5BuyController:_PlayAnimOut()
  if not self.view then
    return
  end
  local animName = "UIeff_UIActivityBattlePassN5BuyController_out"
  UIWidgetHelper.PlayAnimation(self, "animation", animName, 600, function()
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
  end)
end
