_class("BuffLogicSeasonMazeAddRelicCounter", BuffLogicBase)
BuffLogicSeasonMazeAddRelicCounter = BuffLogicSeasonMazeAddRelicCounter

function BuffLogicSeasonMazeAddRelicCounter:Constructor(buffInstance, logicParam)
  self._relicID = logicParam.relicID or 0
end

function BuffLogicSeasonMazeAddRelicCounter:DoLogic()
  local svc = self._world:GetService("SeasonMaze")
  svc:AddRelicCounter(self._relicID)
end
