local RedDotStageGroupAchievementTreeWork, Super = System.NewPoolClass("RedDotStageGroupAchievementTreeWork", RedDotSingleFlow)

function RedDotStageGroupAchievementTreeWork:ctor(args)
  Super.ctor(self, "关卡组成就")
  self.stageGroupTid = args.stageGroupTid
end

function RedDotStageGroupAchievementTreeWork:Execute()
  local curGroupData = CopyMainModel.Instance:GetGroupData(self.stageGroupTid)
  if not curGroupData or not curGroupData.stageList then
    return false
  end
  for _, stageData in ipairs(curGroupData.stageList) do
    if not stageData.achivement or not table.next(stageData.achivement) then
    else
      for stageId, achieveState in pairs(stageData.achivement) do
        if achieveState == cd.MainCopyAchieveState.IsFinish then
          return true
        end
      end
    end
  end
  return false
end

return RedDotStageGroupAchievementTreeWork
