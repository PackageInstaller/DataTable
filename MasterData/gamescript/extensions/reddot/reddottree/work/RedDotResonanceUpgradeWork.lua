local RedDotResonanceUpgradeWork, Super = System.NewClass("RedDotResonanceUpgradeWork", RedDotSingleFlow)

function RedDotResonanceUpgradeWork:ctor(resonanceGroupId, activityTid)
  Super.ctor(self, "共鸣组可升级")
  self.resonanceGroupId = resonanceGroupId
  self.activityTid = activityTid
end

function RedDotResonanceUpgradeWork:Execute()
  if not self.resonanceGroupId then
    return false
  end
  return RedPointDataUtils.IsMainStageResonanceShow(self.resonanceGroupId, nil, self.activityTid) and RedDotDefine.RedDotType.Red or false
end

return RedDotResonanceUpgradeWork
