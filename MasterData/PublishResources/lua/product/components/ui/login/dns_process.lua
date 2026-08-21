_enum("DncRes", {Success = 0, RepeatFailed = 1})
_class("DnsProcess", Object)
DnsProcess = DnsProcess

function DnsProcess:Constructor()
  self.cacheMap = {}
  self.ipString = ""
  self.paring = false
  self.timeNum = 0
  self.sdkTime = 2000
  self.timeMax = 25
  self.timeOut = 100
  if self.timeMax * self.timeOut <= self.sdkTime then
    Log.error("DnsProcess timeout error")
  end
end

function DnsProcess:AnalysisIP(TT, ipStr)
  Log.debug("[dns] ", "Analysis ip:{", ipStr, "}")
  if self.cacheMap[ipStr] ~= nil then
    return self.cacheMap[ipStr]
  end
  if self:IsIP(ipStr) == true then
    return ipStr
  end
  self.paring = true
  self.ipString = ""
  Log.debug("[dns] ", "Analysis start ip:{", ipStr, "}")
  CustomHttpDnsService.GetAddrByName(ipStr, function(str, eCode)
    Log.debug("[dns] ", "Analysis result ip:{", str, "}")
    if eCode == DncRes.RepeatFailed then
      Log.debug("[dns] ", "Analysis repeat ip")
      return
    end
    self.ipString = str
    self.paring = false
  end)
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum >= self.timeMax then
      self.paring = false
    end
    YIELD(TT, self.timeOut)
  end
  if self.ipString == "" then
    self.ipString = CustomHttpDnsService.AgainAnalysis(ipStr)
  end
  Log.debug("[dns] ", "Analysis end ip:{", self.ipString, "}")
  return self.ipString
end

function DnsProcess:IsIP(ipStr)
  return CustomHttpDnsService.Ip4or6IsValid(ipStr)
end

function DnsProcess:ParseResult(ipStr)
  if self:IsIP(ipStr) == true then
    return ipStr
  end
  local point = string.find(ipStr, ";", 1)
  if point == nil then
    return ""
  end
  local len = string.len(ipStr)
  local gapstr = string.sub(ipStr, 1, point - 1)
  if gapstr == "0" then
    gapstr = string.sub(ipStr, point + 1, len)
    if gapstr == "0" then
      return ""
    end
  end
  return gapstr
end
