_class("UIN23HomelandEntryQuest", Object)
UIN23HomelandEntryQuest = UIN23HomelandEntryQuest

function UIN23HomelandEntryQuest:Constructor(campaign)
  self._campaign = campaign
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N23
  self._componentId = ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN
end

function UIN23HomelandEntryQuest:GetNew()
  local pangolinComp = self._campaign:GetComponent(self._componentId)
  local new = pangolinComp:NewTaskRed()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    return false
  end
  return new ~= nil and 0 < new
end

function UIN23HomelandEntryQuest:GetRedCount()
  return 0
end

function UIN23HomelandEntryQuest:OpenUI()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_minigame_tip"))
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIHomelandStoryTaskSimpleController", 2, self._campaignType, ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
end
