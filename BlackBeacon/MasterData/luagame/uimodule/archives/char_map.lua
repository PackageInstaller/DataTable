local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort
local CHAR_MAP_ITEM = "CHAR_MAP_ITEM"
local CHAR_MAP_PAGE_ITEM = "CHAR_MAP_PAGE_ITEM"
local CHAR_MAP_ITEM_CLASS = require("uimodule.archives.char_map_item")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local CharacterRotatePage = ShareRes.get_comm_string_value("CharacterRotatePage")
local MODEL_PARAM = MODEL_CONFIG.UI_CHARACTER_ENTER_MODEL_PARAM
local PAGE_LIST = {ELEMENT = 1, JOB = 2}
local PAGE_VIEW_TYPE = {
  [1] = 2,
  [2] = 3,
  [3] = 4,
  [4] = 5
}
local DEFAULT_CHAR_ICON_LARGE_POS = {X = 24.6, Y = -26}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    if self.v_show_data then
      self:disable_all_red_point(self.v_show_data, true)
    end
    self:ui_hide()
  end)
  self:set_button("CloseHideUI", function()
    self:show_or_hide_all_info(true)
  end)
  self:set_button("BtnScreenType", function()
    local select_page = PAGE_LIST.ELEMENT
    if self.v_cur_page_select == PAGE_LIST.ELEMENT then
      select_page = PAGE_LIST.JOB
    end
    self:switch_page(select_page)
  end)
  self:register_exist_auto_template(CHAR_MAP_ITEM, self.v_uiobjects.CharTem, self.v_uiobjects.CharTem.transform.parent.gameObject)
  self:register_exist_auto_template(CHAR_MAP_PAGE_ITEM, self.v_uiobjects.PageTem, self.v_uiobjects.PageTem.transform.parent.gameObject)
  Util.bind_msg(self, Const.MSG_ON_HIDE_UI, self.char_map_ui_on_hide, self)
end

function ui:on_go_to_main()
  if self.v_show_data then
    self:disable_all_red_point(self.v_show_data, true)
  end
end

function ui:refresh_show_data()
  local ret_data = {}
  local buddy_id_to_idx = {}
  local all_buddy_list = ShareRes.get_buddy_cfg()
  local own_buddy_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  local count_all = 0
  local count_have = 0
  for id, cfg in pairs(all_buddy_list) do
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(id) then
      local info = own_buddy_list[id]
      local own = false
      local redpoint = false
      count_all = count_all + 1
      if info then
        count_have = count_have + 1
        own = true
      end
      if ArchiveMgr.v_concern_net_list[id] then
        redpoint = ArchiveMgr.v_concern_net_list[id].red_state
      end
      local data = {
        id = id,
        own = own,
        job = cfg.Job,
        element = cfg.Element,
        name = cfg.Name,
        quality = cfg.Quality,
        redpoint = redpoint
      }
      _tinsert(ret_data, data)
      buddy_id_to_idx[id] = #ret_data
    end
  end
  return ret_data, buddy_id_to_idx
end

function ui:filter_and_sort_buddy(original_data, filter_func)
  local ret_data = {}
  for _, data in pairs(original_data) do
    if filter_func(data) then
      _tinsert(ret_data, data)
    end
  end
  
  local function sort_func(a, b)
    if a.own ~= b.own then
      return a.own
    elseif a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end
  
  _tsort(ret_data, sort_func)
  return ret_data
end

function ui:ui_on_show()
  self.v_show_data, self.v_buddy_id_to_idx = self:refresh_show_data()
  self.v_page_tog = nil
  self.v_red_points = nil
  self.v_total_red_point = nil
  self:switch_page(PAGE_LIST.ELEMENT)
  self.v_uiobjects.EnterObj:SetActive(true)
  self.v_uiobjects.DetailObj:SetActive(false)
end

function ui:switch_page(page_select)
  self.v_page_tog, self.v_red_points, self.v_total_red_point = self:refresh_page_tog(page_select)
  self.v_page_tog[1].isOn = false
  self.v_page_tog[1].isOn = true
  self.v_cur_page_select = page_select
  self.v_uiobjects.EleSelect:SetActive(page_select == PAGE_LIST.ELEMENT)
  self.v_uiobjects.JobSelect:SetActive(page_select == PAGE_LIST.JOB)
  self:refresh_red_point()
end

function ui:refresh_page_tog(element_or_job)
  local cfg_list = {}
  local ret_list = {}
  local red_points = {}
  if element_or_job == PAGE_LIST.ELEMENT then
    cfg_list = ShareRes.create("buddy.buddy_element")
  elseif element_or_job == PAGE_LIST.JOB then
    cfg_list = ShareRes.create("buddy.buddy_job")
  end
  self:give_back_auto_cache(CHAR_MAP_PAGE_ITEM)
  local item_all = self:get_auto_cache(CHAR_MAP_PAGE_ITEM)
  local tog_all_tog = Util.get_toggle(nil, item_all)
  local total_red_point = Util.get_child_gameobj("TagName/Redpoint", item_all)
  self:set_toggle_listener(tog_all_tog, function(isOn)
    if isOn then
      self:refresh_buddy_content(element_or_job, true)
    end
  end)
  _tinsert(ret_list, tog_all_tog)
  for _, data in ipairs(cfg_list) do
    if 0 ~= data.SortId then
      local item = self:get_auto_cache(CHAR_MAP_PAGE_ITEM)
      local desc = Util.get_text("TagName", item)
      local element_icon = Util.get_image("Icon", item)
      local tog = Util.get_toggle(nil, item)
      tog.isOn = false
      local red_point = Util.get_child_gameobj("TagName/Redpoint", item)
      red_points[data.Id] = red_point
      if element_or_job == PAGE_LIST.ELEMENT then
        ResMgr:load_set_icon(element_icon, data.ElementIconPath)
        desc.text = data.ElementName
      elseif element_or_job == PAGE_LIST.JOB then
        ResMgr:load_set_icon(element_icon, data.IconPath)
        desc.text = data.Name
      end
      self:set_toggle_listener(tog, function(isOn)
        if isOn then
          self:refresh_buddy_content(element_or_job, false, data.Id)
        end
      end)
      _tinsert(ret_list, tog)
    end
  end
  return ret_list, red_points, total_red_point
end

function ui:refresh_buddy_content(element_or_job, show_all_content, element_or_job_id)
  if self.v_cur_element_or_job == element_or_job and self.v_cur_element_or_job_id == element_or_job_id then
    return
  end
  self.v_cur_element_or_job = element_or_job
  if self.v_cur_element_or_job_id and self.v_pre_show_data then
    self:disable_all_red_point(self.v_pre_show_data)
  end
  self.v_cur_element_or_job_id = element_or_job_id
  local use_data = self.v_show_data
  if show_all_content then
    use_data = self:filter_and_sort_buddy(use_data, function(data)
      return true
    end)
  elseif element_or_job == PAGE_LIST.ELEMENT then
    use_data = self:filter_and_sort_buddy(use_data, function(data)
      return data.element == element_or_job_id
    end)
    self.v_pre_show_data = use_data
  elseif element_or_job == PAGE_LIST.JOB then
    use_data = self:filter_and_sort_buddy(use_data, function(data)
      return data.job == element_or_job_id
    end)
    self.v_pre_show_data = use_data
  end
  self:give_back_auto_cache(CHAR_MAP_ITEM)
  self:clear_buddy_ui()
  local count_all = 0
  local count_have = 0
  for idx, data in ipairs(use_data) do
    local char_item = self:get_auto_cache(CHAR_MAP_ITEM)
    local char_item_ui = CHAR_MAP_ITEM_CLASS:ui_wrap_ex(self, char_item, true)
    _tinsert(self.v_buddy_itemui, char_item_ui)
    char_item_ui:set_data(data)
    count_all = count_all + 1
    if data.own then
      count_have = count_have + 1
    end
  end
  self.v_uicompents.MaxNum_txt.text = count_all
  self.v_uicompents.NowNum_txt.text = count_have
end

function ui:clear_buddy_ui()
  if self.v_buddy_itemui then
    for _, obj in pairs(self.v_buddy_itemui) do
      obj:ui_hide()
      obj:ui_destroy()
    end
  end
  self.v_buddy_itemui = {}
end

function ui:show_char_detail(buddy_id)
  self.v_uiobjects.DetailObj:SetActive(true)
  self.v_uiobjects.EnterObj:SetActive(false)
  self.v_buddy_id = buddy_id
  local icon = UtilUI.get_hero_images(buddy_id, 5)
  ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, icon, nil, true)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_path = buddy_cfg.Icon[7]
  if icon_path then
    local idx = self.v_buddy_id_to_idx[buddy_id]
    self.v_show_data[idx].has_special_icon = true
    ResMgr:load_set_icon(self.v_uicompents.CharIconLarge_img, icon_path, nil, true)
    local overview_cfg = ShareRes.get_buddy_archive_overview(buddy_id)
    local rect = Util.get_rect_transform(nil, self.v_uiobjects.CharIconLarge)
    if overview_cfg.IconOffsetAndScale then
      rect:SetAnchoredPositionA(DEFAULT_CHAR_ICON_LARGE_POS.X + overview_cfg.IconOffsetAndScale[1], DEFAULT_CHAR_ICON_LARGE_POS.Y + overview_cfg.IconOffsetAndScale[2])
      rect:SetLocalScaleA(overview_cfg.IconOffsetAndScale[3], overview_cfg.IconOffsetAndScale[4], 1)
    else
      rect:SetAnchoredPositionA(DEFAULT_CHAR_ICON_LARGE_POS.X, DEFAULT_CHAR_ICON_LARGE_POS.Y)
      rect:SetLocalScaleA(1, 1, 1)
    end
  end
  self:get_panel("archive_char_main"):set_enable(true, buddy_id)
  self:show_model()
end

function ui:close_char_detail()
  if self.v_model_view then
    self.v_model_view:set_content_rotate_zero()
  end
  self.v_uiobjects.EnterObj:SetActive(true)
  self.v_uiobjects.DetailObj:SetActive(false)
  self:get_panel("archive_char_main"):set_enable(false)
  self:hide_model()
  self.v_cur_type = nil
end

function ui:show_model()
  if self.v_buddy_id then
    self:update_model_view(self.v_buddy_id)
    self.v_uiobjects.BgEnter:SetActive(false)
    self.v_uiobjects.CharIcon:SetActive(false)
    self.v_uiobjects.CharIconLarge:SetActive(false)
    self.v_uiobjects.BgDetail:SetActive(false)
    self.v_model_or_icon = true
    self.v_hide_model_and_icon = nil
    self:get_panel("archive_basic_info"):set_twodimensional_button(false)
    self:set_model_visible_by_panel(true)
  end
end

function ui:hide_model()
  if self.v_buddy_id then
    self.v_uiobjects.BgEnter:SetActive(true)
    local idx = self.v_buddy_id_to_idx[self.v_buddy_id]
    if self.v_show_data[idx].has_special_icon then
      self.v_uiobjects.CharIcon:SetActive(false)
      self.v_uiobjects.CharIconLarge:SetActive(true)
    else
      self.v_uiobjects.CharIcon:SetActive(true)
      self.v_uiobjects.CharIconLarge:SetActive(false)
    end
    self.v_uiobjects.BgDetail:SetActive(true)
    self.v_model_or_icon = false
    self.v_hide_model_and_icon = nil
    self:get_panel("archive_basic_info"):set_twodimensional_button(true)
    self:set_model_visible_by_panel(false)
  end
end

function ui:switch_model_or_icon(switch_flag)
  if self:visible() then
    if switch_flag then
      self:show_model()
    else
      self:hide_model()
    end
    self:get_panel("archive_basic_info"):set_twodimensional_button(not switch_flag)
  end
end

function ui:hide_model_and_icon()
  self:hide_model()
  self.v_uiobjects.CharIcon:SetActive(false)
  self.v_uiobjects.CharIconLarge:SetActive(false)
  self.v_hide_model_and_icon = true
end

function ui:show_main_panel_ui(set_val)
  self.v_uiobjects.CharMain:SetActive(set_val)
end

function ui:show_or_hide_all_info(switch_flag)
  local model_or_icon = self.v_model_or_icon
  if switch_flag then
    self:get_panel("archive_char_main"):set_enable(true, self.v_buddy_id)
    self.v_uiobjects.CloseHideUI:SetActive(false)
  else
    self:get_panel("archive_char_main"):set_enable(false)
    self.v_uiobjects.CloseHideUI:SetActive(true)
  end
  self:switch_model_or_icon(model_or_icon)
end

function ui:update_model_view(buddy_id)
  if not buddy_id or buddy_id < 1 or buddy_id == self.v_cur_model then
    return
  end
  if not self:visible() then
    return
  end
  self.v_cur_model = buddy_id
  local model_fashion_id = FashionMgr:get_init_fashion_model_id(buddy_id)
  local model_idx
  
  local function load_npc_cb()
    if self.v_model_view then
      self.v_model_view:hide_model_node(false)
      self.v_model_view:signboard_set_dynamic_bone_enable(true)
    end
    if self.v_model_view and self.v_model_view.set_npc_pos_rot_euler then
      self.v_model_view:set_npc_pos_rot_euler()
    end
    CharacterMgr:play_hero_approach_anim(buddy_id, 2, self.v_model_view, true)
  end
  
  local params = {
    model_id = model_fashion_id,
    npc_id = buddy_id,
    is_reload = self.v_model_view ~= nil,
    cb = load_npc_cb,
    use_weapon_id = ShareRes.get_buddy_cfg(buddy_id).WeaponInitId,
    ignore_fashion = true
  }
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME, nil, nil, true)
    model_idx = self.v_model_view:load_npc(params)
    local camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
    self.v_model_view:set_camera_param(camera_param)
  else
    model_idx = self.v_model_view:load_npc(params)
  end
  self.v_model_view:set_view_param(buddy_id, 1, true, true, model_idx)
  self.v_model_idx = model_idx
  if self.v_cur_characterrotatepage then
    if not CharacterRotatePage or 1 == CharacterRotatePage[self.v_cur_characterrotatepage] then
      self.v_model_view:set_touch_area(self.v_uicompents.TouchArea_rect)
    else
      self.v_model_view:set_touch_area(nil)
    end
  end
end

function ui:change_char_view(page, buddy_id, force_play)
  local type = PAGE_VIEW_TYPE[page]
  if self.v_model_view and type then
    local is_fast = not self.v_is_init_view
    self.v_model_view:set_view_param(buddy_id, type, is_fast, is_fast, self.v_model_idx)
    self.v_is_init_view = true
    if not CharacterRotatePage or 1 == CharacterRotatePage[page] then
      self.v_model_view:set_touch_area(self.v_uicompents.TouchArea_rect)
    else
      self.v_model_view:set_touch_area(nil)
      self.v_model_view:set_content_rotate_zero()
    end
    self.v_cur_characterrotatepage = page
  end
  if self.v_cur_type ~= type then
    CharacterMgr:play_hero_approach_anim(buddy_id, type, self.v_model_view)
    self.v_cur_type = type
  end
end

function ui:get_model_view()
  return self.v_model_view
end

function ui:ui_on_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
    self.v_cur_model = nil
  end
end

function ui:refresh_red_point()
  local temp_dict_job = {}
  local temp_dict_ele = {}
  self.v_total_red_point:SetActive(false)
  for _, data in pairs(self.v_show_data) do
    if data.redpoint then
      self.v_total_red_point:SetActive(true)
      temp_dict_job[data.job] = true
      temp_dict_ele[data.element] = true
    end
  end
  if self.v_cur_page_select == PAGE_LIST.ELEMENT then
    for idx, red_point_obj in pairs(self.v_red_points) do
      red_point_obj:SetActive(nil ~= temp_dict_ele[idx])
    end
  elseif self.v_cur_page_select == PAGE_LIST.JOB then
    for idx, red_point_obj in pairs(self.v_red_points) do
      red_point_obj:SetActive(nil ~= temp_dict_job[idx])
    end
  end
end

function ui:disable_red_point(buddy_id)
  if ArchiveMgr.v_concern_net_list[buddy_id] and ArchiveMgr.v_concern_net_list[buddy_id].red_state then
    ArchiveMgr:req_click_action(ArchiveMgr.CommonDefind.ARCH_TYPE.CONCERN_NET, buddy_id, function()
    end)
  end
  local idx = self.v_buddy_id_to_idx[buddy_id]
  self.v_show_data[idx].redpoint = false
  self:refresh_red_point()
end

function ui:disable_all_red_point(page_data, close_ui)
  local disable_redpoint = {}
  for tb_index, tb_data in pairs(page_data) do
    local buddy_id = tb_data.id
    if ArchiveMgr.v_concern_net_list[buddy_id] and ArchiveMgr.v_concern_net_list[buddy_id].red_state then
      _tinsert(disable_redpoint, buddy_id)
    end
    if not close_ui then
      local idx = self.v_buddy_id_to_idx[buddy_id]
      self.v_show_data[idx].redpoint = false
    end
  end
  if next(disable_redpoint) then
    ArchiveMgr:req_click_action_all(ArchiveMgr.CommonDefind.ARCH_TYPE.CONCERN_NET, disable_redpoint)
  end
  if not close_ui then
    self:refresh_red_point()
  end
end

function ui:char_map_ui_on_hide()
  if 1 == self.v_cur_characterrotatepage and self:visible() and not UIMgr:try_get_visible_ui("ui_fashionable_dress") and not self.v_hide_model_and_icon then
    self:switch_model_or_icon(self.v_model_or_icon)
    if self.v_buddy_id and self.v_model_view then
      self:change_char_view(1, self.v_buddy_id)
    end
  end
end

function ui:get_click_char_data(buddy_id)
  return self.v_show_data[self.v_buddy_id_to_idx[buddy_id]]
end

function ui:ui_on_hide()
  self:clear_buddy_ui()
  self:get_panel("archive_char_main"):set_enable(false)
  self:release_model()
  self.v_cur_element_or_job = nil
  self.v_cur_element_or_job_id = nil
  self.v_pre_show_data = nil
end

function ui:ui_on_destroy()
  self:release_model()
end

function ui:cache_ui()
  return true
end

function ui:set_model_visible_by_panel(visible)
  if self.v_model_view and self.v_model_view:is_visible() ~= visible then
    self.v_model_view:set_visible(visible)
  end
end

return ui
