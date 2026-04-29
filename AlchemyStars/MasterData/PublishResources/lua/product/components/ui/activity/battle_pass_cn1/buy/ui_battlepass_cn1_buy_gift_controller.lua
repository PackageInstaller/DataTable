_class("UIBattlePassCN1BuyGiftController", UIController)
UIBattlePassCN1BuyGiftController = UIBattlePassCN1BuyGiftController

function UIBattlePassCN1BuyGiftController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local hideHomeBtn = self._homeLandModule:IsRunning()
  self._backBtns:SetData(function()
    self:_PlayAnimOut()
  end, nil, nil, hideHomeBtn)
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIBattlePassCN1BuyGiftController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
  if res and not res:GetSucc() then
    return
  end
  UIActivityBattlePassHelper.GetAllGiftLocalPrice(self._campaign)
end

function UIBattlePassCN1BuyGiftController:OnShow(uiParams)
  self.callback = uiParams and uiParams[1]
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  self:_GetComponents()
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  UIActivityBattlePassHelper.SetSpecialImgInfo(self._campaign, self, "imgRoot", "img")
  self:_Refresh()
  self:_PlayAnimIn()
  self:_AttachEvents()
end

function UIBattlePassCN1BuyGiftController:OnHide()
  self:_DetachEvents()
end

function UIBattlePassCN1BuyGiftController:_Refresh()
  self:_SetBoard("eliteBoardPool", CampaignGiftType.ECGT_ADVANCED)
  self:_SetBoard("deluxeBoardPool", CampaignGiftType.ECGT_LUXURY)
end

function UIBattlePassCN1BuyGiftController:_SetBoard(widgetName, type)
  local buyState = self._componentInfo.m_buy_state
  type = buyState == BuyGiftStateType.EBGST_ADVANCED and type == CampaignGiftType.ECGT_LUXURY and CampaignGiftType.ECGT_ADDITIONALBUY or type
  
  local function clickCallback(type)
    self:BuyBtnOnClick(type)
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIBattlePassCN1GiftBoard")
  obj:SetData(self._campaign, type, clickCallback)
end

function UIBattlePassCN1BuyGiftController:BuyBtnOnClick(type)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local giftId = component:GetFirstGiftIDByType(type)
  component:BuyGift(giftId, 1, type)
end

function UIBattlePassCN1BuyGiftController:PreviewBtnOnClick(go)
  Log.info("UIBattlePassCN1BuyGiftController:PreviewBtnOnClick")
  UIActivityBattlePassHelper.OpenPreviewController()
end

function UIBattlePassCN1BuyGiftController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.PayGetLocalPriceFinished, self._Refresh)
end

function UIBattlePassCN1BuyGiftController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:DetachEvent(GameEventType.PayGetLocalPriceFinished, self._Refresh)
end

function UIBattlePassCN1BuyGiftController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIBattlePassCN1BuyGiftController:_OnCurrencyBuySuccess(id)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local type
  for t = CampaignGiftType.ECGT_ADVANCED, CampaignGiftType.ECGT_ADDITIONALBUY do
    if component:GetFirstGiftIDByType(t) == id then
      type = t
      break
    end
  end
  if type then
    UIActivityBattlePassHelper.OpenBuyGiftResultController(type, function()
      if self.callback then
        self.callback(type == CampaignGiftType.ECGT_LUXURY or type == CampaignGiftType.ECGT_ADDITIONALBUY)
      end
      self:_PlayAnimOut()
    end)
  else
    Log.fatal("UIBattlePassCN1BuyGiftController:_OnCurrencyBuySuccess(id) CampaignGiftType Wrong! id = ", id)
  end
end

function UIBattlePassCN1BuyGiftController:_PlayAnimIn()
  self:StartTask(function(TT)
    self._animation.enabled = true
    self._animation:Play("UIeff_UIBattlePassCN1BuyGiftController_in")
    YIELD(TT, 400)
    self._animation.enabled = false
  end)
end

function UIBattlePassCN1BuyGiftController:_PlayAnimOut()
  if not self.view then
    return
  end
  self:StartTask(function(TT)
    self._animation.enabled = true
    self._animation:Play("UIeff_UIBattlePassCN1BuyGiftController_out")
    YIELD(TT, 167)
    self._animation.enabled = false
    if self.callback then
      self.callback()
    end
    self:CloseDialog()
  end)
end
