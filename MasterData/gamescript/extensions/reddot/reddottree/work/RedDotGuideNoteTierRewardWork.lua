local RedDotGuideNoteTierRewardWork, Super = System.NewPoolClass("RedDotGuideNoteTierRewardWork", RedDotSingleFlow)

function RedDotGuideNoteTierRewardWork:ctor(show)
  Super.ctor(self, "密境手记活跃度奖励节点")
  self.show = true == show
end

function RedDotGuideNoteTierRewardWork:Execute()
  if self.show then
    return RedDotDefine.RedDotType.Red
  end
  return nil
end

return RedDotGuideNoteTierRewardWork
