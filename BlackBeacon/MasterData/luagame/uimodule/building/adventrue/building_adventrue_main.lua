local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ADVENTRUE_MAIN_ITEM = require("uimodule.building.adventrue.building_adventrue_main_item")
local BUILDING_CONFIG = require("uimodule.building.building_config")
local BUILDING_DISPATCH_TASK_TYPE = BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE
local ADVENTURE_TASK_STATE = Config.CommonDefine.ADVENTURE_TASK_STATE
local BRANCH_TASK_INDEX = 6
local MAX_POS_INDEX = 7
local POS_NAME = "TaskPos"

function ui:on_building_data_update()
  self:refresh_view()
end

function ui:on_click_return_btn()
  self:change_select_task_type(BUILDING_DISPATCH_TASK_TYPE.NORMAL)
  self:ui_hide()
end

function ui:on_click_BtnDispatch()
  UIMgr:try_show_ui("building_one_key_dispatch_tips")
end

function ui:on_click_BtnHarvest()
  BuildingMgr:requst_building_batch_adventure_gain_task_reward(self.v_select_task_type, function(response)
    if response and response.task_list then
      UIMgr:try_show_ui("building_one_key_get_award_tips", nil, response.task_list)
    end
  end)
end

function ui:on_click_clue_btn()
  UIMgr:get_ui("building_adventrue_clue_tips"):ui_show()
end

function ui:on_click_type_tog(isOn, task_type)
  if isOn and self.v_select_task_type ~= task_type then
    self:change_select_task_type(task_type)
    self:refresh_view()
  end
end

function ui:ui_finish_load()
  self:set_button("BtnAddition", function()
    self.v_uiobjects.AdditionGroup:SetActive(true)
    BUILDING_CONFIG.REFRESH_ADDTION_GROUP_FUNC(self, Config.CommonDefine.BUILDING_TYPE.ADVENTURE)
  end)
  self:set_button("BtnCloseTips", function()
    self.v_uiobjects.AdditionGroup:SetActive(false)
  end)
  self:set_button("BtnClue", function()
    self:on_click_clue_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnDispatch", function()
    self:on_click_BtnDispatch()
  end)
  self:set_button("BtnHarvest", function()
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_build_btnharvest_UI_SOUND)
    self:on_click_BtnHarvest()
  end)
  self:set_button("BoxProgress", function()
    self:on_box_progress_click()
  end)
  self:set_toggle("PageNorTask", function(isOn)
    if isOn then
      self.v_uicompents.PageNorTask_tog.interactable = false
      self.v_uicompents.PageSpTask_tog.interactable = true
      self.v_uicompents.PageBoxTask_tog.interactable = true
    end
    self:on_click_type_tog(isOn, BUILDING_DISPATCH_TASK_TYPE.NORMAL)
  end)
  self:set_toggle("PageSpTask", function(isOn)
    if isOn then
      self.v_uicompents.PageNorTask_tog.interactable = true
      self.v_uicompents.PageSpTask_tog.interactable = false
      self.v_uicompents.PageBoxTask_tog.interactable = true
    end
    self:on_click_type_tog(isOn, BUILDING_DISPATCH_TASK_TYPE.SPECIAL)
  end)
  self:set_toggle("PageBoxTask", function(isOn)
    if isOn then
      self.v_uicompents.PageNorTask_tog.interactable = true
      self.v_uicompents.PageSpTask_tog.interactable = true
      self.v_uicompents.PageBoxTask_tog.interactable = false
    end
    self:on_click_type_tog(isOn, BUILDING_DISPATCH_TASK_TYPE.BOX)
  end)
  self:set_playable_stopped_action(self.v_uicompents.Ani_DispatchTips_In_pd, function()
    if self:visible() then
      self.v_uiobjects.DispatchTips:SetActive(false)
    end
  end)
  self.v_task_item_map = {}
  self:change_select_task_type(BUILDING_DISPATCH_TASK_TYPE.NORMAL)
end

function ui:ui_on_show(select_task_type)
  self.v_uiobjects.AdditionGroup:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_BUILDING_DATA_UPDATE, self.on_building_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_BUILDING_CLUE_DATA_UPDATE, self.on_building_data_update, self)
  self.v_uiobjects.DispatchTips:SetActive(false)
  if select_task_type then
    self.v_select_task_type = select_task_type
  else
    self.v_select_task_type = self:get_init_select_type()
  end
  self:init_type_toggle_state()
  self:refresh_view()
end

function ui:ui_on_hide()
  self:clear_task_item()
  self:clear_dispatch_timer()
end

function ui:ui_on_destroy()
  self:clear_dispatch_timer()
end

function ui:get_init_select_type()
  local select_type = BUILDING_DISPATCH_TASK_TYPE.NORMAL
  for _, task_type in pairs(BUILDING_DISPATCH_TASK_TYPE) do
    if BuildingMgr:check_adventrue_type_can_get_award(task_type) then
      select_type = math.max(select_type, task_type)
    end
  end
  if select_type == BUILDING_DISPATCH_TASK_TYPE.BRANCH then
    select_type = BUILDING_DISPATCH_TASK_TYPE.NORMAL
  end
  return select_type
end

local TYPE_TO_TOG = {
  [BUILDING_DISPATCH_TASK_TYPE.NORMAL] = "PageNorTask_tog",
  [BUILDING_DISPATCH_TASK_TYPE.SPECIAL] = "PageSpTask_tog",
  [BUILDING_DISPATCH_TASK_TYPE.BOX] = "PageBoxTask_tog"
}

function ui:init_type_toggle_state()
  for task_type, tog_name in pairs(TYPE_TO_TOG) do
    local is_select = self.v_select_task_type == task_type
    if is_select then
      self.v_uicompents[tog_name].isOn = true
    end
    self.v_uicompents[tog_name].interactable = not is_select
  end
end

function ui:refresh_view()
  self:clear_dispatch_timer()
  self:clear_task_item()
  local is_normal = self.v_select_task_type == BUILDING_DISPATCH_TASK_TYPE.NORMAL
  local adventrue_task_datas = BuildingMgr:get_adventrue_type_data(self.v_select_task_type)
  local branch_task_data
  if is_normal then
    local branch_task_datas = BuildingMgr:get_adventrue_type_data(BUILDING_DISPATCH_TASK_TYPE.BRANCH)
    branch_task_data = branch_task_datas and branch_task_datas[1]
  end
  if not adventrue_task_datas then
    Log.Error("获取派遣任务失败, 任务类型", self.v_select_task_type, "请检查双端是否最新， 如仍有报错需检测配置是否有对应任务类型", debug.traceback())
    return
  end
  local task_data, dispatch_timer, can_get_award, init_red
  local show_red = false
  local is_branch
  self.v_uiobjects.BranchTaskPos6:SetActive(false)
  for index = 1, MAX_POS_INDEX do
    local task_pos_obj = self.v_uiobjects[POS_NAME .. index]
    if index == BRANCH_TASK_INDEX and is_normal then
      task_pos_obj:SetActive(false)
      task_pos_obj = self.v_uiobjects.BranchTaskPos6
      task_data = branch_task_data
      is_branch = true
    else
      task_data = adventrue_task_datas[index]
    end
    if task_data then
      self.v_task_item_map[index] = ADVENTRUE_MAIN_ITEM:ui_wrap_ex(self, task_pos_obj, true)
      can_get_award, init_red = self.v_task_item_map[index]:set_data(task_data)
      if can_get_award or init_red then
        show_red = true
      end
      local remain_explore_time
      if task_data.state == ADVENTURE_TASK_STATE.UNDER_WAY then
        local quality_cfg = ShareRes.get_adventrue_task_quality_cfg_by_task_id(task_data.id)
        local explore_time = quality_cfg.Time * 3600
        local cur_time = Date.server_time()
        remain_explore_time = explore_time - (cur_time - (task_data.explore_time or 0))
      elseif task_data.state == ADVENTURE_TASK_STATE.COMPLETE and is_branch then
        remain_explore_time = BuildingMgr:get_branch_next_refresh_time()
        if not Util.is_more_than_zero(remain_explore_time) then
          self.v_task_item_map[index]:refresh_empty_data()
        end
      end
      task_pos_obj:SetActive(true)
      if Util.is_more_than_zero(remain_explore_time) then
        dispatch_timer = dispatch_timer and math.min(dispatch_timer, remain_explore_time) or remain_explore_time
      end
    else
      task_pos_obj:SetActive(false)
    end
  end
  if Util.is_more_than_zero(dispatch_timer) then
    self.v_dispatch_refresh_timer = Global.ct_timer:add_timer("dispatch_refresh_timer", dispatch_timer + 1, self.dispatch_refresh_cb, self)
  end
  self:set_red_show_state(show_red)
  self:refresh_one_key_adventrue_info()
end

function ui:refresh_one_key_adventrue_info()
  local is_normal = self.v_select_task_type == BUILDING_DISPATCH_TASK_TYPE.NORMAL
  local is_special = self.v_select_task_type == BUILDING_DISPATCH_TASK_TYPE.SPECIAL
  self.v_uiobjects.CommonTask:SetActive(is_normal or is_special)
  local has_comp = false
  if is_normal then
    local _, complete_count = BuildingMgr:get_task_count_by_type(BUILDING_DISPATCH_TASK_TYPE.NORMAL)
    has_comp = complete_count > 0
  end
  self.v_uiobjects.BtnHarvest:SetActive(is_normal and has_comp)
  self.v_uiobjects.BtnDispatch:SetActive(is_normal and not has_comp)
end

function ui.dispatch_refresh_cb(remain_time, self)
  if not self:visible() then
    self:clear_dispatch_timer()
    return
  end
  local can_get_award, init_red
  local show_red = false
  for key, item in pairs(self.v_task_item_map) do
    can_get_award, init_red = item:refresh_dispatch_time()
    if can_get_award or init_red then
      show_red = true
    end
  end
  if remain_time <= 0 then
    self:clear_dispatch_timer()
    self:refresh_view()
  end
  self:set_red_show_state(show_red)
end

function ui:change_select_task_type(task_type)
  local display_str = (task_type == BUILDING_DISPATCH_TASK_TYPE.NORMAL or task_type == BUILDING_DISPATCH_TASK_TYPE.BOX) and "每日重置" or "每周一重置"
  self.v_uicompents.TimeTips_txt.text = Util.format_str(display_str)
  self.v_select_task_type = task_type
end

function ui:set_red_show_state()
  local show_normal, show_branch, show_special, show_box
  show_normal = BuildingMgr:check_adventrue_type_have_red(BUILDING_DISPATCH_TASK_TYPE.NORMAL)
  if not show_normal then
    show_branch = BuildingMgr:check_adventrue_type_have_red(BUILDING_DISPATCH_TASK_TYPE.BRANCH)
  end
  show_special = BuildingMgr:check_adventrue_type_have_red(BUILDING_DISPATCH_TASK_TYPE.SPECIAL)
  show_box = BuildingMgr:check_adventrue_type_have_red(BUILDING_DISPATCH_TASK_TYPE.BOX)
  self.v_uiobjects.NormalRed:SetActive(show_normal or show_branch)
  self.v_uiobjects.SpecialRed:SetActive(show_special)
  self.v_uiobjects.BoxRed:SetActive(show_box)
  self:refresh_box_page()
  self:refresh_box_progress()
end

function ui:refresh_box_page()
  local is_show = not TreasureChestMgr:get_all_chapter_treasure_chest_opened() or BuildingMgr:get_task_type_in_progress(BUILDING_DISPATCH_TASK_TYPE.BOX)
  self.v_uiobjects.PageBoxTask:SetActive(is_show)
  if not is_show and self.v_select_task_type == BUILDING_DISPATCH_TASK_TYPE.BOX then
    self.v_select_task_type = BUILDING_DISPATCH_TASK_TYPE.NORMAL
    self:init_type_toggle_state()
    self:refresh_view()
  end
end

function ui:refresh_box_progress()
  if self.v_select_task_type ~= BUILDING_DISPATCH_TASK_TYPE.BOX then
    self.v_uiobjects.BoxProgress:SetActive(false)
    return
  end
  self.v_uiobjects.BoxProgress:SetActive(true)
  self:refresh_box_progress_red()
  self:refresh_box_progress_info()
end

function ui:refresh_box_progress_red()
  local is_need_show_red = TreasureChestMgr:get_is_need_show_chapter_box_red()
  self.v_uiobjects.BoxProgressRed:SetActive(is_need_show_red)
end

function ui:refresh_box_progress_info()
  local chapter_id, total_count, opened_count = TreasureChestMgr:get_need_open_chapter_info()
  self.v_chapter_id = chapter_id
  self.v_uicompents.BoxProgressNum_txt.text = opened_count .. "/" .. total_count
end

function ui:on_box_progress_click()
  TreasureChestMgr:on_chapter_box_progress_click()
  self:refresh_box_progress_red()
  UIMgr:get_ui("ui_treasure_chest_handbook"):ui_show(0, true)
end

function ui:clear_task_item()
  for key, item in pairs(self.v_task_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_task_item_map[key] = nil
  end
end

function ui:clear_dispatch_timer()
  if self.v_dispatch_refresh_timer then
    Global.ct_timer:remove_timer(self.v_dispatch_refresh_timer)
    self.v_dispatch_refresh_timer = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_select_task_type
end

function ui:show_dispatch_tips()
  self.v_uiobjects.DispatchTips:SetActive(true)
end

return ui
