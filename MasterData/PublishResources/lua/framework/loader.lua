local oldloader = GroupLoader.New

local function callFinish(ldr)
  if ldr.__mdelay then
    Timer.del(ldr.__mdelay)
  end
  if ldr.__delay then
    Timer.del(ldr.__delay)
  end
  local fincall = ldr.__fincall
  if not fincall then
    return
  end
  for ii = 1, #fincall do
    fincall[ii]()
  end
  ldr.__fincall = nil
end

local function maxTime(ldr, t)
  ldr.__max = t + 30
  ldr.__startt = ldr.__startt or os.time()
  ldr.__mdelay = Timer.add(t + (ldr.__startt - _now()), function()
    ldr.__mdelay = nil
    callFinish(ldr)
  end)
end

local function leastTime(ldr, t)
  ldr.__least = t + 30
  ldr.__startt = ldr.__startt or os.time()
  ldr.__delay = GameGlobal.Timer():AddEventTimes(t + (ldr.__startt - _now()), TimerTriggerCount.Once, function()
    ldr.__delay = nil
    if ldr.__finished then
      callFinish(ldr)
    end
  end)
end

local function OnFinish(ldr, fincall)
  ldr.__fincall = ldr.__fincall or {}
  table.insert(ldr.__fincall, fincall)
  local onfinish = ldr.__onFinish
  if onfinish then
    onfinish(ldr.loader, function()
      ldr.__finished = true
      if not ldr.__delay then
        callFinish(ldr)
      end
    end)
    ldr.__onFinish = nil
  end
end

local function onProgress(ldr, procall)
  ldr.__procall = procall
  ldr:__onProgress(function(percent)
    ldr.__procall(ldr:GetProgress())
  end)
end

local function smooth(ldr)
  ldr.__smooth = true
end

local function GetProgress(ldr)
  local leastt = ldr.__least
  local progress = ldr.__GetProgress(ldr.loader)
  local maxt = ldr.__max
  local minpro
  local nowt = os.time()
  if maxt then
    minpro = (nowt - ldr.__startt) / maxt
  end
  if not leastt then
    return math.max(minpro or 0, progress)
  end
  return math.max(minpro or 0, math.min(progress, (nowt - ldr.__startt) / leastt))
end

local function stop(ldr)
  local delay = ldr.__delay
  if delay then
    Timer.del(delay)
  end
  ldr.__stop(ldr)
end

local function safeload(self, ...)
  if CatchResError then
    return self.__loadAsync(self.loader, ...)
  else
    local ok, err = pcall(self.__loadAsync, self.loader, ...)
    if ok then
      return err
    end
  end
end

local function safeloadSync(self, ...)
  if CatchResError then
    return self.__loadSync(self.loader, ...)
  else
    local ok, err = pcall(self.__loadSync, self.loader, ...)
    if ok then
      return err
    end
  end
end

local function UnLoad(self, ...)
  self.__UnLoad(self.loader, ...)
end

local function BeginRecord(self)
  self.__BeginRecord(self.loader)
end

local function EndRecord(self)
  self.__EndRecord(self.loader)
end

local function Dispose(self)
  self.__Dispose(self.loader)
end

function GroupLoader:New(name)
  if not PUBLIC and not name then
    name = debug.traceback()
  end
  local loader = oldloader(self, name or "empty")
  local instance = {}
  instance.__name = name
  if not PUBLIC then
    instance.__trace = debug.traceback("GroupLoader.new")
  end
  instance.leastTime = leastTime
  instance.maxTime = maxTime
  instance.smooth = smooth
  instance.__onFinish = loader.OnFinish
  instance.OnFinish = OnFinish
  instance.__GetProgress = loader.GetProgress
  instance.GetProgress = GetProgress
  instance.__loadAsync = loader.LoadAsync
  instance.LoadAsync = safeload
  instance.__loadSync = loader.LoadSync
  instance.LoadSync = safeloadSync
  instance.__UnLoad = loader.UnLoad
  instance.UnLoad = UnLoad
  instance.__BeginRecord = loader.BeginRecord
  instance.BeginRecord = BeginRecord
  instance.__EndRecord = loader.EndRecord
  instance.EndRecord = EndRecord
  instance.__Dispose = loader.Dispose
  instance.Dispose = Dispose
  instance.loader = loader
  return instance
end

function LoadAsync(TT, name, loadType, loader)
  local outLoader = true
  if not loader then
    loader = GroupLoader:New()
    outLoader = false
  end
  local request = loader:LoadAsync(name, loadType)
  local id = GetCurTaskId()
  loader:OnFinish(function()
    if not outLoader then
      loader:Dispose()
    end
    RESUME(TT, id)
  end)
  if not loader.__finished then
    SUSPEND(TT)
  end
  return request
end
