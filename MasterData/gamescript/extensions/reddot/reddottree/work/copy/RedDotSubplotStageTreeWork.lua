local RedDotSubplotStageTreeWork, Super = System.NewPoolClass("RedDotSubplotStageTreeWork", RedDotStageNewTreeWork)

function RedDotSubplotStageTreeWork:ctor(args)
  Super.ctor(self, args)
  self.redDotDesc = "支线关卡"
end

function RedDotSubplotStageTreeWork:Execute()
  local stageTid = self.stageTid
  if not stageTid then
    return false
  end
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid)
  if not stageConfig then
    return false
  end
  local stageData = MainCopyDataUtils.GetStageData(stageTid)
  if stageData then
    if stageData.openTime and stageData.openTime > TimeUtils.GetServerTime() then
      return false
    end
    if not stageData.unlocked then
      return false
    end
  end
  local groupTid = stageConfig.BelongGroup
  local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(feature, groupTid)
  if not isUnlocked then
    return false
  end
  if not CopyDataUtils.CheckStageIsUnlocked(stageTid) then
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotSubplotStageTreeWork
