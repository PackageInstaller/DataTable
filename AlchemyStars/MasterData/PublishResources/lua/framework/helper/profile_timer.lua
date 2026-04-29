_class("ProfileTimer", Singleton)
ProfileTimer = ProfileTimer

function ProfileTimer:Constructor()
  self._startTime = 0
  self._stamps = {}
end

function ProfileTimer:ResetAndStart()
  self._startTime = os.clock() * 1000
  self._stamps = {}
end

function ProfileTimer:TakeStamp(desc, output)
  local currentTimeStamp = os.clock() * 1000 - self._startTime
  local stampInfo = "[ProfileTimer] " .. " frame:" .. GameGlobal:GetInstance():GetCurrentFrameCount() .. "  " .. desc .. " from start:" .. currentTimeStamp
  if #self._stamps > 0 then
    stampInfo = stampInfo .. " from last:" .. currentTimeStamp - self._stamps[#self._stamps][2]
    self._stamps[#self._stamps + 1] = {stampInfo, currentTimeStamp}
  else
    self._stamps[1] = {stampInfo, currentTimeStamp}
  end
  if output then
    Log.fatal(stampInfo)
  end
end

function ProfileTimer:OutputStamps()
  for i = 1, #self._stamps do
    Log.fatal(self._stamps[i][1])
  end
end
