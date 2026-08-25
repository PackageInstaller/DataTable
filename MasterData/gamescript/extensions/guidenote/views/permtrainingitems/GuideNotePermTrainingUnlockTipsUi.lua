local GuideNotePermTrainingUnlockTipsUi = {}
local TEXT_FEATUREE_CHILD_NAME = "Text_Featuree"

function GuideNotePermTrainingUnlockTipsUi.ApplyToText(viewSelf, textComp, unlocked, featureId, featureKey)
  if nil == textComp or nil == viewSelf then
    return
  end
  if true == unlocked then
    viewSelf:SetText(textComp, "")
    return
  end
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(featureId, featureKey or 0)
  viewSelf:SetText(textComp, tips or "")
end

function GuideNotePermTrainingUnlockTipsUi.ApplyToLockGroup(viewSelf, groupLock, unlocked, featureId, featureKey)
  if nil == groupLock or nil == viewSelf then
    return
  end
  local textGo = viewSelf:FindChild(groupLock, TEXT_FEATUREE_CHILD_NAME)
  if nil == textGo then
    textGo = viewSelf:FindChildRecursively(groupLock, TEXT_FEATUREE_CHILD_NAME)
  end
  if nil == textGo then
    return
  end
  GuideNotePermTrainingUnlockTipsUi.ApplyToText(viewSelf, textGo, unlocked, featureId, featureKey)
end

return GuideNotePermTrainingUnlockTipsUi
