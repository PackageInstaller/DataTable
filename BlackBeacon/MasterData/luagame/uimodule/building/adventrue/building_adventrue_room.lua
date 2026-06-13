local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ADVENTRUE_ROOM_AWARD_TEMP = "ADVENTRUE_ROOM_AWARD_TEMP"
local ADVENTRUE_CHAR_TEMP = "ADVENTRUE_CHAR_TEMP"
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local CHAR_ITEM = require("uimodule.building.adventrue.building_adventrue_char_item")
local CHAR_HEAD_ITEM = require("uimodule.building.adventrue.building_adventrue_char_head_item")
local BUILDING_CONFIG = require("uimodule.building.building_config")
local ADVENTURE_TASK_STATE = Config.CommonDefine.ADVENTURE_TASK_STATE
local BUILDING_BUDDY_LIMIT = Config.CommonDefine.BUILDING_BUDDY_LIMIT
local AWARD_TYPE = {
  NOMAL = 0,
  CLUE = 2,
  CLUE_ADD_AWARD = 1
}
local ADD_WEIGHT_STR = "{1}概率+{2}%"
local PERCENT_STR = "（%d/%d）"
local NEW_INDEX_MT_T = {
  __newindex = function()
    Log.Error("槽位数量不可修改")
    return
  end
}
local CHAR_TYPE = {OWNED = 1, HELP_FIGHT = 2}

local function _after_set_data_func(item_obj, data)
  local ExtraTag = item_obj:get_uiobject("ExtraTag")
  local ChanceTag = item_obj:get_uiobject("ChanceTag")
  if data.award_type == AWARD_TYPE.NOMAL then
    ExtraTag:SetActive(false)
    ChanceTag:SetActive(false)
  elseif data.award_type == AWARD_TYPE.CLUE_ADD_AWARD then
    ExtraTag:SetActive(true)
    ChanceTag:SetActive(false)
  elseif data.award_type == AWARD_TYPE.CLUE then
    ExtraTag:SetActive(false)
    ChanceTag:SetActive(true)
  end
end

local function _sort_fun(a, b)
  if a.award_type ~= b.award_type then
    return a.award_type > b.award_type
  else
    return false
  end
end

function ui:after_select_clue()
  self.v_select_clue_id = BuildingMgr:get_adventrue_clue_select(self.v_task_type, self.v_task_index)
  self:refresh_clue_info()
  self:refresh_task_award_info()
  self:rebuild_char_item_list()
  self:refresh_char_adventrue_info()
end

function ui:try_insert_assign_fixed_char(slot_index, char_id, uuid, index, element_id, is_remove)
  local data = self.v_select_slot_map[slot_index]
  if data and data.fixed_char_id and data.fixed_char_id == char_id and not data.is_ban then
    if is_remove then
      self:set_slot_data(slot_index, false, char_id)
    else
      self:set_slot_data(slot_index, true, char_id, index, uuid, element_id)
    end
    return slot_index
  end
end

function ui:try_insert_fixed_char(char_id, uuid, index, element_id, is_remove)
  for slot_index in pairs(self.v_select_slot_map) do
    local result = self:try_insert_assign_fixed_char(slot_index, char_id, uuid, index, element_id, is_remove)
    if result then
      return slot_index == result and slot_index or nil
    end
  end
end

function ui:try_insert_assign_empty_char(slot_index, char_id, uuid, index, element_id, is_remove)
  local data = self.v_select_slot_map[slot_index]
  if is_remove then
    if data.char_id == char_id then
      self:set_slot_data(slot_index, false, char_id)
      return slot_index
    end
  else
    if uuid and self.v_help_fight_count >= 1 then
      Util.show_message_tip("只可上阵一个助战角色")
      return -1
    end
    if not data.is_select and not data.is_ban and not data.fixed_char_id then
      self:set_slot_data(slot_index, true, char_id, index, uuid, element_id)
      return slot_index
    end
  end
end

function ui:try_insert_empty_char(char_id, uuid, index, element_id, is_remove)
  for slot_index in ipairs(self.v_select_slot_map) do
    local result = self:try_insert_assign_empty_char(slot_index, char_id, uuid, index, element_id, is_remove)
    if result then
      return slot_index == result and slot_index or nil
    end
  end
end

function ui:check_char_is_select(char_id, uuid, show_tips)
  local select_same_id, char_has_select
  local slot_index = self.v_select_char_id_map[char_id]
  local slot_data = self.v_select_slot_map[slot_index]
  if slot_data and (slot_data.char_uuid or uuid) and uuid ~= slot_data.char_uuid then
    if show_tips then
      Util.show_message_tip(2249)
    end
    select_same_id = true
  end
  char_has_select = nil ~= slot_index
  return select_same_id, char_has_select
end

function ui:on_click_char_item(char_id, uuid, index, element_id, slot_index)
  if self.v_under_way or BuildingMgr:check_char_is_dispatch(uuid or char_id) then
    return
  end
  local select_same_id, is_remove = self:check_char_is_select(char_id, uuid, true)
  if select_same_id then
    return
  end
  local opeart_index
  if slot_index then
    local target_slot_data = self.v_select_slot_map[slot_index]
    if not target_slot_data or target_slot_data.is_select then
      return
    end
    if target_slot_data.fixed_char_id then
      opeart_index = self:try_insert_assign_fixed_char(slot_index, char_id, uuid, index, element_id, is_remove)
    else
      opeart_index = self:try_insert_assign_empty_char(slot_index, char_id, uuid, index, element_id, is_remove)
    end
  else
    opeart_index = self:try_insert_fixed_char(char_id, uuid, index, element_id, is_remove)
    opeart_index = opeart_index or self:try_insert_empty_char(char_id, uuid, index, element_id, is_remove)
  end
  if not opeart_index then
    return
  end
  self:on_select_char(opeart_index)
  self:refresh_char_adventrue_info()
  self:refresh_limit_info()
  return true
end

function ui:try_select_first_can_use_char(slot_index)
  local slot_data = self.v_select_slot_map[slot_index]
  if not slot_data or slot_data.is_ban then
    return
  end
  local char_id, char_uuid, can_select, select_same_id, char_has_select
  for _, char_item in ipairs(self.v_char_item_list) do
    char_id, char_uuid = char_item:get_id_info()
    if char_uuid and self.v_help_fight_count and self.v_help_fight_count > 1 then
    elseif slot_data.fixed_char_id and slot_data.fixed_char_id ~= char_id then
    else
      select_same_id, char_has_select = self:check_char_is_select(char_id, char_uuid, false)
      can_select = not select_same_id and not char_has_select
      if can_select and char_item:on_click_item(slot_index) then
        break
      end
    end
  end
end

function ui:on_select_char(index)
  if not self.v_select_slot_map[index] then
    return
  end
  self:update_char_select_state()
  self:update_head_info(index)
end

function ui:update_char_select_state()
  for key, item in ipairs(self.v_char_item_list) do
    item:on_select_char()
  end
end

function ui:update_head_info(index)
  if not self.v_select_slot_map[index] then
    return
  end
  local item = self.v_char_icon_item_map[index]
  if not item then
    local head_obj = self.v_uiobjects["Char" .. index]
    item = CHAR_HEAD_ITEM:ui_wrap_ex(self, head_obj, true)
    self.v_char_icon_item_map[index] = item
  end
  item:set_data(self.v_select_slot_map[index], index)
end

function ui:on_click_clue_btn()
  UIMgr:get_ui("building_adventrue_clue_tips"):ui_show()
end

function ui:on_click_dispatch_btn()
  if self.v_under_way then
    return
  end
  local cfg = ShareRes.get_building_adventure_type(self.v_task_type)
  local clue_count = cfg.ClueCount
  local using_clue_ids = BuildingMgr:select_clue_map_to_use_clue_list(true)
  if self.v_task_type ~= BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.SPECIAL and self.v_task_type ~= BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX and not self.v_select_clue_id then
    Util.show_notify_popup_message(function()
      self:on_click_add_TargetClue()
    end, "请选择目标线索后进行派遣", nil, "确定", "取消")
    return
  end
  if Util.is_more_than_zero(clue_count) then
    local total_count = 0
    for _, count in pairs(using_clue_ids) do
      total_count = total_count + count
    end
    if not using_clue_ids or clue_count > total_count then
      Util.show_message_tip(2250)
      return
    end
  end
  local buddy_list = {}
  for key, slot_data in pairs(self.v_select_slot_map) do
    if slot_data.char_id then
      buddy_list[key] = {}
      buddy_list[key].buddy_id = slot_data.char_id
      buddy_list[key].help_buddy_element_id = slot_data.element_id
      buddy_list[key].help_buddy_index = slot_data.index
    end
  end
  if not BuildingMgr:check_adventrue_team_limit(self.v_task_data.id, buddy_list, true) then
    return
  end
  if self.v_under_way then
    if BuildingMgr:check_adventrue_task_can_get_award(self.v_task_type, self.v_task_index) then
      BuildingMgr:requst_adventure_gain_task_reward(self.v_task_type, self.v_task_index, self.v_task_data.is_history, function()
        self:ui_hide()
      end)
    end
  else
    local function cb(ignore_select_clue_map)
      BuildingMgr:requst_adventure_accept_task(self.v_task_type, self.v_task_index, buddy_list, using_clue_ids, self.v_select_clue_id, function()
        self:ui_hide()
        
        UIMgr:try_call_ui_func("building_adventrue_main", "show_dispatch_tips")
      end)
      if not ignore_select_clue_map then
        BuildingMgr:set_select_clue_map()
      end
    end
    
    if self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX and self.v_is_need_show_box_all_finish_tips then
      local misc_cfg = ShareRes.get_building_misc_cfg()
      local award_id = misc_cfg.DefaultBoxAwardGroup
      local tips = "预见者，暂时没有遗漏的宝箱，本次探索只能获得以上奖励，是否仍要派遣？"
      UIMgr:get_ui("ui_award_notice_tips"):ui_show(tips, award_id, cb)
      return
    else
      cb(true)
    end
  end
  BuildingMgr:set_select_clue_map()
end

function ui:on_click_refresh_btn()
  local cur_flush_count = self.v_task_data.flush_count or 0
  local max_flush_count = self.v_misc_cfg.TaskFlushCount
  if cur_flush_count >= max_flush_count then
    Util.show_message_tip("刷新次数已用尽")
    return
  end
  self.v_uicompents.Ani_UIHomeTask_Task_In_pd:ResetPD()
  self.v_uicompents.Ani_UIHomeTask_Task_In_pd:Play()
  BuildingMgr:requst_building_adventure_task_flush(self.v_task_type, self.v_task_index, function()
    if not self:visible() then
      return
    end
    Util.show_message_tip("任务已刷新")
  end)
end

function ui:on_click_return_btn()
  self.v_uicompents.PageOwnChar_tog.isOn = true
  self.v_task_data = nil
  self.v_task_index = nil
  self.v_task_type = nil
  self.v_task_id = nil
  self.v_select_char_type = CHAR_TYPE.OWNED
  self.v_select_char_id_map = nil
  self.v_select_clue_id = nil
  BuildingMgr:set_select_clue_map()
  self:ui_hide()
end

function ui:on_click_screen_btn()
  UIMgr:get_ui("screen_buddy_tips"):ui_show(self.v_select_char_type == CHAR_TYPE.OWNED, self.v_select_char_type == CHAR_TYPE.HELP_FIGHT)
end

function ui:on_tog_state_change(isOn, char_type)
  if isOn then
    self.v_select_char_type = char_type
    self:refresh_char_info()
  end
end

function ui:on_click_add_clue_btn()
  if self.v_under_way then
    return
  end
  local task_data = BuildingMgr:get_adventrue_task_data(self.v_task_type, self.v_task_index)
  UIMgr:get_ui("building_adventrue_add_clue_tips"):ui_show(task_data)
end

function ui:on_click_add_TargetClue()
  if self.v_under_way then
    return
  end
  UIMgr:try_destory_ui("building_adventrue_select_clue_tips")
  UIMgr:get_ui("building_adventrue_select_clue_tips"):ui_show(self.v_task_type, self.v_task_index)
end

function ui:on_click_add_BirdTask()
  local gorup_id = self.v_task_cfg.ChainCentreEventId
  if Util.is_more_than_zero(gorup_id) then
    UIMgr:get_ui("building_batch_tips"):ui_show(self.v_task_id, false)
  end
end

function ui:on_click_box_task()
  UIMgr:get_ui("info_tips"):ui_show(6)
end

function ui:on_building_data_update()
  self:refresh_data()
  self:refresh_slot_init_data()
  self:refresh_view()
end

function ui:ui_finish_load()
  self:set_button("BtnClue", function()
    self:on_click_clue_btn()
  end)
  self:set_button("BtnDispatch", function()
    self:on_click_dispatch_btn()
  end)
  self:set_button("BtnRefresh", function()
    self:on_click_refresh_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnScreen", function()
    self:on_click_screen_btn()
  end)
  self:set_toggle("PageOwnChar", function(isOn)
    self:on_tog_state_change(isOn, CHAR_TYPE.OWNED)
  end)
  self:set_toggle("PageAssistChar", function(isOn)
    self:on_tog_state_change(isOn, CHAR_TYPE.HELP_FIGHT)
  end)
  self:set_button("Clue", function()
    self:on_click_add_clue_btn()
  end)
  self:set_button("TargetClue", function()
    self:on_click_add_TargetClue()
  end)
  self:set_button("BirdTask", function()
    self:on_click_add_BirdTask()
  end)
  self:set_button("BoxTask", function()
    self:on_click_box_task()
  end)
  self.v_award_item_list = {}
  self.v_char_item_list = {}
  self.v_char_icon_item_map = {}
  self.v_select_char_type = CHAR_TYPE.OWNED
  self.v_select_char_id_map = {}
  self.v_select_slot_map = setmetatable({
    [1] = {is_select = false},
    [2] = {is_select = false},
    [3] = {is_select = false}
  }, NEW_INDEX_MT_T)
  self:register_exist_auto_template(ADVENTRUE_ROOM_AWARD_TEMP, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardList)
  self:register_exist_auto_template(ADVENTRUE_CHAR_TEMP, self.v_uiobjects.CharTem, self.v_uiobjects.CharContent, 30)
end

function ui:ui_on_show(task_data)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_char_info, self)
  self:bind_auto_mq(Const.MSG_ON_BUILDING_DATA_UPDATE, self.on_building_data_update, self)
  self:refresh_data(task_data)
  self:refresh_slot_init_data()
  self:refresh_view()
end

function ui:ui_on_hide()
  self.v_select_clue_id = nil
  self:clear_char_item()
  self:clear_award_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_data(task_data)
  if not task_data and self.v_task_type and self.v_task_index then
    task_data = BuildingMgr:get_adventrue_task_data(self.v_task_type, self.v_task_index)
  end
  if not task_data then
    Log.Error("获取派遣任务数据失败", debug.traceback())
    return
  end
  self.v_task_data = task_data
  self.v_task_index = self.v_task_data.index
  self.v_task_type = self.v_task_data.type
  self.v_task_id = self.v_task_data.id
  self.v_uicompents.PageOwnChar_tog.isOn = true
  self.v_select_char_type = CHAR_TYPE.OWNED
  self.v_select_char_id_map = {}
  self.v_select_clue_id = self.v_select_clue_id or BuildingMgr:get_adventrue_clue_select(self.v_task_type, self.v_task_index)
  self.v_task_cfg = ShareRes.get_adventrue_task_cfg(self.v_task_id)
  self.v_misc_cfg = ShareRes.get_building_misc_cfg()
  self.v_under_way = self.v_task_data.state == ADVENTURE_TASK_STATE.UNDER_WAY
end

function ui:set_slot_data(slot_index, is_select, char_id, index, uuid, element_id)
  local data = self.v_select_slot_map[slot_index]
  if data.char_uuid and not uuid then
    self.v_help_fight_count = self.v_help_fight_count - 1
  end
  if uuid and not data.char_uuid then
    self.v_help_fight_count = self.v_help_fight_count + 1
  end
  self.v_help_fight_count = math.max(self.v_help_fight_count, 0)
  data.char_uuid = uuid
  data.index = index
  data.element_id = element_id
  data.is_select = is_select
  if is_select then
    if char_id then
      self.v_select_char_id_map[char_id] = slot_index
    end
    data.char_id = char_id
  else
    if char_id then
      self.v_select_char_id_map[char_id] = nil
    end
    data.char_id = nil
  end
end

function ui:refresh_slot_init_data()
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(self.v_task_cfg.Quality)
  local buddy_count = quality_cfg.BuddyCount
  local char_id, role_uuid
  self.v_help_fight_count = 0
  for index, data in pairs(self.v_select_slot_map) do
    data.is_ban = index > buddy_count
    if self.v_under_way and self.v_task_data.buddy_list[index] then
      local buddy_data = self.v_task_data.buddy_list[index]
      char_id = buddy_data.buddy_id
      role_uuid = buddy_data.role_uuid and buddy_data.role_uuid .. char_id or nil
      self:set_slot_data(index, true, char_id, nil, role_uuid)
    else
      data.fixed_char_id = nil
      self:set_slot_data(index, false)
    end
  end
  local operate_index = 1
  self.v_fixed_char_id_map = {}
  local limit_info = self.v_task_cfg.LimitInfo
  if limit_info and limit_info.BuddyLimit then
    for buddy_id in pairs(limit_info.BuddyLimit) do
      self.v_fixed_char_id_map[buddy_id] = true
      self.v_select_slot_map[operate_index].fixed_char_id = buddy_id
      operate_index = operate_index + 1
    end
  end
end

function ui:refresh_view()
  self:refresh_task_text_info()
  self:refresh_task_award_info()
  self:refresh_char_info()
  self:refresh_slod_info()
  self:refresh_clue_info()
  self:refresh_task_state()
  self:update_char_select_state()
  self:refresh_char_adventrue_info()
  self:refresh_limit_info()
  self:refresh_flush_count()
  self:refresh_reset_time()
  self:refresh_box_progress()
end

function ui:refresh_task_text_info()
  self.v_uicompents.TaskName_txt.text = Util.format_str(self.v_task_cfg.Name)
  self.v_uicompents.TaskDesc_txt.text = Util.format_str(self.v_task_cfg.Desc)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(self.v_task_cfg.Quality)
  local sec = quality_cfg.Time * 3600
  local str = Date.get_time_formate_5(sec)
  self.v_uicompents.TakeTimeNum_txt.text = str
  self.v_uicompents.ReSetTime_txt.text = "每日重置"
  ResMgr:load_set_icon(self.v_uicompents.TaskQuality_img, quality_cfg.QualityIconPath)
end

function ui:refresh_box_progress()
  local is_need_show_box = self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX
  if not is_need_show_box then
    self.v_uiobjects.BoxNumImage:SetActive(false)
    return
  end
  self.v_uiobjects.BoxNumImage:SetActive(true)
  local _, total_count, opened_count = TreasureChestMgr:get_need_open_chapter_info()
  self.v_uicompents.BoxNum1_txt.text = opened_count
  self.v_uicompents.BoxNum2_txt.text = total_count
  self.v_is_need_show_box_all_finish_tips = total_count == opened_count
end

function ui:refresh_limit_info()
  local limit_id_list = self.v_task_cfg.TeamLimitId
  local tips_str, temp_str
  local total_count = 0
  local cur_count, arg1, arg2
  for _, limit_id in ipairs(limit_id_list) do
    arg1, arg2 = nil, nil
    cur_count = 0
    local cfg = ShareRes.get_building_buddy_limit_cfg(limit_id)
    if cfg.Type == BUILDING_BUDDY_LIMIT.BUDDY_ID then
      if self.v_select_char_id_map[cfg.Arg[1]] then
        cur_count = cur_count + 1
      end
      arg1 = ShareRes.get_buddy_cfg(cfg.Arg[1]).Name
      total_count = 1
    elseif cfg.Type == BUILDING_BUDDY_LIMIT.BUDDY_ELEMENT then
      for key, slot_data in pairs(self.v_select_slot_map) do
        if slot_data.char_id and ShareRes.get_char_element_id(slot_data.char_id) == cfg.Arg[1] then
          cur_count = cur_count + 1
        end
      end
      arg2 = ShareRes.get_element_cfg(cfg.Arg[1]).ElementName
      arg1 = cfg.Arg[2]
      total_count = cfg.Arg[2]
    elseif cfg.Type == BUILDING_BUDDY_LIMIT.BUDDY_JOB then
      for key, slot_data in pairs(self.v_select_slot_map) do
        if slot_data.char_id and ShareRes.get_buddy_cfg(slot_data.char_id).Job == cfg.Arg[1] then
          cur_count = cur_count + 1
        end
      end
      arg2 = ShareRes.get_job_cfg(cfg.Arg[1]).Name
      arg1 = cfg.Arg[2]
      total_count = cfg.Arg[2]
    end
    temp_str = Util.format_str(cfg.TipsStr, arg1, arg2)
    if Util.is_more_than_zero(total_count) then
      temp_str = temp_str .. string.format(PERCENT_STR, cur_count, total_count)
    end
    tips_str = tips_str and tips_str .. "，" .. temp_str or temp_str
  end
  if Util.is_empty(tips_str) then
    self:refresh_only_need_count_tips()
  else
    self.v_uiobjects.CharNeed:SetActive(true)
    self.v_uiobjects.CharNeedDesc:SetActive(true)
    self.v_uicompents.CharNeedDesc_txt.text = tips_str
  end
end

function ui:refresh_only_need_count_tips()
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(self.v_task_cfg.Quality)
  self.v_uiobjects.CharNeed:SetActive(true)
  local select_count = 0
  for i, v in pairs(self.v_select_char_id_map) do
    select_count = select_count + 1
  end
  local count_tips = string.format(PERCENT_STR, select_count, quality_cfg.BuddyCount)
  self.v_uicompents.CharNeedDesc_txt.text = Util.format_str("上阵{1}名任意角色" .. count_tips, quality_cfg.BuddyCount)
end

function ui:refresh_char_adventrue_info()
  if not self.v_select_clue_id then
    self.v_uiobjects.TipsGroup:SetActive(false)
    return
  end
  local buddy_cfg, str
  local cfg = ShareRes.get_building_clue_cfg(self.v_select_clue_id)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(self.v_task_cfg.Quality)
  local building_level = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.ADVENTURE)
  local task_ratio = 0
  for i = building_level, 1, -1 do
    if Util.is_more_than_zero(quality_cfg.Ratio[i]) then
      task_ratio = quality_cfg.Ratio[i]
      break
    end
  end
  local char_add_ratio = 0
  for _, slot_data in pairs(self.v_select_slot_map) do
    if slot_data.char_id then
      buddy_cfg = ShareRes.get_buddy_cfg(slot_data.char_id)
      char_add_ratio = char_add_ratio + self:get_add_task_ratio(slot_data.char_id, buddy_cfg.Quality)
    end
  end
  task_ratio = task_ratio + char_add_ratio
  if task_ratio > 0 then
    str = Util.format_str(ADD_WEIGHT_STR, cfg.Name, task_ratio * 0.01)
  end
  if str then
    self.v_uicompents.Tips1_txt.text = str
    self.v_uiobjects.TipsGroup:SetActive(true)
    self.v_uiobjects.AddIcon:SetActive(char_add_ratio > 0)
  else
    self.v_uiobjects.TipsGroup:SetActive(false)
  end
end

function ui:_get_normal_award_info(data_list)
  local function normal_award_func(award_cfg, index)
    return {
      id = award_cfg.ItemId,
      
      count = award_cfg.Num,
      award_type = AWARD_TYPE.NOMAL
    }
  end
  
  ShareRes.get_item_obj_use_award_list(self.v_task_cfg.AwardGroup, data_list, normal_award_func)
end

function ui:_get_clue_add_award_info(data_list)
  if self.v_select_clue_count_map then
    local cfg
    
    local function clue_award_func(award_cfg, index)
      return {
        id = award_cfg.ItemId,
        count = award_cfg.Num * self.v_temp_clue_count,
        award_type = AWARD_TYPE.CLUE_ADD_AWARD
      }
    end
    
    for clue_id, count in ipairs(self.v_select_clue_count_map) do
      if count > 0 then
        cfg = ShareRes.get_building_clue_cfg(clue_id)
        self.v_temp_clue_count = count
        ShareRes.get_item_obj_use_award_list(cfg.AwardId, data_list, clue_award_func)
      end
    end
  end
end

function ui:_get_clue_award_info(data_list)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(self.v_task_cfg.Quality)
  if Util.is_more_than_zero(quality_cfg.FixedDisplayItem) then
    data_list[#data_list + 1] = {
      id = quality_cfg.FixedDisplayItem,
      count = 1,
      hide_amount = true,
      award_type = AWARD_TYPE.CLUE,
      cb = function()
        UIMgr:try_show_ui("info_tips", nil, 3)
      end
    }
  end
end

function ui:refresh_task_award_info()
  self:clear_award_item()
  local data_list = {}
  self:_get_normal_award_info(data_list)
  self:_get_clue_add_award_info(data_list)
  if self.v_task_type ~= BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.SPECIAL then
    self:_get_clue_award_info(data_list)
  end
  if self.v_task_type ~= BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX then
    table.sort(data_list, _sort_fun)
    for index, data in ipairs(data_list) do
      if not data.cb then
        function data.cb()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = data.id
          })
        end
      end
      data.after_set_data = _after_set_data_func
      local obj = self:get_auto_cache(ADVENTRUE_ROOM_AWARD_TEMP)
      local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
      item:set_data(data)
      self.v_award_item_list[index] = item
    end
  end
  local is_batch = Util.is_more_than_zero(self.v_task_cfg.ChainCentreEventId)
  self.v_uiobjects.BirdTask:SetActive(is_batch)
  if is_batch then
    self.v_uicompents.BirdTask_rect:SetAsLastSibling()
  end
end

function ui:update_clue_button(clue_count)
  self.v_uiobjects.Clue:SetActive(true)
  self.v_uiobjects.TargetClue:SetActive(false)
  local cur_count
  if self.v_under_way then
    cur_count = self.v_task_data.using_clue_ids and #self.v_task_data.using_clue_ids or 0
  else
    cur_count = 0
    self.v_select_clue_count_map = BuildingMgr:get_select_clue_map() or {}
    for key, count in pairs(self.v_select_clue_count_map) do
      cur_count = count + cur_count
    end
  end
  local inactive = clue_count > cur_count
  if inactive then
    cur_count = "<color=#e0212c>" .. cur_count .. "</color>"
  end
  Util.apply_grey_ex(self.v_uiobjects.BtnDispatch, inactive)
  self.v_uicompents.ClueNum_txt.text = cur_count .. "/" .. clue_count
  self.v_uiobjects.ClueActive:SetActive(not inactive)
  self.v_uiobjects.ClueUnActive:SetActive(inactive)
end

function ui:update_target_clue_button()
  self.v_uiobjects.Clue:SetActive(false)
  self.v_uiobjects.TargetClue:SetActive(true)
  local is_select = self.v_select_clue_id ~= nil
  if is_select and 0 ~= self.v_select_clue_id then
    local path = ShareRes.get_item_icon_path(self.v_select_clue_id)
    ResMgr:load_set_icon(self.v_uicompents.TargetClueIcon_img, path)
  end
  self.v_uiobjects.TargetClueIcon:SetActive(is_select)
  self.v_uiobjects.TargetClueActive:SetActive(is_select)
  self.v_uiobjects.TargetClueUnActive:SetActive(not is_select)
  Util.apply_grey_ex(self.v_uiobjects.BtnDispatch, false)
end

function ui:refresh_clue_info()
  local cfg = ShareRes.get_building_adventure_type(self.v_task_type)
  local clue_count = cfg.ClueCount
  if clue_count > 0 then
    self:update_clue_button(clue_count)
  else
    self:update_target_clue_button()
  end
end

function ui:refresh_task_state()
  local is_batch = Util.is_more_than_zero(self.v_task_cfg.ChainCentreEventId)
  self.v_uiobjects.BtnRefresh:SetActive(not is_batch)
  local not_under_way = not self.v_under_way
  self.v_uiobjects.BtnRefresh:SetActive(not_under_way and not is_batch)
  self.v_uicompents.DispatchText_txt.text = Util.format_str(not_under_way and "派 遣" or "派遣中")
  self.v_uicompents.BtnDispatch_btn.enabled = true
  self.v_uiobjects.BoxTask:SetActive(self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX)
  if self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX then
    self.v_uiobjects.BtnRefresh:SetActive(false)
    self.v_uiobjects.TargetClue:SetActive(false)
    self.v_uiobjects.BtnClue:SetActive(false)
  end
end

function ui:refresh_slod_info()
  for index in ipairs(self.v_select_slot_map) do
    self:update_head_info(index)
  end
end

function ui:refresh_char_info(msg)
  self.v_show_buddy_list = nil
  if msg and msg.mm_x then
    self.v_show_buddy_list = msg.mm_x
  end
  self:rebuild_char_item_list()
end

function ui:rebuild_char_item_list()
  local is_help_fight = self.v_select_char_type == CHAR_TYPE.HELP_FIGHT
  self:clear_char_item()
  self.v_show_buddy_list = BuildingMgr:get_sort_char_list_by_task_id(self.v_task_cfg.Id, self.v_select_clue_id, is_help_fight, self.v_show_buddy_list)
  local buddy_list = self.v_show_buddy_list
  for index, data in ipairs(buddy_list) do
    if not is_help_fight or data.uuid then
      local obj = self:get_auto_cache(ADVENTRUE_CHAR_TEMP)
      local role_uuid = is_help_fight and tonumber(data.uuid .. data.id) or nil
      self.v_char_item_list[index] = CHAR_ITEM:ui_wrap_ex(self, obj, true)
      self.v_char_item_list[index]:set_data(data.id, role_uuid, data.index, data.element, self.v_under_way)
    end
  end
  self:update_char_select_state()
  self.v_uicompents.Ani_UIHomeTask_Char_In_pd:ResetPD()
  self.v_uicompents.Ani_UIHomeTask_Char_In_pd:Play()
end

function ui:refresh_flush_count()
  local cur_flush_count = self.v_task_data.flush_count or 0
  local max_flush_count = self.v_misc_cfg.TaskFlushCount
  self.v_uicompents.RefreshLimitNum_txt.text = cur_flush_count .. "/" .. max_flush_count
end

function ui:refresh_reset_time()
  local not_batch = self.v_task_type ~= BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH
  self.v_uiobjects.ReSetTime:SetActive(not_batch)
  if not_batch then
    local display_str = (self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.NORMAL or self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX) and "每日重置" or "每周一重置"
    self.v_uicompents.ReSetTime_txt.text = Util.format_str(display_str)
  end
end

function ui:clear_char_item()
  self:give_back_auto_cache(ADVENTRUE_CHAR_TEMP)
  for key, item in pairs(self.v_char_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_char_item_list[key] = nil
  end
end

function ui:clear_award_item()
  self:give_back_auto_cache(ADVENTRUE_ROOM_AWARD_TEMP)
  for key, item in pairs(self.v_award_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_item_list[key] = nil
  end
end

function ui:check_is_select(char_id, char_uuid)
  local slot_index = self.v_select_char_id_map[char_id]
  if slot_index then
    local data = self.v_select_slot_map[slot_index]
    if data.char_uuid or char_uuid then
      return data.char_uuid == char_uuid
    end
    return true
  end
  return false
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_task_data
end

function ui:is_designated_role(role_id, element_id, job_id)
  local role_count, element_count, job_count = 0, 0, 0
  for key, slot_data in pairs(self.v_select_slot_map) do
    if slot_data.is_select then
      local buddy_cfg = ShareRes.get_buddy_cfg(slot_data.char_id)
      if slot_data.char_id == role_id then
        role_count = role_count + 1
      end
      if buddy_cfg.Element == element_id then
        element_count = element_count + 1
      end
      if buddy_cfg.Job == job_id then
        job_count = job_count + 1
      end
    end
  end
  local limit_info = self.v_task_cfg.LimitInfo
  if limit_info then
    if limit_info.BuddyLimit and limit_info.BuddyLimit[role_id] then
      return role_count < 1
    end
    if limit_info.ElementLimit and limit_info.ElementLimit[element_id] then
      return element_count < limit_info.ElementLimit[element_id]
    end
    if limit_info.JobLimit and limit_info.JobLimit[job_id] then
      return job_count < limit_info.JobLimit[job_id]
    end
  end
  return false
end

function ui:get_add_task_ratio(char_id, quality)
  local add_task_ratio = 0
  if not self.v_select_clue_id then
    return add_task_ratio
  end
  local buddy_to_clue_cfg = ShareRes.get_building_buddy_to_clue_cfg(char_id)
  if buddy_to_clue_cfg then
    for clue_id in pairs(buddy_to_clue_cfg) do
      if self.v_select_clue_id == clue_id then
        local weight = self.v_misc_cfg.AddWeight[quality] or 0
        add_task_ratio = add_task_ratio + weight
      end
    end
  end
  return add_task_ratio
end

return ui
