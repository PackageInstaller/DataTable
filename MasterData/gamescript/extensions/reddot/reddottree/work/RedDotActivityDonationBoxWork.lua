local RedDotActivityDonationBoxWork, Super = System.NewPoolClass("RedDotActivityDonationBoxWork", RedDotSingleFlow)

function RedDotActivityDonationBoxWork:ctor(activityTid)
  Super.ctor(self, "奖池箱奖励")
  self.activityTid = activityTid
end

function RedDotActivityDonationBoxWork:Execute()
  local produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  if not produceTid then
    return false
  end
  if RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.ProduceBox, {produceTid}) then
    return RedDotDefine.RedDotType.New
  end
  if RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.DonationBox, {produceTid}) then
    return RedDotDefine.RedDotType.Red
  end
end

return RedDotActivityDonationBoxWork
