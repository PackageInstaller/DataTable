local _IsDebug = IS_EDITOR or IS_DEV_BUILD
local C_Profiler = CS.UnityEngine.Profiling.Profiler
local _OpenProfiler = false
local profilerUtil = {}

function profilerUtil.BeginSample(name)
  if _OpenProfiler and _IsDebug then
    C_Profiler.BeginSample(name)
  end
end

function profilerUtil.EndSample()
  if _OpenProfiler and _IsDebug then
    C_Profiler.EndSample()
  end
end

function profilerUtil.ToggleProfiler(open)
  _OpenProfiler = open
end

function profilerUtil.IsOpenProfiler()
  return _OpenProfiler
end

L_ProfilerUtil = profilerUtil
