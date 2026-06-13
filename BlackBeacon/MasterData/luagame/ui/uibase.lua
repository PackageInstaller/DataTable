local MaskComponent = require("ui.uibase_mask")
local GraphicRaycaster = typeof(UnityEngine.UI.GraphicRaycaster)
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Coroutine = _ENV.Coroutine
local coroutine = _ENV.coroutine
local wait_for_seconds = UnityEngine.WaitForSeconds
local ScreenSpaceCameraRenderMode = UnityEngine.RenderMode.ScreenSpaceCamera
local DESIGN_RATIO = 1.7777777777777777
local res_path_map
local FORCE_FULL_SCREEN = {ui_guide = true, loading = true}

function ui:ui_new(cfg, isdynamic)
  self = setmetatable({}, self)
  if not cfg or cfg.preload_type or not cfg.scene_type then
  end
  self.v_ui_name = cfg.name
  self.v_msg_handles = {}
  self.v_cfg = cfg or {}
  self.v_panel_list = {}
  self.v_cache_list = {}
  self.v_isdynamic = isdynamic
  self.v_cache = cfg.cache or 120
  self.v_view_level = cfg.view_level
  self.v_sub_panels = {}
  self.v_parent_panel = nil
  self.v_background_blur = cfg.background_blur
  self.v_open_default_ui = cfg.open_default_ui
  self.v_blur_img = nil
  self.v_blur_texture = false
  if cfg.show_waiting then
    Global.ui_mgr:get_ui("waiting"):ui_show(cfg.class)
  end
  local res_path = Path.get_full_prefab_path(self:get_resource_path(cfg.resource))
  local cache_prefab = UIMgr:get_cache_ui_prefab(self:ui_get_name())
  if cache_prefab then
    self:ui_on_load(cache_prefab)
  elseif cfg.sync_load then
    local obj = ResMgr:load_gameobj(res_path, nil, not cfg.auto_destroy)
    assert(obj)
    self:ui_on_load(obj)
  else
    ResMgr:load_gameobj_async(res_path, nil, not cfg.auto_destroy, self.ui_on_load, self)
  end
  self.v_update_interval = cfg.update_interval
  return self
end

function ui:get_resource_path(path)
  local result_path = Path.get_full_prefab_path_with_language(path, Global.curr_text_language)
  if not res_path_map then
    res_path_map = {}
  end
  if not result_path then
    if Global.is_need_check_default then
      result_path = Path.get_full_prefab_path_with_language(path, Global.default_folder_name)
    end
    result_path = result_path or Path.get_full_prefab_path_with_language(path, Global.default_language)
  end
  res_path_map[path] = result_path
  return result_path
end

function ui:get_ui_obj()
  return self.v_object
end

function ui:init_ui_text(gameobj)
  local str = string.sub(gameobj.name, -7)
  if "(Clone)" == str then
    local length = string.len(gameobj.name)
    str = string.sub(gameobj.name, 1, length - 7)
  else
    str = gameobj.name
  end
  local text_tab = Global.ui_text_config[str]
  if text_tab then
    for k, v in pairs(text_tab) do
      local text_obj = Util.get_component(k, gameobj, UnityEngine.UI.Text)
      if text_obj.text == "日程表" then
      end
      if text_obj.text then
        if text_obj.text == "日程表" then
          Log.Info("Global.i18n[text_obj.text]", Global.i18n[text_obj.text])
        end
        text_obj.text = Global.i18n[text_obj.text] or text_obj.text
      end
    end
  end
end

function ui:replace_ui_text(gameobj)
  local components = gameobj:GetComponentsInChildren(TypeUnityUIText, true)
  if next(components) then
    for _, text_obj in pairs(components) do
      text_obj.text = Global.i18n[text_obj.text] or text_obj.text
    end
  end
end

function ui:ui_on_load(gameobj)
  if self.v_is_destroy then
    Global.res_mgr:destroy_gameobj(gameobj)
    return
  end
  self:_init_common(gameobj)
  local cfg = self.v_cfg
  if cfg and cfg.world then
    self.v_object_transform:SetParent(Global.ui_mgr:get_wcanvas().transform, false)
  end
  if Global.ui_mgr.root_obj then
    local group = cfg.group or Config.UI_GROUPS.GROUP_NORMAL
    self.v_object_transform:SetParent(Global.ui_mgr:get_group_root_transform(group), true)
  end
  if not self.v_isdynamic then
    local canvas = self:get_canvas()
    if cfg and cfg.world then
      canvas.worldCamera = Global.ui_mgr.world_camera
    else
      canvas.worldCamera = Global.ui_mgr.root_camera
    end
    self.canvas = canvas
    if not cfg.is_not_set_space_camera_render then
      canvas.renderMode = ScreenSpaceCameraRenderMode
    end
  end
  if cfg and cfg.show_waiting then
    Global.ui_mgr:get_ui("waiting"):ui_hide(cfg.class)
  end
  local ui_canvas_scaler = self:get_component(nil, nil, UnityEngine.UI.CanvasScaler)
  if ui_canvas_scaler and not cfg.not_calc_match then
    if Global.screen_ratio > DESIGN_RATIO then
      ui_canvas_scaler.matchWidthOrHeight = 1
    else
      ui_canvas_scaler.matchWidthOrHeight = 0
    end
  end
  self:set_safe_area_offset()
  self:init_ui_objlist()
  self:_init_panels()
  self.v_blur_img = self:get_rawimage(nil, self.v_uiobjects.Blur)
  Base.ui_on_load(self)
  self:_on_ui_ready()
end

function ui:set_safe_area_offset()
  if self.v_object == nil or self.v_is_destroy then
    Log.Info("set_safe_area_offset err, ui has destroy", debug.traceback())
    return
  end
  local safe_panel_rect = self:get_rect_transform("SafeArea")
  safe_panel_rect = safe_panel_rect or self:get_rect_transform("SafeArea_")
  if safe_panel_rect and not FORCE_FULL_SCREEN[self.v_cfg.name] then
    local offset_x = UIMgr:get_safe_area_offset()
    safe_panel_rect:SetAnchoredMinMax(offset_x, 0, 1 - offset_x, 1)
  end
  self.v_safe_panel_rect = safe_panel_rect
end

function ui:_set_ui_mask()
  if self.v_cfg.has_mask then
    local mask_img = self:get_image("ImageMask")
    self.v_mask_component = MaskComponent:new(mask_img.gameObject)
  end
end

function ui:_set_show()
  if self.v_need_show then
    self:ui_show(table.unpack(self.v_show_data))
  end
end

function ui:check_canvas_order(cur_order)
  local order = Global.ui_mgr.cache_ui_order[cur_order]
  if nil == order then
    return cur_order
  end
  local canvas_order = cur_order + order
  Global.ui_mgr.cache_ui_order[cur_order] = order + 1
  return canvas_order
end

function ui:has_inited()
  return self.v_finish_init
end

function ui:is_ready()
  return self.v_finish_init and not self.v_is_destroy and not Util.is_nil(self.v_object)
end

function ui:_init_panels()
  local cfg = self.v_cfg
  if not cfg.panels then
    return
  end
  for _, panel_cfg in ipairs(cfg.panels) do
    local root_obj
    if panel_cfg.root then
      root_obj = self:get_uiobject(panel_cfg.root)
    elseif panel_cfg.resource then
      root_obj = ResMgr:load_gameobj(self:get_resource_path(panel_cfg.resource), nil, true)
      root_obj.transform:SetParent(self.v_object_transform, false)
    else
      assert(nil)
    end
    assert(root_obj, panel_cfg.root or panel_cfg.resource)
    local class = require("uimodule." .. panel_cfg.class)
    assert(type(class) == "table", panel_cfg.class)
    local class_obj = class:ui_wrap_common(self, root_obj)
    self:add_panel(panel_cfg.name, class_obj, panel_cfg.initshow or false)
  end
end

function ui:ui_show(...)
  if self:_wait_finish(...) then
    return
  end
  local show_after_panel = self.v_cfg.show_after_panel
  if show_after_panel then
    local after_ui = Global.ui_mgr:try_get_visible_ui(show_after_panel)
    if after_ui then
      after_ui:set_hide_cb(function(...)
        self:ui_show(...)
      end)
      return
    end
  end
  self:_clear_show_data()
  if self.v_mask_component then
    self.v_mask_component:on_uibase_show()
  end
  if self.v_cfg.is_end_joystick then
    Joystick.on_joystick("end")
  end
  if self.v_cfg.is_set_player_control_off then
    SceneMgr:set_player_control_off()
  end
  self:change_canvas_raycaster(true)
  self:set_plane_distance()
  if self.v_view_level == Global.config.UI_VIEW_LEVEL.MAIN_VIEW then
    Global.ui_mgr:set_current_fullscreen(self.v_ui_name, true)
  end
  local cfg = self.v_cfg
  if cfg.sort_order <= Config.UI_SORT_ORDER.System and not cfg.parent_ui and not cfg.world and not cfg.no_push_stack then
    Global.ui_mgr:push_ui(self)
  end
  local last_visible = self.v_visible
  Base.ui_show(self, ...)
  if self.v_cfg.use_low_render_frame then
    UIMgr:set_render_frame(self, true)
  end
  if not last_visible then
    self:set_panel_order()
  end
  if GuideMgr then
    GuideMgr:check_sys_guide(self)
  end
  if not SceneMgr:check_main_scene() and self.v_cfg.need_pause_game and not last_visible then
    UIMgr:add_set_game_pause_count(1)
  end
  self:send_ui_show_message()
end

function ui:send_ui_show_message()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_UI)
  msg.mm_obj = self.v_cfg.name
  msg.mm_y = self.v_cfg.show_model_camera_ui
end

function ui:send_ui_hide_message()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_HIDE_UI)
  msg.mm_obj = self.v_cfg.name
end

function ui:set_visible_by_distance(is_visible, ...)
  local canvas = self:get_canvas()
  canvas.planeDistance = is_visible and 100 or 0
  local graph_ray_com = self:get_component(nil, canvas, GraphicRaycaster)
  if graph_ray_com then
    graph_ray_com.enabled = is_visible
  end
  if is_visible then
    self:send_ui_show_message()
  else
    self:send_ui_hide_message()
  end
  self:_call_sub_panels_function("set_visible_by_distance", is_visible, ...)
end

function ui:set_panel_order()
  if self:skip_sort_order() then
    return
  end
  local canvas = self.canvas or self:get_canvas()
  if not canvas then
    return
  end
  if self.v_cfg.sort_order then
    local new_order = self:check_canvas_order(self.v_cfg.sort_order)
    canvas.sortingOrder = new_order
  end
  self:_set_sub_panel_order()
end

function ui:_set_sub_panel_order()
  for _, v in pairs(self.v_sub_panels) do
    if v:visible() and v.set_panel_order then
      v:set_panel_order()
    end
  end
end

function ui:ui_update(delta_time)
  if self.v_mask_component then
    self.v_mask_component:on_uibase_update()
  end
  if not (self.v_update_interval and self.v_last_update_time) or Global.real_time - self.v_last_update_time > self.v_update_interval then
    Base.ui_update(self, delta_time)
    self.v_last_update_time = Global.real_time
  end
end

function ui:visible()
  return self.v_visible
end

function ui:need_show()
  return self.v_need_show
end

function ui:cache_ui()
  return false
end

function ui:get_cache_data()
  return {}
end

function ui:_ui_hide(is_force, is_auto, is_destroy)
  if self:visible() then
    self:send_ui_hide_message()
    local canvas = self:get_canvas()
    canvas.planeDistance = 100
    if not SceneMgr:check_main_scene() and self.v_cfg.need_pause_game then
      UIMgr:add_set_game_pause_count(-1)
    end
  end
  self:_clear_blur()
  self:_clear_show_data()
  if self.v_mask_component then
    self.v_mask_component:on_uibase_hide()
  end
  if self.v_cfg.use_low_render_frame then
    UIMgr:set_render_frame(self)
  end
  Base.ui_hide(self, is_force, is_auto)
  Global.ui_mgr:refresh_ui_canvas_order(self.v_cfg.sort_order)
  if self.v_view_level == Global.config.UI_VIEW_LEVEL.MAIN_VIEW then
    Global.ui_mgr:set_current_fullscreen(self.v_ui_name, false)
  end
  self:_call_sub_panels_function("ui_hide", is_force, is_auto)
  local cfg = self.v_cfg
  if not is_destroy and cfg.sort_order <= Config.UI_SORT_ORDER.System and not cfg.parent_ui and not cfg.no_push_stack then
    Global.ui_mgr:pop_ui(self)
  end
  if self.v_cfg.is_set_player_control_off then
    SceneMgr:set_player_control_on()
  end
  if self.v_on_hide_pd and not self.v_on_hide_pd:IsNull() then
    self.v_on_hide_pd:Stop()
  end
  Base.call_ui_after_hide(self)
end

function ui:_check_ui_hide_after_exiting_pd(is_force, is_auto, is_destroy)
  if is_force or is_destroy or Util.is_nil(self.v_object) then
    return
  end
  local ui_container = self:get_component(nil, nil, CS.UIContainer)
  if ui_container and not Util.is_nil(ui_container.ExitPD) then
    local exit_pd = ui_container.ExitPD
    local no_canvas_group
    local canvas_group = self:get_canvas_group()
    no_canvas_group = Util.is_nil(canvas_group)
    if no_canvas_group then
      canvas_group = self.v_object.gameObject:AddComponent(typeof(UnityUICanvasGroup))
    end
    canvas_group.blocksRaycasts = false
    self.v_on_exiting_pd = true
    self:set_playable_stopped_action(exit_pd, function()
      if self:is_destroy() or not self:visible() then
        return
      end
      self.v_on_exiting_pd = false
      if no_canvas_group then
        self.v_object.gameObject:TryRemoveComponent(typeof(UnityUICanvasGroup))
      else
        local _canvas_group = self:get_canvas_group()
        _canvas_group.blocksRaycasts = true
      end
      self:_ui_hide(is_force, is_auto, is_destroy)
      if not Util.is_nil(exit_pd) then
        self:remove_playable_stopped_action(exit_pd)
      end
      if self.v_open_default_ui then
        UIMgr:open_default_ui(false)
      end
    end)
    exit_pd:RePlayPD()
    if self.v_open_default_ui then
      UIMgr:open_default_ui(true)
    end
    return true
  end
  return false
end

function ui:ui_hide(is_force, is_auto, is_destroy)
  if self.v_on_exiting_pd then
    return
  end
  if self:visible() and not is_destroy and not is_force and self:_check_ui_hide_after_exiting_pd(is_force, is_auto, is_destroy) then
    return
  end
  self:_ui_hide(is_force, is_auto, is_destroy)
end

function ui:_clear_show_data()
  self.v_need_show = false
  self.v_show_data = nil
end

function ui:ui_destroy()
  self:ui_hide(nil, nil, true)
  local cache_on_destory = self.v_cfg.cache_on_destory
  if cache_on_destory then
    UIMgr:cache_ui_prefab(self:ui_get_name(), self.v_object)
    self:cache_ui_prefab_clear()
  end
  if self.v_isdynamic then
    Global.ui_mgr:destroy_dynamic_ui(self)
  else
    Global.ui_mgr:on_destroy_ui(self:ui_get_name(), self)
  end
  Base.ui_destroy(self)
  RedPointMgr:unbind_redpoint_by_ui(self)
  if self.v_object then
    if not cache_on_destory then
      Global.res_mgr:destroy_gameobj(self.v_object)
    end
    self.v_object = nil
  end
  self.canvas = nil
  if self.v_cfg.panels then
    for _, panel_cfg in ipairs(self.v_cfg.panels) do
      if panel_cfg.resource then
        local path
        if res_path_map and res_path_map[panel_cfg.resource] then
          path = res_path_map[panel_cfg.resource]
        else
          path = "ui/" .. panel_cfg.resource
        end
        ResMgr:unload_res(path)
      end
    end
  end
  self.v_finish_init = false
  if nil ~= self.v_parent_panel then
    self.v_parent_panel:ui_remove_sub_panel(self)
    self.v_parent_panel = nil
  end
  self:_call_sub_panels_function("ui_destroy")
  self.v_sub_panels = nil
  self.v_safe_panel_rect = nil
  res_path_map = nil
end

function ui:ui_can_auto_destroy(now_time)
  if not (self.v_finish_init and (not self.v_background_blur or self.v_blur_texture)) or self.v_cache > 100000 then
    return false
  end
  if self.v_cfg.preload_type then
    return false
  end
  if not self.v_last_hide_time then
    Global.log.Debug("------------ hide but not value " .. self.v_cfg.class .. ", " .. self.v_cfg.name, debug.traceback())
    return true
  end
  if now_time - self.v_last_hide_time > self.v_cache then
    return true
  end
end

function ui:alive_in_scene_type(target_scene_type)
  if self.v_cfg.no_destroy then
    return true
  end
  if self.v_cfg.scene_type and self.v_cfg.scene_type & 1 << target_scene_type > 0 then
    return true
  end
  if self.v_cfg.preload_type and self.v_cfg.preload_type & 1 << target_scene_type > 0 then
    return true
  end
  return false
end

function ui:try_ui_add_sub_panels(sub_ui)
  if self.v_sub_panels[sub_ui.v_ui_name] ~= nil then
    return
  end
  self:ui_add_sub_panels(sub_ui)
end

function ui:ui_add_sub_panels(sub_ui)
  if self.v_sub_panels[sub_ui.v_ui_name] ~= nil then
    Log.Error("add duplicate sub panel with name = ", sub_ui.v_ui_name, debug.traceback())
    return false
  end
  self.v_sub_panels[sub_ui.v_ui_name] = sub_ui
  sub_ui:set_parent_panel(self)
  return true
end

function ui:ui_remove_sub_panel(ui)
  if self.v_sub_panels[ui.v_ui_name] == nil then
    Log.Info("panel need remove don not exit in list !!")
    return false
  end
  self.v_sub_panels[ui.v_ui_name] = nil
  return true
end

function ui:set_parent_panel(parent)
  self.v_parent_panel = parent
end

function ui:get_parent_panel()
  return self.v_parent_panel
end

function ui:_call_sub_panels_function(function_name, ...)
  assert(function_name)
  if self.v_sub_panels then
    for _, panel in pairs(self.v_sub_panels) do
      assert(panel[function_name])
      panel[function_name](panel, ...)
    end
  end
end

function ui:_wait_finish(...)
  local need_wait = false
  if not self.v_finish_init or self.v_background_blur and not self.v_blur_texture then
    need_wait = true
  end
  if need_wait then
    self.v_need_show = true
    self.v_show_data = table.pack(...)
    if self.v_finish_init then
      Global.ui_mgr:set_backgroud_blur(self.v_cfg.name, self._set_blur_img, self)
    end
  end
  return need_wait
end

function ui:_set_blur_img(blur_img, ui_blur)
  if not self.v_object or not self.v_blur_img then
    if not self.v_blur_img then
      Log.Error("ui don't have blur componet", self:ui_get_name())
    end
    Global.ui_mgr:remove_backgroud_blur(self.v_cfg.name)
    return
  end
  self.v_blur_img.gameObject:SetActive(ui_blur)
  if ui_blur then
    self.v_blur_img.texture = blur_img
  else
    self.v_blur_img.texture = nil
  end
  self.v_blur_texture = true
  if self.v_finish_init and not self:is_destroy() then
    self:_on_ui_ready()
  end
end

function ui:_clear_blur()
  if self.v_background_blur == true then
    self:release_blur_texture()
  end
end

function ui:release_blur_texture()
  if not self.v_blur_img then
    Log.Error("ui don't have blur componet", self:ui_get_name())
  end
  self.v_blur_img.texture = nil
  self.v_blur_img.gameObject:SetActive(false)
  Global.ui_mgr:remove_backgroud_blur(self.v_cfg.name)
  self.v_blur_texture = nil
end

function ui:_on_ui_ready()
  self.v_finish_init = true
  self:_set_ui_mask()
  self:_set_show()
end

function ui:ui_get_depth()
  return self.v_cfg.depth_group or 0
end

function ui:ui_get_name()
  return self.v_cfg.name
end

function ui:get_cfg()
  return self.v_cfg
end

function ui:ui_is_fullscreen()
  return self.v_cfg.is_fullscreen
end

function ui:on_model_view_load_gameobj()
end

function ui:cache_ui()
  return false
end

function ui:cache_hide_ui()
  return true
end

function ui:get_ui_level()
  return self.v_view_level
end

function ui:change_canvas_raycaster(is_on)
  local canvas = self:get_canvas()
  local graph_ray_com = Util.get_component(nil, canvas, GraphicRaycaster)
  if graph_ray_com then
    graph_ray_com.enabled = is_on
  end
end

function ui:set_plane_distance()
  local canvas = self:get_canvas()
  canvas.planeDistance = 100
end

function ui:get_safe_panel_rect()
  return self.v_safe_panel_rect
end

function ui:set_safe_panel_hidden()
  local canvas_group = self.v_safe_panel_rect:GetComponent("CanvasGroup")
  if canvas_group and not canvas_group:IsNull() then
    canvas_group.alpha = 0
    canvas_group.interactable = false
  end
  self:update_effect_obj_visible(false)
  self:on_set_safe_panel_alpha(false)
end

function ui:set_safe_panel_visible()
  local canvas_group = self.v_safe_panel_rect:GetComponent("CanvasGroup")
  if canvas_group and not canvas_group:IsNull() then
    canvas_group.alpha = 1
    canvas_group.interactable = true
  end
  self:update_effect_obj_visible(true)
  self:on_set_safe_panel_alpha(true)
end

function ui:update_effect_obj_visible(is_visible)
end

function ui:on_set_safe_panel_alpha(is_visible)
end

function ui:on_background_show()
  return false
end

function ui:response_click_escape()
  return UIMgr.RESPONCE_ESCAPE_TYPE.AUTO_CALL
end

function ui:on_exiting_pd()
  return self.v_on_exiting_pd
end

return ui
