require("skill_effect_result_base")
_class("SkillEffectRefreshGridByBoardIDResult", SkillEffectResultBase)
SkillEffectRefreshGridByBoardIDResult = SkillEffectRefreshGridByBoardIDResult

function SkillEffectRefreshGridByBoardIDResult:Constructor()
  self._gridPieceData = nil
  self._destroyTrapEntityIDList = {}
  self._sceneChangeTimes = 0
end

function SkillEffectRefreshGridByBoardIDResult:GetEffectType()
  return SkillEffectType.RefreshGridByBoardID
end

function SkillEffectRefreshGridByBoardIDResult:SetGridPieceData(gridPieceData)
  self._gridPieceData = gridPieceData
end

function SkillEffectRefreshGridByBoardIDResult:GetGridPieceData()
  return self._gridPieceData
end

function SkillEffectRefreshGridByBoardIDResult:AddDestroyTrapEntityIDList(entityID)
  table.insert(self._destroyTrapEntityIDList, entityID)
end

function SkillEffectRefreshGridByBoardIDResult:GetDestroyTrapEntityIDList()
  return self._destroyTrapEntityIDList
end

function SkillEffectRefreshGridByBoardIDResult:SetSceneChangeTimes(changeTimes)
  self._sceneChangeTimes = changeTimes
end

function SkillEffectRefreshGridByBoardIDResult:GetSceneChangeTimes()
  return self._sceneChangeTimes
end
