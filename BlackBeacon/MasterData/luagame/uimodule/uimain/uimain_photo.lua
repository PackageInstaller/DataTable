local ItemBase = require("ui.uiobject")
local Math = require("base.mathx")
local _clamp = Math.Clamp
local Input = UnityEngine.Input
local TouchPhase = UnityEngine.TouchPhase
local TOUCH_SCALE_SPEED = ShareRes.get_comm_value("PhotoScaleSpeed") or 1
local TOUCH_SCALE_SPEED_M = ShareRes.get_comm_value("PhotoScaleSpeedM") or 3
local OperateType = {
  NONE = 0,
  CHANGE = 1,
  EDIT = 2
}
local TDFrameItem = Util.create_child_mt(ItemBase)

function TDFrameItem:ui_finish_load()
  self:set_button("Button", function()
    if 0 == self.v_frame_idx then
      Util.show_message_tip(2235)
      return
    end
    if self.v_is_selected then
      return
    end
    self.v_linked_parent:on_click_frame(self.v_frame_idx, self.v_frame_id, true)
  end)
  Util.set_start_drag(self.v_uiobjects.PictureOutline, self, function(x, y)
    self.v_cache_touch = nil
  end)
  Util.set_drag(self.v_uiobjects.PictureOutline, self, function(x, y)
    self:on_drag()
  end)
  Util.set_start_drag(self.v_uiobjects.Picture, self, function(x, y)
    self.v_cache_touch = nil
  end)
  Util.set_drag(self.v_uiobjects.Picture, self, function(x, y)
    self:on_drag()
  end)
end

function TDFrameItem:get_click_offset()
  local touch_0_pos
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    touch_0_pos = Input.mousePosition
  elseif Input.touchCount > 0 then
    touch_0_pos = Input.GetTouch(0).position
  else
    return 0, 0
  end
  if not self.v_cache_touch then
    self.v_cache_touch = touch_0_pos
    return 0, 0
  else
    local offset_x = touch_0_pos.x - self.v_cache_touch.x
    local offset_y = touch_0_pos.y - self.v_cache_touch.y
    self.v_cache_touch = touch_0_pos
    return offset_x, offset_y
  end
end

function TDFrameItem:ui_on_show()
end

function TDFrameItem:play_anim(frame_id)
  if frame_id == self.v_frame_id then
    local photo_id = PhotoMgr:get_photo_id_by_frame_id(self.v_frame_id)
    if photo_id and 0 ~= photo_id then
      self:play_playable_director("Ani_UIMainDIY_Confirm")
    end
  end
end

function TDFrameItem:set_linked_parent(parent)
  self.v_linked_parent = parent
  self.v_canvas_camera = parent:get_canvas().worldCamera
  self.v_slider_min_val = parent.v_slider.minValue
  self.v_slider_max_val = parent.v_slider.maxValue
end

local offset_z_vec3 = UnityVector3(0, 0, 0.08)

function TDFrameItem:set_data(data)
  self.v_mesh_render = data.mesh_render
  self.v_mesh_filter = data.mesh_filter
  self.v_frame_idx = data.frame_idx
  self.v_frame_id = data.frame_id
  local meshBounds = self.v_mesh_filter.mesh.bounds
  local min = self.v_mesh_filter.transform:TransformPoint(meshBounds.min + offset_z_vec3)
  local max = self.v_mesh_filter.transform:TransformPoint(meshBounds.max + offset_z_vec3)
  local min_screen_pos_x, min_screen_pos_y = self.v_linked_parent.v_uimain:world_to_screen_pos(min:Get())
  local max_screen_pos_x, max_screen_pos_y = self.v_linked_parent.v_uimain:world_to_screen_pos(max:Get())
  local size_x = math.abs(max_screen_pos_x - min_screen_pos_x)
  local size_y = math.abs(max_screen_pos_y - min_screen_pos_y)
  local size = UnityVector2(size_x, size_y)
  local center = UnityVector2((min_screen_pos_x + max_screen_pos_x) / 2, (min_screen_pos_y + max_screen_pos_y) / 2)
  self.v_object.transform.sizeDelta = size
  self.v_object.transform.anchoredPosition = center
  self.v_size = size
  self:update_fixed_info()
  self:update_selected()
  self.v_uicompents.Ani_UIMainDIY_Confirm_pd.time = 1
  self.v_uicompents.Ani_UIMainDIY_Confirm_pd:Evaluate()
end

function TDFrameItem:update_fixed_info()
  self.v_uiobjects.BanMask:SetActive(0 == self.v_frame_idx)
  self.v_uiobjects.Tips:SetActive(0 ~= self.v_frame_idx)
  self.v_uicompents.NumTxt_txt.text = self.v_frame_idx
  if 0 == self.v_frame_idx then
    self.v_uiobjects.Content:SetActive(false)
  end
end

function TDFrameItem:update_selected()
  if 0 == self.v_frame_idx then
    return
  end
  local operate_type = self.v_linked_parent:get_operate_type()
  local selected_id = self.v_linked_parent:get_selected_frame_id()
  self.v_is_selected = selected_id == self.v_frame_id
  self.v_uiobjects.Content:SetActiveEx(self.v_is_selected)
  if self.v_is_selected then
    self.v_object_transform:SetAsLastSibling()
    local photo_id = PhotoMgr:get_photo_id_by_frame_id(self.v_frame_id, true)
    local show_photo = photo_id and 0 ~= photo_id
    local show_edit = show_photo
    self.v_uiobjects.Picture:SetActive(show_photo)
    self.v_uiobjects.PictureOutline:SetActive(show_edit)
    if show_photo then
      local photo_path = ShareRes.get_photo_path(photo_id)
      if photo_path then
        ResMgr:load_set_icon(self.v_uicompents.Picture_img, photo_path, nil, true)
      end
      self:init_picture_size(photo_id)
    else
      self.v_init_size = nil
    end
  end
end

function TDFrameItem:un_select_content()
  self.v_uiobjects.Content:SetActiveEx(false)
end

function TDFrameItem:update_mat()
  if 0 == self.v_frame_idx then
    return
  end
  PhotoMgr:update_frame_mat(self.v_mesh_render, self.v_mesh_filter, self.v_frame_id, true)
end

function TDFrameItem:update_temp_img(photo_id)
  local selected_id = self.v_linked_parent:get_selected_frame_id()
  self.v_is_selected = selected_id == self.v_frame_id
  if self.v_is_selected then
    local show_photo = photo_id and 0 ~= photo_id
    self.v_uiobjects.Picture:SetActive(show_photo)
    self.v_uiobjects.PictureOutline:SetActive(show_photo)
    self.v_mesh_render:SetActive(show_photo)
    if show_photo then
      local photo_path = ShareRes.get_photo_path(photo_id)
      if photo_path then
        ResMgr:load_set_icon(self.v_uicompents.Picture_img, photo_path, nil, true)
      end
      self:init_picture_size(photo_id)
    else
      self.v_init_size = nil
    end
    PhotoMgr:update_frame_mat(self.v_mesh_render, self.v_mesh_filter, self.v_frame_id, true, photo_id or 0)
  end
end

function TDFrameItem:init_picture_size(photo_id)
  local sprite_size = self.v_uicompents.Picture_img.overrideSprite.bounds.size
  self.v_image_ratio = sprite_size.x / sprite_size.y
  self.v_frame_ratio = self.v_size.x / self.v_size.y
  local width, hight
  if self.v_image_ratio > self.v_frame_ratio then
    hight = self.v_size.y
    width = self.v_image_ratio * hight
  else
    width = self.v_size.x
    hight = width / self.v_image_ratio
  end
  self.v_init_size = UnityVector2(width, hight)
  local cfg_max_width = ShareRes.get_photo_max_width(photo_id)
  if width > cfg_max_width then
    cfg_max_width = width
  end
  self.v_max_scale = cfg_max_width / width
  self.v_linked_parent:refresh_scale_limit(self.v_max_scale)
end

function TDFrameItem:refresh_limit()
  local picture_size = self.v_uicompents.Picture_rect.sizeDelta
  self.v_max_x = (picture_size.x - self.v_size.x) / 2
  self.v_max_y = (picture_size.y - self.v_size.y) / 2
end

function TDFrameItem:map_scale(input_scale)
  if 1 == self.v_max_scale then
    return 1
  end
  local inputRange = self.v_slider_max_val - self.v_slider_min_val
  local outputRange = self.v_max_scale - 1
  local normalizedValue = (input_scale - 1) / inputRange
  local mappedValue = normalizedValue * outputRange + 1
  return mappedValue
end

function TDFrameItem:set_scale(scale)
  if not self.v_init_size then
    return
  end
  if 0 == self.v_frame_idx then
    return
  end
  local selected_id = self.v_linked_parent:get_selected_frame_id()
  self.v_is_selected = selected_id == self.v_frame_id
  if self.v_is_selected then
    scale = self:map_scale(scale or 1)
    self.v_uicompents.Picture_rect.sizeDelta = self.v_init_size * scale
    self.v_uicompents.PictureOutline_rect.sizeDelta = self.v_init_size * scale
    self:refresh_limit()
    local pos_x, pos_y = self.v_uicompents.Picture_rect:GetLocalPositionA3()
    pos_x = _clamp(pos_x, -self.v_max_x, self.v_max_x)
    pos_y = _clamp(pos_y, -self.v_max_y, self.v_max_y)
    local new_x = 0 == self.v_max_x and 0 or pos_x / self.v_max_x
    local new_y = 0 == self.v_max_y and 0 or pos_y / self.v_max_y
    self.v_linked_parent:set_photo_param(nil, new_x, new_y)
  end
end

function TDFrameItem:set_pos(x, y)
  if not self.v_init_size then
    return
  end
  if 0 == self.v_frame_idx then
    return
  end
  local selected_id = self.v_linked_parent:get_selected_frame_id()
  self.v_is_selected = selected_id == self.v_frame_id
  if self.v_is_selected then
    x = _clamp(x, -self.v_max_x, self.v_max_x)
    y = _clamp(y, -self.v_max_y, self.v_max_y)
    self.v_uicompents.Picture_rect:SetLocalPositionA(x * self.v_max_x, y * self.v_max_y, 0)
    self.v_uicompents.PictureOutline_rect:SetLocalPositionA(x * self.v_max_x, y * self.v_max_y, 0)
  end
end

function TDFrameItem:on_drag()
  local operate_type = self.v_linked_parent:get_operate_type()
  local offset_x, offset_y = self:get_click_offset()
  local pos_x, pos_y, pos_z = self.v_uicompents.Picture_rect:GetLocalPositionA3()
  local new_x, new_y = pos_x + offset_x, pos_y + offset_y
  new_x = _clamp(new_x, -self.v_max_x, self.v_max_x)
  new_y = _clamp(new_y, -self.v_max_y, self.v_max_y)
  new_x = 0 == self.v_max_x and 0 or new_x / self.v_max_x
  new_y = 0 == self.v_max_y and 0 or new_y / self.v_max_y
  self.v_linked_parent:set_photo_param(nil, new_x, new_y)
end

local FrameItem = Util.create_child_mt(ItemBase)

function FrameItem:ui_finish_load()
  self:set_button("Button", function()
    self.v_linked_parent:on_click_frame(self.v_frame_idx, self.v_frame_id)
  end)
  self.v_cg = self:get_canvas_group()
end

function FrameItem:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function FrameItem:set_data(frame_cfg, show_tween)
  if show_tween then
    self.v_cg.alpha = 0
    self.v_cg:DOFade(1, 0.3)
  else
    self.v_cg.alpha = 1
  end
  self.v_frame_idx = frame_cfg.Index
  self.v_frame_id = frame_cfg.Id
  self:update_img()
  self:update_selected()
end

function FrameItem:update_img()
  local photo_id = PhotoMgr:get_photo_id_by_frame_id(self.v_frame_id, true)
  self.v_uiobjects.PictureIcon:SetActive(nil ~= photo_id)
  if nil ~= photo_id then
    local photo_path = ShareRes.get_photo_path(photo_id)
    if photo_path then
      ResMgr:load_set_icon(self.v_uicompents.PictureIcon_img, photo_path, nil, true)
    end
  end
  self.v_uicompents.FrameName_txt.text = Util.format_str("框{1}", self.v_frame_idx)
end

function FrameItem:update_selected()
  local selected_id = self.v_linked_parent:get_selected_frame_id()
  self.v_is_selected = selected_id == self.v_frame_id
  self.v_uiobjects.Select:SetActiveEx(self.v_is_selected)
end

local PhotoItem = Util.create_child_mt(ItemBase)

function PhotoItem:ui_finish_load()
  self:set_button("Button", function()
    if self.v_is_empty or self.v_if_own then
      self.v_linked_parent:on_click_photo(self.v_id)
      if self.v_is_new and not self.v_is_photo_page then
        FashionMgr:on_new_main_scene_fashion_click(self.v_id)
        self:refresh_is_new(false)
      end
    elseif self.v_is_photo_page then
      local photo_cfg = ShareRes.get_photo_cfg(self.v_id)
      if photo_cfg and photo_cfg.Desc then
        Util.show_message_tip(photo_cfg.Desc)
      end
    else
      self.v_linked_parent:on_lock_photo_click(self.v_id)
    end
  end)
  self.v_cg = self:get_canvas_group()
end

function PhotoItem:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function PhotoItem:set_data(data)
  self.v_page = self.v_parent_ui:get_page()
  self.v_is_photo_page = self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO
  self.v_cg.alpha = 0
  self.v_cg:DOFade(1, 0.3)
  self.v_id = data and data.id or 0
  self.v_path = data and data.path
  self.v_name = data and data.name
  self.v_is_new = data and data.is_new
  self.v_is_empty = nil == data
  self.v_uicompents.Name_txt.text = self.v_name
  self:refresh_is_new(self.v_is_new)
  self:update_img()
  self:update_using()
  self:update_selected()
end

function PhotoItem:refresh_is_new(visible)
  self.v_uiobjects.New:SetActive(visible)
end

function PhotoItem:update_img()
  self.v_uiobjects.PictureIcon:SetActive(not self.v_is_empty)
  self.v_uiobjects.Frame:SetActive(false)
  self.v_uiobjects.Lock:SetActive(false)
  if not self.v_is_empty then
    ResMgr:load_set_icon(self.v_uicompents.PictureIcon_img, self.v_path, nil, true)
    if self.v_is_photo_page then
      self:refresh_photo_img()
    else
      self:refresh_scene_img()
    end
  end
end

function PhotoItem:refresh_photo_img()
  self.v_if_own = PhotoMgr:check_own_photo(self.v_id)
  self.v_uiobjects.Lock:SetActiveEx(not self.v_if_own)
  if self.v_if_own then
    local frame_data = PhotoMgr:get_frame_data_by_photo(self.v_id, true)
    local frame_id = frame_data and frame_data.frame_id or 0
    local frame_idx = ShareRes.get_photo_frame_idx(frame_id)
    self.v_uiobjects.Frame:SetActive(nil ~= frame_idx and 0 ~= frame_idx)
    self.v_uicompents.FrameNum_txt.text = frame_idx
  end
end

function PhotoItem:refresh_scene_img()
  self.v_if_own = FashionMgr:check_is_own_fashion(self.v_id)
  self.v_uiobjects.Lock:SetActiveEx(not self.v_if_own)
end

function PhotoItem:update_using()
  local using_id = self.v_linked_parent:get_using_photo()
  self.v_uiobjects.Using:SetActiveEx(using_id == self.v_id)
end

function PhotoItem:update_selected()
  local selected_id = self.v_linked_parent:get_selected_photo()
  self.v_is_selected = selected_id == self.v_id
  self.v_uiobjects.Select:SetActiveEx(self.v_is_selected)
end

local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TypeMaterailCollect = typeof(CS.Game.MaterailCollect)
local TD_FRAME_LIST_ITEM_TEMP_KEY = "TD_FRAME_LIST_ITEM_TEMP_KEY"
local FRAME_LIST_ITEM_TEMP_KEY = "FRAME_LIST_ITEM_TEMP_KEY"
local PICTURE_LIST_ITEM_TEMP_KEY = "PICTURE_LIST_ITEM_TEMP_KEY"

function ui:ui_finish_load()
  self:set_button("MaskHideAll", function()
    self:ani_in()
  end)
  self:set_button("BtnHide", function()
    self:save_temp_data()
    self:refresh_3d_frame_mat()
    self:ani_out()
  end)
  
  local function confirm_cb()
    self:show_photo_list()
  end
  
  self:set_button("BtnConfirm", function()
    self:do_save(true, confirm_cb)
    if self.v_is_photo_page then
      self:try_retrurn_to_frame_list()
    end
  end)
  self:set_button("BtnSave", function()
    self:do_save(true)
  end)
  self:set_button("BtnPosReset", function()
    self:reset_selected_frame_pos()
  end)
  self:set_button("PageScene", function()
    self:select_page(Config.CommonDefine.MAIN_SCENE_DIY_PAGE.SCENE)
  end)
  self:set_button("PagePicture", function()
    self:select_page(Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO)
  end)
  self:set_button("BtnReturn", function()
    self:on_back_click()
  end)
  self:set_button("BtnRet1", function()
    self:on_back_click()
  end)
  self:set_button("BtnJump", function()
    self:on_jump_click()
  end)
  self.v_slider = self.v_uicompents.Slider_sld
  self:set_slider_listener(self.v_slider, function()
    self:on_slider_val_change()
  end)
  local page_obj_list = {
    self.v_uiobjects.PageScene,
    self.v_uiobjects.PagePicture
  }
  self.v_page_info = {}
  for page = 1, #page_obj_list do
    self.v_page_info[page] = Util.get_child_gameobj("Select", page_obj_list[page])
  end
  self:register_exist_auto_template(TD_FRAME_LIST_ITEM_TEMP_KEY, self.v_uiobjects.EditFrameTem, self.v_uiobjects.EditFrameContent)
  self:register_exist_auto_template(FRAME_LIST_ITEM_TEMP_KEY, self.v_uiobjects.FrameTem, self.v_uiobjects.FrameContent)
  self:register_exist_auto_template(PICTURE_LIST_ITEM_TEMP_KEY, self.v_uiobjects.PictureTem, self.v_uiobjects.PictureContent)
end

function ui:on_back_click(cb)
  if self:try_retrurn_to_frame_list() then
    self:refresh_3d_frame_mat()
    return
  end
  local is_select_own_scene_fashion = FashionMgr:check_is_own_fashion(self.v_selected_scene)
  local need_save_scene = is_select_own_scene_fashion and self.v_selected_scene ~= FashionMgr:get_using_main_scene_fashion_id()
  self:save_temp_data()
  local need_save_photo = PhotoMgr:if_need_save_temp_data()
  if need_save_photo or need_save_scene then
    local function cancel_cb()
      if need_save_photo then
        PhotoMgr:init_temp_data()
      end
      if self.v_is_photo_page then
        self:refresh_3d_frame_mat()
      end
      if need_save_scene or not is_select_own_scene_fashion then
        FashionMgr:reset_main_scene_fashion()
      end
      if cb then
        cb()
      else
        self:ui_hide()
      end
    end
    
    local function confirm_cb()
      if need_save_photo then
        self:save_photo()
      end
      if need_save_scene then
        self:save_scene()
      end
      if not is_select_own_scene_fashion then
        FashionMgr:reset_main_scene_fashion()
      end
      if cb then
        cb()
      else
        self:ui_hide()
      end
    end
    
    Util.show_notify_popup_message(confirm_cb, "直接退出将丢失未保存改动，\n是否确认退出？", nil, "保存后退出", "直接退出", cancel_cb, nil, nil, true)
  else
    if self.v_is_photo_page then
      self:refresh_3d_frame_mat()
    end
    if not is_select_own_scene_fashion then
      FashionMgr:reset_main_scene_fashion()
    end
    if cb then
      cb()
    else
      self:ani_out(true)
      self.v_delay_hide_timer = Timer:add_timer("photo_delay_hide_timer", 0.3, function()
        self:ui_hide()
      end)
    end
  end
end

function ui:do_save(just_show_tips, save_scene_cb)
  self:save_photo(just_show_tips)
  self:save_scene(just_show_tips, save_scene_cb)
end

function ui:save_photo(just_show_tips)
  if not self.v_is_photo_page then
    PhotoMgr:req_save_photo(nil)
    return
  end
  local selected_frame_id = self.v_selected_frame_id
  self:save_temp_data()
  self:refresh_3d_frame_mat()
  self.v_uiobjects.Blocker:SetActive(true)
  
  local function cb()
    self.v_uiobjects.Blocker:SetActive(false)
    if just_show_tips then
      Util.show_message_tip(2172)
      self:refresh_offset_color()
      self:refresh_scale_color()
      for _, item in ipairs(self.v_wrap_3d_frame_item) do
        item:play_anim(selected_frame_id)
      end
    else
      self:ui_hide()
    end
  end
  
  PhotoMgr:req_save_photo(cb)
end

function ui:save_scene(just_show_tips, save_scene_cb)
  local function cb()
    Util.show_message_tip(2172)
    
    if save_scene_cb then
      save_scene_cb()
    end
  end
  
  if not FashionMgr:check_is_own_fashion(self.v_selected_scene) then
    FashionMgr:reset_main_scene_fashion()
    return
  end
  FashionMgr:change_main_scene_fashion(self.v_selected_scene, cb)
end

function ui:save_temp_data()
  if self.v_selected_frame_id then
    local real_scale = self:map_scale(self.v_param_scale)
    PhotoMgr:set_frame_use_photo(self.v_selected_frame_id, self.v_selected_photo, real_scale, self.v_param_offset_x, self.v_param_offset_y)
  end
end

function ui:try_retrurn_to_frame_list()
  if self.v_uiobjects.PictureList.activeSelf and self.v_is_photo_page then
    if not self.v_selected_photo then
      self.v_operate_type = OperateType.NONE
    else
      self.v_operate_type = OperateType.EDIT
    end
    self:save_temp_data()
    self:show_frame_list()
    self:change_frame_selected()
    return true
  end
end

function ui:on_confirm_change_photo()
  self:save_temp_data()
  self:try_retrurn_to_frame_list()
  self:refresh_3d_frame_mat()
end

function ui:on_jump_click()
  if self.v_is_photo_page then
    return
  end
  local cfg = ShareRes.create("main_scene.main_scene_fashion", self.v_selected_scene)
  if not cfg or not cfg.JumpId then
    return
  end
  
  local function cb()
    SysOpenMgr:jump_to_sys(cfg.JumpId, true)
  end
  
  self:on_back_click(cb)
end

function ui:ui_on_show(page)
  TOUCH_SCALE_SPEED = PhotoMgr.GM_TOUCH_SCALE_SPEED or TOUCH_SCALE_SPEED
  TOUCH_SCALE_SPEED_M = PhotoMgr.GM_TOUCH_SCALE_SPEED_M or TOUCH_SCALE_SPEED_M
  PhotoMgr:init_temp_data()
  self.v_selected_frame_idx = nil
  self.v_selected_frame_id = nil
  self.v_selected_photo = nil
  self.v_selected_scene = nil
  self.v_using_scene = nil
  self.v_uiobjects.Blocker:SetActive(false)
  self.v_operate_type = OperateType.NONE
  self.v_max_scale = 1
  self:resgister_event()
  self.v_uimain = UIMgr:get_ui("uimain")
  self.v_uimain:enter_photo()
  self.v_mat_collect = self.v_uimain.v_photo_frame_mat_collect
  self:refresh_page(page)
  self:ani_in()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.PageSceneRed, RedEnum.SCENE_FASHION)
end

function ui:refresh_page(page)
  self.v_page = page
  if not page then
    self.v_page = Config.CommonDefine.MAIN_SCENE_DIY_PAGE.SCENE
  end
  self.v_is_photo_page = self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO
  self.v_uiobjects.EditFrameContent:SetActive(self.v_is_photo_page)
  for index, select_obj in pairs(self.v_page_info) do
    select_obj:SetActive(index == self.v_page)
  end
  self.v_uiobjects.BtnConfirm:SetActive(false)
  self.v_uiobjects.BtnJump:SetActive(false)
  if self.v_is_photo_page then
    self:show_3d_frame()
    self:show_frame_list()
  else
    if self.v_wrap_3d_frame_item then
      for _, item in ipairs(self.v_wrap_3d_frame_item) do
        item:un_select_content()
      end
    end
    self.v_using_scene = FashionMgr:get_using_main_scene_fashion_id()
    if not self.v_selected_scene then
      self.v_selected_scene = FashionMgr:get_using_main_scene_fashion_id()
    end
    self:show_photo_list()
  end
end

function ui:select_page(page)
  if self.v_page == page then
    return
  end
  self:refresh_page(page)
end

function ui:get_page()
  return self.v_page
end

function ui:ani_in()
  self.v_uicompents.Ani_UIMainDIY_In_pd.time = 0
  self.v_uicompents.Ani_UIMainDIY_In_pd:Play()
  self.v_uiobjects.MaskHideAll:SetActive(false)
end

function ui:ani_out(do_block)
  self.v_uicompents.Ani_UIMainDIY_out_pd.time = 0
  self.v_uicompents.Ani_UIMainDIY_out_pd:Play()
  if do_block then
    self.v_uiobjects.Blocker:SetActive(true)
  else
    self.v_uiobjects.MaskHideAll:SetActive(true)
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_page
end

function ui:ui_on_hide()
  self.v_selected_frame_idx = nil
  self.v_selected_frame_id = nil
  self.v_selected_photo = nil
  self.v_using_photo = nil
  self.v_selected_scene = nil
  self.v_using_scene = nil
  self.v_uimain:release_enter_photo()
  self:clear_wrap_3d_frame_item()
  self:clear_wrap_frame_item()
  self:clear_wrap_photo_item()
  self:remove_delay_hide_timer()
end

function ui:remove_delay_hide_timer()
  if self.v_delay_hide_timer then
    Timer:remove_timer(self.v_delay_hide_timer)
    self.v_delay_hide_timer = nil
  end
end

function ui:resgister_event()
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  Util.assert(root_gameobj)
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  Util.assert(self.v_container)
  local photo_frame = self.v_container:Get("Main_xiangkuang")
  self.v_photo_frame_mat_collect = photo_frame:GetComponent(TypeMaterailCollect)
  self.v_entry_attach = self.v_container:Get("JourneyEntry").transform
  self.v_entry_trans = self.v_uicompents.Entry_rect
  self.v_canvas = self:get_canvas()
  local main_ui = UIMgr:try_get_visible_ui("uimain")
  if main_ui and main_ui.v_model_view then
    self.v_main_ui_camera = main_ui.v_model_view.v_camera
  end
end

function ui:show_3d_frame()
  if not self.v_mat_collect or self.v_mat_collect:IsNull() then
    return
  end
  local MR = self.v_mat_collect.meshRenderers
  local MF = self.v_mat_collect.meshFilters
  self.v_3d_frame_list = {}
  local cfg = ShareRes.create("main_scene_video.chartlet_frame")
  for _, v in pairs(cfg) do
    if 1 == v.Show then
      local target = MR[v.PosType - 1]
      if not target then
        Log.Error("主场景Main_xiangkuang未收集对应MeshRender，PosType：", v.PosType)
      else
        table.insert(self.v_3d_frame_list, {
          mesh_render = target,
          mesh_filter = MF[v.PosType - 1],
          frame_idx = v.Index,
          frame_id = v.Id
        })
      end
    end
  end
  self:clear_wrap_3d_frame_item()
  self.v_wrap_3d_frame_item = {}
  self:give_back_auto_cache(TD_FRAME_LIST_ITEM_TEMP_KEY)
  for i, data in ipairs(self.v_3d_frame_list) do
    local obj = self:get_auto_cache(TD_FRAME_LIST_ITEM_TEMP_KEY)
    obj.name = "EditFrameTem" .. i
    local item = TDFrameItem:ui_wrap_ex(self, obj, true)
    item:set_linked_parent(self)
    item:set_data(data)
    table.insert(self.v_wrap_3d_frame_item, item)
  end
end

function ui:show_frame_list()
  self.v_selected_frame_id = nil
  local show_tween = not self.v_uiobjects.FrameList.activeSelf
  self.v_uiobjects.FrameList:SetActive(true)
  self.v_uiobjects.PictureList:SetActive(false)
  local photo_id = PhotoMgr:get_photo_id_by_frame_id(self.v_selected_frame_id, true) or 0
  self.v_uiobjects.PictureParam:SetActive(0 ~= photo_id)
  self.v_uiobjects.BtnConfirm:SetActive(false)
  self.v_uiobjects.BtnJump:SetActive(false)
  self.v_frame_list = {}
  local cfg = ShareRes.create("main_scene_video.chartlet_frame")
  for _, v in pairs(cfg) do
    if v.Index > 0 then
      table.insert(self.v_frame_list, v)
    end
  end
  table.sort(self.v_frame_list, function(a, b)
    return a.Index < b.Index
  end)
  self:clear_wrap_frame_item()
  self.v_wrap_frame_item = {}
  self:give_back_auto_cache(FRAME_LIST_ITEM_TEMP_KEY)
  for i, data in ipairs(self.v_frame_list) do
    local obj = self:get_auto_cache(FRAME_LIST_ITEM_TEMP_KEY)
    obj.name = "FrameTem" .. i
    local item = FrameItem:ui_wrap_ex(self, obj, true)
    item:set_linked_parent(self)
    item:set_data(data, show_tween)
    table.insert(self.v_wrap_frame_item, item)
  end
end

function ui:get_all_cfg()
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return ShareRes.create("main_scene_video.chartlet")
  end
  return ShareRes.create("main_scene.main_scene_fashion")
end

function ui:get_is_own(id)
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return PhotoMgr:check_own_photo(id)
  end
  return FashionMgr:check_is_own_fashion(id)
end

function ui:get_is_new(id)
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return false
  end
  return FashionMgr:get_is_new_fashion(id)
end

function ui:get_picture_param_visible()
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return self.v_selected_photo and 0 ~= self.v_selected_photo
  end
  return false
end

function ui:get_using_photo()
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return self.v_using_photo
  end
  return FashionMgr:get_using_main_scene_fashion_id()
end

function ui:get_selected_photo()
  if self.v_page == Config.CommonDefine.MAIN_SCENE_DIY_PAGE.PHOTO then
    return self.v_selected_photo
  end
  return self.v_selected_scene
end

function ui:get_operate_type()
  return self.v_operate_type
end

function ui:get_selected_frame_id()
  return self.v_selected_frame_id
end

function ui:show_photo_list()
  self.v_uiobjects.FrameList:SetActive(false)
  self.v_uiobjects.PictureList:SetActive(true)
  self.v_uiobjects.PictureParam:SetActive(self:get_picture_param_visible())
  self.v_uiobjects.BtnSave:SetActive(false)
  self.v_uiobjects.BtnConfirm:SetActive(true)
  self.v_photo_list = {}
  local cfg = self:get_all_cfg()
  for id, data in pairs(cfg) do
    if not data.ReleaseTime or Date.check_time_pass_by_scheme_id(data.ReleaseTime) then
      local is_own = self:get_is_own(id)
      local is_new = self:get_is_new(id)
      local _data = {
        id = id,
        priority = data.Priority,
        if_own = is_own,
        path = data.Path,
        name = data.Name,
        is_new = is_new
      }
      table.insert(self.v_photo_list, _data)
    end
  end
  table.sort(self.v_photo_list, function(a, b)
    if a.if_own ~= b.if_own then
      return a.if_own == true
    end
    if a.priority ~= b.priority then
      return a.priority < b.priority
    end
    return a.id < b.id
  end)
  self:clear_wrap_photo_item()
  self.v_wrap_photo_item = {}
  self:give_back_auto_cache(PICTURE_LIST_ITEM_TEMP_KEY)
  do
    local obj = self:get_auto_cache(PICTURE_LIST_ITEM_TEMP_KEY)
    obj.name = "PictureTem0"
    local item = PhotoItem:ui_wrap_ex(self, obj, true)
    item:set_linked_parent(self)
    item:set_data(nil)
    table.insert(self.v_wrap_photo_item, item)
  end
  for i, data in ipairs(self.v_photo_list) do
    local obj = self:get_auto_cache(PICTURE_LIST_ITEM_TEMP_KEY)
    obj.name = "PictureTem" .. i
    local item = PhotoItem:ui_wrap_ex(self, obj, true)
    item:set_linked_parent(self)
    item:set_data(data)
    table.insert(self.v_wrap_photo_item, item)
  end
end

function ui:clear_wrap_photo_item()
  if self.v_wrap_photo_item then
    for _, item in pairs(self.v_wrap_photo_item) do
      item:ui_destroy()
    end
    self.v_wrap_photo_item = nil
  end
end

function ui:clear_wrap_frame_item()
  if self.v_wrap_frame_item then
    for _, item in pairs(self.v_wrap_frame_item) do
      item:ui_destroy()
    end
    self.v_wrap_frame_item = nil
  end
end

function ui:clear_wrap_3d_frame_item()
  if self.v_wrap_3d_frame_item then
    for _, item in pairs(self.v_wrap_3d_frame_item) do
      item:ui_destroy()
    end
    self.v_wrap_3d_frame_item = nil
  end
end

function ui:refresh_btn_state(is_own)
  self.v_uiobjects.BtnConfirm:SetActive(is_own)
  self.v_uiobjects.BtnJump:SetActive(not is_own)
end

function ui:on_lock_photo_click(photo_id)
  self:refresh_btn_state(false)
  self:on_scene_item_click(photo_id)
end

function ui:on_click_photo(photo_id)
  self:refresh_btn_state(true)
  if self.v_is_photo_page then
    self:on_photo_item_click(photo_id)
  else
    self:on_scene_item_click(photo_id)
  end
end

function ui:on_photo_item_click(photo_id)
  if self.v_selected_frame_id then
    local click_photo_frame_data = PhotoMgr:get_frame_data_by_photo(photo_id, true)
    local frame_id = click_photo_frame_data and click_photo_frame_data.frame_id or 0
    local is_occupy = 0 ~= frame_id and self.v_selected_frame_id ~= frame_id
    if is_occupy then
      local function confirm_cb()
        self.v_selected_photo = photo_id
        
        self.v_using_photo = photo_id
        self.v_uiobjects.PictureParam:SetActive(true)
        self:save_temp_data()
        for _, item in ipairs(self.v_wrap_photo_item) do
          item:update_img()
          item:update_using()
          item:update_selected()
        end
        for _, item in ipairs(self.v_wrap_3d_frame_item) do
          item:update_mat()
          item:update_selected()
        end
      end
      
      Util.show_notify_popup_message(confirm_cb, "是否将所选内容替换到当前画框中？", nil, nil, nil, nil, nil, nil, true)
      return
    end
  end
  self:change_photo_selected(photo_id)
end

function ui:on_scene_item_click(scene_id)
  self.v_uiobjects.PictureParam:SetActive(false)
  if self.v_selected_scene ~= scene_id then
    self.v_selected_scene = scene_id
    for _, item in ipairs(self.v_wrap_photo_item) do
      item:update_img()
      item:update_using()
      item:update_selected()
    end
    FashionMgr:refresh_main_scene_fashion(scene_id)
  end
end

function ui:on_click_frame(frame_idx, frame_id)
  if self.v_selected_photo then
    self:save_temp_data()
  end
  local go_change_photo = true
  local photo_id = PhotoMgr:get_photo_id_by_frame_id(frame_id, true) or 0
  if not photo_id or 0 == photo_id then
    go_change_photo = true
  end
  self.v_selected_frame_idx = frame_idx
  self.v_selected_frame_id = frame_id
  self.v_selected_photo = photo_id
  self.v_using_photo = photo_id
  if go_change_photo then
    self.v_operate_type = OperateType.CHANGE
    self:show_photo_list()
  else
    self.v_operate_type = OperateType.EDIT
    self:show_frame_list()
  end
  self:change_frame_selected()
  self:refresh_3d_frame_mat()
end

function ui:change_photo_selected(photo_id)
  if self.v_selected_photo and 0 ~= self.v_selected_photo then
    self:save_temp_data()
  end
  self.v_selected_photo = photo_id
  for _, item in ipairs(self.v_wrap_photo_item) do
    item:update_selected()
  end
  for _, item in ipairs(self.v_wrap_3d_frame_item) do
    item:update_temp_img(photo_id)
  end
  self.v_param_scale = self:revert_map_scale(PhotoMgr:get_scale_by_frame_id(self.v_selected_frame_id, true))
  self.v_param_offset_x, self.v_param_offset_y = PhotoMgr:get_offset_by_frame_id(self.v_selected_frame_id, true)
  self:refresh_param_show_scale()
  self.v_param_offset_x, self.v_param_offset_y = PhotoMgr:get_offset_by_frame_id(self.v_selected_frame_id, true)
  self:refresh_param_show_pos()
  self.v_uiobjects.PictureParam:SetActive(self.v_selected_photo and 0 ~= self.v_selected_photo)
end

function ui:change_frame_selected()
  if not self.v_wrap_frame_item then
    return
  end
  for _, item in ipairs(self.v_wrap_frame_item) do
    item:update_selected()
  end
  for _, item in ipairs(self.v_wrap_3d_frame_item) do
    item:update_selected()
  end
  self.v_param_scale = self:revert_map_scale(PhotoMgr:get_scale_by_frame_id(self.v_selected_frame_id, true))
  self.v_param_offset_x, self.v_param_offset_y = PhotoMgr:get_offset_by_frame_id(self.v_selected_frame_id, true)
  self:refresh_param_show_scale()
  self.v_param_offset_x, self.v_param_offset_y = PhotoMgr:get_offset_by_frame_id(self.v_selected_frame_id, true)
  self:refresh_param_show_pos()
end

function ui:reset_selected_frame_pos()
  self:set_photo_param(1, 0, 0)
end

function ui:set_photo_param(scale, offset_x, offset_y)
  if scale then
    self.v_param_scale = scale
    self:refresh_param_show_scale()
  end
  if offset_x or offset_y then
    self.v_param_offset_x = offset_x
    self.v_param_offset_y = offset_y
    self:refresh_param_show_pos()
  end
end

local normal_color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
local modify_color = Util.get_unity_color_by_hex(tonumber("a0c0ff", 16))

local function func_compare_num(num1, num2)
  return math.floor(num1 * 100) == math.floor(num2 * 100)
end

function ui:refresh_param_show_pos()
  local show_x = 0 == self.v_param_offset_x and 0 or -self.v_param_offset_x
  local show_y = 0 == self.v_param_offset_y and 0 or -self.v_param_offset_y
  self.v_uicompents.PosParam_txt.text = string.format("（%.2f,%.2f）", show_x, show_y)
  self:set_selected_3d_frame_pos()
  self:refresh_offset_color()
end

function ui:refresh_param_show_scale()
  self.v_uicompents.SizeParam_txt.text = string.format("%.2f", self.v_param_scale)
  self.v_slider.value = self.v_param_scale
  self:set_selected_3d_frame_scale()
  self:refresh_scale_color()
end

function ui:refresh_offset_color()
  local x, y = PhotoMgr:get_offset_by_frame_id(self.v_selected_frame_id)
  local need_save = not func_compare_num(self.v_param_offset_x, x) or not func_compare_num(self.v_param_offset_y, y)
  self.v_uicompents.PosParam_txt.color = need_save and modify_color or normal_color
  self.v_uicompents.PosParamTxt_txt.color = need_save and modify_color or normal_color
end

function ui:refresh_scale_color()
  local need_save = not func_compare_num(self:revert_map_scale(PhotoMgr:get_scale_by_frame_id(self.v_selected_frame_id)), self.v_param_scale)
  self.v_uicompents.SizeParam_txt.color = need_save and modify_color or normal_color
  self.v_uicompents.SizeParamTxt_txt.color = need_save and modify_color or normal_color
end

function ui:refresh_scale_limit(max_scale)
  self.v_max_scale = max_scale
  local is_limit = 1 == max_scale
  self.v_uiobjects.SizeLimitTxt:SetActive(is_limit)
  self.v_uiobjects.Slider:SetActive(not is_limit)
  self.v_uiobjects.SizeParam:SetActive(not is_limit)
end

function ui:map_scale(input_scale)
  if 1 == self.v_max_scale then
    return 1
  end
  local inputRange = self.v_slider.maxValue - self.v_slider.minValue
  local outputRange = self.v_max_scale - 1
  local normalizedValue = (input_scale - 1) / inputRange
  local output_scale = normalizedValue * outputRange + 1
  return output_scale
end

function ui:revert_map_scale(output_scale)
  if 1 == self.v_max_scale then
    return 1
  end
  local inputRange = self.v_slider.maxValue - self.v_slider.minValue
  local outputRange = self.v_max_scale - 1
  local normalizedValue = (output_scale - 1) / outputRange
  local input_scale = normalizedValue * inputRange + self.v_slider.minValue
  return input_scale
end

function ui:on_slider_val_change()
  self.v_param_scale = self.v_slider.value
  self.v_uicompents.SizeParam_txt.text = string.format("%.2f", self.v_param_scale)
  self:set_selected_3d_frame_scale()
  self:refresh_scale_color()
end

function ui:set_selected_3d_frame_scale()
  for _, item in ipairs(self.v_wrap_3d_frame_item) do
    item:set_scale(self.v_param_scale)
  end
end

function ui:set_selected_3d_frame_pos()
  for _, item in ipairs(self.v_wrap_3d_frame_item) do
    item:set_pos(self.v_param_offset_x, self.v_param_offset_y)
  end
end

function ui:refresh_3d_frame_mat()
  if not self.v_wrap_3d_frame_item then
    return
  end
  for _, item in ipairs(self.v_wrap_3d_frame_item) do
    item:update_mat()
  end
end

function ui:ui_update()
  self:_check_touch()
end

function ui:_check_touch()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    local diff = Input.GetAxis("Mouse ScrollWheel")
    if 0 ~= diff then
      self:_on_pinch(diff * TOUCH_SCALE_SPEED_M)
    end
  elseif 2 == Input.touchCount then
    local touch_1 = Input.GetTouch(0)
    local touch_2 = Input.GetTouch(1)
    local touch_1_pos = touch_1.position
    local touch_2_pos = touch_2.position
    if touch_2.phase == TouchPhase.Ended then
      self.v_touch_cache_distance = nil
      return
    end
    local cur_dis = UnityVector2.Distance(touch_1_pos, touch_2_pos)
    if not self.v_touch_cache_distance then
      self.v_touch_cache_distance = cur_dis
      return
    end
    local diff = cur_dis - self.v_touch_cache_distance
    self:_on_pinch(diff * TOUCH_SCALE_SPEED)
    self.v_touch_cache_distance = cur_dis
  else
    self.v_touch_cache_distance = nil
  end
end

function ui:_on_pinch(diff)
  self.v_slider.value = self.v_slider.value + diff
end

return ui
