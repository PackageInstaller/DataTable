require("time_base_service")
_class("ClientTimeService", TimeBaseService)
ClientTimeService = ClientTimeService

function ClientTimeService:SetCurrentTime(curTimeMS)
  self._CurTimeMS = curTimeMS
end

function ClientTimeService:SetDeltaTime(deltaTimeMS)
  self._DeltaTimeMS = deltaTimeMS
  self._DeltaTime = deltaTimeMS / 1000
end
