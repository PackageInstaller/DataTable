_class("UIBattlePassCN1BuyGiftResultController", UIController)
UIBattlePassCN1BuyGiftResultController = UIBattlePassCN1BuyGiftResultController

function UIBattlePassCN1BuyGiftResultController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
end

function UIBattlePassCN1BuyGiftResultController:OnShow(uiParams)
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self._type = uiParams and uiParams[1]
  self._callback = uiParams and uiParams[2]
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetState(self._type)
  self:_SetTitle()
  self:_SetRewards()
end

function UIBattlePassCN1BuyGiftResultController:OnHide()
end

function UIBattlePassCN1BuyGiftResultController:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [CampaignGiftType.ECGT_ADVANCED] = {"_Elite"},
    [CampaignGiftType.ECGT_LUXURY] = {"_Deluxe"},
    [CampaignGiftType.ECGT_ADDITIONALBUY] = {"_Deluxe"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIBattlePassCN1BuyGiftResultController:_SetTitle()
  local tb = {
    [CampaignGiftType.ECGT_ADVANCED] = "str_activity_battlepass_elite",
    [CampaignGiftType.ECGT_LUXURY] = "str_activity_battlepass_deluxe",
    [CampaignGiftType.ECGT_ADDITIONALBUY] = "str_activity_battlepass_deluxe"
  }
  local text = StringTable.Get(tb[self._type])
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle_Elite", text)
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle_Deluxe", text)
end

function UIBattlePassCN1BuyGiftResultController:_SetRewards()
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local giftId = component:GetFirstGiftIDByType(self._type)
  local rewards = component:GetGiftExtraAwardById(giftId)
  local items = UIWidgetHelper.SpawnObjects(self, "Content", "UIBattlePassCN1ItemIcon", table.count(rewards))
  for i, v in ipairs(items) do
    local lv = UIActivityBattlePassHelper.IsExtraLevelReward(self._campaign, rewards[i])
    if lv then
      v:SetData_LvIcon(self._campaign, i, lv)
    else
      v:SetData(i, rewards[i], self._tipsCallback, 0.75)
    end
  end
end

function UIBattlePassCN1BuyGiftResultController:CloseBtnOnClick(go)
  Log.info("UIBattlePassCN1BuyGiftResultController:CloseBtnOnClick")
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
end
