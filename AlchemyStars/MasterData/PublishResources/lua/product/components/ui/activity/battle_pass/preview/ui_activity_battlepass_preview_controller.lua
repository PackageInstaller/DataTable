_class("UIActivityBattlePassPreviewController", UIController)
UIActivityBattlePassPreviewController = UIActivityBattlePassPreviewController

function UIActivityBattlePassPreviewController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassPreviewController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassPreviewController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self._txtTitleElite = self:GetUIComponent("UILocalizationText", "txtTitleElite")
  self._txtTitleStandard = self:GetUIComponent("UILocalizationText", "txtTitleStandard")
end

function UIActivityBattlePassPreviewController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityBattlePassPreviewController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  self:_SetTitle()
  self:_SetRewards()
end

function UIActivityBattlePassPreviewController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassPreviewController:_SetTitle()
  self._txtTitleElite:SetText(StringTable.Get("str_activity_battlepass_preview_title_elite"))
  self._txtTitleStandard:SetText(StringTable.Get("str_activity_battlepass_preview_title_standard"))
end

function UIActivityBattlePassPreviewController:_SetRewards()
  local component = self:_GetLVRewardComponent()
  local rewards = component:GetSortAdvancedRewards()
  self:_SpawnRewards(rewards, "rewardElite")
  local rewards = component:GetSortNormalRewards()
  self:_SpawnRewards(rewards, "rewardStandard")
end

function UIActivityBattlePassPreviewController:_SpawnRewards(rewards, sopName)
  local sop = self:GetUIComponent("UISelectObjectPath", sopName)
  sop:SpawnObjects("UIActivityBattlePassItemIcon", table.count(rewards))
  local items = sop:GetAllSpawnList()
  for i, v in ipairs(items) do
    v:SetData(i, rewards[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
    end, UIItemScale.Level1)
  end
end

function UIActivityBattlePassPreviewController:CloseBtnOnClick(go)
  Log.info("UIActivityBattlePassPreviewController:CloseBtnOnClick")
  self:CloseDialog()
end

function UIActivityBattlePassPreviewController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassPreviewController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassPreviewController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
