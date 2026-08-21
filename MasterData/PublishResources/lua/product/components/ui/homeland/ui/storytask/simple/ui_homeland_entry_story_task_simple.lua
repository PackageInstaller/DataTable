_class("UIHomelandEntryStoryTaskSimple", Object)
UIHomelandEntryStoryTaskSimple = UIHomelandEntryStoryTaskSimple

function UIHomelandEntryStoryTaskSimple:Constructor(campaign, cfg)
  self._campaign = campaign
  self._cfg = cfg
  self._campaignType = cfg.CampaignType
  self._componentId = cfg.ComponentID
end

function UIHomelandEntryStoryTaskSimple:GetNew()
  local component = self._campaign:GetComponent(self._componentId)
  local new = component:NewTaskRed()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    return false
  end
  return new ~= nil and 0 < new
end

function UIHomelandEntryStoryTaskSimple:GetRedCount()
  return 0
end

function UIHomelandEntryStoryTaskSimple:OpenUI()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_STORY_TASK)
  if not unlock then
    ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_minigame_tip"))
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIHomelandStoryTaskSimpleController", 2, self._campaignType, self._componentId)
end
