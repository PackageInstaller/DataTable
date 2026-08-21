_class("TimeBaseService", BaseService)
TimeBaseService = TimeBaseService

function TimeBaseService:Constructor(world)
  self._FrameRate = 30
  self._DeltaTime = 1 / self._FrameRate
  self._DeltaTimeMS = self._DeltaTime * 1000
  self._CurTimeMS = 0
end

function TimeBaseService:GetDeltaTime()
  return self._DeltaTime
end

function TimeBaseService:GetDeltaTimeMs()
  return self._DeltaTimeMS
end

function TimeBaseService:GetCurrentTimeMs()
  return self._CurTimeMS
end
