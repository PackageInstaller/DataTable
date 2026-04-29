_class("BuffLogicAddSeasonMazeRelicCounter", BuffLogicBase)
BuffLogicAddSeasonMazeRelicCounter = BuffLogicAddSeasonMazeRelicCounter

function BuffLogicAddSeasonMazeRelicCounter:Constructor(buffInstance, logicParam)
  self._relicID = logicParam.relicID or 0
end

function BuffLogicAddSeasonMazeRelicCounter:DoLogic()
  local svc = self._world:GetService("SeasonMaze")
  svc:AddRelicCount(self._relicID)
end
