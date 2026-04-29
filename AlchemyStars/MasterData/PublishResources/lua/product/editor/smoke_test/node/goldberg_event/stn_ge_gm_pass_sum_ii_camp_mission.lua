require("common_async_base")
_class("GoldbergEvent_GM_PassSumIICampMission", Common_AsyncBase)
GoldbergEvent_GM_PassSumIICampMission = GoldbergEvent_GM_PassSumIICampMission

function GoldbergEvent_GM_PassSumIICampMission:Constructor(_, cmptID, lastMissionID)
  self._cmptID = cmptID
  self._lastMissionID = lastMissionID
end

function GoldbergEvent_GM_PassSumIICampMission:TaskFunc(TT, outResult)
  self._manager:AsyncGM_PassSumIICampMission(TT, outResult, self._cmptID, self._lastMissionID)
end
