_class("UIActivityBattlePassN5PreviewController", UIController)
UIActivityBattlePassN5PreviewController = UIActivityBattlePassN5PreviewController

function UIActivityBattlePassN5PreviewController:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5PreviewController:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5PreviewController:_GetComponents()
end

function UIActivityBattlePassN5PreviewController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityBattlePassN5PreviewController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  UIActivityBattlePassHelper.SetSpecialImg(self._campaign, self:GetGameObject("imgRoot"), self:GetUIComponent("RawImageLoader", "img1"), self:GetName())
  UIActivityBattlePassHelper.SetSpecialImg(self._campaign, self:GetGameObject("imgRoot2"), self:GetUIComponent("RawImageLoader", "img2"), self:GetName())
  self:_SetTitle()
  self:_SetRewards()
end

function UIActivityBattlePassN5PreviewController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityBattlePassN5PreviewController:_SetTitle()
  local txt = self:GetUIComponent("UILocalizationText", "title2")
  local strId = UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_main_title_2")
  txt:SetText(StringTable.Get(strId))
end

function UIActivityBattlePassN5PreviewController:_SetRewards()
  local component = self:_GetLVRewardComponent()
  local rewards = component:GetSortAdvancedRewards()
  self:_SpawnRewards(rewards, "rewardElite")
  local rewards = component:GetSortNormalRewards()
  self:_SpawnRewards(rewards, "rewardStandard")
end

function UIActivityBattlePassN5PreviewController:_SpawnRewards(rewards, sopName)
  local sop = self:GetUIComponent("UISelectObjectPath", sopName)
  sop:SpawnObjects("UIActivityBattlePassN5ItemIcon", table.count(rewards))
  local items = sop:GetAllSpawnList()
  for i, v in ipairs(items) do
    v:SetData(i, rewards[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
    end, UIItemScale.Level3)
    local count = 3
    v:PlayAnimationInSequence(math.floor((i - 1) / count))
  end
end

function UIActivityBattlePassN5PreviewController:CloseBtnOnClick(go)
  Log.info("UIActivityBattlePassN5PreviewController:CloseBtnOnClick")
  self:CloseDialog()
end

function UIActivityBattlePassN5PreviewController:nullOnClick(go)
end

function UIActivityBattlePassN5PreviewController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassN5PreviewController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityBattlePassN5PreviewController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
