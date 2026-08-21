_class("UIN23HomelandEnterMiniGame", Object)
UIN23HomelandEnterMiniGame = UIN23HomelandEnterMiniGame

function UIN23HomelandEnterMiniGame:Constructor(campaign)
  self._campaign = campaign
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N23
  self._componentId = ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  self._key = "UIN23HomelandEntryQuest" .. openID
end

function UIN23HomelandEnterMiniGame:GetNew()
  local res = LocalDB.GetInt(self._key)
  return res ~= 1
end

function UIN23HomelandEnterMiniGame:GetRedCount()
  return 0
end

function UIN23HomelandEnterMiniGame:OpenUI()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_minigame_tip"))
    return
  end
  LocalDB.SetInt(self._key, 1)
  GameGlobal.UIStateManager():ShowDialog("UIN23Movie", true, function()
    GameGlobal.UIStateManager():ShowDialog("UIHomelandStoryTaskSimpleController", 2, self._campaignType, self._componentId)
  end)
end
