local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local horizon_group = UnityEngine.UI.HorizontalLayoutGroup
local _tinsert = table.insert
local _abs = math.abs
local LocalStorage = require("utils.localstorage")
local LOCAL_MATERIAL_SELECT_DROP_KEY = "LOCAL_MATERIAL_SELECT_DROP_KEY"
local LOCAL_MATERIAL_FIRST_OPENVIEW_KEY = "LOCAL_MATERIAL_FIRST_OPENVIEW_KEY"
local MATERIAL_STAGE_ITEM_KEY = "CHAPTER_MATERIAL_STAGE_ITEM_KEY"
local Scroll_Anim_Time = 0.7
local MODEL = {
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_level_content = {
    "LevelContent",
    BIND_TYPE.OBJECT
  },
  v_level_list = {
    "LevelList",
    BIND_TYPE.IMAGE
  },
  v_stage_tem = {
    "StageTem",
    BIND_TYPE.OBJECT
  },
  v_title_txt = {
    "TitleTxt",
    BIND_TYPE.TEXT
  },
  v_viewport = {
    "Viewport",
    BIND_TYPE.OBJECT
  },
  v_scroll_rect = {
    "LevelList",
    BIND_TYPE.SCROLL
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnSelectDrop", function()
    self:show_select_drop_view()
  end)
  self:register_exist_auto_template(MATERIAL_STAGE_ITEM_KEY, self.v_stage_tem, self.v_level_content)
  self.v_bg_eff = Util.get_child_gameobj("FullScreenBackground/Bg/Fx_ChapterNew_Bg_Star", self.v_object)
  self.v_ani = Util.get_child_gameobj("Animation/UIStage_Material_IN", self.v_object)
  self:update_local_select_data()
end

function ui:ui_after_show(material_type, epi_id, need_select_index)
  if not epi_id and ChapterMaterialMgr:get_restore_sweep_data() then
    self.v_auto_click_sweep = true
  end
  epi_id = epi_id or ChapterMaterialMgr:get_restore_sweep_data()
  ChapterMaterialMgr:set_restore_sweep_data(nil)
  self.need_select_epi_id = epi_id
  self.v_cache_material_type = material_type
  self.v_cur_material_type = material_type
  self:set_title()
  self:init_content_layout()
  self:init_stage_cfg()
  self:init_stage_list()
  self:refresh_stage_data()
  self.v_scroll_rect.movementType = 1
  self:set_bg_eff(true)
  self:bind_auto_mq(Const.MSG_UPDATE_MATERIAL_LEVEL_INFO, self.refresh_stage_data, self)
  self:bind_auto_mq(Const.MSG_ON_CHAPTER_DETAIL_INFO_HIDE, self.clear_select_param, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.hide_message, self)
  self:select_item_with_epi_id()
  if need_select_index then
    ChapterMaterialMgr:set_mat_select_index(self.v_chapter_id, need_select_index)
    self:update_local_select_data()
    self:set_title()
    self:check_daily_open_view(true)
  else
    self:check_daily_open_view()
  end
end

function ui:check_daily_open_view(ignore_select_ui)
  if not self.v_select_drop_group_id then
    return
  end
  self.v_first_openview_data = LocalStorage:load_table(LOCAL_MATERIAL_FIRST_OPENVIEW_KEY, true) or {}
  if self.v_first_openview_data[self.v_cur_material_type] then
    local last_timestamp = self.v_first_openview_data[self.v_cur_material_type]
    local cur_timestamp = Date.server_time()
    local duration_hour = (cur_timestamp - last_timestamp) // 3600
    if duration_hour >= 24 then
      self.v_first_openview_data[self.v_cur_material_type] = Date.server_time()
      self:show_select_drop_view(ignore_select_ui)
    else
      local timetable = {
        year = os.date("!%Y", cur_timestamp),
        month = os.date("!%m", cur_timestamp),
        day = os.date("!%d", cur_timestamp),
        hour = Global.daily_reset_hour
      }
      local timestampof5 = Date.to_timestamp(timetable)
      if cur_timestamp >= timestampof5 and last_timestamp < timestampof5 then
        self.v_first_openview_data[self.v_cur_material_type] = Date.server_time()
        self:show_select_drop_view(ignore_select_ui)
      end
    end
  else
    self.v_first_openview_data[self.v_cur_material_type] = Date.server_time()
    self:show_select_drop_view(ignore_select_ui)
  end
  LocalStorage:save_table(LOCAL_MATERIAL_FIRST_OPENVIEW_KEY, self.v_first_openview_data, true)
end

function ui:hide_message(msg)
  if msg.mm_obj == "team" then
    local canvas = self:get_canvas()
    self:set_bg_eff(canvas.planeDistance >= 100)
  end
end

function ui:set_bg_eff(enable)
  self.v_ani:SetActive(enable)
  self.v_bg_eff:SetActive(enable)
end

function ui:show_select_drop_view(ignore_select_ui)
  if ignore_select_ui then
    return
  end
  UIMgr:get_ui("material_select_drop_tips"):ui_show(self.v_select_drop_group_id, self.v_select_index, self.v_chapter_id)
end

function ui:ui_on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self.v_cur_material_type = nil
  UIMgr:try_hide_ui("material_stage_info")
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_cache_material_type
end

function ui:update_local_select_data()
  self.v_local_select_data = LocalStorage:load_table(LOCAL_MATERIAL_SELECT_DROP_KEY, true) or {}
end

function ui:set_title()
  local chapter_material_type = ShareRes.create("chapter.chapter_material_type")
  local cfg
  for _, v in pairs(chapter_material_type) do
    if v.MaterialType == self.v_cur_material_type then
      cfg = v
    end
  end
  self.v_title_txt.text = cfg.Name
  self.v_select_drop_group_id = cfg.SelectDropGroupID
  self.v_chapter_id = cfg.Id
  self.v_can_select_drop = cfg.SelectDropGroupID and true or false
  self.v_uiobjects.BtnSelectDrop:SetActive(cfg.SelectDropGroupID)
  if cfg.SelectDropGroupID then
    local drop_group_cfg = ShareRes.create("chapter.chapter_material_select_drop_group", cfg.SelectDropGroupID)
    if not self.v_local_select_data[cfg.Id] then
      self.v_local_select_data[cfg.Id] = 1
      LocalStorage:save_table(LOCAL_MATERIAL_SELECT_DROP_KEY, self.v_local_select_data, true)
    end
    self.v_select_index = self.v_local_select_data[cfg.Id]
    ChapterMaterialMgr:set_cur_drop_select_index(self.v_select_index)
    local image_path = drop_group_cfg.Icon[self.v_select_index]
    ResMgr:load_set_icon(self.v_uicompents.DropIcon_img, image_path)
  end
end

function ui:get_select_drop_state()
  return self.v_can_select_drop
end

function ui:get_select_drop_param()
  return self.v_select_drop_group_id, self.v_select_index, self.v_chapter_id
end

function ui:init_stage_cfg()
  local cfg_list = ShareRes.get_chapter_material_list_with_type(self.v_cur_material_type)
  self.v_stage_list = {}
  for _, cfg in pairs(cfg_list) do
    _tinsert(self.v_stage_list, {cfg = cfg})
  end
  table.sort(self.v_stage_list, function(a, b)
    return a.cfg.Id < b.cfg.Id
  end)
end

function ui:init_stage_list()
  self:give_back_auto_cache(MATERIAL_STAGE_ITEM_KEY)
  for i, v in ipairs(self.v_stage_list) do
    local item = self:get_auto_cache(MATERIAL_STAGE_ITEM_KEY)
    local root_trans = self:get_child_gameobj("Content_", item).transform
    local pos_down_trans = self:get_child_gameobj("PosDown_", item).transform
    local pos_up_trans = self:get_child_gameobj("PosUp_", item).transform
    local line_down_obj = self:get_child_gameobj("Content_/LineDown", item)
    local line_up_obj = self:get_child_gameobj("Content_/LineUp", item)
    local icon = self:get_image("Content_/ChapterIcon_", item)
    local name_txt = self:get_text("Content_/MainText_/ChapterName_", item)
    local difficulty_txt = self:get_text("Content_/MainText_/Difficulty/Difficulty_", item)
    local is_odd = 0 ~= i % 2
    local offset_y = is_odd and pos_down_trans.localPosition.y or pos_up_trans.localPosition.y
    root_trans:SetLocalPositionA(0, offset_y, 0)
    line_down_obj:SetActive(is_odd)
    line_up_obj:SetActive(not is_odd)
    ResMgr:load_set_icon(icon, v.cfg.Icon, nil, true, self)
    name_txt.text = v.cfg.tips
    difficulty_txt.text = v.cfg.DiffName
    v.item = item
    v.btn = self:get_button("Content_", item)
    v.red_obj = self:get_child_gameobj("Content_/Red_", item)
    v.select_obj = self:get_child_gameobj("Content_/Select_", item)
    local un_complete_obj_list = {}
    local complete_obj_list = {}
    for i = 1, 3 do
      un_complete_obj_list[i] = self:get_child_gameobj(Util.format_str("Content_/MainText_/UnComplete{1}", i), item)
      complete_obj_list[i] = self:get_child_gameobj(Util.format_str("Content_/MainText_/Complete{1}", i), item)
    end
    v.un_complete_obj_list = un_complete_obj_list
    v.complete_obj_list = complete_obj_list
    v.lock_txt = self:get_text("Content_/Locked_/Condition_", item)
    v.lock_obj = self:get_child_gameobj("Content_/Locked_", item)
    v.red_obj:SetActive(false)
    v.select_obj:SetActive(false)
    local is_start, activity_id = NoviceMgr:is_double_challenge_start(Config.CommonDefine.DOUBLE_TYPE.MATERIAL)
    local multi_obj = Util.get_child_gameobj("Content_/Multi", item)
    multi_obj:SetActive(is_start)
    if is_start then
      local multi_times_txt = Util.get_text("MultiTimes", multi_obj)
      multi_times_txt.text = ShareRes.get_double_challenge_cfg(activity_id).Double .. "倍"
    end
  end
  if not self.v_cache_material_type then
    self.v_scroll_rect.horizontalNormalizedPosition = 0
  end
end

function ui:refresh_stage_data()
  for idx, v in ipairs(self.v_stage_list) do
    local cfg = v.cfg
    local net_data = ChapterMaterialMgr:get_material_server_info(cfg.Id)
    local star_num = ChapterMaterialMgr:get_material_epi_star_num(cfg.Id)
    local max_star = ChapterMaterialMgr:get_material_max_star(cfg.Id)
    for i = 1, 3 do
      v.un_complete_obj_list[i]:SetActive(i <= max_star)
      v.complete_obj_list[i]:SetActive(i <= star_num)
    end
    local show_tips
    local is_lock = false
    local condition_id = cfg.OpenCondition
    if condition_id and not Condition:check_condition(condition_id) then
      show_tips = Condition:get_condition_desc(condition_id)
      is_lock = true
    end
    if not is_lock and (not net_data or net_data.is_lock) then
      is_lock = true
      show_tips = cfg.ConditionDesc
    end
    v.lock_obj:SetActive(is_lock)
    v.lock_txt.text = show_tips
    Util.apply_grey_ex(v.item.gameObject, is_lock)
    self:set_button_listener(v.btn, function()
      if is_lock then
        Util.show_message_tip(show_tips)
        return
      end
      self:move_level_item_to_first(idx)
      self.v_cache_material_type = self.v_cur_material_type
      v.select_obj:SetActive(true)
    end)
  end
end

function ui:select_item_with_epi_id()
  if not self.need_select_epi_id then
    return
  end
  local index = 1
  for idx, v in ipairs(self.v_stage_list) do
    if v.cfg.Id == self.need_select_epi_id then
      index = idx
      if v.select_obj then
        v.select_obj:SetActive(true)
      end
      break
    end
  end
  self:move_level_item_to_first(index)
  self.v_cache_material_type = self.v_cur_material_type
  self.need_select_epi_id = nil
end

function ui:init_content_layout()
  self.v_viewport_width = self.v_uicompents.Viewport_rect.rect.width
  local item_width = self.v_uicompents.StageTem_rect.rect.width
  local content_horizon_layout = self.v_level_content:GetComponent(typeof(horizon_group))
  local content_spacing = content_horizon_layout.spacing
  self.v_move_step = item_width + content_spacing
end

function ui:move_level_item_to_first(idx)
  self.v_scroll_rect.movementType = 0
  self.v_content_pos_x = self.v_level_content.transform.anchoredPosition.x
  local content_target_pos_x = -1 * (idx - 1) * self.v_move_step
  local move_width = self.v_content_pos_x - content_target_pos_x
  local rate = move_width / self.v_viewport_width
  self.v_anim_time = _abs(Scroll_Anim_Time * rate)
  local stage_item = self.v_stage_list[idx]
  self.v_move_item_obj = stage_item.item
  if self.v_sequence then
    self.v_sequence:Kill(false)
  end
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_uicompents.LevelContent_rect:DOAnchorPosX(content_target_pos_x, self.v_anim_time))
  self.v_sequence:AppendCallback(function()
    UIMgr:get_ui("material_stage_info"):ui_show(stage_item.cfg, self.v_move_item_obj, self.v_anim_time, self.v_auto_click_sweep)
    self.v_auto_click_sweep = nil
  end)
end

function ui:move_level_item_to_src_pos()
  local pos_x = self.v_content_pos_x or 0
  local ani_time = self.v_anim_time or Scroll_Anim_Time
  if self.v_sequence then
    self.v_sequence:Kill(false)
  end
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_uicompents.LevelContent_rect:DOAnchorPosX(pos_x, ani_time))
end

function ui:revert_scroll(alpha)
  if self.v_move_item_obj then
    local item_canvas = self:get_canvas_group(nil, self.v_move_item_obj)
    item_canvas.alpha = alpha
  end
  self.v_scroll_rect.movementType = 1
end

function ui:clear_select_param(duration)
  self.v_select_chapter_id, self.v_select_module_param, self.v_select_module_type = nil, nil, nil
  for _, v in pairs(self.v_stage_list) do
    v.select_obj:SetActiveEx(false)
  end
end

return ui
