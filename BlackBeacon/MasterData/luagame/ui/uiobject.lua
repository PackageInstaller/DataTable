local Math = require("base.mathx")
local Const = require("const")
local SHOP_HELPER = require("uimodule.shop.shop_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local CSUnityEngine = UnityEngine
local UnityGraphic = CSUnityEngine.UI.Graphic
local UnityShader = CSUnityEngine.Shader
local UnityMaterial = CSUnityEngine.Material
local Folder = require("ui.widget.widget_folder_ex")
local AsyncMgr = require("utils.async_mgr")
local TypeCustomDOTween = typeof(CS.CustomDOTween)
local BIND_TYPE = Config.BIND_TYPE
local NORMAL_BIND_TBL = {
  [BIND_TYPE.TRANSFORM] = TypeUnityRectTransform,
  [BIND_TYPE.IMAGE] = TypeUnityUIImage,
  [BIND_TYPE.TEXT] = TypeUnityUIText,
  [BIND_TYPE.BUTTON] = TypeUnityUIButton,
  [BIND_TYPE.TOGGLE] = TypeUnityUIToggle,
  [BIND_TYPE.INPUT] = TypeUnityUIInputField,
  [BIND_TYPE.SCROLL] = TypeUnityUIScrollRect,
  [BIND_TYPE.DROPDOWN] = TypeUnityUIDropdown,
  [BIND_TYPE.SCROLL_EX] = TypeCSScrollRectEx,
  [BIND_TYPE.SLIDER] = TypeUnityUISlider,
  [BIND_TYPE.BUTTON_EX] = TypeCSButtonEx,
  [BIND_TYPE.RAW_IMAGE] = TypeUnityUIRawImage,
  [BIND_TYPE.UIPARTICLE] = TypeUIParticle,
  [BIND_TYPE.PLAYABLEDIRECTOR] = TypePlayableDirector,
  [BIND_TYPE.CANVAS_GROUP] = TypeCanvasGroup
}
local COMP_TO_LAST_NAME = {
  [TypeUnityUIText] = "_txt",
  [TypeUnityUIButton] = "_btn",
  [TypeUnityUIImage] = "_img",
  [TypeUnityUISlider] = "_sld",
  [TypeUnityUIToggle] = "_tog",
  [TypeUnityRectTransform] = "_rect",
  [TypePlayableDirector] = "_pd",
  [TypeCanvasGroup] = "_cg"
}
local ui = {}
ui.__index = ui

function ui:ui_wrap_common(parent, obj, init_show)
  self = setmetatable({}, self)
  self.v_visible_record = {}
  self:_init_common(obj)
  self.v_parent_ui = parent
  self.v_enable = init_show
  if init_show then
    self:ui_show()
  end
  return self
end

function ui:ui_wrap(parent, obj, init_show)
  self = self:ui_wrap_common(parent, obj, init_show)
  if parent then
    parent:add_wrap_ui(self)
  end
  self:init_ui_objlist()
  self:ui_finish_load()
  return self
end

function ui:ui_wrap_ex(parent, obj, init_show)
  self = self:ui_wrap_common(parent, obj)
  if parent then
    parent:add_wrap_ui(self)
  end
  self:init_ui_objlist()
  self:ui_finish_load()
  self.v_enable = init_show
  if init_show then
    self:ui_show()
  end
  return self
end

function ui:_init_common(obj)
  obj:SetActive(false)
  self.v_msg_handles = {}
  self.v_wrap_uis = {}
  self.v_need_remove_wrap_uis = {}
  self.v_panels = {}
  self.v_panels_arr = {}
  self.v_object = obj
  self.v_object_transform = obj.transform
  self.v_parent_ui = nil
  self.v_visible = false
  self.v_enable = true
  self.v_auto_cache_list = {}
  self.v_auto_cache_to_key = {}
  self.v_func_list = {}
  Global.listener_mgr:on_add_ui(self.v_object)
end

function ui:_call_panels_function(function_name, ...)
  assert(function_name)
  if self.v_panels then
    for _, panel in pairs(self.v_panels) do
      assert(panel[function_name])
      panel[function_name](panel, ...)
    end
  end
end

function ui:_call_wrap_ui_function(function_name, ...)
  assert(function_name)
  if self.v_wrap_uis then
    for wrap_ui in pairs(self.v_wrap_uis) do
      assert(wrap_ui[function_name])
      wrap_ui[function_name](wrap_ui, ...)
    end
  end
end

function ui:add_wrap_ui(ui)
  self.v_wrap_uis[ui] = true
end

function ui:remove_wrap_ui(ui)
  self.v_wrap_uis[ui] = nil
  if self.v_need_remove_wrap_uis then
    self.v_need_remove_wrap_uis[ui] = true
  end
end

function ui:remove_wrap_ui_list(wrap_list)
  for _, wrap_ui in pairs(wrap_list) do
    self:remove_wrap_ui(wrap_ui)
  end
end

function ui:add_panel(panel_name, ui_class, is_enable)
  assert(panel_name)
  assert(ui_class)
  assert(nil ~= is_enable)
  self.v_panels[panel_name] = ui_class
  self.v_panels_arr[#self.v_panels_arr + 1] = ui_class
  ui_class.v_enable = is_enable
end

function ui:get_panel(panel_name)
  assert(panel_name, "panel name is nil")
  assert(self.v_panels[panel_name], "can't find panel by name: " .. panel_name)
  return self.v_panels[panel_name]
end

function ui:get_panel_by_id(idx)
  return self.v_panels_arr[idx]
end

function ui:get_panels()
  return self.v_panels
end

function ui:get_wraps()
  return self.v_wrap_uis
end

function ui:set_panel_enable(panel_name, enable, ...)
  local panel = self.v_panels[panel_name]
  if not panel then
    return
  end
  panel:set_enable(enable, ...)
end

function ui:get_parent_canvas()
  local obj = self
  while not obj.v_canvas and obj.v_parent_ui do
    obj = obj.v_parent_ui
  end
  return obj.v_canvas
end

function ui:set_enable(is_enable, ...)
  assert(nil ~= is_enable)
  if self.v_enable == is_enable then
    return
  end
  self.v_enable = is_enable
  if not self.v_parent_ui or self.v_parent_ui.v_visible then
    if is_enable then
      self:ui_show(...)
    else
      self:ui_hide()
    end
  end
end

function ui:set_enable_ex(is_enable, ...)
  assert(nil ~= is_enable)
  if self.v_enable == is_enable then
    return
  end
  self.v_enable = is_enable
  if is_enable then
    self:ui_show(...)
  else
    self:ui_hide()
  end
end

function ui:get_enable()
  return self.v_enable
end

function ui:ui_on_load()
  self.v_visible_record = {}
  self:ui_finish_load()
  self:_call_panels_function("init_ui_objlist", self.v_object)
  self:_call_panels_function("ui_on_load", self.v_object)
  self:ui_all_finish_load()
  if not self.v_cfg or not self.v_cfg.skip_init_common_widget then
    self:_init_common_widget()
  end
  self:check_create_asset_bar()
end

function ui:refresh_language_text()
  Util.refresh_language_text(self.v_object)
end

function ui:refresh_language_image()
  if not self.v_object then
    return
  end
  local image_languages = self.v_object.gameObject:GetComponentsInChildren(typeof(CS.ImageLanguage), true)
  if 0 == image_languages.Length then
    return
  end
  for i = 0, image_languages.Length - 1 do
    local image_language = image_languages[i]
    if Util.is_nil(image_language) then
    else
      local image = image_language.gameObject:GetComponent(typeof(UnityEngineUI.Image))
      if Util.is_nil(image) then
        Log.Error("未找到Image组件,但挂载了ImageLanguage", tostring(image_language.gameObject.name))
      elseif 1 ~= image_language.Type and 2 ~= image_language.Type then
      elseif image_language.Path and image_language.Path ~= "" then
        local is_sprite_exit = false
        if 1 == image_language.Type then
          is_sprite_exit = Path.is_file_exist(Path.get_texture_path(image_language.Path), UnityEngine.Sprite)
        else
          is_sprite_exit = Path.is_file_exist(Path.get_image_icon_path(image_language.Path), UnityEngine.Sprite)
        end
        if not is_sprite_exit then
          Log.Error("ImageLanguage配置错误 节点名", image_language.gameObject.name, "图片不存在", image_language.Path)
        else
          ResMgr:load_set_icon_sync(image, image_language.Path, nil, 1 == image_language.Type)
        end
      end
    end
  end
end

function ui:init_ui_objlist()
  local ui_container = self:get_component(nil, nil, CS.UIContainer)
  self.v_uiobjects = {}
  self.v_uicompents = {}
  if ui_container then
    local list_name = ui_container.ListName
    local list_objects = ui_container.ListObj
    local list_comp_name = ui_container.ListCompName
    local list_comp_objects = ui_container.ListComponent
    for i = 0, list_name.Count - 1 do
      local name = list_name[i]
      local object = list_objects[i]
      self.v_uiobjects[name] = object
    end
    for i = 0, list_comp_name.Count - 1 do
      local name = list_comp_name[i]
      local component = list_comp_objects[i]
      self.v_uicompents[name] = component
    end
    if ui_container.OnHidePd and not ui_container.OnHidePd:IsNull() then
      self.v_on_hide_pd = ui_container.OnHidePd
    end
    if ui_container.PdDuration and ui_container.PdDuration > 0 then
      self.v_hide_pd_duration = ui_container.PdDuration
    end
    if ui_container.NoClickImg and not ui_container.OnHidePd:IsNull() then
      self.v_no_click_img_uicon = ui_container.NoClickImg
    end
    if ui_container and not Util.is_nil(ui_container.ExitPD) then
      self.v_exit_pd = ui_container.ExitPD
    end
    self:_init_self_object()
  end
  self:refresh_language_image()
  self:refresh_language_text()
end

local NORMAL_BIND_TBL_2 = {
  [BIND_TYPE.TRANSFORM] = "rect",
  [BIND_TYPE.IMAGE] = "img",
  [BIND_TYPE.TEXT] = "txt",
  [BIND_TYPE.BUTTON] = "btn",
  [BIND_TYPE.TOGGLE] = "tog",
  [BIND_TYPE.RAW_IMAGE] = "rimg",
  [BIND_TYPE.UIPARTICLE] = "ptc",
  [BIND_TYPE.SLIDER] = "sld",
  [BIND_TYPE.PLAYABLEDIRECTOR] = "pd",
  [BIND_TYPE.CANVAS_GROUP] = "cg"
}

function ui:_init_self_object()
  local len = string.len(self.v_object.name)
  local idx = string.find(self.v_object.name, "_")
  if not idx or idx ~= len then
    return
  end
  local obj_name = string.sub(self.v_object.name, 1, len - 1)
  self.v_uiobjects[obj_name] = self.v_object
  for k, v in pairs(NORMAL_BIND_TBL_2) do
    local component = self.v_object:GetComponent(NORMAL_BIND_TBL[k])
    if component then
      local com_name = self.v_object.name .. v
      self.v_uicompents[com_name] = component
    end
  end
end

function ui:get_uiobject(name, component)
  if not self.v_uiobjects then
    return
  end
  local obj = self.v_uiobjects[name]
  if obj and component then
    if component == BIND_TYPE.OBJECT then
      return obj
    elseif COMP_TO_LAST_NAME[component] then
      return self.v_uicompents[name .. COMP_TO_LAST_NAME[component]]
    else
      return obj:GetComponent(NORMAL_BIND_TBL[component])
    end
  else
    return obj
  end
end

function ui:ui_finish_load()
end

function ui:ui_all_finish_load()
end

function ui:ui_show(...)
  if not self.v_enable then
    return
  end
  self.v_visible_record = {}
  if self.v_visible then
    self.v_last_is_pressed = nil
    self.v_last_pressed_obj = nil
    self:ui_before_show(...)
    self:_call_panels_function("ui_show", ...)
    self:_call_wrap_ui_function("ui_show", ...)
    self:ui_after_show(...)
  else
    if not self.v_object or self.v_object:IsNull() then
      Log.Error("ui_show: self.v_object is null", debug.traceback())
      return
    end
    self.v_object:SetActive(true)
    self:_ui_on_show_internaval()
    self.v_visible = true
    self:ui_before_show(...)
    self:ui_on_show(...)
    self:ui_func_check()
    self:_call_panels_function("ui_show", ...)
    self:_call_wrap_ui_function("ui_show", ...)
    self:ui_after_show(...)
    self:set_no_click(false)
    if self.v_cfg and self.v_cfg.is_settle_ui and not SceneMgr:check_main_scene() then
      MsgGame:mq_publish2(Const.MSG_ON_OPEN_SETTLE_UI)
    end
    if self.v_base_asset_bar then
      self.v_base_asset_bar:on_create()
    end
  end
end

function ui:ui_after_show(...)
end

function ui:ui_before_show(...)
end

function ui:_ui_on_show_internaval()
  if self.v_clear_all_cache_data_timer then
    Timer:remove_timer(self.v_clear_all_cache_data_timer)
    self.v_clear_all_cache_data_timer = nil
  end
  Global.ui_mgr:on_show_ui(self)
end

function ui:ui_on_show(...)
end

function ui:ui_update(delta_time)
  if not self.v_visible then
    return
  end
  self:update_effects(delta_time)
  self:ui_on_update(delta_time)
  self:_call_panels_function("ui_update", delta_time)
end

function ui:ui_on_update(delta_time)
end

function ui:_ui_clean_up(force)
  self:remove_all_effects()
  self:unbind_all_auto_mq()
  self:give_back_all_auto_cache()
  self:_clear_all_cache_data(force)
  self:unregister_ui_funcs()
  if force then
    self:remove_all_listeners()
  end
  self.v_last_pressed_obj = nil
  self.v_last_is_pressed = nil
end

function ui:set_hide_cb(cb)
  self.v_hide_cb = cb
end

function ui:ui_hide(is_force, is_auto)
  if not self.v_visible then
    return
  end
  self.v_visible = false
  Global.ui_mgr.ui_res_mgr:release_all_item_res(self)
  self:_call_panels_function("ui_hide")
  self:_call_wrap_ui_function("ui_hide")
  self:_ui_clean_up()
  self:_ui_on_hide_internal(is_force, is_auto)
  self:ui_on_hide()
  if self.v_hide_cb then
    self.v_hide_cb()
    self.v_hide_cb = nil
  end
  if self.v_object and not self.v_object:IsNull() then
    self.v_object:SetActive(false)
  end
  if self.v_folder_list then
    for _, folder in ipairs(self.v_folder_list) do
      folder:on_reset()
    end
  end
  if self.v_async_list then
    for _, t in ipairs(self.v_async_list) do
      AsyncMgr:del_async(t)
    end
  end
  if self.v_playing_effects then
    for effect_name, _ in pairs(self.v_playing_effects) do
      local effect_info = self.v_effects[effect_name]
      if not effect_info.is_effect_status then
        effect_info.uiparticle:Stop()
      else
        effect_info.effect_status:StopAll()
      end
    end
  end
  if self.v_cfg and self.v_cfg.destroy_on_hide and not self.v_is_destroy then
    self:ui_destroy()
  end
  self:clear_ui_visible_record()
  if self.v_base_asset_bar then
    self.v_base_asset_bar:on_hide()
  end
end

function ui:_ui_on_hide_internal(is_force, is_auto)
  Global.ui_mgr:on_hide_ui(self, is_force, is_auto)
  self.v_last_hide_time = Global.real_time
end

function ui:ui_on_hide()
end

function ui:call_ui_after_hide()
  self:ui_after_hide()
end

function ui:ui_after_hide()
end

function ui:ui_destroy()
  self:_call_panels_function("ui_destroy")
  self:_call_wrap_ui_function("ui_destroy")
  self:unregister_all_auto_template()
  self:_ui_clean_up(true)
  self:remove_timer()
  if self.v_instantiate_mat then
    for _, mat in pairs(self.v_instantiate_mat) do
      Global.res_mgr:destroy_gameobj(mat)
    end
    self.v_instantiate_mat = nil
  end
  if self.v_loaded_texture_dic then
    for icon_path, count in pairs(self.v_loaded_texture_dic) do
      ResMgr:unload_texture(icon_path, count)
    end
    self.v_loaded_texture_dic = nil
  end
  if self.v_need_remove_wrap_uis then
    for ui, _ in pairs(self.v_need_remove_wrap_uis) do
      ui:ui_destroy()
    end
  end
  self.v_need_remove_wrap_uis = nil
  if self.v_parent_ui then
    self.v_parent_ui.v_wrap_uis[self] = nil
  end
  self.v_is_destroy = true
  self.v_visible = false
  self.v_enable = false
  self.v_panels = nil
  self.v_panels_arr = nil
  self.v_uicompents = nil
  self.v_uiobjects = nil
  self.v_effects = nil
  self.v_playing_effects = nil
  if self.v_base_asset_bar then
    self.v_base_asset_bar:on_destory()
    self.v_base_asset_bar = nil
  end
  if UIEffectMgr then
    UIEffectMgr:clear_ui_effect(self)
  end
  self.v_effect_name_to_id_map = nil
  self:ui_on_destroy()
end

function ui:is_destroy()
  return self.v_is_destroy
end

function ui:ui_on_destroy()
end

function ui:add_texture_reference(key)
  local dic = self.v_loaded_texture_dic or {}
  dic[key] = dic[key] and dic[key] + 1 or 1
  self.v_loaded_texture_dic = dic
end

function ui:register_auto_template(template_key, parent)
  assert(template_key)
  assert(not self.v_auto_cache_list[template_key], template_key)
  CacheMgr:register_template(template_key, parent)
  self.v_auto_cache_list[template_key] = {}
end

function ui:register_exist_auto_template(template_key, obj, parent, capacity)
  assert(template_key)
  assert(not self.v_auto_cache_list[template_key], template_key)
  assert(obj)
  CacheMgr:register_exist_template(template_key, obj, parent, capacity)
  obj:SetActive(false)
  self.v_auto_cache_list[template_key] = {}
end

function ui:register_exist_auto_template_by_config(template_key, obj, parent, config)
  assert(template_key)
  assert(not self.v_auto_cache_list[template_key], template_key)
  assert(obj)
  CacheMgr:register_exist_template_by_config(template_key, obj, parent, config)
  obj:SetActive(false)
  self.v_auto_cache_list[template_key] = {}
end

function ui:unregister_template(template_key)
  if not self.v_auto_cache_list then
    return
  end
  CacheMgr:unregister_template(template_key)
  self.v_auto_cache_list[template_key] = nil
  for obj, key in pairs(self.v_auto_cache_to_key) do
    if key == template_key then
      self.v_auto_cache_to_key[obj] = nil
    end
  end
end

function ui:unregister_all_auto_template()
  if not self.v_auto_cache_list then
    return
  end
  for template_key, _ in pairs(self.v_auto_cache_list) do
    CacheMgr:unregister_template(template_key)
    self.v_auto_cache_list[template_key] = nil
  end
  self.v_auto_cache_to_key = {}
end

function ui:get_auto_cache(template_key)
  assert(template_key)
  assert(self.v_auto_cache_list[template_key], template_key)
  local cache = CacheMgr:pop_from_cache(template_key)
  table.insert(self.v_auto_cache_list[template_key], cache)
  self.v_auto_cache_to_key[cache] = template_key
  return cache
end

function ui:create_effect(effect_name, parent, callback)
  local effect_id = Global.ui_effect_mgr:create_effect(effect_name, parent, callback)
  self.v_effect_ids = self.v_effect_ids or {}
  self.v_effect_ids[effect_id] = true
  return effect_id
end

function ui:remove_effect(effect_id)
  assert(effect_id)
  self.v_effect_ids[effect_id] = nil
  Global.ui_effect_mgr:remove_effect_by_effect_id(effect_id)
end

function ui:remove_all_effects()
  if self.v_effect_ids then
    local ui_effect_mgr = Global.ui_effect_mgr
    for eid, _ in pairs(self.v_effect_ids) do
      ui_effect_mgr:remove_effect_by_effect_id(eid)
    end
  end
end

function ui:get_using_auto_cache_list(template_key)
  assert(template_key)
  assert(self.v_auto_cache_list[template_key], template_key)
  return self.v_auto_cache_list[template_key]
end

function ui:give_back_auto_cache(template_key, change_parent)
  assert(template_key)
  if not self.v_auto_cache_list[template_key] then
    Log.Error("give_back_auto_cache fail, no such cache by key:", template_key, debug.traceback())
    return
  end
  local cache_list = self.v_auto_cache_list[template_key]
  for i = #cache_list, 1, -1 do
    self.v_auto_cache_to_key[cache_list[i]] = nil
    CacheMgr:push_to_cache(template_key, cache_list[i], change_parent)
    table.remove(cache_list, i)
  end
end

function ui:give_back_auto_cache_obj(_, obj, change_parent)
  local template_key = self.v_auto_cache_to_key[obj]
  assert(self.v_auto_cache_to_key[obj])
  assert(self.v_auto_cache_list[template_key])
  local cache_list = self.v_auto_cache_list[template_key]
  local cache_len = #cache_list
  for i = 1, cache_len do
    if cache_list[i] == obj then
      CacheMgr:push_to_cache(template_key, cache_list[i], change_parent)
      table.remove(cache_list, i)
      break
    end
  end
  self.v_auto_cache_to_key[obj] = nil
end

function ui:give_back_all_auto_cache(change_parent)
  if self.v_auto_cache_list and next(self.v_auto_cache_list) then
    for template_key, cache_list in pairs(self.v_auto_cache_list) do
      for i = #cache_list, 1, -1 do
        CacheMgr:push_to_cache(template_key, cache_list[i], change_parent)
        table.remove(cache_list, i)
      end
    end
  end
  self.v_auto_cache_to_key = {}
end

local function _do_destroy_all_cache(self, is_force)
  for template_key, cache_list in pairs(self.v_auto_cache_list) do
    CacheMgr:clear_cache(template_key)
    if is_force then
      self.v_auto_cache_list[template_key] = nil
    else
      self.v_auto_cache_list[template_key] = {}
    end
  end
end

function ui:_clear_all_cache_data(is_force)
  if self.v_auto_cache_list and next(self.v_auto_cache_list) then
    if self.v_clear_all_cache_data_timer then
      Timer:remove_timer(self.v_clear_all_cache_data_timer)
      self.v_clear_all_cache_data_timer = nil
    end
    local cache = not self.v_cache and self.v_parent_ui and self.v_parent_ui.v_cache
    if is_force or not cache then
      _do_destroy_all_cache(self, is_force)
    else
      cache = math.min(cache / 2, 100)
      self.v_clear_all_cache_data_timer = Timer:add_timer("do destroy all cache", cache, _do_destroy_all_cache, self, false)
    end
  end
end

function ui:fade_hide_and_push_all_to_cache()
  for template_key, cache_list in pairs(self.v_auto_cache_list) do
    local dirty = false
    for i = #cache_list, 1, -1 do
      local obj = cache_list[i]
      cache_list[i]:setlocalPositionA(0, 1000000, 0)
      CacheMgr:raw_push_to_cache(template_key, cache_list[i])
      self.v_auto_cache_to_key[obj] = nil
      dirty = true
    end
    if dirty then
      self.v_auto_cache_list[template_key] = {}
    end
  end
end

function ui:raw_push_all_to_cache()
  for template_key, cache_list in pairs(self.v_auto_cache_list) do
    for i = #cache_list, 1, -1 do
      local obj = cache_list[i]
      CacheMgr:raw_push_to_cache(template_key, obj)
      self.v_auto_cache_to_key[obj] = nil
    end
    self.v_auto_cache_list[template_key] = {}
  end
end

function ui:raw_set_all_cache_active(is_active)
  for template_key, cache_list in pairs(self.v_auto_cache_list) do
    CacheMgr:raw_set_all_cache_active(template_key, is_active)
  end
end

function ui:register_ui_func(func_info)
  assert(func_info)
  local obj = func_info[1]
  local func_id = func_info[2]
  assert(obj and func_id)
  self.v_func_list[func_id] = self.v_func_list[func_id] or {}
  table.insert(self.v_func_list[func_id], func_info)
end

function ui:register_ui_funcs(func_list)
  assert(func_list)
  for _, v in ipairs(func_list) do
    self:register_ui_func(v)
  end
  self:bind_auto_mq(Const.MSG_ON_UPDATE_FUNC_STATE, self.update_ui_func_state, self)
end

function ui:ui_func_check()
  for func_id, func_infos in pairs(self.v_func_list) do
    for _, func_info in ipairs(func_infos) do
      local obj = func_info[1]
      local callback = func_info[3]
      local param = func_info[4]
      local funcopen_mgr = Global.hero.funcopen_mgr
      local flag = funcopen_mgr:is_open(func_id)
      if obj then
        if flag then
          obj:SetActive(true)
        else
          obj:SetActive(false)
        end
        if callback then
          callback(param, func_id, flag)
        end
      end
    end
  end
end

function ui:unregister_ui_funcs()
  if not self.v_func_list then
    return
  end
  for func_id, _ in pairs(self.v_func_list) do
    self.v_func_list[func_id] = nil
  end
  self.v_func_list = {}
end

function ui:update_ui_func_state(msg)
  local change_list = msg.change_list
  for _, func_info in ipairs(change_list) do
    local func_id = func_info.func_id
    if self.v_func_list[func_id] then
      for _, cur_func in ipairs(self.v_func_list[func_id]) do
        local obj = cur_func[1]
        local callback = cur_func[3]
        local param = cur_func[4]
        local flag = func_info.state
        if obj then
          if flag then
            obj:SetActive(true)
          else
            obj:SetActive(false)
          end
        end
        if callback then
          callback(param, func_id, flag)
        end
      end
    end
  end
end

function ui:visible()
  return self.v_enable and self.v_visible
end

function ui:reset_trans()
  local trans = self.v_object_transform
  trans:SetPositionA(0, 0, 0)
  trans:SetLocalPositionA(1, 1, 1)
end

function ui:get_object()
  return self.v_object.gameObject
end

function ui:get_lua_object()
  return self.v_object
end

function ui:get_object_transform()
  return self.v_object_transform
end

function ui:get_child_transform(name, parent)
  parent = parent or self.v_object_transform
  return parent:FindChild(name)
end

function ui:get_child_gameobj(name, parent)
  parent = parent or self.v_object
  local transform = parent:FindChild(name)
  return transform and transform.gameObject
end

function ui:get_component(path, parent, component_type)
  parent = parent or self.v_object
  return Util.get_component(path, parent, component_type)
end

function ui:get_text(path, parent)
  return self:get_component(path, parent, UnityUIText)
end

function ui:get_image(path, parent)
  return self:get_component(path, parent, UnityUIImage)
end

function ui:get_rawimage(path, parent)
  return self:get_component(path, parent, UnityUIRawImage)
end

function ui:get_button(path, parent)
  return self:get_component(path, parent, UnityUIButton)
end

function ui:get_button_ex(path, parent)
  return self:get_component(path, parent, CSButtonEx)
end

function ui:get_slider(path, parent)
  return self:get_component(path, parent, UnityUISlider)
end

function ui:get_toggle(path, parent)
  return self:get_component(path, parent, UnityUIToggle)
end

function ui:get_toggle_group(path, parent)
  return self:get_component(path, parent, UnityUIToggleGroup)
end

function ui:get_dropdown(path, parent)
  return self:get_component(path, parent, UnityUIDropdown)
end

function ui:get_scrollrect(path, parent)
  return self:get_component(path, parent, UnityUIScrollRect)
end

function ui:get_scrollrect_ex(path, parent)
  return self:get_component(path, parent, TypeCSScrollRectEx)
end

function ui:get_inputfield(path, parent)
  return self:get_component(path, parent, UnityUIInputField)
end

function ui:get_canvas(path, parent)
  return self:get_component(path, parent, UnityUICanvas)
end

function ui:get_canvas_group(path, parent)
  return self:get_component(path, parent, UnityUICanvasGroup)
end

function ui:get_rect_transform(path, parent)
  return self:get_component(path, parent, UnityRectTransform)
end

function ui:get_animator(path, parent)
  return self:get_component(path, parent, UnityAnimator)
end

function ui:get_animation(path, parent)
  return self:get_component(path, parent, UnityEngine.Animation)
end

function ui:get_shadow(path, parent)
  return self:get_component(path, parent, UnityEngineUI.Shadow)
end

function ui:get_particle(path, parent)
  return self:get_component(path, parent, CSUIParticle)
end

function ui:get_effect_status(path, parent)
  return self:get_component(path, parent, CSEffectStatus)
end

function ui:get_layout_element(path, parent)
  return self:get_component(path, parent, UnityUILayoutElement)
end

function ui:get_custom_dotween(path, parent)
  return self:get_component(path, parent, TypeCustomDOTween)
end

function ui:set_close_button(btnname)
  local btn = self:get_uiobject(btnname, BIND_TYPE.BUTTON)
  
  local function hide()
    self:ui_hide()
  end
  
  Global.listener_mgr:add_listener(self.v_object, btn.onClick, hide)
end

function ui:set_button(btnname, callback)
  local btn = self:get_uiobject(btnname, BIND_TYPE.BUTTON)
  assert(btn, "add button, " .. (btnname or "(nil)"))
  if callback then
    Global.listener_mgr:add_listener(self.v_object, btn.onClick, callback)
  end
  return btn
end

function ui:set_toggle(name, callback, isOn)
  local toggle = self:get_uiobject(name, BIND_TYPE.TOGGLE)
  toggle.onValueChanged:RemoveAllListeners()
  if nil ~= isOn then
    toggle.isOn = isOn
  end
  if callback then
    Global.listener_mgr:add_listener(self.v_object, toggle.onValueChanged, callback)
  end
  return toggle
end

function ui:set_dropdown(name, callback)
  local dropdown = self:get_uiobject(name, BIND_TYPE.DROPDOWN)
  if callback then
    Global.listener_mgr:add_listener(self.v_object, dropdown.onValueChanged, callback)
  end
  return dropdown
end

function ui:set_button_listener(btn, callback)
  btn = btn or self:get_button()
  assert(btn)
  assert(callback)
  Global.listener_mgr:add_listener(self.v_object, btn.onClick, callback)
end

function ui:remove_button_listener(btn)
  if not btn then
    return
  end
  Global.listener_mgr:remove_listener(self.v_object, btn.onClick)
end

function ui:set_playable_stopped_action(playable, action)
  if not playable then
    Log.Error("传入的 playable 为空，无法添加回调", debug.traceback())
    return
  end
  if not action then
    Log.Error("传入的 action 为空，无法添加回调", debug.traceback())
    return
  end
  Global.listener_mgr:add_playable_stopped_action(self.v_object, playable, action)
end

function ui:remove_playable_stopped_action(playable)
  if not playable then
    return
  end
  Global.listener_mgr:remove_playable_stopped_action(self.v_object, playable)
end

function ui:set_button_ex_listener(btn, began_cb, ended_cb, cancelled_cb, cancel_ended_cb)
  assert(btn)
  btn.onTouchBegan:RemoveAllListeners()
  btn.onTouchEnded:RemoveAllListeners()
  btn.onTouchCancelled:RemoveAllListeners()
  btn.onTouchCancelEnded:RemoveAllListeners()
  if began_cb then
    Global.listener_mgr:add_listener(self.v_object, btn.onTouchBegan, began_cb)
  end
  if ended_cb then
    Global.listener_mgr:add_listener(self.v_object, btn.onTouchEnded, ended_cb)
  end
  if cancelled_cb then
    Global.listener_mgr:add_listener(self.v_object, btn.onTouchCancelled, cancelled_cb)
  end
  if cancel_ended_cb then
    Global.listener_mgr:add_listener(self.v_object, btn.onTouchCancelEnded, cancel_ended_cb)
  end
end

function ui:set_toggle_listener(toggle, callback, isOn)
  assert(toggle)
  assert(callback)
  if nil ~= isOn then
    toggle.isOn = isOn
  end
  Global.listener_mgr:add_listener(self.v_object, toggle.onValueChanged, callback, true)
end

function ui:remove_toggle_listener(toggle)
  if not toggle then
    return
  end
  Global.listener_mgr:remove_listener(self.v_object, toggle.onValueChanged)
end

function ui:set_slider_listener(slider, callback)
  assert(slider)
  assert(callback)
  Global.listener_mgr:add_listener(self.v_object, slider.onValueChanged, callback)
end

function ui:set_inputfield_listener(inputfield, change_callback, end_callback)
  assert(inputfield)
  inputfield.onValueChanged:RemoveAllListeners()
  inputfield.onEndEdit:RemoveAllListeners()
  if change_callback then
    Global.listener_mgr:add_listener(self.v_object, inputfield.onValueChanged, change_callback)
  end
  if end_callback then
    Global.listener_mgr:add_listener(self.v_object, inputfield.onEndEdit, end_callback)
  end
end

function ui:set_dropdown_listener(dropdown, callback)
  assert(dropdown)
  assert(callback)
  Global.listener_mgr:add_listener(self.v_object, dropdown.onValueChanged, callback)
end

function ui:set_scrollrect_listener(scroll_rect, callback)
  assert(scroll_rect)
  assert(callback)
  Global.listener_mgr:add_listener(self.v_object, scroll_rect.onValueChanged, callback)
end

function ui:set_scrollrect_ex_listener(scroll_rect, began_cb, move_cb, ended_cb, value_changed_cb)
  assert(scroll_rect)
  scroll_rect.onDragBegan:RemoveAllListeners()
  scroll_rect.onDragMove:RemoveAllListeners()
  scroll_rect.onDragEnded:RemoveAllListeners()
  scroll_rect.onValueChanged:RemoveAllListeners()
  if began_cb then
    Global.listener_mgr:add_listener(self.v_object, scroll_rect.onDragBegan, began_cb)
  end
  if move_cb then
    Global.listener_mgr:add_listener(self.v_object, scroll_rect.onDragMove, move_cb)
  end
  if ended_cb then
    Global.listener_mgr:add_listener(self.v_object, scroll_rect.onDragEnded, ended_cb)
  end
  if value_changed_cb then
    Global.listener_mgr:add_listener(self.v_object, scroll_rect.onValueChanged, value_changed_cb)
  end
end

local GREY_PRECENT_ID = UnityShader.PropertyToID("_GreyPrecent")

function ui:_do_set_graphic_mat(graphic, is_grey, is_fast)
  local mat
  if graphic.material:HasProperty(GREY_PRECENT_ID) then
    local instance_id = graphic:GetInstanceID()
    if is_grey then
      if not self.v_instantiate_mat then
        self.v_instantiate_mat = {}
      end
      mat = self.v_instantiate_mat[instance_id]
      mat = mat or Global.res_mgr:instantiate(graphic.material, true)
      mat:SetFloat(GREY_PRECENT_ID, 1.0)
      graphic.material = mat
      self.v_instantiate_mat[instance_id] = mat
    elseif self.v_instantiate_mat and self.v_instantiate_mat[instance_id] then
      self.v_instantiate_mat[instance_id]:SetFloat(GREY_PRECENT_ID, 0.0)
    end
  else
    if is_grey then
      mat = ResMgr:load_res(is_fast and FAST_GREY_MAT or DEFAULT_GREY_MAT, UnityMaterial)
    else
      mat = nil
    end
    graphic.material = mat
  end
end

function ui:set_mat_grey(path, parent, is_grey, is_fast)
  local graphic = self:get_component(path, parent, UnityGraphic)
  self:_do_set_graphic_mat(graphic, is_grey, is_fast)
end

function ui:set_all_mat_grey(path, parent, is_grey, is_fast, excludes)
  local obj = parent
  if path then
    obj = parent:FindChild(path)
  end
  local ex_objs
  if excludes then
    ex_objs = {}
    for _, p in ipairs(excludes) do
      ex_objs[self:get_child_gameobj(p, parent)] = true
    end
  else
    ex_objs = Config.EMPTY_TBL
  end
  local graphics = obj:GetComponentsInChildren(UnityGraphic)
  for _, g in ipairs(graphics) do
    if not ex_objs[g.gameObject] then
      self:_do_set_graphic_mat(g, is_grey, is_fast)
    end
  end
end

function ui:get_print_size(label, text)
  label.text = text
  return label.preferredWidth, label.preferredHeight
end

function ui:set_raycastable(path, parent, can_raycast)
  local graphic = self:get_component(path, parent, UnityGraphic)
  graphic.raycastTarget = can_raycast
end

function ui:bind_auto_mq(msg_type, callback, cbdata)
  local msg_handle = MsgGame:mq_bind(msg_type, callback, cbdata)
  self.v_msg_handles[msg_handle] = msg_type
  return msg_handle
end

function ui:unbind_auto_mq(msg_handle)
  MsgGame:mq_unbind(msg_handle)
  self.v_msg_handles[msg_handle] = nil
end

function ui:unbind_all_auto_mq()
  if self.v_msg_handles then
    for msg_handle, _ in pairs(self.v_msg_handles) do
      MsgGame:mq_unbind(msg_handle)
    end
  end
  self.v_msg_handles = {}
end

function ui:_check_last_pressed()
  local touch_input = Global.ui_mgr.touch_input
  local ispressed = touch_input.isPressed
  local pressed_obj = touch_input.pressedGameObject
  if self.v_last_is_pressed and not ispressed then
    local trans = self.v_last_pressed_obj and self.v_last_pressed_obj.transform
    while nil ~= trans do
      local parent = trans.parent
      if parent and parent == self.v_object_transform then
        break
      end
      trans = parent
    end
    if not trans then
      self:ui_hide()
      return
    end
  end
  self.v_last_is_pressed = ispressed
  self.v_last_pressed_obj = pressed_obj
  return true
end

function ui:init_model(model_cfg)
  for key, cfg in pairs(model_cfg) do
    local obj_name = cfg[1]
    local obj_type = cfg[2]
    local obj = self.v_uiobjects[obj_name]
    if not obj or obj:IsNull() then
      Log.Error("找不到UI object：", obj_name, debug.traceback())
    else
      if self[key] then
        Log.Error("重复定义：" .. obj_name, debug.traceback())
      end
      local component
      if obj_type == BIND_TYPE.OBJECT then
        component = obj
      else
        component = obj:GetComponent(NORMAL_BIND_TBL[obj_type])
      end
      if not component then
        Log.Error("找不到相应component: ", key, obj_type, debug.traceback())
      end
      self[key] = component
    end
  end
end

function ui:new_folder(folder)
  folder = folder or Folder:new()
  self.v_folder_list = self.v_folder_list or {}
  table.insert(self.v_folder_list, folder)
  return folder
end

function ui:new_async_task(cb, post_cb)
  local t = AsyncMgr:new_async(cb, post_cb)
  self.v_async_list = self.v_async_list or {}
  table.insert(self.v_async_list, t)
  return t:deal_process()
end

function ui:highlight_tab(parent_obj, is_highlight)
  local highlight_bg = self:get_child_gameobj("HeightBg", parent_obj)
  highlight_bg:SetActive(is_highlight)
  local text = self:get_text("Text", parent_obj)
  text.color = Util.get_unity_color_by_hex(is_highlight and 16775910 or 6576709)
  local shadow = self:get_shadow("Text", parent_obj)
  if shadow then
    shadow.enabled = is_highlight
  end
end

function ui:show_trans(trans)
  trans:SetLocalPositionA(0, 0, 0)
end

function ui:hide_trans(trans)
  trans:SetLocalPositionA(2000000, 0, 0)
end

function ui:set_uiobject_visible(object_name, visible)
  local object = self:get_uiobject(object_name)
  if object then
    object:SetActive(visible)
  end
end

function ui:create_item_obj(parent, replace_obj, template_key, param, ...)
  return UIMgr.ui_res_mgr:create_obj(self, parent, replace_obj, template_key, param, ...)
end

function ui:release_items_by_template_key(template_key)
  return UIMgr.ui_res_mgr:release_items_by_template_key(self, template_key)
end

function ui:register_effect(effect_name)
  local uiparticle = self:get_uiobject(effect_name, BIND_TYPE.UIPARTICLE)
  if not uiparticle then
    Log.Error("can't find ui effect: ", effect_name)
    return false
  end
  if not self.v_effects then
    self.v_effects = {}
  end
  if self.v_effects[effect_name] then
    Log.Error("register duplicated effect: ", effect_name)
    return false
  end
  local effect_status = uiparticle:GetComponentInChildren(TypeEffectStatus)
  if not effect_status then
    Log.Error("can't find uiparticle effect_status: ", effect_name)
    return false
  end
  self.v_effects[effect_name] = {
    uiparticle = uiparticle,
    obj = uiparticle.gameObject,
    effect_status = effect_status,
    start_time = 0,
    length = effect_status.LifeTime
  }
  return true
end

function ui:register_effect_status(obj_name, effect_name, start_effect, ui_obj)
  ui_obj = ui_obj or self.v_uiobjects[obj_name]
  if not ui_obj then
    return
  end
  local effect_status_obj = ui_obj
  if effect_name and "" ~= effect_name then
    effect_status_obj = self:get_child_gameobj(effect_name, ui_obj)
  end
  if not effect_status_obj then
    return
  end
  if not self.v_effects then
    self.v_effects = {}
  end
  local effect_status = effect_status_obj:GetComponentInChildren(TypeEffectStatus)
  if not effect_status then
    return
  end
  self.v_effects[obj_name] = {
    obj = ui_obj,
    is_effect_status = true,
    effect_status = effect_status,
    start_time = 0,
    length = effect_status.LifeTime
  }
  if not Util.is_empty(start_effect) then
    local start_effect_obj
    start_effect_obj = self:get_child_gameobj(start_effect, ui_obj)
    local start_effect_status = start_effect_obj:GetComponentInChildren(TypeEffectStatus)
    if start_effect_status then
      self.v_effects[obj_name].start_effect = {
        is_effect_status = true,
        effect_status = start_effect_status,
        start_time = 0,
        length = start_effect_status.LifeTime
      }
    end
  end
  return true
end

function ui:get_effect(effect_name)
  return self.v_effects[effect_name]
end

function ui:play_effect(effect_name, need_restart)
  local effect_info = self.v_effects[effect_name]
  if not effect_info then
    Log.Error("play ui effect error, no effect: ", effect_name, debug.traceback())
    return
  end
  if not self.v_playing_effects then
    self.v_playing_effects = {}
  end
  if effect_info.is_effect_status then
    self:play_effect_status(effect_name, need_restart)
    return
  end
  effect_info.obj:SetActive(true)
  local playing_effect_info = self.v_playing_effects[effect_name]
  if not playing_effect_info then
    playing_effect_info = {}
    self.v_playing_effects[effect_name] = playing_effect_info
  end
  effect_info.uiparticle:RePlay()
  playing_effect_info.time = 0
  playing_effect_info.length = effect_info.length
end

function ui:play_effect_by_mgr(prefab_name, parent)
  self.v_effect_name_to_id_map = self.v_effect_name_to_id_map or {}
  local effect_id = self.v_effect_name_to_id_map[prefab_name]
  if effect_id and UIEffectMgr:try_replay_effect(effect_id) then
    return effect_id
  end
  local effect_data = UIEffectMgr:get_new_effect_data()
  effect_data.ui_object = self
  effect_data.parent = parent
  effect_data.prefab_name = prefab_name
  effect_id = UIEffectMgr:play_effect(effect_data)
  self.v_effect_name_to_id_map[prefab_name] = effect_id
  return effect_id
end

function ui:play_effect_end_status_by_mgr(prefab_name)
  if not self.v_effect_name_to_id_map then
    return
  end
  local effect_id = self.v_effect_name_to_id_map[prefab_name]
  if not effect_id then
    return
  end
  UIEffectMgr:try_play_end_effect(effect_id)
end

function ui:stop_effect_by_mgr(prefab_name, skip_end)
  if not self.v_effect_name_to_id_map then
    return
  end
  local effect_id = self.v_effect_name_to_id_map[prefab_name]
  if not effect_id then
    return
  end
  UIEffectMgr:stop_effect(effect_id, skip_end)
end

function ui:stop_all_effect_by_mgr(skip_end)
  if not self.v_effect_name_to_id_map then
    return
  end
  for key, effect_id in pairs(self.v_effect_name_to_id_map) do
    UIEffectMgr:stop_effect(effect_id, skip_end)
  end
  self.v_effect_name_to_id_map = nil
end

function ui:play_playable_director(pd_name)
  local name = pd_name .. "_pd"
  local pd = self.v_uicompents[name]
  if pd then
    pd:ResetPD()
    pd:Play()
    return true
  end
  return false
end

function ui:stop_playable_director(pd_name, reset)
  local name = pd_name .. "_pd"
  local pd = self.v_uicompents[name]
  if pd then
    if reset then
      pd.time = 0
      pd:Evaluate()
    end
    pd:Stop()
    return true
  end
  return false
end

function ui:set_no_click(is_no_click)
  if nil ~= is_no_click and self.v_no_click_img_uicon and not self.v_no_click_img_uicon:IsNull() then
    self.v_no_click_img_uicon.raycastTarget = is_no_click
    self.v_no_click_img_uicon.gameObject:SetActive(is_no_click)
  end
end

function ui:play_effect_status(effect_name, need_restart)
  local effect_info = self.v_effects[effect_name]
  if not effect_info then
    return
  end
  effect_info.obj:SetActive(true)
  local playing_effect_info = self.v_playing_effects[effect_name]
  if not playing_effect_info then
    playing_effect_info = {}
    self.v_playing_effects[effect_name] = playing_effect_info
  end
  local effect_status
  if effect_info.start_effect then
    effect_status = effect_info.start_effect.effect_status
    playing_effect_info.start_effect_time = 0
    playing_effect_info.start_effect_length = effect_info.start_effect.length
    self:_restart_effect_status(effect_status, need_restart)
  end
  effect_status = effect_info.effect_status
  self:_restart_effect_status(effect_status, need_restart, effect_name)
  effect_info.obj:SetActive(true)
  playing_effect_info.time = 0
  playing_effect_info.length = effect_info.length
end

function ui:_restart_effect_status(effect_status, need_restart, effect_name)
  if effect_status:IsNull() then
    Log.Error("effect_name", effect_name, debug.traceback())
    return
  end
  local is_active
  is_active = effect_status.gameObject.activeSelf
  effect_status:SetActive(true)
  if not is_active or need_restart then
    effect_status:RestartAll(nil, true)
  end
end

function ui:stop_effect(effect_name)
  self.v_playing_effects = self.v_playing_effects or {}
  local playing_effect_info = self.v_playing_effects[effect_name]
  if playing_effect_info then
    self.v_playing_effects[effect_name] = nil
  end
  local effect_info = self.v_effects[effect_name]
  if not effect_info then
    return
  end
  if effect_info.is_effect_status then
    self:stop_effect_status(effect_name)
    return
  end
  effect_info.obj:SetActive(false)
end

function ui:stop_effect_status(effect_name)
  local effect_info = self.v_effects[effect_name]
  if not effect_info then
    return
  end
  effect_info.obj:SetActive(false)
  local effect_status = effect_info.effect_status
  effect_status:StopAll()
end

function ui:update_effects(dt)
  if not self.v_playing_effects then
    return
  end
  local t, obj, start_effect_status
  for effect_name, effect_info in pairs(self.v_playing_effects) do
    if effect_info.start_effect_time and -1 ~= effect_info.start_effect_length then
      t = effect_info.start_effect_time + dt
      if t >= effect_info.start_effect_length then
        start_effect_status = self.v_effects[effect_name].start_effect.effect_status
        obj = start_effect_status.gameObject
        obj:SetActive(false)
        effect_info.start_effect_time = nil
        effect_info.start_effect_length = nil
      else
        effect_info.start_effect_time = t
      end
    end
    if -1 ~= effect_info.length then
      t = effect_info.time + dt
      if t >= effect_info.length then
        obj = self.v_effects[effect_name].obj
        obj:SetActive(false)
        self.v_playing_effects[effect_name] = nil
        if self.on_playing_effect_remove then
          self:on_playing_effect_remove(effect_name)
        end
      else
        effect_info.time = t
      end
    end
  end
end

function ui:_init_common_widget()
  if self.v_uiobjects.BtnMain then
    self:set_button("BtnMain", function()
      if not SceneMgr:check_main_scene() then
        UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("当前场景不可回到主界面"))
      else
        if self.on_go_to_main then
          self:on_go_to_main()
        end
        UIMgr:go_to_main()
        UIMgr:clear_all_cache_ui_custom_data()
      end
    end)
  end
  if self.v_uiobjects.BtnIntroduce then
    self:set_button("BtnIntroduce", function()
      UIMgr:get_ui("ui_introduce"):ui_show(self)
    end)
  end
end

function ui:switch_ui_image(obj_name, img_path)
  local img_obj = self.v_uiobjects[obj_name]
  if not img_obj then
    return
  end
  local image = self:get_image(nil, img_obj)
  ResMgr:load_set_icon(image, img_path)
end

function ui:update_ui_visible(ui_obj, is_visible)
  if not self.v_visible_record or self.v_visible_record[ui_obj] == is_visible then
    return
  end
  self.v_visible_record[ui_obj] = is_visible
  ui_obj.gameObject:SetActive(is_visible)
end

function ui:clear_ui_visible_record()
  UtilTable.clear_map(self.v_visible_record)
end

function ui:skip_sort_order()
  return false
end

function ui:check_create_asset_bar()
  if self.v_asset_item_info_list and self.v_uiobjects.AssetBar then
    local asset_config = SHOP_HELPER.get_asset_list_by_info_list(self.v_asset_item_info_list)
    self.v_base_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  end
end

function ui:remove_all_listeners()
  Global.listener_mgr:on_destroy_ui_object(self.v_object)
end

function ui:remove_timer()
  if self.v_clear_all_cache_data_timer then
    Timer:remove_timer(self.v_clear_all_cache_data_timer)
    self.v_clear_all_cache_data_timer = nil
  end
end

return ui
