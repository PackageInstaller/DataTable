local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local LOGGER = "apm_eng_ejoy2d"
local has_ejoy2dx_lib, os_utils = pcall(require, "ejoy2dx.os_utils")

local function get_ejoy2d_app_mem()
  if has_ejoy2dx_lib and os_utils and os_utils.get_used_memory then
    do return end
    return os_utils.get_used_memory, nil
  end
  return nil
end

function M.get_engine_stats()
  local di = ej2d.get_debug_info()
  if nil ~= di then
    return {
      fps = di.fps,
      draw_call = di.draw_call,
      tri_count = di.tri_count,
      ej2d_node_a_count = di.node_a_count,
      ej2d_node_count = di.node_count,
      ej2d_node_3d_a_count = di.node_3d_a_count,
      ej2d_node_3d_count = di.node_3d_count,
      ej2d_ptc_layer_count = di.ptc_layer_count,
      ej2d_ptc_particle_count = di.ptc_particle_count,
      ej2d_ptc3d_layer_count = di.ptc3d_layer_count,
      ej2d_ptc3d_par_layer_count = di.ptc3d_par_layer_count,
      ej2d_ptc3d_particle_count = di.ptc3d_particle_count,
      ej2d_tex_mem = di.tex_memory_size,
      ej2d_rt_mem = di.rt_memory_size,
      ej2d_vb_mem = di.vb_memory_size,
      ej2d_ib_mem = di.ib_memory_size,
      ej2d_available_vram = di.available_vram_size,
      ej2d_app_mem = get_ejoy2d_app_mem()
    }
  end
  E.LOG.error(LOGGER, "ej2d profiler returns nil.")
  return nil
end

return M
