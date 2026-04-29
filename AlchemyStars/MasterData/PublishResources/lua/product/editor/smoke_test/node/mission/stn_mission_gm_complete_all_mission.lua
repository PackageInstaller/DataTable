require("common_async_base")
_class("Mission_Cheat_CompleteAllMission", Common_AsyncBase)
Mission_Cheat_CompleteAllMission = Mission_Cheat_CompleteAllMission

function Mission_Cheat_CompleteAllMission:TaskFunc(TT, status)
  self._manager:AsyncGM_CompleteAllMission(TT, status)
end
