local TimerManager = require("GameCore.Timer.TimerManager")
local GuideStepRunner = {}
GuideStepRunner.__index = GuideStepRunner
local nDefaultSystemTimeout = 3
local nPlayerSkipDelay = 20
local nEventPollInterval = 0.1

local function Guard(fn, ...)
  if fn == nil then
    return true
  end
  return xpcall(fn, debug.traceback, ...)
end

function GuideStepRunner.Start(objParent, objGroup)
  local obj = setmetatable({}, GuideStepRunner)
  objParent._objStepRunner = obj
  obj:_Start(objParent, objGroup)
  return obj
end

function GuideStepRunner:_Start(objParent, objGroup)
  self._objParent = objParent
  self._objGroup = objGroup
  self._nGroupId = objGroup.nGroupId
  self._nGuideType = objGroup.nGuideType or AllEnum.GuideType.Dorm
  self._bNeedCheckpoint = objGroup.bNeedCheckpoint == true
  self._nGroupGen = 1
  self._nStepGen = 0
  self._nPresentGen = 0
  self._nConfirmGen = 0
  self._bStopped = false
  self._bExiting = false
  self._bReported = false
  self._bInTick = false
  self._bDirty = false
  self._tbListen = {}
  self._mapCtx = {
    mapData = {},
    nGroupId = self._nGroupId
  }
  
  function self._mapCtx.Set(mapCtx, sKey, anyVal)
    mapCtx.mapData[sKey] = anyVal
  end
  
  function self._mapCtx.Get(mapCtx, sKey)
    return mapCtx.mapData[sKey]
  end
  
  local ok, tbSteps = Guard(objGroup.GetSteps, objGroup)
  if not ok or type(tbSteps) ~= "table" or #tbSteps == 0 then
    printError("[DormGuide] GetSteps 失败 group=" .. tostring(self._nGroupId))
    self:Stop("abort", false)
    return
  end
  self._tbSteps = tbSteps
  self._nIndex = 1
  if objGroup.OnStart ~= nil then
    local bOk = Guard(objGroup.OnStart, objGroup, self._mapCtx)
    if not bOk or self._bStopped then
      if not self._bStopped then
        self:Stop("abort", false)
      end
      return
    end
  end
  self:_BeginStep()
end

function GuideStepRunner:_Alive(nGroup, nStep, nPresent)
  if self._bStopped or self._bExiting then
    return false
  end
  if nGroup ~= nil and nGroup ~= self._nGroupGen then
    return false
  end
  if nStep ~= nil and nStep ~= self._nStepGen then
    return false
  end
  if nPresent ~= nil and nPresent ~= self._nPresentGen then
    return false
  end
  return true
end

function GuideStepRunner:_Call(fn, ...)
  local ok, a, b = Guard(fn, ...)
  if not ok then
    printError("[DormGuide] group=" .. tostring(self._nGroupId) .. " step=" .. tostring(self._nIndex) .. " phase=" .. tostring(self._sPhase) .. "\n" .. tostring(a))
    return false
  end
  return true, a, b
end

function GuideStepRunner:_CancelTick()
  if self._objTick ~= nil then
    TimerManager.Remove(self._objTick)
    self._objTick = nil
  end
end

function GuideStepRunner:_ArmTick(nInterval, fn)
  if self._bStopped or self._bCompleting and fn == nil then
    return
  end
  self:_CancelTick()
  local nGroup = self._nGroupGen
  local nStep = self._nStepGen
  local timer
  timer = TimerManager.Add(1, nInterval, self, function()
    timer:Cancel(false)
    if self._objTick == timer then
      self._objTick = nil
    end
    if self._bStopped or self._nGroupGen ~= nGroup or self._nStepGen ~= nStep then
      return
    end
    if fn ~= nil then
      fn()
    else
      self:_Tick()
    end
  end, true, true, true, nil)
  self._objTick = timer
end

function GuideStepRunner:_Schedule(fn)
  self:_ArmTick(0, fn)
end

function GuideStepRunner:_Wake()
  if self._bStopped or self._bExiting or self._bCompleting or self._bActionRunning then
    return
  end
  if self._bInTick then
    self._bDirty = true
    return
  end
  self:_Tick()
end

function GuideStepRunner:_UnbindStep()
  for sName, fn in pairs(self._tbListen) do
    EventManager.Remove(sName, self, fn)
  end
  self._tbListen = {}
end

function GuideStepRunner:_Bind(sName)
  if sName == nil or self._tbListen[sName] ~= nil then
    return
  end
  local nGroup, nStep = self._nGroupGen, self._nStepGen
  
  local function fn(_, ...)
    if self:_Alive(nGroup, nStep) then
      self:_OnEvent(sName, ...)
    end
  end
  
  self._tbListen[sName] = fn
  EventManager.Add(sName, self, fn)
end

function GuideStepRunner:_BindList(tbName)
  if tbName == nil then
    return
  end
  for _, sName in ipairs(tbName) do
    self:_Bind(sName)
  end
end

function GuideStepRunner:_OnEvent(sName, ...)
  if self._bStopped or self._bExiting then
    return
  end
  local step = self._mapStep
  if step == nil then
    return
  end
  local bCare = false
  local tbArg = table.pack(...)
  
  local function Match(mapWait)
    if mapWait == nil or mapWait.Events == nil then
      return false
    end
    for _, sWait in ipairs(mapWait.Events) do
      if sWait == sName then
        if mapWait.Match ~= nil then
          local ok, bHit = self:_Call(mapWait.Match, self._mapCtx, table.unpack(tbArg, 1, tbArg.n))
          return ok and bHit == true
        end
        return true
      end
    end
    return false
  end
  
  if Match(step.WaitTrigger) or Match(step.Present) or Match(step.End) or Match(step.Prepare) or Match(step.Start) then
    bCare = true
  end
  if step.tbHint ~= nil then
    for _, sHint in ipairs(step.tbHint) do
      if sHint == sName then
        bCare = true
      end
    end
  end
  if not bCare then
    return
  end
  self:_Wake()
end

function GuideStepRunner:_Now()
  return TimerManager.GetUnscaledTime()
end

function GuideStepRunner:_Frozen()
  if self._objParent ~= nil and self._objParent.IsRunnerBudgetFrozen ~= nil then
    return self._objParent:IsRunnerBudgetFrozen()
  end
  return false
end

function GuideStepRunner:_TimeoutReached(nStart, nLimit)
  if nLimit == nil or nLimit <= 0 then
    return false
  end
  if not self:_IsPlayerWait() and self:_Frozen() then
    if not self._bFrozen then
      self._bFrozen = true
      self._nFreezeAt = self:_Now()
    end
    return false
  end
  if self._bFrozen then
    self._nStartShift = (self._nStartShift or 0) + (self:_Now() - (self._nFreezeAt or self:_Now()))
    self._bFrozen = false
  end
  local nStartUse = nStart + (self._nStartShift or 0)
  return nLimit <= self:_Now() - nStartUse
end

function GuideStepRunner:_SetPhase(sPhase)
  if self._sPhase == sPhase then
    return
  end
  if not self._bCompleting then
    self:_CancelTick()
  end
  self._sPhase = sPhase
  self._nConfirmGen = self._nConfirmGen + 1
  self._bSkipAsking = false
  self._objParent:CloseRunnerSkip()
  self._nMiss = 0
  self:_ResetBudget()
end

function GuideStepRunner:_IsPlayerWait()
  local step = self._mapStep
  if step == nil then
    return false
  end
  if self._sPhase == "trigger" then
    return step.WaitTrigger ~= nil and step.WaitTrigger.bPlayerWait == true
  end
  if self._sPhase ~= "end" then
    return false
  end
  local sKind = step.Present ~= nil and step.Present.sKind or "None"
  if sKind == "Mask" then
    return not self._bClickUsed
  end
  return step.bPlayerWait == true
end

function GuideStepRunner:_NextMissInterval()
  self._nMiss = (self._nMiss or 0) + 1
  if self._nMiss <= 3 then
    return 0
  end
  local nInterval = 0.05
  local nPow = self._nMiss - 3
  for _ = 2, nPow do
    nInterval = nInterval * 2
    if nInterval >= nEventPollInterval then
      return nEventPollInterval
    end
  end
  return nInterval
end

function GuideStepRunner:_HoldForEvent(mapWait)
  local nInterval = nEventPollInterval
  if mapWait == nil then
    nInterval = math.min(self:_NextMissInterval(), nEventPollInterval)
  elseif mapWait.Interval ~= nil then
    nInterval = mapWait.Interval
  end
  self:_ArmTick(nInterval, nil)
end

function GuideStepRunner:_ResetBudget()
  self._nBudgetStart = self:_Now()
  self._nStartShift = 0
  self._bFrozen = false
  self._bSkipAvailable = false
  if self._objParent ~= nil then
    self._objParent:SetRunnerSkipVisible(false)
  end
end

function GuideStepRunner:_BudgetHit(nLimit)
  if self:_IsPlayerWait() then
    if not self._bSkipAvailable and self:_TimeoutReached(self._nBudgetStart or self:_Now(), nPlayerSkipDelay) then
      self._bSkipAvailable = true
      self._objParent:SetRunnerSkipVisible(true)
    end
    return false
  end
  return self:_TimeoutReached(self._nBudgetStart or self:_Now(), nLimit)
end

function GuideStepRunner:_ApplyPolicy(sStage)
  local step = self._mapStep
  if step == nil or step.InputPolicy == nil or self._objParent == nil then
    return
  end
  local mapPolicy = step.InputPolicy
  if type(mapPolicy) == "function" then
    local ok, mapRet = self:_Call(mapPolicy, self._mapCtx, sStage)
    mapPolicy = ok and mapRet or nil
  elseif mapPolicy.enter ~= nil or mapPolicy.click ~= nil or mapPolicy.present ~= nil or mapPolicy.request ~= nil then
    mapPolicy = mapPolicy[sStage]
  end
  if mapPolicy ~= nil and self._objParent.ApplyRunnerPolicy ~= nil then
    self._objParent:ApplyRunnerPolicy(mapPolicy)
  end
end

function GuideStepRunner:_Decide()
  local step = self._mapStep
  if step.ShouldRun == nil then
    return "run"
  end
  local ok, sRet = self:_Call(step.ShouldRun, self._mapCtx)
  if not ok then
    return "abort"
  end
  if sRet ~= "run" and sRet ~= "skip" and sRet ~= "abort" and sRet ~= "finish" then
    return "run"
  end
  return sRet
end

function GuideStepRunner:_LeaveByDecide(sDecide)
  if sDecide == "skip" then
    self:_FinishStep("skip")
    return true
  end
  if sDecide == "abort" then
    self:_FinishStep("abort")
    return true
  end
  if sDecide == "finish" then
    self:_FinishStep("finish")
    return true
  end
  return false
end

function GuideStepRunner:_CacheValid()
  local tr = self._trCache
  if tr == nil or tr == false then
    return false
  end
  if tr.gameObject == nil then
    return false
  end
  local step = self._mapStep
  if step.CacheValid ~= nil then
    local ok, bOk = self:_Call(step.CacheValid, self._mapCtx, tr, self._mapCacheId)
    if not ok or bOk ~= true then
      return false
    end
  end
  return true
end

function GuideStepRunner:_DropCache()
  self._trCache = nil
  self._mapCacheId = nil
end

function GuideStepRunner:_StorePoll(anyRet)
  if anyRet == false then
    return "fail"
  end
  if anyRet == nil then
    self:_DropCache()
    return "miss"
  end
  self._trCache = anyRet
  local step = self._mapStep
  if step.CacheId ~= nil then
    local ok, mapId = self:_Call(step.CacheId, self._mapCtx, anyRet)
    self._mapCacheId = ok and mapId or nil
  else
    self._mapCacheId = {
      nInst = anyRet.gameObject ~= nil and anyRet.gameObject:GetInstanceID() or 0
    }
  end
  if not self:_CacheValid() then
    self:_DropCache()
    return "miss"
  end
  return "hit"
end

function GuideStepRunner:_PollOnce()
  local step = self._mapStep
  if step.Poll == nil then
    return "none"
  end
  local ok, anyRet = self:_Call(step.Poll, self._mapCtx)
  if not ok then
    return "fail"
  end
  return self:_StorePoll(anyRet)
end

function GuideStepRunner:_BeginStep()
  if self._bStopped then
    return
  end
  if self._nIndex > #self._tbSteps then
    local bReport = not self._bNeedCheckpoint or self._bReported
    self:Stop("finish", bReport)
    return
  end
  self._bExiting = false
  self._bCompleting = false
  self._nStepGen = self._nStepGen + 1
  self._nPresentGen = 0
  self._nOpId = 0
  self._bPreFindDone = false
  self._bEntered = false
  self._bPrepared = false
  self._bPreparing = false
  self._sPrepareVer = nil
  self._bPresented = false
  self._bStepExited = false
  self._bActionRunning = false
  self._bSkipAsking = false
  self._bClickUsed = false
  self._nMiss = 0
  self:_DropCache()
  self:_ResetBudget()
  self._mapStep = self._tbSteps[self._nIndex]
  local mapEnd = self._mapStep.End
  if mapEnd ~= nil and (mapEnd.sMode == "Event" or mapEnd.sMode == "Condition") and type(mapEnd.Ready) ~= "function" then
    printError("[DormGuide] End.Ready 未配置 group=" .. tostring(self._nGroupId) .. " step=" .. tostring(self._nIndex))
    self:Stop("abort", false)
    return
  end
  self._sPhase = "decide"
  local step = self._mapStep
  self:_UnbindStep()
  self:_BindList(step.tbHint)
  if step.WaitTrigger ~= nil then
    self:_BindList(step.WaitTrigger.Events)
  end
  if step.Present ~= nil then
    self:_BindList(step.Present.Events)
  end
  if step.End ~= nil then
    self:_BindList(step.End.Events)
  end
  if step.Prepare ~= nil then
    self:_BindList(step.Prepare.Events)
  end
  if step.Start ~= nil then
    self:_BindList(step.Start.Events)
    self._sPhase = "start"
    print("[DormGuide] " .. tostring(self._nGroupId) .. " wait start " .. tostring(step.sName))
  else
    print("[DormGuide] " .. tostring(self._nGroupId) .. " step " .. tostring(self._nIndex) .. " " .. tostring(step.sName))
  end
  self:_Wake()
end

function GuideStepRunner:_SystemLimit(mapWait)
  if mapWait ~= nil and mapWait.Timeout ~= nil then
    return mapWait.Timeout
  end
  local step = self._mapStep
  if step ~= nil and step.nSystemTimeout ~= nil then
    return step.nSystemTimeout
  end
  return nDefaultSystemTimeout
end

function GuideStepRunner:_OnWaitTimeout(mapWait)
  printError("[DormGuide] timeout group=" .. tostring(self._nGroupId) .. " step=" .. tostring(self._nIndex) .. " name=" .. tostring(self._mapStep.sName) .. " phase=" .. tostring(self._sPhase) .. " limit=" .. tostring(self:_SystemLimit(mapWait)) .. " reported=" .. tostring(self._bReported))
  self:_FinishStep("abort")
end

function GuideStepRunner:_Tick()
  if not self:_Alive() or self._bCompleting then
    return
  end
  self._bInTick = true
  local nGuard = 0
  while self:_Alive() and not self._bCompleting and nGuard < 16 do
    nGuard = nGuard + 1
    local sBefore = self._sPhase
    local ok, bWait = self:_Call(self._RunPhase, self)
    if not ok and self:_Alive() then
      self:_FinishStep("abort")
    end
    if not self:_Alive() or bWait or self._sPhase == sBefore then
      break
    end
  end
  self._bInTick = false
  if 16 <= nGuard and self:_Alive() and not self._bCompleting then
    self._bDirty = true
  end
  if self._bDirty and self:_Alive() then
    self._bDirty = false
    if not self._bCompleting then
      self:_Schedule()
    end
  end
end

function GuideStepRunner:_RunPhase()
  local sPhase = self._sPhase
  if sPhase == "decide" or sPhase == "show" then
    if self:_LeaveByDecide(self:_Decide()) then
      return true
    end
    if sPhase == "decide" then
      if self._mapStep.Poll ~= nil and not self._bPreFindDone then
        self._sPhase = "prefind"
      else
        self._sPhase = "enter"
      end
    else
      self:_SetPhase("presentReady")
    end
    return false
  end
  if sPhase == "prefind" then
    self._bPreFindDone = true
    local sRet = self:_PollOnce()
    if sRet == "fail" then
      self:_OnFail("poll")
      return true
    end
    self._sPhase = "enter"
    return false
  end
  if sPhase == "enter" then
    if not self._bEntered then
      self:_ApplyPolicy("enter")
    end
    if not self._bEntered and self._mapStep.OnEnter ~= nil then
      local ok = self:_Call(self._mapStep.OnEnter, self._mapCtx)
      if not ok or not self:_Alive() then
        if self:_Alive() then
          self:_FinishStep("abort")
        end
        return true
      end
    end
    self._bEntered = true
    if self._mapStep.Prepare ~= nil then
      self:_SetPhase("prepare")
    else
      self:_SetPhase("trigger")
    end
    return false
  end
  if sPhase == "prepare" then
    return self:_RunPrepare()
  end
  if sPhase == "start" then
    return self:_RunStart()
  end
  if sPhase == "trigger" then
    return self:_RunTrigger()
  end
  if sPhase == "find" then
    return self:_RunFind()
  end
  if sPhase == "presentReady" then
    return self:_RunPresentReady()
  end
  if sPhase == "present" then
    return self:_RunPresent()
  end
  if sPhase == "end" or sPhase == "request" then
    return self:_RunEnd()
  end
  return true
end

function GuideStepRunner:_RunStart()
  local mapStart = self._mapStep.Start
  local bReady = true
  if mapStart ~= nil and mapStart.Ready ~= nil then
    local ok, bRet = self:_Call(mapStart.Ready, self._mapCtx)
    if not ok then
      self:_FinishStep("abort")
      return true
    end
    bReady = bRet == true
  end
  if bReady then
    self:_SetPhase("decide")
    print("[DormGuide] " .. tostring(self._nGroupId) .. " step " .. tostring(self._nIndex) .. " " .. tostring(self._mapStep.sName))
    return false
  end
  if self:_BudgetHit(self:_SystemLimit(mapStart)) then
    self:_OnWaitTimeout(mapStart)
    return true
  end
  self:_HoldForEvent(mapStart)
  return true
end

function GuideStepRunner:_RunPrepare()
  if self:_LeaveByDecide(self:_Decide()) then
    return true
  end
  local mapPrepare = self._mapStep.Prepare
  if mapPrepare.Ready ~= nil then
    local ok, bReady = self:_Call(mapPrepare.Ready, self._mapCtx)
    if not ok then
      self:_FinishStep("abort")
      return true
    end
    if bReady ~= true then
      if self:_BudgetHit(self:_SystemLimit(mapPrepare)) then
        self:_OnWaitTimeout(mapPrepare)
        return true
      end
      self:_Schedule()
      return true
    end
  end
  if self._bPrepared then
    local sNow
    if mapPrepare.Version ~= nil then
      local bOkVer, anyNow = self:_Call(mapPrepare.Version, self._mapCtx)
      if bOkVer then
        sNow = anyNow
      end
    end
    if mapPrepare.Version == nil or sNow == self._sPrepareVer then
      self:_SetPhase("trigger")
      return false
    end
    self._bPrepared = false
  end
  if self._bPreparing then
    return true
  end
  local sVer
  if mapPrepare.Version ~= nil then
    local ok, anyVer = self:_Call(mapPrepare.Version, self._mapCtx)
    if ok then
      sVer = anyVer
    end
  end
  if self._sPrepareVer ~= nil and sVer == self._sPrepareVer then
    self._bPrepared = true
    self:_SetPhase("trigger")
    return false
  end
  self._bPreparing = true
  local ok, bRan = self:_Call(mapPrepare.Run, self._mapCtx)
  self._bPreparing = false
  if not self:_Alive() then
    return true
  end
  if not ok then
    self:_FinishStep("abort")
    return true
  end
  if bRan == false then
    if self:_BudgetHit(self:_SystemLimit(mapPrepare)) then
      self:_OnWaitTimeout(mapPrepare)
    else
      self:_Schedule()
    end
    return true
  end
  self._bPrepared = true
  self._sPrepareVer = sVer
  if mapPrepare.Version ~= nil then
    local ok2, anyVer = self:_Call(mapPrepare.Version, self._mapCtx)
    if ok2 then
      self._sPrepareVer = anyVer
    end
  end
  self:_SetPhase("trigger")
  return false
end

function GuideStepRunner:_RunTrigger()
  if self:_LeaveByDecide(self:_Decide()) then
    return true
  end
  local mapWait = self._mapStep.WaitTrigger
  if mapWait == nil or mapWait.Ready == nil then
    self:_SetPhase("find")
    return false
  end
  local ok, bReady = self:_Call(mapWait.Ready, self._mapCtx)
  if not ok then
    self:_FinishStep("abort")
    return true
  end
  if bReady == true then
    self._nMiss = 0
    self:_SetPhase("find")
    return false
  end
  if self:_BudgetHit(self:_SystemLimit(mapWait)) then
    self:_OnWaitTimeout(mapWait)
    return true
  end
  self:_HoldForEvent(mapWait)
  return true
end

function GuideStepRunner:_RunFind()
  if self:_LeaveByDecide(self:_Decide()) then
    return true
  end
  if self._mapStep.Poll == nil then
    self:_SetPhase("show")
    return false
  end
  if self:_CacheValid() then
    self:_SetPhase("show")
    return false
  end
  self:_DropCache()
  local sRet = self:_PollOnce()
  if sRet == "fail" then
    self:_OnFail("poll")
    return true
  end
  if sRet == "hit" then
    self._nMiss = 0
    self:_SetPhase("show")
    return false
  end
  if self:_BudgetHit(self:_SystemLimit(self._mapStep.Find)) then
    self:_OnWaitTimeout(self._mapStep.Find)
    return true
  end
  self:_HoldForEvent(nil)
  return true
end

function GuideStepRunner:_RunPresentReady()
  local mapPresent = self._mapStep.Present
  if mapPresent == nil or mapPresent.sKind == "None" or mapPresent.sKind == "Avg" or mapPresent.sKind == "Dict" then
    self:_SetPhase("present")
    return false
  end
  if not self:_CacheValid() then
    self:_DropCache()
    self._bPresented = false
    self:_SetPhase("find")
    return false
  end
  if self:_LeaveByDecide(self:_Decide()) then
    return true
  end
  if not self._bShown then
    if mapPresent.Show ~= nil then
      local ok = self:_Call(mapPresent.Show, self._mapCtx, self._trCache)
      if not ok or not self:_Alive() then
        if self:_Alive() then
          self:_FinishStep("abort")
        end
        return true
      end
    end
    self._bShown = true
    if not self:_CacheValid() then
      self:_DropCache()
      self._bShown = false
      self:_SetPhase("find")
      return false
    end
  end
  if not self._trCache.gameObject.activeInHierarchy then
    if self:_BudgetHit(self:_SystemLimit(mapPresent)) then
      self:_OnWaitTimeout(mapPresent)
    else
      self:_HoldForEvent(mapPresent)
    end
    return true
  end
  if mapPresent.Ready ~= nil then
    local ok, bReady = self:_Call(mapPresent.Ready, self._mapCtx, self._trCache)
    if not ok then
      self:_FinishStep("abort")
      return true
    end
    if bReady ~= true then
      if self:_BudgetHit(self:_SystemLimit(mapPresent)) then
        self:_OnWaitTimeout(mapPresent)
        return true
      end
      self:_Schedule()
      return true
    end
  end
  self:_SetPhase("present")
  return false
end

function GuideStepRunner:_RunPresent()
  if self._bPresented then
    self:_SetPhase("end")
    return false
  end
  local mapPresent = self._mapStep.Present or {sKind = "None"}
  local sKind = mapPresent.sKind or "None"
  if sKind == "None" then
    self._bPresented = true
    self:_SetPhase("end")
    return false
  end
  if sKind == "Avg" or sKind == "Dict" then
    self._nPresentGen = self._nPresentGen + 1
    local nGroup, nStep, nPresent = self._nGroupGen, self._nStepGen, self._nPresentGen
    
    local function fnEnd(bNatural)
      if not self:_Alive(nGroup, nStep, nPresent) then
        return
      end
      if bNatural ~= true then
        self:_FinishStep("abort")
        return
      end
      self:_RequestComplete("present")
    end
    
    local ok, bStart
    if sKind == "Avg" then
      ok, bStart = self:_Call(self._objParent.PlayRunnerAvg, self._objParent, mapPresent, fnEnd)
    else
      ok, bStart = self:_Call(self._objParent.PlayRunnerDict, self._objParent, mapPresent, fnEnd)
    end
    if not self:_Alive() then
      return true
    end
    if not ok or bStart ~= true then
      printError("[DormGuide] 呈现启动失败 group=" .. tostring(self._nGroupId) .. " kind=" .. sKind)
      self:_FinishStep("abort")
      return true
    end
    self._bPresented = true
    self:_SetPhase("end")
    self:_ApplyPolicy("present")
    if not self._bCompleting then
      self:_HoldForEvent(mapPresent)
    end
    return true
  end
  if not self:_CacheValid() then
    self:_DropCache()
    self._bShown = false
    self:_SetPhase("find")
    return false
  end
  self._nPresentGen = self._nPresentGen + 1
  self._bClickUsed = false
  local nGroup, nStep, nPresent = self._nGroupGen, self._nStepGen, self._nPresentGen
  
  local function fnClick()
    self:_OnClick(nGroup, nStep, nPresent)
  end
  
  local ok, bShown = self:_Call(self._objParent.PlayStepMask, self._objParent, self._trCache, mapPresent.mapMask or {}, fnClick)
  if not ok or bShown ~= true then
    self:_FinishStep("abort")
    return true
  end
  self._bPresented = true
  self:_SetPhase("end")
  self:_ApplyPolicy("click")
  self:_HoldForEvent(self._mapStep.End)
  return true
end

function GuideStepRunner:_OnClick(nGroup, nStep, nPresent)
  if not self:_Alive(nGroup, nStep, nPresent) then
    return
  end
  if self._bClickUsed or self._bCompleting or self._bSkipAsking or self._sPhase == "request" then
    return
  end
  if not self:_CacheValid() then
    self._objParent:ReleaseStepVisual(true)
    self._bPresented = false
    self._bShown = false
    self:_DropCache()
    self:_SetPhase("find")
    self:_Wake()
    return
  end
  if self:_LeaveByDecide(self:_Decide()) then
    return
  end
  self._bClickUsed = true
  self._bActionRunning = true
  self._nPresentGen = self._nPresentGen + 1
  local mapEnd = self._mapStep.End or {sMode = "Click"}
  if mapEnd.sMode ~= "Click" then
    self:_SetPhase("request")
    self:_ApplyPolicy("request")
  end
  self._objParent:ReleaseStepVisual(true)
  local ok, mapRet
  if self._mapStep.Action ~= nil then
    ok, mapRet = self:_Call(self._mapStep.Action, self._mapCtx, self._trCache)
  else
    ok, mapRet = self:_Call(self._objParent.InvokeRunnerTarget, self._objParent, self._trCache)
  end
  self._bActionRunning = false
  if not self:_Alive() then
    return
  end
  if not ok or type(mapRet) ~= "table" then
    self:_FinishStep("abort")
    return
  end
  self._nOpId = mapRet.nOpId or 0
  self._mapCtx:Set("nOpId", self._nOpId)
  if mapRet.sState ~= "accepted" and mapRet.sState ~= "pending" and mapRet.sState ~= "done" then
    self:_FinishStep("abort")
    return
  end
  if mapEnd.sMode == "Click" and (mapRet.sState == "accepted" or mapRet.sState == "done") then
    self:_RequestComplete("click")
    return
  end
  if mapRet.sState == "done" or mapEnd.Ready ~= nil and self:_EndReady() then
    self:_RequestComplete("click")
    return
  end
  if not self:_Alive() then
    return
  end
  self:_SetPhase("request")
  self:_ApplyPolicy("request")
  self:_Schedule()
end

function GuideStepRunner:_EndReady()
  local mapEnd = self._mapStep.End
  if mapEnd == nil or mapEnd.Ready == nil then
    return false
  end
  local ok, bReady = self:_Call(mapEnd.Ready, self._mapCtx)
  if not ok then
    self:_FinishStep("abort")
    return false
  end
  return bReady == true
end

function GuideStepRunner:_RunEnd()
  local mapEnd = self._mapStep.End
  local mapPresent = self._mapStep.Present or {}
  if mapPresent.sKind == "Mask" and self._sPhase == "end" and not self._bClickUsed and (not self:_CacheValid() or not self._trCache.gameObject.activeInHierarchy) then
    self._objParent:ReleaseStepVisual(true)
    self._bPresented = false
    self._bShown = false
    self:_DropCache()
    self:_SetPhase("find")
    return false
  end
  local bPresentWait = mapPresent.sKind == "Avg" or mapPresent.sKind == "Dict"
  local bWaitClick = mapPresent.sKind == "Mask" and not self._bClickUsed
  if not bPresentWait and not bWaitClick and self:_EndReady() then
    self:_RequestComplete("end")
    return true
  end
  if not self:_Alive() then
    return true
  end
  local mapWait = mapEnd or mapPresent
  if self:_BudgetHit(self:_SystemLimit(mapWait)) then
    self:_OnWaitTimeout(mapWait)
    return true
  end
  self:_HoldForEvent(mapWait)
  return true
end

function GuideStepRunner:_RequestComplete(sWhy)
  if self._bStopped or self._bExiting or self._bCompleting then
    return
  end
  self._bCompleting = true
  local nGroup, nStep = self._nGroupGen, self._nStepGen
  self:_Schedule(function()
    if self._bStopped or self._nGroupGen ~= nGroup or self._nStepGen ~= nStep then
      return
    end
    self._bExiting = false
    self:_FinishStep("success")
  end)
end

function GuideStepRunner:_OnFail(sWhy)
  local step = self._mapStep
  local sHow = "abort"
  if step ~= nil and step.OnFail ~= nil then
    sHow = step.OnFail
  end
  printError("[DormGuide] fail group=" .. tostring(self._nGroupId) .. " step=" .. tostring(self._nIndex) .. " " .. tostring(sWhy))
  if sHow == "continue" then
    self:_FinishStep("skip")
    return
  end
  self:_FinishStep("abort")
end

function GuideStepRunner:AskSkip()
  if not self:_Alive() or self._bCompleting or self._bSkipAsking or not self._bSkipAvailable then
    return
  end
  self._bSkipAsking = true
  self._nConfirmGen = self._nConfirmGen + 1
  local nGroup, nStep, nConfirm = self._nGroupGen, self._nStepGen, self._nConfirmGen
  
  local function IsCurrent()
    return self:_Alive(nGroup, nStep) and self._nConfirmGen == nConfirm and not self._bCompleting
  end
  
  self._objParent:OpenRunnerSkip(nGroup, nStep, nConfirm, function()
    if IsCurrent() then
      self:Stop("jump", true)
    end
  end, function()
    if IsCurrent() then
      self._bSkipAsking = false
      self:_Wake()
    end
  end)
end

function GuideStepRunner:_ExitStep(sReason, bKeepBarrier)
  if self._bStepExited then
    return
  end
  self._bStepExited = true
  self:_CancelTick()
  self:_UnbindStep()
  self._nConfirmGen = self._nConfirmGen + 1
  if self._objParent ~= nil then
    self._objParent:ReleaseStepVisual(bKeepBarrier)
    self._objParent:CancelRunnerPresent()
    self._objParent:CloseRunnerSkip()
    self._objParent:SetRunnerSkipVisible(false)
  end
  local step = self._mapStep
  if step ~= nil and step.OnExit ~= nil then
    self:_Call(step.OnExit, self._mapCtx, sReason)
  end
end

function GuideStepRunner:_FinishStep(sReason)
  if self._bStopped or self._bExiting then
    return
  end
  self._bExiting = true
  local step = self._mapStep
  if sReason == "success" and step ~= nil and step.bReportDone then
    self:_Report()
  end
  if sReason == "skip" and step ~= nil and step.bReportOnSkip then
    self:_Report()
  end
  if sReason == "finish" then
    self:_Report()
  end
  self:_ExitStep(sReason, sReason ~= "abort" and sReason ~= "finish")
  if self._bStopped then
    return
  end
  if sReason == "abort" then
    self._bExiting = false
    self:Stop("abort", false)
    return
  end
  if sReason == "finish" then
    self._bExiting = false
    self:Stop("finish", false)
    return
  end
  self._nIndex = self._nIndex + 1
  self._bExiting = false
  self._bShown = false
  self:_BeginStep()
end

function GuideStepRunner:_Report()
  if self._bReported or self._objParent == nil then
    return
  end
  if self._objParent.isDebugTest then
    self._bReported = true
    return
  end
  self._bReported = true
  self._objParent:SendGuideStep(self._nGroupId, -1, self._nGuideType)
end

function GuideStepRunner:Stop(sReason, bReport)
  if self._bStopped then
    return
  end
  self._bStopped = true
  self._bExiting = true
  self._nGroupGen = self._nGroupGen + 1
  self._nPresentGen = self._nPresentGen + 1
  self:_ExitStep(sReason, false)
  local objParent = self._objParent
  if self._objGroup ~= nil and self._objGroup.OnClear ~= nil then
    Guard(self._objGroup.OnClear, self._objGroup, self._mapCtx, sReason)
  end
  if sReason == "jump" or bReport then
    self:_Report()
  end
  if sReason == "abort" and PlayerData.Guide ~= nil and PlayerData.Guide.NoteDormAbort ~= nil then
    PlayerData.Guide:NoteDormAbort(self._nGroupId)
  end
  self._objParent = nil
  if objParent ~= nil then
    objParent._objStepRunner = nil
    objParent:FinishRunnerGroup(sReason == "finish" or sReason == "jump")
  end
end

return GuideStepRunner
