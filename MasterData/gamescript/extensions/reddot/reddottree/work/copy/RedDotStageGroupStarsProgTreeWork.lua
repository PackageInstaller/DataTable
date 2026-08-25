local RedDotStageGroupStarsProgTreeWork, Super = System.NewPoolClass("RedDotStageGroupStarsProgTreeWork", RedDotSingleFlow)

function RedDotStageGroupStarsProgTreeWork:ctor(args)
  Super.ctor(self, "关卡组星级奖励")
  self.stageGroupTid = args.stageGroupTid
end

function RedDotStageGroupStarsProgTreeWork:Execute()
  local curGroupData = CopyMainModel.Instance:GetGroupData(self.stageGroupTid)
  if not curGroupData or not curGroupData.starGainInfo then
    return false
  end
  local stageGroupCfg = DT.StageGroup[self.stageGroupTid]
  if not stageGroupCfg or not stageGroupCfg.StageGroupDrop then
    return false
  end
  local progressDrops = stageGroupCfg.StageGroupDrop
  local starGainInfo = curGroupData.starGainInfo
  local star = MainCopyDataUtils.GetStageGroupCurStar(self.stageGroupTid)
  for i = 1, #progressDrops, 2 do
    local needStar = progressDrops[i]
    local isAttach = star >= needStar
    local isGet = starGainInfo and starGainInfo[needStar] or false
    if isAttach and false == isGet then
      return true
    end
  end
  return false
end

return RedDotStageGroupStarsProgTreeWork
