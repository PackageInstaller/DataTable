require("common_async_base")
_class("GM_ModifySvcTimeBias", Common_AsyncBase)
GM_ModifySvcTimeBias = GM_ModifySvcTimeBias

function GM_ModifySvcTimeBias:Constructor(_manager, timeSec)
  self._timeSec = timeSec
end

function GM_ModifySvcTimeBias:TaskFunc(TT, status)
  while GameGlobal.UIStateManager():IsLocked() do
    YIELD(TT)
  end
  self._manager:AsyncGM_ModifyAllSvcTimeBias(TT, status, self._timeSec)
end
