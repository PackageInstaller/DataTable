local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local HpItem = require("uimodule.fight.hud.ui_hp")
local UI_FOLLOW_DEBUG_INFO_CLASS = require("uimodule.fight.hud.ui_follow_debug_info")
local FloatIconItem = require("uimodule.fight.hud.ui_float_icon")
local ProgressDisplay = require("uimodule.fight.hud.ui_progress_display")
local NavigationHud = require("uimodule.fight.hud.ui_navigation")
local NavigationFightHud = require("uimodule.fight.hud.ui_navigation_fight")
local UI_FOLLOW_DEBUG_INFO_TEMP_KEY = "UI_FOLLOW_DEBUG_INFO_TEMP_KEY"
local UPDATE_INTERVAL = 1
local is_need_refresh_display = false

function ui:ui_finish_load()
  self.last_update_time = 0
  self.v_damage_hud_update_list = {}
  self.v_ui_hp_update_list = {}
  self.v_follow_debug_info_map = {}
  self.v_tra = self:get_object_transform()
  self.v_cg = self.v_object:GetComponent("CanvasGroup")
  self.v_canvas = self.v_object:GetComponent(typeof(UnityEngine.Canvas))
  self:bind_auto_mq(Const.MSG_CG_TIMELINE_START, self.on_timeline_start, self)
  self:bind_auto_mq(Const.MSG_CG_TIMELINE_END, self.timeline_play_end, self)
  self.s_hp_pool = LuaObjPoolMgr.get_pool("fight_hp_pool") or LuaObjPoolMgr.register("fight_hp_pool", 10, HpItem)
  self.v_float_icon_pool = LuaObjPoolMgr.get_pool("fight_float_icon_pool") or LuaObjPoolMgr.register("fight_float_icon_pool", 10, FloatIconItem)
  self.v_navigation_hud_pool = LuaObjPoolMgr.get_pool("navigation_hud_pool") or LuaObjPoolMgr.register("navigation_hud_pool", 5, NavigationHud)
  self.v_navigation_fight_hud_pool = LuaObjPoolMgr.get_pool("navigation_fight_hud_pool") or LuaObjPoolMgr.register("navigation_fight_hud_pool", 2, NavigationFightHud)
  self.v_ui_navigation = nil
end

function ui:_pop_item(pool, ...)
  return pool:new_obj(self, ...)
end

function ui:_push_item(pool, item)
  pool:destroy_obj(item)
end

function ui:get_hp_item(...)
  return self:_pop_item(self.s_hp_pool, ...)
end

function ui:get_hurt_item(...)
  return self:_pop_item(self.s_hurt_pool, ...)
end

function ui:get_float_icon_item(...)
  return self:_pop_item(self.v_float_icon_pool, ...)
end

function ui:get_navigation_hud_item(...)
  return self:_pop_item(self.v_navigation_hud_pool, ...)
end

function ui:get_navigation_fight_hud_item(...)
  return self:_pop_item(self.v_navigation_fight_hud_pool, ...)
end

function ui:release_navigation_fight_hud_item(item)
  if not item then
    return
  end
  self:_push_item(self.v_navigation_fight_hud_pool, item)
end

function ui:release_hp_item(item)
  if not item then
    return
  end
  self:_push_item(self.s_hp_pool, item)
end

function ui:release_hurt_item(item)
  if not item then
    return
  end
  self:_push_item(self.s_hurt_pool, item)
end

function ui:release_float_icon_item(item)
  if not item then
    return
  end
  self:_push_item(self.v_float_icon_pool, item)
end

function ui:release_navigation_hud_item(item)
  if not item then
    return
  end
  self:_push_item(self.v_navigation_hud_pool, item)
end

function ui:ui_on_show()
  is_need_refresh_display = false
  self:set_ui_alpha(1)
  self.v_canvas.sortingOrder = -1
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.show_message, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.hide_message, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_LOADING_END, self.response_battle_loading, self)
  if not Util.is_client_only() then
    self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_START, self._response_hero_born_event, self)
    self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_END, self._response_hero_born_finish_event, self)
  end
  Global.ui_dynamic_canvas = self
  self.v_size_delta_x, self.v_size_delta_y = self.v_tra:GetSizeDeltaA()
end

function ui:get_hp_root_trans()
  local hp_root_obj = self.v_uiobjects.HpRoot
  if not self.v_redisplay_hp_root then
    hp_root_obj:SetActive(false)
    hp_root_obj:SetActive(true)
    self.v_redisplay_hp_root = true
  end
  return hp_root_obj.transform
end

function ui:get_hurt_root_trans()
  local hurt_root_trans = self.v_uiobjects.HurtRoot
  return hurt_root_trans.transform
end

function ui:get_root_trans_by_name(root_name)
  local root_trans = self.v_uiobjects[root_name]
  return root_trans.transform
end

function ui:get_interaction_npc_hud_root_trans()
  local interaction_root_trans = self.v_uiobjects.InteractionNpcHudRoot
  return interaction_root_trans.transform
end

function ui:get_role_npc_chat_root_trans()
  local role_npc_root_trans = self.v_uiobjects.RoleNpcChatRoot
  return role_npc_root_trans.transform
end

function ui:get_navigation_root_trans()
  local navigation_root_trans = self.v_uiobjects.NavigationRoot
  return navigation_root_trans.transform
end

function ui:create_hud_navigation()
  self.v_ui_navigation = self:get_navigation_hud_item()
  return self.v_ui_navigation
end

function ui:release_hud_navigation()
  if self.v_ui_navigation then
    self:release_navigation_hud_item(self.v_ui_navigation)
  end
end

function ui:get_ui_navigation()
  return self.v_ui_navigation
end

function ui:ui_on_hide()
  self:clear_follow_debug_info()
  self.v_damage_hud_update_list = {}
  self.v_ui_hp_update_list = {}
  Global.ui_dynamic_canvas = nil
  self.s_hp_pool:release_active_objs()
  self.s_hp_pool:release_free_objs()
  self.v_ui_navigation = nil
  self.v_navigation_hud_pool:release_active_objs()
  self.v_navigation_hud_pool:release_free_objs()
end

function ui:ui_on_destroy()
  if self.v_follow_debug_info_tem then
    if not self.v_follow_debug_info_tem:IsNull() then
      ResMgr:destroy_gameobj(self.v_follow_debug_info_tem)
    end
    self.v_follow_debug_info_tem = nil
  end
  self.s_hp_pool = nil
  self.v_navigation_hud_pool = nil
  self.v_float_icon_pool = nil
  self.v_navigation_fight_hud_pool = nil
end

function ui:show_message(msg)
  if msg.mm_obj == "ui_challenge_ring" then
    local canvas = self:get_canvas()
    canvas.planeDistance = 0
  end
end

function ui:hide_message(msg)
  if msg.mm_obj == "ui_challenge_ring" then
    local canvas = self:get_canvas()
    canvas.planeDistance = 100
  end
end

function ui:_response_hero_born_finish_event()
  self.v_object:SetActive(true)
end

function ui:_response_hero_born_event()
  self.v_object:SetActive(false)
end

function ui:response_battle_loading(msg)
  if nil == msg then
    return
  end
  local is_open = msg.mm_x
  self.v_object:SetActive(is_open)
end

function ui:ui_on_update()
  if UNITY_EDITOR then
    local size_x, size_y = self.v_tra:GetSizeDeltaA()
    if size_x ~= self.v_size_delta_x or size_y ~= self.v_size_delta_y then
      self.v_size_delta_x = size_x
      self.v_size_delta_y = size_y
    end
  end
  self:hud_pos_update()
  if is_need_refresh_display then
    ProgressDisplay:on_update()
  end
  for char, item in pairs(self.v_follow_debug_info_map) do
    if not Util.is_destroy(char) then
      item:ui_on_update()
    else
      self:destroy_follow_debug_info(char)
    end
  end
end

function ui:hud_pos_update()
  if Global.frame_id - self.last_update_time > UPDATE_INTERVAL then
    for damage_hud in pairs(self.v_damage_hud_update_list) do
      damage_hud:update()
    end
    self.last_update_time = Global.frame_id
  end
  for ui_hp in pairs(self.v_ui_hp_update_list) do
    ui_hp:update_hp_obj_position()
  end
end

function ui:get_canvas_scale_x()
  return self.v_size_delta_x / Global.screen_width
end

function ui:get_canvas_scale_y()
  return self.v_size_delta_y / Global.screen_height
end

function ui:get_rect_size_delta_x()
  return self.v_size_delta_x
end

function ui:get_rect_size_delta_y()
  return self.v_size_delta_y
end

function ui:set_follow_bar_tf(tf)
end

function ui:set_ui_alpha(alpha)
  self.v_cg.alpha = alpha
end

function ui:on_timeline_start()
  self.v_cg.alpha = 0
end

function ui:timeline_play_end()
  self.v_cg.alpha = 1
end

function ui:get_tf()
  if not Util.is_nil(self.v_object) then
    return self.v_object.transform
  end
end

function ui:skip_sort_order()
  return true
end

function ui:on_progress_display_open(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval, ui_style_index)
  is_need_refresh_display = true
  local progress_parent = self.v_uiobjects.EpiDisplayProgressRoot
  if ui_style_index then
    self.progress_display_slider = Util.get_slider("Progress" .. ui_style_index, progress_parent)
  end
  if not self.progress_display_slider then
    self.progress_display_slider = Util.get_slider("Progress1", progress_parent)
  end
  if is_need_anim then
    Log.Info("播放开启动画")
  end
  self.progress_display_slider:SetActive(true)
  ProgressDisplay:set_progress_display_slider(self.progress_display_slider)
  ProgressDisplay:on_progress_display_open(self, init_value, curr_room__final_value, all_room_final_value, up_speed, up_interval)
end

function ui:on_progress_display_update(up_value)
  ProgressDisplay:on_progress_display_update(up_value)
end

function ui:on_progress_display_close(is_need_anim)
  if not self.progress_display_slider then
    return
  end
  if is_need_anim then
    Log.Info("播放关闭动画")
  end
  self.progress_display_slider:SetActive(false)
  is_need_refresh_display = false
end

function ui:add_damage_hud_to_update_list(damage_hud)
  self.v_damage_hud_update_list[damage_hud] = true
end

function ui:remove_damage_hud_at_update_list(damage_hud)
  self.v_damage_hud_update_list[damage_hud] = nil
end

function ui:add_ui_hp_to_update_list(ui_hp)
  self.v_ui_hp_update_list[ui_hp] = true
end

function ui:remove_ui_hp_at_update_list(ui_hp)
  self.v_ui_hp_update_list[ui_hp] = nil
end

function ui:get_follow_debug_info(char)
  if not self.v_follow_debug_info_map[char] then
    if not self.v_auto_cache_list[UI_FOLLOW_DEBUG_INFO_TEMP_KEY] then
      if Util.is_nil(self.v_follow_debug_info_tem) then
        local path = CS.ResLoader.GetFullPath("UIFollowDebugInfo")
        self.v_follow_debug_info_tem = ResMgr:load_gameobj(path)
        self.v_follow_debug_info_tem.transform:SetParent(self.v_uiobjects.FollowDebugInfoRoot.transform)
        self.v_follow_debug_info_tem.transform:ResetAttr()
      end
      self:register_exist_auto_template(UI_FOLLOW_DEBUG_INFO_TEMP_KEY, self.v_follow_debug_info_tem.gameObject, self.v_uiobjects.FollowDebugInfoRoot)
    end
    local obj = self:get_auto_cache(UI_FOLLOW_DEBUG_INFO_TEMP_KEY)
    self.v_follow_debug_info_map[char] = UI_FOLLOW_DEBUG_INFO_CLASS:ui_wrap_ex(self, obj, true)
    self.v_follow_debug_info_map[char]:set_data(char)
  end
  return self.v_follow_debug_info_map[char]
end

function ui:destroy_follow_debug_info(char)
  local item = self.v_follow_debug_info_map[char]
  if item then
    if self.v_auto_cache_to_key[item.v_object] then
      self:give_back_auto_cache_obj(UI_FOLLOW_DEBUG_INFO_TEMP_KEY, item.v_object)
    end
    self.v_follow_debug_info_map[char]:ui_hide()
    self.v_follow_debug_info_map[char]:ui_destroy()
    self.v_follow_debug_info_map[char] = nil
  end
end

function ui:clear_follow_debug_info()
  for char, _ in pairs(self.v_follow_debug_info_map) do
    self:destroy_follow_debug_info(char)
  end
end

return ui
