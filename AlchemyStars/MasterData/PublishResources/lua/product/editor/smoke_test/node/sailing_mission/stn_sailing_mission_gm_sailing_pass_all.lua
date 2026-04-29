require("common_async_base")
_class("SailingMission_GM_SailingPassAll", Common_AsyncBase)
SailingMission_GM_SailingPassAll = SailingMission_GM_SailingPassAll

function SailingMission_GM_SailingPassAll:TaskFunc(TT, status)
  self._manager:AsyncGM_SailingPassAll(TT, status)
end
