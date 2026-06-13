local Base = require("gamemode.base")
local Const = require("const")
local Util = require("utils.util")
local CSGameMgr = CS.Game.GameMgr
local M = Util.create_child_mt(Base)
local LUA_GC_INTERVAL = 180
local UNLOAD_INTERVAL = 300
local LAST_LUA_GC_TIME = 0
local LAST_RESOURCE_GC_TIME = 0
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local FightHudMgr = require("uimodule.fight.fight_hud_mgr")

function M:gd_update(delta_time)
  Base.gd_update(self, delta_time)
end

function M:gd_fixed_update(delta_time)
  self:update_collider_list()
  Base.gd_fixed_update(self, delta_time)
end

function M:gd_late_update()
  Base.gd_late_update(self)
  if Global.real_time - LAST_LUA_GC_TIME > LUA_GC_INTERVAL then
    collectgarbage("incremental")
    LAST_LUA_GC_TIME = Global.real_time
  end
  if Global.real_time - LAST_RESOURCE_GC_TIME > UNLOAD_INTERVAL then
    LAST_RESOURCE_GC_TIME = Global.real_time
  end
end

function M:gd_on_enter()
  Base.gd_on_enter(self)
  if GAME_DEBUG or UNITY_EDITOR or PUBLISH_GM then
    UIMgr:get_ui("ui_debug_info"):ui_show()
  end
  Global.is_enter_room_failed = false
  Util.collectgarbage()
  Global.render_mgr:enter_game_mode()
end

function M:gd_on_leave(new_mode)
  Base.gd_on_leave(self)
  UIMgr:try_destory_ui("fight")
  UIMgr:cache_hide_ui()
  local swtich_login_mode = new_mode == Const.MODE_CHECK_UPDATE or new_mode == Const.MODE_LOGIN
  SceneMgr:clear_scene(swtich_login_mode or SceneMgr:check_main_scene())
  if swtich_login_mode then
    UIMgr:on_switch_to_login_mode()
  end
  Global.render_mgr:leave_game_mode()
  if new_mode == Const.MODE_RELOAD or Global.need_clear_hero_list then
    Global.scene_mgr:clear_hero_list()
  end
  Global.npc_pool_mgr:clear()
  SceneMgr:destroy_camera()
  if not Global.gamemode:get_is_tp_next_floor() or SceneMgr:check_main_scene() then
    LuaObjPoolMgr.release_all_pool()
  end
  Global.res_pool_mgr:clear()
  UtilTable.clear_map(Global.KEYFRAMES)
  ShareRes.clear()
  Util.clear_wrap_caches()
  Util.collectgarbage()
  SDKManager:clear_sensitive_cache()
end

function M:update_collider_list()
  local length = CSGameMgr.ColliderInstanceIdsLength
  if length > 0 then
    local collider_instance_ids = CSGameMgr.ColliderInstanceIds
    local collider_layers = CSGameMgr.ColliderLayers
    for i = 0, length - 1, 2 do
      local id1, id2 = collider_instance_ids[i], collider_instance_ids[i + 1]
      local layer1, layer2 = collider_layers[i], collider_layers[i + 1]
      SceneMgr:on_collide(id1, id2, layer1, layer2)
    end
    CSGameMgr.ColliderInstanceIdsLength = 0
  end
  length = CSGameMgr.ExitColliderInstanceIdsLength
  if length > 0 then
    local collider_instance_ids = CSGameMgr.ExitColliderInstanceIds
    for i = 0, length - 1, 2 do
      local id1, id2 = collider_instance_ids[i], collider_instance_ids[i + 1]
      SceneMgr:on_collide_exit(id1, id2)
    end
    CSGameMgr.ExitColliderInstanceIdsLength = 0
  end
end

return M
