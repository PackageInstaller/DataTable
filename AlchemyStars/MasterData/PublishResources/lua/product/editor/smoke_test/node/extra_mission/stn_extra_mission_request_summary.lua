require("common_async_base")
_class("ExtraMission_RequestSummary", Common_AsyncBase)
ExtraMission_RequestSummary = ExtraMission_RequestSummary

function ExtraMission_RequestSummary:TaskFunc(TT, outResult)
  local extModule = GameGlobal.GetModule(ExtMissionModule)
  extModule:Request_GetSummary_All(TT)
end
