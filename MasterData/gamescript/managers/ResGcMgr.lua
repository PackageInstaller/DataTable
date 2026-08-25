local IUpdater = require("Ecs.IUpdater")
local ResGcMgr, Super = System.NewClass("ResGcMgr", Manager, IUpdater)
local gcInterval = 20
local Time = CS.UnityEngine.Time
local Resources_UnloadUnusedAssets = CS.UnityEngine.Resources.UnloadUnusedAssets
local GC_Collect = CS.System.GC.Collect
local UnloadNoRefAssets = CS.Framework.AssetLoadUtil.UnloadNoRefAssets
local os_clock = os.clock
local collectgarbage = _ENV.collectgarbage
local GC_BUDGET_DEFAULT = 0.001
local GC_BUDGET_BATTLE = 5.0E-4
local GC_STEP_SIZE = 20
CS.UnityEngine.Application.backgroundLoadingPriority = 4
CS.UnityEngine.QualitySettings.asyncUploadTimeSlice = 20
CS.UnityEngine.QualitySettings.asyncUploadBufferSize = 16

function ResGcMgr:ctor()
  Super.ctor(self)
  self.lastGcTime = 0
  self._gcBudget = GC_BUDGET_DEFAULT
  self._stepGcEnabled = true
end

function ResGcMgr:SetStepGcEnabled(enabled)
  self._stepGcEnabled = enabled
end

function ResGcMgr:SetInBattle(inBattle)
  self._gcBudget = inBattle and GC_BUDGET_BATTLE or GC_BUDGET_DEFAULT
end

function ResGcMgr:Update()
  if not self._stepGcEnabled then
    return
  end
  local budget = self._gcBudget
  local startTime = os_clock()
  while budget > os_clock() - startTime and not collectgarbage("step", GC_STEP_SIZE) do
  end
end

function ResGcMgr:DelayTryGc(delay)
  delay = delay or 0.8
  TimerManager.Instance:CreateTimer(delay, 0, nil, System.fn(self, self.TryGc))
end

function ResGcMgr:DelayGc(delay)
  delay = delay or 0.8
  TimerManager.Instance:CreateTimer(delay, 0, nil, System.fn(self, self.Gc))
end

function ResGcMgr:TryGc()
  local time = Time.time
  if time - self.lastGcTime > gcInterval then
    self:Gc()
  end
end

function ResGcMgr:Gc()
  self:UnloadUnusedAssets()
  GC_Collect()
  collectgarbage("collect")
  self.lastGcTime = Time.time
end

function ResGcMgr:UnloadUnusedAssets()
  UIImageCache.Instance:ReleaseAllUnused()
  UnloadNoRefAssets(true)
  Resources_UnloadUnusedAssets()
end

return ResGcMgr
