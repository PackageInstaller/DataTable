_class("BuffLogicAddAlchemyLevelMax", BuffLogicBase)
BuffLogicAddAlchemyLevelMax = BuffLogicAddAlchemyLevelMax

function BuffLogicAddAlchemyLevelMax:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddAlchemyLevelMax:DoLogic(notify)
  local boardEntity = self._world:GetBoardEntity()
  local logicFeatureCmpt = boardEntity:LogicFeature()
  if not logicFeatureCmpt then
    return
  end
  local curLevelMax = logicFeatureCmpt:GetAlchemyLevelMax()
  curLevelMax = curLevelMax + self._addValue
  logicFeatureCmpt:SetAlchemyLevelMax(curLevelMax)
end
