local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local PHOTO_TAG_TOG_KEY = "PHOTO_TAG_TOG_KEY"
local PHOTO_ITEM_KEY = "PHOTO_ITEM_KEY"
local PHOTO_ITEM_GROUP_KEY = "PHOTO_ITEM_GROUP_KEY"
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local _tinsert = table.insert
local PHOTO_TYPE = {COMMON_PHOTO = 1, SPINE_PHOTO = 2}
local spine_bg_color_black = UnityEngine.Color(0, 0, 0, 0)
local spine_bg_color_white = UnityEngine.Color(1, 1, 1, 1)

function ui:ui_finish_load()
  self.v_rawimg_spine = self:get_rawimage(nil, self.v_uiobjects.SpinePhoto)
  self:set_button("BtnRet1", function()
    self.v_tag_toggle_tab:set_toggle_by_index(1)
    self:ui_hide()
  end)
  self:set_button("BtnPhotoRet", function()
    self.v_uiobjects.PhotoShow:SetActive(false)
    self.v_uiobjects.Photo:SetActive(false)
    self.v_rawimg_spine.color = spine_bg_color_black
    self.v_uiobjects.Main:SetActive(true)
  end)
  self:set_button("BtnNext", function()
    self:click_next_btn()
  end)
  self:set_button("BtnLast", function()
    self:click_last_btn()
  end)
  self:set_button("BtnHideUI", function()
    self.v_is_hide_btn = not self.v_is_hide_btn
    self:update_big_btn_show()
  end)
  self:register_exist_auto_template(PHOTO_TAG_TOG_KEY, self.v_uiobjects.TagItem, self.v_uiobjects.TagList)
  self:register_exist_auto_template(PHOTO_ITEM_KEY, self.v_uiobjects.CGTem, self.v_uiobjects.PhotoList)
  self:register_exist_auto_template(PHOTO_ITEM_GROUP_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.PhotoList)
end

function ui:init_tag_tog()
  self.v_tog_list = ShareRes.create("archives.album_title")
  UtilTable.list_delete_by_func(self.v_tog_list, function(info)
    local is_show = ShareRes.get_archive_photo_title_cfg(info.Id)
    return not is_show
  end)
  if not self.v_tag_toggle then
    self.v_tag_toggle = {}
    for _, data in ipairs(self.v_tog_list) do
      local item = self:get_auto_cache(PHOTO_TAG_TOG_KEY)
      local name = Util.get_text("TagName", item)
      local red_point = Util.get_child_gameobj("Redpoint", name.gameObject)
      red_point:SetActive(ArchiveMgr:update_photo_title_red(data.Id))
      name.text = data.Name
      local tog = Util.get_toggle(nil, item)
      _tinsert(self.v_tag_toggle, tog)
    end
  end
  self.v_tag_toggle_tab = ToggleTab:new(self)
  self.v_tag_toggle_tab:init_by_toggles(self.v_tag_toggle, function(cur_select)
    self:click_tag(cur_select)
  end, 1, false)
  self:click_tag(1)
end

function ui:click_tag(cur_select)
  self:update_photo_list(cur_select)
  self.v_cur_select_tog_index = cur_select
end

function ui:update_tag_show(cur_select_index)
  for index, tog in pairs(self.v_tag_toggle) do
    local tog_text_Eng = Util.get_text("TagEnName", tog.gameObject)
    local page_name = Util.get_text("TagName", tog.gameObject)
    tog_text_Eng.color = index == cur_select_index and ArchiveMgr.v_en_color or ArchiveMgr.v_en_un_color
    page_name.color = index == cur_select_index and ArchiveMgr.v_color or ArchiveMgr.v_un_color
  end
end

function ui:update_photo_list(id)
  self:give_back_auto_cache(PHOTO_ITEM_KEY)
  self:give_back_auto_cache(PHOTO_ITEM_GROUP_KEY)
  local group_id = self.v_tog_list[id].Id
  self.v_cur_photo_list = nil
  self.v_cur_photo_list = UtilTable.copy_table(ShareRes.get_archive_photo_title_cfg(group_id))
  self.v_cur_red_list = {}
  
  local function sort_insert(temp_table, insert_data, compare_func)
    local insert_index = 1
    for _, info in ipairs(temp_table) do
      if compare_func(info, insert_data) then
        insert_index = insert_index + 1
      else
        break
      end
    end
    _tinsert(temp_table, insert_index, insert_data)
  end
  
  local function photo_sort_compare(a, b)
    if a.ShowPriority ~= b.ShowPriority then
      return a.ShowPriority > b.ShowPriority
    end
    return a.Id < b.Id
  end
  
  local function photo_group_sort_compare(a, b)
    if a.cfg.ShowPriority ~= b.cfg.ShowPriority then
      return a.cfg.ShowPriority > b.cfg.ShowPriority
    end
    return a.cfg.Id < b.cfg.Id
  end
  
  local temp = {}
  local temp_sort = {}
  for _, data in pairs(self.v_cur_photo_list) do
    local small_group_cfg = ShareRes.get_album_arch_small_group_cfg(data.PhotoGroup)
    local chapter_cfg = ShareRes.get_chapter_cfg(small_group_cfg.ChapterId)
    if chapter_cfg and 1 ~= chapter_cfg.ShowOff or not chapter_cfg then
      if temp[data.PhotoGroup] then
        sort_insert(temp[data.PhotoGroup].photos, data, photo_sort_compare)
      else
        temp[data.PhotoGroup] = {
          cfg = ShareRes.get_album_arch_small_group_cfg(data.PhotoGroup),
          PhotoGroup = data.PhotoGroup,
          photos = {}
        }
        sort_insert(temp_sort, temp[data.PhotoGroup], photo_group_sort_compare)
        sort_insert(temp[data.PhotoGroup].photos, data, photo_sort_compare)
      end
    end
  end
  self.v_photo_group_data = temp
  self.v_photo_group_data_sort = temp_sort
  self.v_photo_group_obj = {}
  self.v_cur_photo_list = {}
  self.v_unlock_photo_num = 0
  self.v_photo_lock_state = {}
  self.v_max_unlock_photo = 0
  local state_index = 0
  for index, group_data in ipairs(self.v_photo_group_data_sort) do
    local group_item = self:get_auto_cache(PHOTO_ITEM_GROUP_KEY)
    self.v_photo_group_obj[group_data.PhotoGroup] = group_item
    local chapter_name = Util.get_text("Title/StageName", group_item)
    local chapter_num = Util.get_text("Title/StageSort/SortText", group_item)
    chapter_name.text = group_data.cfg.Name
    chapter_num.text = group_data.cfg.ChapterName
    for _, data in ipairs(group_data.photos) do
      _tinsert(self.v_cur_photo_list, data)
      local photo_count = #self.v_cur_photo_list
      local item = self:get_auto_cache(PHOTO_ITEM_KEY)
      item.transform:SetParent(group_item.transform)
      local lock_go = Util.get_child_gameobj("LockObj", item)
      local un_lock_go = Util.get_child_gameobj("UnLockObj", item)
      local lock_flag = ArchiveMgr.v_album_list[data.Id].lock_state
      local btn = Util.get_button(nil, item)
      lock_go:SetActive(lock_flag)
      un_lock_go:SetActive(not lock_flag)
      self:set_button_listener(btn, function()
        if ArchiveMgr:is_to_achieve_Condition(data.ConditionID, true) then
          self.v_cur_select_photo = photo_count
          self:open_big_content()
          self:click_item()
        end
      end)
      state_index = state_index + 1
      self.v_photo_lock_state[state_index] = lock_flag
      if not lock_flag then
        self.v_unlock_photo_num = self.v_unlock_photo_num + 1
        local red_point = Util.get_child_gameobj("UnLockObj/RedPoint", item)
        local icon = Util.get_image("UnLockObj/CGIcon", item)
        local name = Util.get_text("UnLockObj/CGName", item)
        red_point:SetActive(ArchiveMgr.v_album_list[data.Id].red_state)
        ResMgr:load_set_icon(icon, data.SmallPthoto, nil, true, self)
        name.text = data.Name
        _tinsert(self.v_cur_red_list, red_point)
        if state_index > self.v_max_unlock_photo then
          self.v_max_unlock_photo = state_index
        end
      end
    end
  end
  self.v_cur_select_photo = 1
end

function ui:get_next_open_index()
  for index = 1, #self.v_photo_lock_state do
    if index > self.v_cur_select_photo and not self.v_photo_lock_state[index] then
      return index
    end
  end
  return nil
end

function ui:get_last_open_index()
  for index = #self.v_photo_lock_state, 1, -1 do
    if index < self.v_cur_select_photo and not self.v_photo_lock_state[index] then
      return index
    end
  end
  return nil
end

function ui:open_big_content()
  self.v_uiobjects.PhotoShow:SetActive(true)
  self.v_uiobjects.Photo:SetActive(true)
  self.v_uiobjects.BtnPhotoRet:SetActive(true)
  self.v_uiobjects.Main:SetActive(false)
  self.v_uiobjects.Ani_UIArchivePhoto1_PhotoShow_In:SetActive(false)
  self.v_uiobjects.Ani_UIArchivePhoto1_PhotoShow_In:SetActive(true)
  self.v_is_hide_btn = false
end

function ui:click_item()
  local photo_index = self.v_cur_select_photo
  local photo_id = self.v_cur_photo_list[photo_index].Id
  if ArchiveMgr.v_album_list[photo_id].red_state then
    ArchiveMgr:req_click_action(ArchiveMgr.CommonDefind.ARCH_TYPE.ALBUM_SYS, photo_id, function()
      self:update_red(photo_index, photo_id)
    end)
  end
  self:update_big_photo_info(photo_index)
end

function ui:update_red(cur_select, photo_id)
  if not (self:visible() and self.v_cur_red_list) or not self.v_cur_red_list[cur_select] then
    return
  end
  local red_go = self.v_cur_red_list[cur_select]
  red_go:SetActive(ArchiveMgr.v_album_list[photo_id].red_state)
  local text_go = Util.get_child_gameobj("TagName", self.v_tag_toggle[self.v_cur_select_tog_index].gameObject)
  local tog_red = Util.get_child_gameobj("Redpoint", text_go)
  local tog_id = self.v_tog_list[self.v_cur_select_tog_index].Id
  tog_red:SetActive(ArchiveMgr:update_photo_title_red(tog_id))
end

function ui:update_big_photo_info(photo_index)
  local info = self.v_cur_photo_list[photo_index]
  self.v_uiobjects.BtnLast:SetActive(1 ~= self:get_unlock_num())
  self.v_uiobjects.BtnNext:SetActive(1 ~= self:get_unlock_num())
  self.v_uicompents.PhtotDesc_txt.text = info.Desc
  self.v_uicompents.CGName_txt.text = info.Name
  local tog_length = #info.BigPhoto
  if 1 == tog_length then
    tog_length = 0
  end
  for i = 1, 7 do
    self.v_uiobjects["T" .. i]:SetActive(i <= tog_length)
  end
  if 1 ~= self.v_cur_select_photo_tog then
    self.v_select_toggle_tab:set_toggle_by_index(1)
  else
    self:update_photo()
  end
end

function ui:get_unlock_num()
  return self.v_unlock_photo_num or 0
end

function ui:click_next_btn()
  local next_id = self:get_next_open_index()
  if not next_id then
    self.v_cur_select_photo = 1
  else
    self.v_cur_select_photo = next_id
  end
  local photo_id = self.v_cur_photo_list[self.v_cur_select_photo].Id
  if not ArchiveMgr.v_album_list[photo_id].lock_state then
    self:click_item()
  end
end

function ui:click_last_btn()
  local last_index = self:get_last_open_index()
  if not last_index then
    self.v_cur_select_photo = self.v_max_unlock_photo
  else
    self.v_cur_select_photo = last_index
  end
  local photo_id = self.v_cur_photo_list[self.v_cur_select_photo].Id
  if not ArchiveMgr.v_album_list[photo_id].lock_state then
    self:click_item()
  end
end

function ui:update_big_btn_show()
  self.v_uiobjects.BigContent:SetActive(not self.v_is_hide_btn)
  if not self.v_is_hide_btn then
  end
end

function ui:ui_on_show()
  self.v_rawimg_spine.color = spine_bg_color_black
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self:init_tag_tog()
  local tog_list = {}
  for i = 1, 7 do
    _tinsert(tog_list, self.v_uicompents["T" .. i .. "_tog"])
  end
  self.v_cur_select_photo_tog = 1
  self.v_select_toggle_tab = ToggleTab:new(self)
  self.v_select_toggle_tab:init_by_toggles(tog_list, function(cur_select)
    self.v_cur_select_photo_tog = cur_select
    self:update_photo()
  end, 1, false)
end

function ui:update_photo()
  local photo_index = self.v_cur_select_photo
  local data = self.v_cur_photo_list[photo_index]
  if data.PhotoType[self.v_cur_select_photo_tog] == PHOTO_TYPE.COMMON_PHOTO then
    self.v_uiobjects.Photo:SetActive(true)
    self.v_rawimg_spine.color = spine_bg_color_black
    self.v_is_show_photo = true
    ResMgr:load_set_icon(self.v_uicompents.Photo_img, data.BigPhoto[self.v_cur_select_photo_tog], nil, true, self)
  elseif data.PhotoType[self.v_cur_select_photo_tog] == PHOTO_TYPE.SPINE_PHOTO then
    self.v_uiobjects.Photo:SetActive(false)
    self.v_rawimg_spine.color = spine_bg_color_white
    local spine_id = tonumber(data.BigPhoto[self.v_cur_select_photo_tog])
    self.v_is_show_photo = false
    if spine_id then
      self.v_anim_interval = SpineHelper.get_anim_interval(spine_id)
      self.v_single_anim_delay = SpineHelper.get_single_anim_delay(spine_id)
      self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpinePhoto)
      if self.v_spine_id ~= spine_id then
        self.v_spine_id = spine_id
        if self.v_spine_rt:check_spine_res(SpineHelper.get_spine_res(spine_id)) then
          local spine_cfg = ShareRes.get_spine_cfg(spine_id)
          local role_res = spine_cfg.SpineRes
          local loop_anim_name = spine_cfg.DefaultAnim
          self.v_uiobjects.SpinePhoto:SetActive(true)
          self.v_spine_rt:play_loop_anim(role_res, loop_anim_name)
        else
          SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpinePhoto)
        end
      else
        self.v_uiobjects.SpinePhoto:SetActive(true)
      end
    end
  end
end

function ui:ui_on_update()
  if not self.v_spine_id or self.v_is_show_photo then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:ui_on_hide()
  self.v_tag_toggle = nil
  self.v_cur_photo_list = nil
  self.v_cur_red_list = nil
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
    self.v_spine_id = nil
  end
end

function ui:load_spine_photo(rt_view, spine_res)
  local function load_cb(obj)
    obj:ResetAttr()
  end
  
  rt_view:load_spine_res(spine_res, load_cb)
end

return ui
