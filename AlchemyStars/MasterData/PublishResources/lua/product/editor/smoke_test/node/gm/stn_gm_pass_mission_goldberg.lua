require("common_async_base")
_class("GM_PassMissionGoldberg", Common_AsyncBase)
GM_PassMissionGoldberg = GM_PassMissionGoldberg

function GM_PassMissionGoldberg:Constructor(_manager)
end

function GM_PassMissionGoldberg:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local missionID = runData:GetMissionID()
  self._manager:AsyncGM_PassLineCampMission(TT, status, componentID, missionID)
  self._manager:AsyncGM_PassMultiLineCampMission(TT, status, componentID, missionID)
end
