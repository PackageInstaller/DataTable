local Global = require("global")
local script_ver = require("ver")
local APUS = require("ejoysdk_lua.apm-sdk-lua.apus")
local M = {}

function M.init()
  APUS.set_game_version(tostring(BUILD_VER))
  APUS.set_static_label("raw_season", tostring(Global.season_mgr:get_raw_season()))
  APUS.set_static_label("script_version", tostring(script_ver))
  APUS.set_position_func(function()
    if Global.viewport:vp_is_init() then
      do return Global.viewport.get_center_grid end
      return Global.viewport.get_center_grid, Global.viewport
    end
  end)
  APUS.set_login_func(function()
    APUS.set_quality_level(Global.quality_mgr:get_save_lv())
    APUS.set_static_label("is_3d", Global.dimension_mgr:is_3d() and "1" or "0")
    APUS.set_static_label("is_3d_ui", Global.dimension_mgr:is_3d_ui() and "1" or "0")
    APUS.set_static_label("is_portrait", Global.dimension_mgr:is_portrait_mode() and "1" or "0")
  end)
  local s3_stats = APUS.new_custom_stats("s3_stats", "s3")
  s3_stats:set_calc_func(function()
    return {
      armies = Global.optimize_mgr:get_total_army_num(),
      army_num_2d = Global.optimize_mgr:get_lod_army_num(),
      army_num_3d = Global.optimize_mgr:get_high_army_num()
    }
  end)
end

return M
