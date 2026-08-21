_class("SvrTimeModule", GameModule)
SvrTimeModule = SvrTimeModule

function SvrTimeModule:Constructor()
  self.tmServerBase = 0
  self.tmClientBase = 0
  self.bHaveInit = false
end

function SvrTimeModule:Init()
  self:_InitServerTime(os.time())
end

function SvrTimeModule:_InitServerTime(serverTime)
  self.tmServerBase = serverTime * 1000
  self.tmClientBase = GameGlobal:GetInstance():GetCurrentRealTime()
end

function SvrTimeModule:InitServerTime(serverTime)
  self.nTimeIndex = 0
  local l_utc_time = os.date("!*%Y-%m-%d %H:%M:%S", t)
  Log.info("SvrTimeModule:InitServerTime Cur TimeStamp : ", serverTime, ", DateTime == ", l_utc_time)
  self:_InitServerTime(serverTime)
  self.bHaveInit = true
end

function SvrTimeModule:UpdateServerTime(serverTime)
  self:_InitServerTime(serverTime)
  self.bHaveInit = true
end

function SvrTimeModule:GetServerTime()
  local tmNow = GameGlobal:GetInstance():GetCurrentRealTime()
  return self.tmServerBase + (tmNow - self.tmClientBase)
end

function SvrTimeModule:Update(deltaTimeMS)
end
