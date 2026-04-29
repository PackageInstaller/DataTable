require("common_async_base")
_class("GM_PassLineCampMission", Common_AsyncBase)
GM_PassLineCampMission = GM_PassLineCampMission

function GM_PassLineCampMission:Constructor(_manager, componentID, missionID)
  self._componentID = componentID
  self._missionID = missionID
end

function GM_PassLineCampMission:TaskFunc(TT, status)
  self._manager:AsyncGM_PassLineCampMission(TT, status, self._componentID, self._missionID)
end
