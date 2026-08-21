require("common_async_base")
_class("GM_PassLineCampMissionSingle", Common_AsyncBase)
GM_PassLineCampMissionSingle = GM_PassLineCampMissionSingle

function GM_PassLineCampMissionSingle:Constructor(_manager, componentID, missionID)
  self._componentID = componentID
  self._missionID = missionID
end

function GM_PassLineCampMissionSingle:TaskFunc(TT, status)
  self._manager:AsyncGM_PassLineCampMissionSingle(TT, status, self._componentID, self._missionID)
end
