require("base_state_node")
_class("GoldbergEvent_GM_PassTreeCampMission", Common_AsyncBase)
GoldbergEvent_GM_PassTreeCampMission = GoldbergEvent_GM_PassTreeCampMission

function GoldbergEvent_GM_PassTreeCampMission:Constructor(_, cmptID, lastMissionID)
  self._cmptID = cmptID
  self._lastMissionID = lastMissionID
end

function GoldbergEvent_GM_PassTreeCampMission:TaskFunc(TT, outResult)
  self._manager:AsyncGM_PassTreeCampMission(TT, outResult, self._cmptID, self._lastMissionID)
end
