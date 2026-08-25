local RedDotActivityLotteryWork, Super = System.NewPoolClass("RedDotActivityLotteryWork", RedDotSingleFlow)

function RedDotActivityLotteryWork:ctor(activityTid)
  Super.ctor(self, "活动奖池红点")
  self.activityTid = activityTid or {}
end

function RedDotActivityLotteryWork:Execute()
  local lotteryTidList = ActivityDataUtils.GetLotteryList(self.activityTid)
  if not table.next(lotteryTidList) then
    return false
  end
  for _, lotteryTid in ipairs(lotteryTidList) do
    local redTag = RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
    if redTag == RedPointDataUtils.RedAttrType.IsNew then
      return RedDotDefine.RedDotType.New
    end
  end
  for _, lotteryTid in ipairs(lotteryTidList) do
    local redTag = RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
    if redTag == RedPointDataUtils.RedAttrType.Red then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotActivityLotteryWork
