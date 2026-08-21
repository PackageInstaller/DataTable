require("common_async_base")
_class("GM_PassMultiLineCampMission", Common_AsyncBase)
GM_PassMultiLineCampMission = GM_PassMultiLineCampMission

function GM_PassMultiLineCampMission:Constructor(_manager, componentID, missionID)
  self._componentID = componentID
  self._missionID = missionID
end

function GM_PassMultiLineCampMission:TaskFunc(TT, status)
  self._manager:AsyncGM_PassMultiLineCampMission(TT, status, self._componentID, self._missionID)
end
