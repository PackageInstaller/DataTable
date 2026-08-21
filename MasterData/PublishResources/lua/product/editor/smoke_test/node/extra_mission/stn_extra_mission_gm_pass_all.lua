require("common_async_base")
_class("ExtraMission_GM_PassAll", Common_AsyncBase)
ExtraMission_GM_PassAll = ExtraMission_GM_PassAll

function ExtraMission_GM_PassAll:TaskFunc(TT, status)
  self._manager:AsyncGM_CompleteAllExtTask(TT, status)
end
