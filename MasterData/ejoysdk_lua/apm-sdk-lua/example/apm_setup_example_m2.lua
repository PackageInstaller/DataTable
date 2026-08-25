local global = require("global")
local Graphic = require("graphic_cfg")
local APUS = require("ejoysdk_lua.apm-sdk-lua.apus")
local M = {}

function M.init()
  APUS.set_game_version(CS.UnityEngine.Application.version)
  APUS.set_static_label("script_version", tostring(global.script_version))
  APUS.set_logout_func(function()
    APUS.set_quality_level(tostring(Graphic.cur_rank))
  end)
  APUS.set_scene_func(function()
    if global.cave_mgr then
      local cur_cave = global.cave_mgr:get_cur_cave()
      return cur_cave.id
    end
  end)
  APUS.set_position_func(function()
    if global.me and global.me.pos then
      local pos = global.me.pos
      return pos[1], pos[2], pos[3]
    end
  end)
  local m2_stats = APUS.new_custom_stats("m2_stats", "m2")
  m2_stats:set_calc_func(function()
    local s = {}
    if global.server_time then
      s.net_delay = global.server_time:get_delay()
    end
    if global.CameraFollow and global.CameraFollow.distance then
      s.camera = global.CameraFollow.distance
    end
    return s
  end)
end

return M
