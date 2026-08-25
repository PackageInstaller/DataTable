local CopyMainModel, Super = NewClass("CopyMainModel", CopyStagesModel)

function CopyMainModel:OnReset()
  self.curDifficulty = CommonDefine.Difficulty.Normal
  self.exitBattleGroupTid = nil
  Super.OnReset(self)
end

function CopyMainModel:OnInit()
  self:OnReset()
end

function CopyMainModel:SetCurDifficulty(difficulty)
  if self.curDifficulty == difficulty then
    return
  end
  self.curDifficulty = difficulty
  self:LocalNotify(NotifyId.OnCopyMainDifficultyChanged, difficulty)
end

function CopyMainModel:GetCurDifficulty()
  return self.curDifficulty
end

function CopyMainModel:GetFeatureId(difficulty)
  local featureId = CommonDefine.FeatureId.MainCopy
  if difficulty == CommonDefine.Difficulty.Hard then
    featureId = CommonDefine.FeatureId.MainCopyHard
  elseif difficulty == CommonDefine.Difficulty.Super then
    featureId = CommonDefine.FeatureId.MainCopyCrazy
  end
  return featureId
end

function CopyMainModel:GetCurFeatureId()
  do return self.GetFeatureId, self end
  return self.GetFeatureId, self, self.curDifficulty
end

function CopyMainModel:CheckMainChapterDifficultyModeUnlocked(difficulty, alerted)
  local feature = self:GetFeatureId(difficulty)
  local mainTypeKey = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, mainTypeKey, nil)
  if not unlocked then
    if alerted then
      PlayerDataUtils.AlertLockedTips(feature, mainTypeKey)
    end
    return false
  end
  return true
end

function CopyMainModel:SetStageGroupID(stageGroupId)
  Super.SetStageGroupID(self, stageGroupId)
  self:LocalNotify(NotifyId.OnCopyMainStageGroupIdChanged, stageGroupId)
end

function CopyMainModel:CheckStageGroupUnlocked(stageGroupId, alerted)
  if MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) then
    return true
  end
  if not alerted then
    return false
  end
  local featureId = self:GetCurFeatureId()
  local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(featureId, stageGroupId)
  if tips then
    Alert.ShowStr(LT.Text(tips))
  end
  return false
end

function CopyMainModel:SetExitBattleGroupTid(stageGroupId)
  self.exitBattleGroupTid = stageGroupId
end

function CopyMainModel:GetExitBattleGroupTid()
  return self.exitBattleGroupTid
end

return CopyMainModel
