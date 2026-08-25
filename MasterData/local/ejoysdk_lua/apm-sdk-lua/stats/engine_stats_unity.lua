local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local M = {}
local gen_engine_data_func

function M.set_gen_engine_data_func(func)
  gen_engine_data_func = func
  Global.set_is_old_unity_project(true)
end

function M.get_engine_stats()
  if not gen_engine_data_func then
    return nil
  end
  local data = Utils.exec(gen_engine_data_func)
  if not data then
    return nil
  end
  local stats = {}
  stats.fps = data.fps
  stats.draw_call = data.drawCalls
  stats.tri_count = data.triangles
  stats.unity_vertices = data.vertices
  stats.unity_batches = data.batches
  stats.unity_setpasscalls = data.setPassCalls
  stats.unity_rendertime = data.renderTime
  stats.unity_timecpu = data.timeCPU
  stats.unity_usedmem = data.usedMems
  return stats
end

return M
