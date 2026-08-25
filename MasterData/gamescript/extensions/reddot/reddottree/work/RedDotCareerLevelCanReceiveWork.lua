local RedDotCareerLevelCanReceiveWork, Super = System.NewPoolClass("RedDotCareerLevelCanReceiveWork", RedDotSingleFlow)

function RedDotCareerLevelCanReceiveWork:ctor(careerLevelType)
  Super.ctor(self, "生涯等级奖励检查节点")
  self.careerLevelType = careerLevelType
end

function RedDotCareerLevelCanReceiveWork:Execute()
  for level = 1, DungeonTaskDataModel.Instance.maxLv do
    if CareerLevelModel.Instance:IsCareerLevelCanReceive(self.careerLevelType, level) then
      return RedDotDefine.RedDotType.Red
    end
  end
  return false
end

return RedDotCareerLevelCanReceiveWork
