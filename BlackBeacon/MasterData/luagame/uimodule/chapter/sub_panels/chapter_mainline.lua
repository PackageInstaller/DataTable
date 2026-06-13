local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local horizon_group = UnityEngine.UI.HorizontalLayoutGroup
local _tinsert = table.insert
local ToggleTab = require("ui.widget.widget_toggle_tab")
local MAINLINE_PAGE_KEY = "CHAPTER_MAINLINE_PAGE_KEY"
local MAINLINE_CHAPTER_ITEM_KEY = "CHAPTER_MAINLINE_CHAPTER_ITEM_KEY"
local MAINLINE_CHAPTER_SMALL_ITEM_KEY = "MAINLINE_CHAPTER_SMALL_ITEM_KEY"
local COLLECTION_SYS_OPEN_KEY = 39

function ui:ui_finish_load()
  self:set_button("BtnCollection", function()
    self:on_click_collection()
  end)
  self:register_exist_auto_template(MAINLINE_PAGE_KEY, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
  self:register_exist_auto_template(MAINLINE_CHAPTER_ITEM_KEY, self.v_uiobjects.ChapTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(MAINLINE_CHAPTER_SMALL_ITEM_KEY, self.v_uiobjects.SmallChapTem, self.v_uiobjects.Content)
  self.v_content_rect = self.v_uicompents.Content_rect
  local scroll_rect = self.v_uiobjects.ChapList:GetComponent(typeof(UnityEngine.UI.ScrollRect))
  self:set_scrollrect_listener(scroll_rect, function()
    local width = self.v_content_rect:GetSizeDeltaA()
    local pos = self.v_content_rect.anchoredPosition.x
    self.v_uiobjects.ScrollTip:SetActiveEx(width + pos > 100)
  end)
end

function ui:ui_on_show(tab_idx)
  self.v_init_select_chapter = ChapterMgr:get_record_select_chapter_id()
  self:init_content_layout()
  self:init_left_tab_cfg()
  self:init_left_tab_list(tab_idx or 1)
  self:refresh_collection()
  DownloadMgr:check_chapter_other_res()
end

function ui:init_content_layout()
  local content_horizon_layout = self.v_uiobjects.Content:GetComponent(typeof(horizon_group))
  local content_spacing = content_horizon_layout.spacing
  local item_width = Util.get_rect_transform("Container", self.v_uiobjects.ChapTem).rect.width
  self.v_move_step = item_width + content_spacing
end

function ui:ui_on_hide()
  self.v_init_select_chapter = nil
  ChapterMgr:set_record_select_chapter_id()
  self:clear_timer()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_current_tab_idx
end

function ui:get_cache()
  return self.v_current_tab_idx
end

function ui:clear_cache()
  self.v_current_tab_idx = nil
  self.v_cache_focus = false
end

function ui:init_left_tab_cfg()
  local page_cfg = ShareRes.create("chapter.chapter_page")
  self.v_left_tab_list = {}
  for _, v in pairs(page_cfg) do
    if 1 == v.IfShow then
      self.v_left_tab_list[#self.v_left_tab_list + 1] = {cfg = v}
    end
  end
  table.sort(self.v_left_tab_list, function(a, b)
    return a.cfg.Order < b.cfg.Order
  end)
end

function ui:init_left_tab_list(tab_idx)
  self:give_back_auto_cache(MAINLINE_PAGE_KEY)
  local toggle_list = {}
  for i, v in ipairs(self.v_left_tab_list) do
    local item = self:get_auto_cache(MAINLINE_PAGE_KEY)
    local tog = Util.get_toggle(nil, item)
    _tinsert(toggle_list, tog)
    v.tog_obj = tog.gameObject
    v.red_obj = self:get_child_gameobj("PageName/Redpoint", tog.gameObject)
    v.red_obj:SetActive(false)
    local icon = self:get_image("Icon", tog.gameObject)
    ResMgr:load_set_icon(icon, v.cfg.Icon)
    local name = Util.get_text("PageName", tog.gameObject)
    name.text = v.cfg.Name
  end
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(toggle_list, function(idx)
    self.v_cache_focus = false
    self:switch_page(idx)
  end, tab_idx)
  self:switch_page(tab_idx)
end

function ui:switch_page(tab_idx)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.chapter_refresh_UI_SOUND)
  self:on_chapter_list_refresh(tab_idx)
end

function ui:on_chapter_list_refresh(tab_idx)
  self.v_current_tab_idx = tab_idx
  local page_type = self.v_left_tab_list[tab_idx].cfg.PageType
  self.v_chapter_show_list = self:get_chapter_show_list(page_type)
  self:refresh_chapter_list()
  self:refresh_content_pos()
end

function ui:get_chapter_show_list(page_type)
  local chapter_data = ShareRes.get_chapter_cfg()
  local new_data = {}
  local cover_chapter_map = {}
  local cover_count = 0
  for _, data in pairs(chapter_data) do
    if data.ChapterPage == page_type and 1 ~= data.ShowOff and data.ChapterMode ~= Config.Chapter_Mode.HARD then
      if not Util.is_more_than_zero(data.OriginalChapter) then
        _tinsert(new_data, data)
      else
        local is_need_add = false
        if ChapterMgr:check_in_preopen_chapter(data.Id) then
          is_need_add = true
        end
        if not is_need_add then
          local pre_open_time = Date.get_time_stamp_by_scheme_id(data.PreOpenStartTime)
          local pre_end_time = Date.get_time_stamp_by_scheme_id(data.PreOpenEndTime)
          if pre_end_time > Date.server_time() then
            local original_cfg = ShareRes.get_chapter_cfg(data.OriginalChapter)
            if not original_cfg.PreOpenStartTime then
              is_need_add = true
            else
              local original_pre_open_time = Date.get_time_stamp_by_scheme_id(original_cfg.PreOpenStartTime)
              if pre_open_time < original_pre_open_time then
                is_need_add = true
              end
            end
          end
        end
        if is_need_add then
          cover_chapter_map[data.OriginalChapter] = data.Id
          cover_count = cover_count + 1
        end
      end
    end
  end
  table.sort(new_data, function(a, b)
    return a.SerialNum < b.SerialNum
  end)
  self.v_last_unlock_idx = nil
  local show_list = {}
  for i, data in ipairs(new_data) do
    local temp = {}
    local is_time_open = ChapterMgr:is_chapter_time_open(data.Id)
    if ChapterMgr:get_chapter_data_by_chapter_id(data.Id) and is_time_open then
      temp.cfg = data
      temp.lock = false
      _tinsert(show_list, temp)
      if self.v_init_select_chapter and self.v_init_select_chapter == data.Id or not self.v_last_unlock_idx then
        self.v_last_unlock_idx = i
      end
    else
      if cover_chapter_map[data.Id] then
        temp.cfg = ShareRes.get_chapter_cfg(cover_chapter_map[data.Id])
        cover_count = cover_count - 1
        temp.lock = false
      else
        temp.cfg = data
        temp.lock = true
      end
      _tinsert(show_list, temp)
    end
  end
  if not self.v_last_unlock_idx then
    self.v_last_unlock_idx = #show_list
  end
  return show_list
end

function ui:refresh_chapter_list()
  self:give_back_auto_cache(MAINLINE_CHAPTER_ITEM_KEY)
  self:give_back_auto_cache(MAINLINE_CHAPTER_SMALL_ITEM_KEY)
  local parent
  self:clear_timer()
  if not self.v_pre_open_timer_list then
    self.v_pre_open_timer_list = {}
  end
  for i, v in ipairs(self.v_chapter_show_list) do
    local item
    local is_small_item = v.cfg and 1 == v.cfg.IsSmallItem
    if not is_small_item then
      item = self:get_auto_cache(MAINLINE_CHAPTER_ITEM_KEY)
      parent = Util.get_child_gameobj("ChildContainer", item).transform
      parent.gameObject:SetActive(false)
    else
      item = self:get_auto_cache(MAINLINE_CHAPTER_SMALL_ITEM_KEY)
      if parent then
        parent.gameObject:SetActive(true)
        item.transform:SetParent(parent)
      end
    end
    item.name = "ChapTem" .. i
    v.item = item
    v.item_trans = item.transform
    local container_obj = Util.get_child_gameobj("Container", item)
    local chapter_cfg = v.cfg
    local bg_img = Util.get_image("ChapIcon_", container_obj)
    ResMgr:load_set_icon(bg_img, chapter_cfg.BgName, nil, true, self)
    local name_text = Util.get_text("ChapInfo_/ChapName_", container_obj)
    name_text.text = chapter_cfg.Name
    local english_name = Util.get_text("ChapInfo_/ChapEnName_", container_obj)
    english_name.text = chapter_cfg.EnglishName
    local chapter_num = Util.get_text("ChapInfo_/ChapterNum/ChapNum_", container_obj)
    chapter_num.text = chapter_cfg.ClientNum
    local chapter_name_canvas_group = Util.get_canvas_group("ChapInfo_", container_obj)
    local lock_panel = Util.get_child_gameobj("LockMask_", container_obj)
    local PreOpenLock = self:get_child_gameobj("ChapLock/PreOpenLock_", lock_panel)
    local PreOpen = self:get_child_gameobj("PreOpen_", container_obj)
    PreOpenLock:SetActive(false)
    PreOpen:SetActive(false)
    local con_result_id = Condition:check_condition_list(chapter_cfg.Condition)
    local is_lock = 0 ~= con_result_id or v.lock
    local is_time_open = ChapterMgr:is_chapter_time_open(v.cfg.Id)
    local is_lock_by_time = false
    if not is_lock or is_lock and 0 == con_result_id then
      is_lock = not is_time_open
      is_lock_by_time = true
    end
    local need_dp_txt = Util.get_text("ChapLock/Condition/Condition_", lock_panel)
    if 0 ~= con_result_id then
      local con_cfg = ShareRes.create("condition.condition", con_result_id)
      need_dp_txt.text = con_cfg.Desc
    elseif is_lock and is_lock_by_time then
      local open_time = Date.get_time_stamp_by_scheme_id(chapter_cfg.PreOpenStartTime)
      need_dp_txt.text = Util.format_str("开启时间：{1}", Date.standard_data(open_time))
    end
    chapter_name_canvas_group.alpha = is_lock and 0.04 or 1
    lock_panel:SetActive(is_lock)
    local frame_go = Util.get_child_gameobj("Frame_", container_obj)
    Util.apply_grey_ex(frame_go.gameObject, is_lock)
    Util.apply_grey_ex(bg_img.gameObject, is_lock)
    local cur_time = Date.server_time()
    local PreOpenObj = is_lock and PreOpenLock or PreOpen
    local preopen = ChapterMgr:check_in_preopen_chapter(v.cfg.Id)
    if preopen then
      PreOpenObj:SetActive(preopen)
      local Layout = self:get_child_gameobj("Layout", PreOpenObj)
      local pre_open_end_time = Date.get_time_stamp_by_scheme_id(chapter_cfg.PreOpenEndTime) or 0
      local seconds = pre_open_end_time - cur_time
      local remain_time
      if seconds then
        remain_time = Date.get_time_format_7(seconds)
      end
      if seconds <= 86400 then
        local pre_open_time = self:get_text("Layout/PreOpenTime", PreOpenObj)
        local timer_key = "CHAPTER_MAINLINE_PRE_OPEN" .. v.cfg.Id
        local timer = Global.ct_timer:add_timer(timer_key, seconds, function(left_time)
          remain_time = Date.get_time_format_7(left_time)
          pre_open_time.text = remain_time
          if left_time <= 0 then
            self:clear_timer()
            self:on_chapter_list_refresh(self.v_current_tab_idx)
          end
        end)
        self.v_pre_open_timer_list[timer_key] = timer
      end
      local show_layout = nil ~= remain_time
      Layout:SetActive(show_layout)
      if show_layout then
        local PreOpenTime = self:get_text("Layout/PreOpenTime", PreOpenObj)
        PreOpenTime.text = remain_time
      end
    end
    local red_go = Util.get_child_gameobj("ChapRed_", container_obj)
    if is_lock then
      red_go:SetActive(false)
    else
      local is_red = self:refresh_chapter_red_point(red_go, chapter_cfg.Id)
      self:refresh_chapter_progress(container_obj, chapter_cfg)
      if is_red then
        self.v_left_tab_list[self.v_current_tab_idx].red_obj:SetActiveEx(true)
      end
    end
    local btn = Util.get_button(nil, container_obj)
    self:set_button_listener(btn, function()
      if ResMgr:check_is_can_fight_with_res(chapter_cfg) then
        self.v_cache_focus = true
        self:click_chapter_ui(chapter_cfg)
      end
    end)
    local chapter_id = v.cfg.Id
    local is_open = v.lock and ChapterMgr:check_story_preheat_group_open(chapter_id)
    local pre_btn = Util.get_button("BtnStoryPreview_", container_obj)
    pre_btn.gameObject:SetActive(is_open)
    if is_open then
      self:set_button_listener(pre_btn, function()
        UIMgr:get_ui("chapter_story_preheat"):ui_show(chapter_id)
      end)
    end
    Util.get_child_gameobj("Animation/AfterIN/Ani_ChapTem_Loop_Up", container_obj):SetActiveEx(0 ~= i % 2)
    Util.get_child_gameobj("Animation/AfterIN/Ani_ChapTem_Loop_Down", container_obj):SetActiveEx(0 == i % 2)
  end
end

function ui:refresh_content_pos()
  if self.v_cache_focus then
    return
  end
  local focus_idx = self.v_last_unlock_idx or 1
  if #self.v_chapter_show_list == focus_idx then
    focus_idx = focus_idx - 1
  end
  local focus_pos = focus_idx < 3 and 0 or -(focus_idx - 2) * self.v_move_step
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_content_rect)
  self.v_content_rect:SetLocalPositionA(focus_pos, 0, 0)
  local width = self.v_content_rect:GetSizeDeltaA()
  local pos = self.v_content_rect.anchoredPosition.x
  self.v_uiobjects.ScrollTip:SetActiveEx(width + pos > 100)
end

function ui:refresh_chapter_red_point(red_go, chapter_id)
  local is_red = TaskMgr:get_chapter_task_red(chapter_id)
  local new_chapter_data = ChapterMgr:get_new_chapter_open_data()
  if new_chapter_data.new_chapter_id == chapter_id then
    is_red = is_red or 1 == new_chapter_data.is_new
  end
  red_go:SetActive(is_red)
  return is_red
end

function ui:refresh_chapter_progress(chapter_ui, chapter_cfg)
  local chapter_id = chapter_cfg.Id
  local item_id, count = ChapterMgr:get_next_unlock_chapter_need_item(chapter_id)
  local progress_go = Util.get_child_gameobj("BtnTask_", chapter_ui)
  if not item_id or not count then
    progress_go:SetActive(false)
  else
    progress_go:SetActive(true)
    local cur_count = BagMgr:get_item_num(item_id)
    local pre = cur_count / count
    local pro_img = Util.get_image("BtnTask_/DpBarFill_", chapter_ui)
    pro_img.fillAmount = pre
  end
end

function ui:click_chapter_ui(chapter_cfg)
  local chapter_id = chapter_cfg.Id
  if not ChapterMgr:check_chapter_is_unlock(chapter_id, true) then
    return
  end
  local is_time_open = ChapterMgr:is_chapter_time_open(chapter_id)
  if not is_time_open then
    Util.show_message_tip(2349)
    return
  end
  UIMgr:get_ui("ui_chapter_detail"):ui_show(chapter_id, nil, nil, nil, nil, nil, true)
  local new_chapter_data = ChapterMgr:get_new_chapter_open_data()
  if new_chapter_data.new_chapter_id == chapter_id and 1 == new_chapter_data.is_new then
    new_chapter_data.is_new = 0
    ChapterMgr:save_local_new_chapter_open_data(new_chapter_data)
  end
end

function ui:on_click_collection()
  if SysOpenMgr:get_sys_is_open(COLLECTION_SYS_OPEN_KEY, true) then
    UIMgr:get_ui("collection_main"):ui_show()
  end
end

function ui:refresh_collection()
  local open = SysOpenMgr:get_sys_is_open(COLLECTION_SYS_OPEN_KEY, false)
  local uobj = self.v_uiobjects
  uobj.BtnCollection:SetActive(open)
  uobj.BtnCollection:SetActive(false)
end

function ui:clear_timer()
  if not self.v_pre_open_timer_list then
    return
  end
  for timer_key, timer in pairs(self.v_pre_open_timer_list) do
    if timer then
      Global.ct_timer:remove_timer(timer)
    end
  end
  self.v_pre_open_timer_list = nil
end

return ui
