local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local SELECT_ITEM = require("uimodule.common.multi_select_item")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CHALLENGE_TXT = "挑战"
local asset_bar_config = {
  {
    item_id = Config.PLAYER_SP_ITEMID,
    func = "_onclick_stamina",
    const_event = Const.MSG_ON_PLAYER_SP_UPDATE,
    bg_click = false
  }
}
local POINT_TAG_NAME = {
  [0] = "首通",
  [1] = "一星",
  [2] = "二星",
  [3] = "三星"
}
local NODE_TAG_NAME = {
  [-1] = "Tag_",
  [0] = "Tag0_",
  [1] = "Tag1_",
  [2] = "Tag2_",
  [3] = "Tag3_",
  [4] = "Tag4_"
}
local TYPE_FUNC_NAME = {
  [Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE] = "refresh_node_detail_info",
  [Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT] = "refresh_point_detail_info"
}
local enough_color = Util.get_unity_color_by_hex(tonumber("F5EDE1", 16))
local not_enough_color = Util.CommonColor_RedWarm
local TEMPLATE_KEY_TARGET_HARD, TEMPLATE_KEY_SELECT_ITEM, TEMPLATE_KEY_NODE_AWARD
local CHAPTER_ACTIVITY_ITEM_KEY = "CHAPTER_ACTIVITY_ITEM_KEY"
local challenge_multiple = 4

function ui:ui_finish_load()
  TEMPLATE_KEY_TARGET_HARD = "TEMPLATE_KEY_TARGET_HARD"
  TEMPLATE_KEY_SELECT_ITEM = "TEMPLATE_KEY_SELECT_ITEM"
  TEMPLATE_KEY_NODE_AWARD = "TEMPLATE_KEY_NODE_AWARD"
  self:set_button("BtnBack", function()
    local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
    if is_need_run_journey_event then
      return
    end
    self:do_hide()
  end)
  self:set_button("BtnFight", function()
    if self:is_can_not_click() then
      return
    end
    self:_click_fight_node_start_btn()
  end)
  self:set_button("BtnPlay", function()
    if self:is_can_not_click() then
      return
    end
    self:_click_story_node_start_btn()
  end)
  self:set_button("BtnJump", function()
    if self:is_can_not_click() then
      return
    end
    self:_click_jump_btn()
  end)
  self:set_button("BtnNext", function()
    if self:is_can_not_click() then
      return
    end
    local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
    if is_need_run_journey_event then
      self:refresh_next_btn_image_text_visible(true)
      return
    end
    self:_click_next_btn()
  end)
  self:set_button("BtnSettle", function()
    local is_need_force_settle = JourneyEventMgr:get_is_need_force_settle()
    if is_need_force_settle then
      if not SceneMgr:check_main_scene() then
        UIMgr:clear_ui_stack()
        self:_click_settle_btn(nil, true)
      else
        UIMgr:go_to_main()
      end
      return
    end
    self:_click_settle_btn()
  end)
  self:set_button("BtnStoryDrop", function()
    if self:is_can_not_click() then
      return
    end
    self:_click_story_drop_btn()
  end)
  self:set_button("BtnQuickFinish", function()
    local activeSelf = self.v_uiobjects.MultiSetTimesRoot.activeSelf
    self.v_uiobjects.MultiSetTimesRoot:SetActive(not activeSelf)
    if true == activeSelf then
      return
    end
    self:refresh_chapter_activity_multi_info()
  end)
  self.v_item_list = {}
  self.v_select_item_list = {}
  self.v_sa_cg = self:get_canvas_group(nil, self.v_uiobjects.SafeArea)
  self.v_cg = self:get_canvas_group()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
  self:register_exist_auto_template(TEMPLATE_KEY_TARGET_HARD, self.v_uiobjects.TargetTem, self.v_uiobjects.TargetContent)
  self:register_exist_auto_template(TEMPLATE_KEY_SELECT_ITEM, self.v_uiobjects.MultiSelectTem, self.v_uiobjects.MultiSelectRoot)
  self:register_exist_auto_template(TEMPLATE_KEY_NODE_AWARD, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
  self:register_exist_auto_template(CHAPTER_ACTIVITY_ITEM_KEY, self.v_uiobjects.MultiSetTimesTem, self.v_uiobjects.MultiSetTimesRoot)
  self.v_cost_symbol_txt = self:get_text("Line", self.v_uiobjects.BtnFightCost)
end

function ui:ui_on_show(param, module_param, module_type, settle_param, ignore_btn_back)
  self.v_ignore_btn_back = ignore_btn_back
  self.v_uiobjects.BtnBack:SetActive(not ignore_btn_back)
  self.v_uiobjects.BtnQuickFinish:SetActive(false)
  self.v_uiobjects.MultiSetTimesRoot:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.refresh_fight_cost_state, self)
  self:refresh_panel(param, module_param, module_type, settle_param)
end

function ui:refresh_panel(param, module_param, module_type, settle_param, ignore_fade_in_anim)
  self.v_ignore_fade_in_anim = ignore_fade_in_anim
  MsgGame:mq_publish2(Const.MSG_ON_FIGHT_OVER_WIN_OPEN)
  self:refresh_treasure_chest(nil)
  self.v_is_story = false
  PlayerMgr:try_show_exp_up_tips()
  self:check_need_destory_story()
  self:close_story_full_bg()
  self.v_sa_cg.alpha = 1
  self:clear_timer()
  self.v_asset_bar:on_create()
  self:set_no_click_active(false)
  self.v_param = nil
  self.v_record_group_id = nil
  self.v_on_request_node_continue = false
  self:refresh_view(param, module_param, module_type, settle_param)
  if not self.v_ignore_fade_in_anim then
    self:fade_in()
  end
  self:clear_fight_end_node_data()
  StoryMgr:force_stop_captions_talk()
  self:refresh_next_btn_image_text_visible()
  if self.v_module_param then
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
    if node_cfg then
      local is_need_hide_next_btn = JourneyEventMgr:get_is_need_hide_next_btn()
      if is_need_hide_next_btn then
        self.v_uiobjects.BtnNext:SetActive(false)
      end
      if self.v_is_settle then
        self:check_track_finish(node_cfg)
      end
    end
  end
  local chapter_ui = UIMgr:try_get_visible_ui("ui_chapter_detail")
  if chapter_ui and chapter_ui:get_jump_to_team() then
    self:_click_fight_node_start_btn()
  end
end

function ui:check_track_finish(node_cfg)
  if node_cfg.TagNumName == "1-1" then
    SDKManager:track_adjust_event("21_1-1_finish")
  elseif node_cfg.TagNumName == "1-2" then
    SDKManager:track_adjust_event("24_1-2_finish")
  elseif node_cfg.TagNumName == "1-3" then
    SDKManager:track_adjust_event("28_1-3_finish")
  elseif node_cfg.TagNumName == "1-4" then
    SDKManager:track_adjust_event("31_1-4_finish")
  end
end

function ui:check_track_begin()
  local guide_tips = UIMgr:try_get_visible_ui("ui_guide")
  if not guide_tips then
    return
  end
  local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
  if not node_cfg then
    return
  end
  if node_cfg.TagNumName == "1-2" then
    SDKManager:track_adjust_event("23_1-2_Start")
  elseif node_cfg.TagNumName == "1-3" then
    SDKManager:track_adjust_event("27_1-3_Start")
  elseif node_cfg.TagNumName == "1-4" then
    SDKManager:track_adjust_event("30_1-4_start")
  end
end

function ui:refresh_next_btn_image_text_visible(is_play_timeline)
  local btn_image = Util.get_image(nil, self.v_uiobjects.BtnNext)
  btn_image.enabled = not is_play_timeline
  self.v_uicompents.BtnNextText_txt.enabled = not is_play_timeline
  self.v_uiobjects.BtnNextEffect:SetActive(is_play_timeline)
  self.v_uiobjects.UIStageInfoNew_PoSui:SetActive(is_play_timeline)
  if is_play_timeline then
    local pd = self.v_uicompents.UIStageInfoNew_PoSui_pd
    pd:ResetPD()
    pd:Play()
  end
end

function ui:clear_fight_end_node_data()
  local tower = TowerMgr and TowerMgr:get_tower()
  if tower then
    tower:record_fight_end_node_data()
  end
end

function ui:fade_in()
  local function cb()
    UIMgr:add_set_game_pause_count(1)
    
    self:set_no_click_active(false)
    if self.v_is_settle then
      self:check_ui_chapter_detail()
    end
    local in_pd = self.v_settle_param and self.v_uicompents.UIStageInfoNew_Settle_In_pd or self.v_uicompents.UIStageInfoNew_In_pd
    in_pd:ResetPD()
    in_pd:Play()
  end
  
  self:stop_fain_timer()
  self.v_cg.alpha = 0
  if SceneMgr:check_main_scene() then
    cb()
  else
    local tower = TowerMgr:get_tower()
    if not (not self.v_is_close_story and tower and TowerMgr:is_long_chapter()) or tower:get_fight_end_node_data() then
      cb()
    else
      self:set_no_click_active(true)
      local TpDir = ShareRes.get_chapter_node_tp_dir(self.v_module_param)
      local duration_key = Util.is_more_than_zero(TpDir) and "SettleUIFadeInTimeByTP" or "SettleUIFadeInTime"
      local duration = ShareRes.get_comm_value(duration_key)
      self.v_fade_in_timer = Timer:add_timer("fade_in_timer", duration, cb)
    end
  end
end

function ui:stop_fain_timer()
  if self.v_fade_in_timer then
    Timer:remove_timer(self.v_fade_in_timer)
    self.v_fade_in_timer = nil
  end
end

function ui:refresh_view(param, module_param, module_type, settle_param)
  self:refresh_settle_data(module_param, module_type, settle_param)
  if type(param) == "table" then
    if param.fight_type == Config.CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
      self.v_param = param
      self.v_module_param = param.point_id
      self.v_first_pass = param.first_pass
      self:refresh_func_teach(param)
      return
    elseif param.fight_type == Config.CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
      self.v_param = param
      self.v_module_param = param.point_id
      self.v_module_type = Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT
      self:refresh_version_episode_fun(param)
      return
    end
    self.v_param = param
    self.v_module_param = param.cfg.PointId
    self:refresh_func1(param)
  elseif type(param) == "number" then
    self.v_chapter_id, self.v_module_param, self.v_module_type = param, module_param, module_type
    self:refresh_func2()
  end
end

function ui:refresh_settle_data(module_param, module_type, settle_param)
  if not self.v_is_click_next_btn then
    self.v_settle_param = settle_param
    self.v_is_settle = self.v_settle_param ~= nil
    if self.v_is_settle then
      self.v_tower_progress = TowerMgr:get_tower_progress()
      if module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
        self.v_cur_node_id = module_param
        self.v_next_node_id = ShareRes.get_chapter_node_behind_node_id(self.v_cur_node_id)
      end
    end
  end
  self.v_uiobjects.Clear:SetActive(self.v_is_settle and not self.v_is_click_next_btn)
  self:set_settle_no_click_active(self.v_is_settle)
end

function ui:refresh_func_teach()
  self:refresh_title_teach()
  self.v_uiobjects.Target:SetActive(false)
  self:refresh_point_award_teach()
  self:refresh_no_award_show()
  self:refresh_fight_cost_state()
  self:refresh_button()
  self.v_uiobjects.Zhanli:SetActive(false)
  self.v_uiobjects.BtnStoryDrop:SetActive(false)
  self.v_uiobjects.StageDesc:SetActive(false)
  self.v_uiobjects.ChallengeDesc:SetActive(true)
end

function ui:refresh_func1(param)
  self.v_uiobjects.Zhanli:SetActive(true)
  self:refresh_title(param)
  self:refresh_star_condition()
  self:refresh_point_detail_info()
  self:refresh_no_award_show()
  self:refresh_fight_cost_state()
  self:refresh_button()
  self.v_uiobjects.BtnStoryDrop:SetActive(false)
  self.v_uiobjects.StageDesc:SetActive(false)
  self.v_uiobjects.ChallengeDesc:SetActive(false)
end

function ui:refresh_func2()
  local func = TYPE_FUNC_NAME[self.v_module_type]
  if func and self[func] then
    self[func](self)
  end
  self.v_uiobjects.Zhanli:SetActive(false)
  self:refresh_star_condition()
  self:refresh_no_award_show()
  self:refresh_button()
  self:refresh_story_fragment()
  self:refresh_type_icon()
end

function ui:refresh_version_episode_fun(param)
  TimeLimitedActMgr:set_fight_challenge_multiple(1)
  self:refresh_version_episode_title(param)
  self:refresh_no_award_show()
  self:refresh_button()
  self:refresh_version_episode_fight_cost(param)
  self.v_uiobjects.Target:SetActive(false)
  self.v_uiobjects.BtnStoryDrop:SetActive(false)
  self.v_uiobjects.StageDesc:SetActive(true)
  self.v_uiobjects.ChallengeDesc:SetActive(false)
  self.v_uiobjects.BtnQuickFinish:SetActive(true)
  self.v_uicompents.StageID_txt.text = ""
  self.v_uiobjects.QuickFinishLock:SetActive(false)
end

function ui:refresh_version_episode_fight_cost(param)
  local episode_cfg = ShareRes.get_chapter_point_cfg(param.point_id)
  local cost = episode_cfg.FightCost[1] or episode_cfg.FightCost[2]
  self.v_uiobjects.BtnFightCost:SetActive(cost and cost > 0)
  local fight_multiple = TimeLimitedActMgr:get_fight_challenge_multiple()
  self.v_uicompents.BtnQuickFinishText_txt.text = Util.format_str("{1}倍", fight_multiple)
  self.v_fight_cost = fight_multiple * cost
  self:refresh_fight_cost_state()
end

function ui:refresh_chapter_activity_multi_info()
  self:give_back_auto_cache(CHAPTER_ACTIVITY_ITEM_KEY)
  for i = challenge_multiple, 1, -1 do
    local task_data = {}
    task_data.num = i
    local obj = self:get_auto_cache(CHAPTER_ACTIVITY_ITEM_KEY)
    self:set_multiple_item_data(obj, task_data)
  end
end

function ui:set_multiple_item_data(obj, data)
  local select = Util.get_child_gameobj("Icon", obj)
  local num_text = Util.get_text("Text_", obj)
  select:SetActive(self.v_cur_multiple_times == data.num)
  num_text.text = Util.format_str("{1}倍", data.num)
  if self.v_cur_multiple_times == data.num then
    Util.set_color(num_text, "f5ede2")
  else
    Util.set_color(num_text, "ae9577")
  end
  local btn = Util.get_button(nil, obj)
  self:set_button_listener(btn, function()
    self.v_uicompents.BtnQuickFinishText_txt.text = Util.format_str("{1}倍", data.num)
    TimeLimitedActMgr:set_fight_challenge_multiple(data.num)
    self.v_uiobjects.MultiSetTimesRoot:SetActive(false)
    self:refresh_version_episode_fight_cost(self.v_param)
  end)
end

function ui:ui_on_hide()
  self.v_on_request_node_continue = false
  self.v_on_story_show_hide = false
  self.v_is_click_next_btn = false
  self.v_first_pass = nil
  self.v_real_first_pass = nil
  self.v_cur_node_id = nil
  self.v_next_node_id = nil
  self.v_settle_param = nil
  self.v_click_settle_cb = nil
  self.v_module_type = nil
  self.v_tower_progress = nil
  if self.v_is_settle and not SceneMgr:check_main_scene() then
    UIMgr:try_hide_ui("ui_chapter_detail")
  end
  self.v_chapter_id = nil
  self.v_is_settle = false
  self.v_fight_cost = 0
  self.v_asset_bar:on_hide()
  self.v_uiobjects.MultiSelectRoot:SetActive(false)
  self:clear_award_item()
  self:remove_all_select_item()
  self:clear_timer()
  UIMgr:add_set_game_pause_count(-1)
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_title(param)
  self.v_uicompents.StageID_txt.text = param.cfg.Difficulty
  local episode_cfg = ShareRes.get_chapter_point_cfg(param.cfg.PointId)
  self.v_uicompents.StageName_txt.text = episode_cfg.PointName
  local fight_value = episode_cfg.RecomFightVal or 0
  self.v_uicompents.ZhanliNum_txt.text = fight_value
  self.v_uiobjects.Zhanli:SetActive(fight_value > 0)
end

function ui:refresh_version_episode_title(param)
  local episode_cfg = ShareRes.get_chapter_point_cfg(param.point_id)
  self.v_uicompents.StageName_txt.text = episode_cfg.PointName
  local fight_value = episode_cfg.RecomFightVal or 0
  self.v_uicompents.ZhanliNum_txt.text = fight_value
  self.v_uiobjects.Zhanli:SetActive(fight_value > 0)
  self.v_uicompents.StageDesc_txt.text = episode_cfg.PointDesc
  self.v_fight_cost = episode_cfg.FightCost[1] or episode_cfg.FightCost[2]
end

function ui:refresh_node_detail_info()
  local node_id = self.v_module_param
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  local is_repeat
  if SceneMgr:check_main_scene() then
    self.v_first_pass = ChapterMgr:check_node_is_first_save_suc(node_id)
    is_repeat = not self.v_first_pass
  else
    self.v_first_pass = ChapterMgr:is_first_save_node(node_id)
    self.v_real_first_pass = ChapterMgr:get_node_state(self.v_chapter_id, node_id) == Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED
    is_repeat = self.v_real_first_pass
  end
  local point_cfg = ShareRes.get_chapter_point_cfg(node_cfg.EpisodeId)
  local fight_val = node_cfg.RecomFightVal or point_cfg.RecomFightVal
  local RepeatCost = node_cfg.RepeatCost or 0
  local Cost = node_cfg.Cost or 0
  self.v_fight_cost = is_repeat and RepeatCost or Cost
  self.v_is_story = node_cfg.NodeType == Config.ENTER_NODE_TYPE.STORY_NODE and Config.AREA_POINT_TYPE.STORY or Config.AREA_POINT_TYPE.NORMAL
  self:refresh_stage_text(node_cfg.TagNumName, node_cfg.MainName, node_cfg.Text, nil, fight_val)
  self:refresh_node_award()
  self.v_uiobjects.ClearPd:SetActive(self.v_settle_param ~= nil and ChapterMgr:is_first_save_node(node_id))
  self:refresh_treasure_chest(node_cfg)
  self:refresh_hard_bg()
end

function ui:refresh_point_detail_info()
  local point_id = self.v_module_param
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local point_data = ChapterMgr:get_point_data_by_id(self.v_chapter_id, point_id)
  self.v_first_pass = nil == point_data or point_data.complete_cnt <= 0
  self.v_fight_cost = self.v_first_pass and point_cfg.FightCost[1] or point_cfg.FightCost[2]
  self.v_is_story = point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.STORY == Config.AREA_POINT_TYPE.STORY or Config.AREA_POINT_TYPE.CHALLENGE
  local is_hard = ChapterMgr:check_point_is_difficult(self.v_chapter_id, self.v_module_param)
  local text = is_hard and CHALLENGE_TXT or point_cfg.SerialNum
  self:refresh_stage_text(text, point_cfg.PointName, nil, point_cfg.PointDesc, point_cfg.RecomFightVal)
  self:refresh_point_award()
  self.v_uiobjects.ClearPd:SetActive(true)
  self:refresh_treasure_chest(nil)
  self:refresh_hard_bg()
end

function ui:refresh_hard_bg()
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self.v_uiobjects.HardBg:SetActive(chapter_cfg and chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD)
  local epi_cfg = ShareRes.get_chapter_point_cfg(self.v_module_param)
  if epi_cfg and epi_cfg.FightType == Config.CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
    self.v_uiobjects.HardBg:SetActive(1 == self.v_param.cfg.Difficulty)
  end
end

function ui:refresh_stage_text(stage_tag, stage_name, stage_desc, challenge_desc, fight_val)
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  local is_hard = chapter_cfg and chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD
  objs.HardBg:SetActive(is_hard)
  coms.StageID_txt.text = is_hard and "困难" .. stage_tag or stage_tag
  coms.StageName_txt.text = stage_name
  objs.ChallengeDesc:SetActive(false)
  objs.StageDesc:SetActive(false)
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    objs.StageDesc:SetActive(true)
    coms.StageDesc_txt.text = stage_desc
  else
    objs.ChallengeDesc:SetActive(true)
    coms.ChallengeDesc_txt.text = challenge_desc
  end
  coms.ZhanliNum_txt.text = fight_val
end

function ui:refresh_point_award()
  local point_id = self.v_module_param
  local data_list = {}
  ShareRes.get_point_award2(point_id, data_list, true)
  ShareRes.get_point_star_award2(point_id, data_list)
  ShareRes.get_hard_node_type_five_award2(point_id, data_list)
  table.sort(data_list, function(a, b)
    if a.star ~= b.star then
      return a.star < b.star
    end
    return false
  end)
  self:show_award(data_list)
end

function ui:show_award(data_list)
  if not data_list then
    return
  end
  local settle_award_map
  if self.v_settle_param and self.v_settle_param.result_list then
    settle_award_map = {}
    for key, data in pairs(self.v_settle_param.result_list) do
      settle_award_map[data.id] = data.count
    end
  end
  local complete
  local epi_cfg = ShareRes.get_chapter_point_cfg(self.v_module_param)
  for index, data in pairs(data_list) do
    if epi_cfg and epi_cfg.FightType == Config.CommonDefine.CHALLENGE_TYPE.LINEAR then
      local curr_star = LinearMgr:get_star_with_epi_id(self.v_module_param)
      data.complete = curr_star >= data.star and 0 ~= curr_star
      if data.check_first_pass and not data.complete then
        data.complete = LinearMgr:get_passed_with_epi_id(self.v_module_param)
      end
    elseif epi_cfg and epi_cfg.FightType == Config.CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
      local curr_star = ClimbingTowerMgr:get_star_with_epi_id(self.v_module_param)
      data.complete = curr_star >= data.star and 0 ~= curr_star
      if data.check_first_pass and not data.complete then
        data.complete = ClimbingTowerMgr:get_passed_with_epi_id(self.v_module_param)
      end
    else
      if data.throw_data_id then
        complete = ChapterMgr:check_throw_is_gained(data.throw_data_id)
      elseif data.check_first_pass then
        complete = self.v_real_first_pass or not self.v_first_pass
      elseif data.check_star_complete and data.star and data.star > 0 then
        complete = ChapterMgr:check_point_star_pass(self.v_chapter_id, self.v_module_param, data.star)
      else
        complete = false
      end
      data.complete = complete
      data.show_effect = nil == settle_award_map or settle_award_map[data.id] ~= nil
    end
  end
  table.sort(data_list, function(a, b)
    if a.complete ~= b.complete then
      return b.complete
    elseif a.index ~= b.index then
      return a.index < b.index
    elseif a.star ~= b.star then
      return a.star < b.star
    end
    return false
  end)
  self:give_back_auto_cache(TEMPLATE_KEY_NODE_AWARD)
  for index, data in ipairs(data_list) do
    self:set_award_item(data, data.complete)
  end
end

function ui:refresh_node_award()
  self:clear_award_item()
  local node_id = self.v_module_param
  local data_list = {}
  ShareRes.get_chapter_node_award2(node_id, data_list, true)
  self:show_award(data_list)
end

function ui:set_award_item(data, complete)
  function data.cb()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.id,
      
      is_hide_get_way = true,
      jump_cb = function()
        self:ui_hide()
      end
    })
  end
  
  local obj = self:get_auto_cache(TEMPLATE_KEY_NODE_AWARD)
  local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
  item:set_data(data)
  local tag_obj
  for key, value in pairs(NODE_TAG_NAME) do
    tag_obj = self:get_child_gameobj(value, obj)
    if tag_obj then
      if data.type and key == data.type then
        tag_obj.gameObject:SetActive(true)
        if -1 == data.type then
          local text = self:get_text("TagName_", tag_obj)
          text.text = POINT_TAG_NAME[data.star]
        end
      else
        tag_obj.gameObject:SetActive(false)
      end
    end
  end
  local cmp_obj = self:get_child_gameobj("Complete_", obj)
  cmp_obj.gameObject:SetActive(complete)
  local tag_cmp_obj = self:get_child_gameobj("TagComplete_", obj)
  tag_cmp_obj.gameObject:SetActive(complete)
  local pd = self:get_child_gameobj("Complete_/Image/CompletePd_", obj)
  pd.gameObject:SetActive(self.v_settle_param ~= nil and not self.v_is_click_next_btn and self.v_first_pass)
  table.insert(self.v_item_list, item)
end

function ui:refresh_no_award_show()
  self.v_uiobjects.NoAward:SetActive(next(self.v_item_list) == nil)
end

function ui:refresh_star_condition()
  self:give_back_auto_cache(TEMPLATE_KEY_TARGET_HARD)
  if self.v_module_type and self.v_module_type ~= Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
    self.v_uiobjects.Target:SetActive(false)
    return
  end
  self.v_uiobjects.Target:SetActive(true)
  local fight_progress = self.v_tower_progress
  local cond_list = ShareRes.get_point_star_condition(self.v_module_param)
  for index, condition_id in ipairs(cond_list) do
    if condition_id > 0 then
      local item = self:get_auto_cache(TEMPLATE_KEY_TARGET_HARD)
      local cfg = ShareRes.get_point_star_condition_cfg(condition_id)
      if cfg then
        local desc_txt = Util.get_text("TargetDesc", item)
        local temp = cfg.ConditionDesc
        local arg = cfg.Arg[1]
        if cfg.ConditionType == Config.Condition_Type.HealthMoreThan then
          local percent_health = arg / 100
          percent_health = math.max(percent_health, 1)
          arg = string.format("%d", percent_health) .. "%"
        end
        temp = Util.format_str(temp, arg)
        desc_txt.text = temp
        local complete = false
        if fight_progress then
          if fight_progress.tower_task and fight_progress.tower_task[index] then
            complete = fight_progress.tower_task[index].status
          end
        else
          complete = ChapterMgr:check_point_star_pass(self.v_chapter_id, self.v_module_param, index)
        end
        local comp_img = Util.get_image("Complete", item)
        comp_img:SetActive(complete)
        local temp_color = desc_txt.color
        temp_color.a = complete and 1 or 0.3
        desc_txt.color = temp_color
      end
    end
  end
end

function ui:refresh_button()
  if self.v_is_settle then
    self:show_settle_btn()
  else
    self:show_normal_btn()
  end
end

function ui:refresh_next_btn_state()
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
    local continue = ChapterMgr:is_first_save_node(self.v_module_param) and node_cfg.FirstContinue or node_cfg.RepeatContinue
    local is_show = Util.is_more_than_zero(node_cfg.BehindNodeId) and Util.is_more_than_zero(continue)
    self.v_uiobjects.BtnNext:SetActive(is_show)
  else
    local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
    if not chapter_cfg or chapter_cfg.ChapterMode ~= Config.Chapter_Mode.HARD then
      self.v_uiobjects.BtnNext:SetActive(false)
      return
    end
    local fight_progress = self.v_tower_progress
    local cond_list = ShareRes.get_point_star_condition(self.v_module_param)
    local complete = false
    for index, condition_id in ipairs(cond_list) do
      if condition_id > 0 then
        local cfg = ShareRes.get_point_star_condition_cfg(condition_id)
        if cfg then
          if fight_progress then
            if fight_progress.tower_task and fight_progress.tower_task[index] then
              complete = fight_progress.tower_task[index].status
            end
          else
            complete = ChapterMgr:check_point_star_pass(self.v_chapter_id, self.v_module_param, index)
          end
        end
        if complete then
          break
        end
      end
    end
    self.v_is_need_show_next_btn, self.v_next_epi_id = self:is_need_show_left_btn_with_fight_type()
    self.v_uiobjects.BtnNext:SetActive(self.v_is_need_show_next_btn and complete)
  end
end

function ui:show_settle_btn()
  local objs = self.v_uiobjects
  objs.NormalButton:SetActive(false)
  objs.SettleButton:SetActive(true)
  if self.v_is_click_next_btn then
    objs.BtnNext:SetActive(false)
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
    if node_cfg and node_cfg.NodeType == Config.CommonDefine.CHAPTER_NODE_TYPE.STORY_LINE then
      objs.BtnFight:SetActive(false)
      objs.BtnPlay:SetActive(true)
    else
      self:refresh_fight_cost_state()
      objs.BtnFight:SetActive(true)
      objs.BtnPlay:SetActive(false)
    end
  else
    objs.BtnFight:SetActive(false)
    objs.BtnPlay:SetActive(false)
    self:refresh_next_btn_state()
  end
end

function ui:show_normal_btn()
  local is_story = self.v_is_story == Config.AREA_POINT_TYPE.STORY
  local objs = self.v_uiobjects
  objs.NormalButton:SetActive(true)
  objs.SettleButton:SetActive(false)
  objs.BtnPlay:SetActive(is_story)
  if not is_story then
    if not self.v_first_pass then
      if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
        local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
        if node_cfg and node_cfg.ExploreNode then
          if node_cfg.ExploreNode ~= self.v_module_param then
            self:refresh_fight_or_jump_btn(false)
          else
            self:refresh_fight_or_jump_btn(true)
          end
        end
      else
        self:refresh_fight_or_jump_btn(true)
      end
    else
      self:refresh_fight_or_jump_btn(true)
    end
  else
    objs.BtnJump:SetActive(false)
    objs.BtnFight:SetActive(false)
  end
end

function ui:refresh_fight_or_jump_btn(show_fight)
  local objs = self.v_uiobjects
  objs.BtnJump:SetActive(not show_fight)
  objs.BtnFight:SetActive(show_fight)
  if show_fight then
    self:refresh_fight_cost_state()
  end
end

function ui:refresh_fight_cost_state()
  local objs = self.v_uiobjects
  if self.v_fight_cost and self.v_fight_cost > 0 then
    objs.BtnFightCost:SetActive(true)
    self.v_uicompents.BtnFightCostTxt_txt.text = self.v_fight_cost
    local is_enough = BagMgr:get_cost_enough(Config.PLAYER_SP_ITEMID, self.v_fight_cost)
    self.v_uicompents.BtnFightCostTxt_txt.color = is_enough and enough_color or not_enough_color
    if self.v_cost_symbol_txt then
      self.v_cost_symbol_txt.color = is_enough and enough_color or not_enough_color
    end
  else
    objs.BtnFightCost:SetActive(false)
  end
end

function ui:refresh_type_icon()
  local area_point_cfg = ShareRes.get_chapter_area_point_cfg_by_module(self.v_module_type, self.v_module_param)
  if not area_point_cfg then
    return
  end
  local icon_type = area_point_cfg and area_point_cfg.IconType
  if icon_type then
    local type_cfg = ShareRes.get_chapter_area_point_type_cfg(icon_type)
    ResMgr:load_set_icon(self.v_uicompents.TypeIcon_img, type_cfg.TypeIconPath)
  end
end

function ui:clear_award_item()
  self:give_back_auto_cache(TEMPLATE_KEY_NODE_AWARD)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:try_clear_select_param(duration)
  local ui_chapter_detail = UIMgr:try_get_loaded_ui("ui_chapter_detail")
  if ui_chapter_detail then
    ui_chapter_detail:clear_select_param(duration)
  end
end

function ui:try_move_to_target_area_point(target_node_id, play_settle_pd, play_unlock_anima)
  if not Util.is_more_than_zero(target_node_id) then
    return
  end
  local ui_chapter_detail = UIMgr:try_get_loaded_ui("ui_chapter_detail")
  if ui_chapter_detail then
    local area_point_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, target_node_id)
    if area_point_cfg then
      local state = ChapterMgr:get_node_state(self.v_chapter_id, target_node_id)
      if play_unlock_anima and state ~= Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED and ui_chapter_detail:do_unlock_anima(play_settle_pd) then
        self:set_no_click_active(true)
        self.v_uicompents.BtnFight_rect:SetAnchoredPositionA(99999, 99999)
        if play_settle_pd then
          self.v_uicompents.UIStageInfoNew_Settle_In_pd:ResetPD()
          self.v_uicompents.UIStageInfoNew_Settle_Out_pd:ResetPD()
          self.v_uicompents.UIStageInfoNew_Settle_Out_pd:Play()
        end
      else
        local area_id = area_point_cfg.AreaId
        local area_point_id = area_point_cfg.Id
        ui_chapter_detail:move_to_target_area_point(area_id, area_point_id, true, false, nil, nil, nil, play_unlock_anima and state ~= Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED)
        ui_chapter_detail:on_click_detail_item(area_point_cfg, true)
      end
    else
      Log.Error(string.format("节点%s未配置区域点位配置", target_node_id))
    end
  end
end

function ui:_after_click_start_btn()
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_SETTLE_UI)
  local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
  local last_node_cfg = ShareRes.get_chapter_node_cfg(self.v_cur_node_id)
  local is_tp_room = SceneMgr:check_continue_tp_room()
  local is_tp_floor = last_node_cfg.FloorId ~= node_cfg.FloorId
  local story_id = node_cfg.ChapterNodeStory
  local need_play_story = Util.is_more_than_zero(story_id)
  if not is_tp_room then
    if is_tp_floor then
      local next_floor_num = node_cfg.FloorId
      local tower = TowerMgr:get_tower()
      tower:record_temp_formation_data(next_floor_num)
      if need_play_story then
        local room = tower:get_room()
        if room then
          room:set_check_node_stroy(true)
        end
      end
      local progress = TowerMgr:get_tower_progress()
      local chapter_id = progress.param
      local point_id = progress.episode_id
      local node_id = progress.node_id
      local fight_type = progress.challenge_type
      if 1 == node_cfg.SkipTeamWin and fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
        local fight_team_send_data = FormationMgr:get_new_fight_team_send_data(point_id, node_id, next_floor_num)
        if not next_floor_num then
          TowerMgr:on_new_enter_tower(fight_type, point_id, chapter_id, nil, fight_team_send_data, node_id)
        else
          tower:on_node_tp_next_floor(next_floor_num, fight_team_send_data)
        end
      else
        UIMgr:get_ui("team"):ui_show(chapter_id, point_id, fight_type, nil, node_id, next_floor_num)
      end
      self:do_hide(true)
    elseif self.v_record_group_id then
      GraphicGuideMgr:init(self.v_record_group_id)
      self.v_record_group_id = nil
    end
  end
  if is_tp_room then
    local loding = UIMgr:get_ui("loading")
    loding:set_loading_show_time(2, 0.5)
    loding:ui_show()
    self:do_hide(true)
  end
  if not is_tp_floor then
    if need_play_story then
      self.v_on_story_show_hide = true
      
      local function story_real_start_cb()
        self:_on_story_begin()
      end
      
      StoryMgr:set_story_real_start_cb(story_id, story_real_start_cb)
      StoryMgr:on_start(story_id)
    else
      local achievement_tip = UIMgr:get_ui("common_battle_tips")
      local show_data = {node_cfg = last_node_cfg, is_first_save = true}
      if not achievement_tip:visible() then
        local data = {node_data = show_data}
        achievement_tip:ui_show(data)
      else
        achievement_tip:show_save_suc_tips(show_data)
      end
      self:do_hide(true)
    end
  end
  BehaviorMgr:call_scene_logic_event_fun("on_chapter_node_continue", self.v_module_param)
end

function ui:_on_fight_scene_click_start_btn()
  local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
  local need_cost = node_cfg.Cost
  local cur_cost = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  if need_cost <= cur_cost then
    local fight_type = TowerMgr:get_fight_type()
    local is_long_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
    local is_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
    if is_long_chapter or is_chapter then
      ChapterMgr:set_record_select_chapter_id()
      ChapterMgr:set_record_select_param_id()
    end
    
    local function cb()
      self:_after_click_start_btn()
    end
    
    if not TowerMgr:check_play_fight_story(nil, cb) then
      cb()
    end
  else
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("体力不足"))
  end
  AssistMgr:try_hide_add_assist_friend_tips()
  self:clear_timer()
end

function ui:_on_main_scene_click_start_btn()
  if TowerMgr:check_fight_progress() then
    return
  end
  local id = self.v_module_param
  local module_type = self.v_module_type
  local point_cfg = ShareRes.get_chapter_point_cfg(id)
  local item_count = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  local fight_type, point_id, node_id
  local chapter_id = self.v_chapter_id
  local is_skip_team = false
  if module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    local node_cfg = ShareRes.get_chapter_node_cfg(id)
    if node_cfg and node_cfg.NodeType == Config.ENTER_NODE_TYPE.FIGHT_NODE then
      point_cfg = ShareRes.get_chapter_point_cfg(node_cfg.EpisodeId)
      fight_type = point_cfg.FightType
      point_id = point_cfg.Id
      node_id = id
      is_skip_team = 1 == node_cfg.SkipTeamWin
    else
      Log.Error("所选点位非战斗节点", "章节", self.v_chapter_id, "点位ID", self.v_module_param, "点位类型", self.v_module_type, debug.traceback())
      return
    end
  elseif module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
    fight_type = point_cfg.FightType
    point_id = id
  elseif not module_type then
    fight_type = point_cfg.FightType
    point_id = id
  end
  if self.v_fight_cost and self.v_fight_cost > 0 and (not item_count or item_count < self.v_fight_cost) then
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("体力不足"))
    UIMgr:get_ui("uiforcerecharg"):ui_show()
    return
  end
  if self.v_chapter_id then
  elseif self.v_param and self.v_param.cfg then
    chapter_id = self.v_param.cfg.Id
  end
  if is_skip_team then
    local fight_team_send_data = FormationMgr:get_new_fight_team_send_data(point_id, node_id, nil)
    if TowerMgr then
      TowerMgr:on_new_enter_tower(fight_type, point_id, chapter_id, nil, fight_team_send_data, node_id)
    end
  elseif fight_type == Config.CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    UIMgr:get_ui("team"):ui_show(nil, point_id, fight_type, self.v_param.buddy_id, nil, self.v_param.floor_index)
  else
    if fight_type == Config.CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
      chapter_id = self.v_param.index
    end
    UIMgr:get_ui("team"):ui_show(chapter_id, point_id, fight_type, nil, node_id, nil)
  end
  self:try_record_select_param(fight_type)
  self:do_hide(true)
  self:clear_timer()
end

function ui:_click_fight_node_start_btn()
  if self.v_ui_hide_timer then
    return
  end
  if SceneMgr:check_main_scene() then
    self:_on_main_scene_click_start_btn()
  else
    self:_on_fight_scene_click_start_btn()
  end
  self:check_track_begin()
end

function ui:_click_story_node_start_btn()
  if self.v_ui_hide_timer then
    return
  end
  local id = self.v_module_param
  local node_cfg = ShareRes.get_chapter_node_cfg(id)
  local story_id = node_cfg.Param
  if node_cfg then
    local is_main_scene = SceneMgr:check_main_scene()
    if is_main_scene then
      self.v_on_story_show_hide = true
      
      local function story_real_start_cb()
        self:_on_story_begin()
      end
      
      StoryMgr:set_story_real_start_cb(story_id, story_real_start_cb)
      local node_state = ChapterMgr:get_node_state(self.v_chapter_id, id)
      if is_main_scene and node_state ~= Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED then
        ChapterMgr:chapter_node_play_story(self.v_chapter_id, id, nil, true)
      end
      StoryMgr:on_start(story_id)
    else
      self:_click_settle_btn(story_id)
    end
  end
end

function ui:is_can_not_click()
  if not self.v_chapter_id then
    return false
  end
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  if not (chapter_cfg and chapter_cfg.PreOpenEndTime and chapter_cfg.IsPreOpen) or 1 ~= chapter_cfg.IsPreOpen then
    return false
  end
  local pre_open_end_time = Date.get_time_stamp_by_scheme_id(chapter_cfg.PreOpenEndTime) or 0
  if pre_open_end_time > Date.server_time() then
    return false
  end
  Util.show_message_tip(2280)
  return true
end

function ui:clear_timer()
  if self.v_ui_hide_timer then
    Timer:remove_timer(self.v_ui_hide_timer)
    self.v_ui_hide_timer = nil
  end
  self:stop_fain_timer()
end

function ui:do_hide(not_pd)
  if self.v_ui_hide_timer then
    return
  end
  MsgGame:mq_publish2(Const.MSG_ON_CHAPTER_DETAIL_INFO_HIDE)
  if not_pd then
    self:ui_hide()
    self:set_no_click_active(false)
    return
  end
  local out_pd = self.v_uicompents.UIStageInfoNew_Out_pd
  local duration = out_pd.duration
  out_pd:ResetPD()
  out_pd:Play()
  self.v_ui_hide_timer = Timer:add_timer("ui_hide", duration, function()
    self:ui_hide()
    self:set_no_click_active(false)
    self:try_clear_select_param(duration)
    self:set_no_click_active(true)
    self.v_ui_hide_timer = nil
  end)
end

function ui:_click_jump_btn()
  if self.v_ui_hide_timer then
    return
  end
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
    if node_cfg and node_cfg.ExploreNode and node_cfg.ExploreNode ~= node_cfg then
      local function sure_func()
        self:try_move_to_target_area_point(node_cfg.ExploreNode, false, false)
      end
      
      local str = node_cfg.MultipleEntryTips or "重复挑战？"
      UIMgr:get_ui("uinotice_tips"):ui_show(sure_func, nil, str)
    end
  else
    return
  end
end

function ui:_click_next_btn()
  if self.v_ui_hide_timer then
    return
  end
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    self.v_is_click_next_btn = true
    self:try_move_to_target_area_point(self.v_next_node_id, true, true)
  elseif self.v_is_need_show_next_btn then
    if self.v_last_click_time and Global.real_time - self.v_last_click_time < 3 then
      return
    end
    self.v_last_click_time = Global.real_time
    TowerMgr:on_exit_tower(function()
      TowerMgr:restart_tower(self.v_next_epi_id, self.v_chapter_id)
    end)
  end
end

function ui:is_need_show_left_btn_with_fight_type()
  local is_need_show_next_btn = false
  local next_epi_id = 0
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  if chapter_cfg and chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD then
    local curr_index = 999
    for idx, point_id in ipairs(chapter_cfg.Point) do
      if point_id == self.v_module_param then
        curr_index = idx
      end
      if idx > curr_index and point_id > 0 then
        next_epi_id = point_id
        is_need_show_next_btn = true
        break
      end
    end
  end
  return is_need_show_next_btn, next_epi_id
end

function ui:_click_settle_btn(after_load_story_id, ignore_ui)
  if self.v_ui_hide_timer then
    return
  end
  self:set_no_click_active(true)
  if self.v_on_request_node_continue then
    return
  end
  local do_unlock_anima = false
  if not self.v_is_click_next_btn and self.v_next_node_id then
    local state = ChapterMgr:get_node_state(self.v_chapter_id, self.v_next_node_id)
    if state ~= Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED then
      do_unlock_anima = true
    end
  end
  local fight_type = TowerMgr:get_fight_type()
  self:try_record_select_param(fight_type)
  if SceneMgr:check_main_scene() then
    self:do_hide()
    if self.v_click_settle_cb then
      self.v_click_settle_cb()
      self.v_click_settle_cb = nil
    end
    if do_unlock_anima then
      self:try_move_to_target_area_point(self.v_next_node_id, false, true)
    end
    return
  end
  local is_long_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
  local is_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
  local chapter_id = self.v_chapter_id
  local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
  if chapter_cfg.NormalChapter then
    chapter_cfg = ShareRes.get_chapter_cfg(chapter_cfg.NormalChapter)
    chapter_id = chapter_cfg.Id
  end
  
  local function cb()
    local function exit_cb()
      if (is_long_chapter or is_chapter) and not ignore_ui then
        local pass_param = {
          pass_id = self.v_module_param,
          
          is_hard = is_chapter,
          not_show_anima = true,
          do_unlock_anima = do_unlock_anima
        }
        local ui_name = "ui_chapter_detail"
        UIMgr:set_main_scene_after_load_ui(ui_name, chapter_id, pass_param, nil, after_load_story_id)
      end
      Global.scene_mgr:on_enter_main_scene()
      UIMgr:revert_cache_ui()
    end
    
    if is_long_chapter then
      TowerMgr:long_chapter_exit(true, exit_cb)
    else
      TowerMgr:on_exit_tower(exit_cb)
    end
  end
  
  if not TowerMgr:check_play_fight_story(nil, cb) then
    cb()
  end
  AssistMgr:try_hide_add_assist_friend_tips()
end

function ui:_click_story_drop_btn()
  if self.v_ui_hide_timer then
    return
  end
  if self.v_on_request_node_continue then
    return
  end
  local root = self.v_uiobjects.MultiSelectRoot
  if not self.v_is_story == Config.AREA_POINT_TYPE.STORY then
    root:SetActive(false)
    return
  end
  local active = root.activeInHierarchy
  root:SetActive(not active)
end

function ui:refresh_story_fragment()
  self:remove_all_select_item()
  local is_have = self:is_have_story_fragment()
  self.v_uiobjects.BtnStoryDrop:SetActive(is_have)
  if not is_have then
    return
  end
  local id = self.v_module_param
  local node_cfg = ShareRes.get_chapter_node_cfg(id)
  local cfgs = ShareRes.get_archive_by_small_group_id(node_cfg.Param)
  local data
  if not cfgs then
    Log.Error("获取剧情档案配置失败，请检查节点：", id, "的Param字段是否有对应的剧情档案配置")
    return
  end
  for key, cfg in ipairs(cfgs) do
    data = {}
    local obj = self:get_auto_cache(TEMPLATE_KEY_SELECT_ITEM)
    local item = SELECT_ITEM:ui_wrap(self, obj, true)
    data.text = cfg.Name
    
    function data.cb()
      if Util.is_more_than_zero(cfg.TowerID) and Util.is_more_than_zero(cfg.Floor) and Util.is_more_than_zero(cfg.RoomID) then
        UIMgr:set_main_scene_after_load_ui("ui_chapter_detail", self.v_chapter_id, nil, true, nil, self.v_module_param)
        TowerMgr:enter_story_room(cfg.PoltId)
        return
      end
      self:open_story_full_bg(cfg.StoryBg)
      
      local function story_cb()
        self:close_story_full_bg()
        self.v_sa_cg.alpha = 1
      end
      
      StoryMgr:set_story_end_cb(cfg.PoltId, story_cb)
      StoryMgr:on_start(cfg.PoltId)
      self.v_sa_cg.alpha = 0
    end
    
    data.type = Config.SELECT_ITEM_TYPE.STORY_SNIPPET
    item:set_data(data)
    table.insert(self.v_select_item_list, item)
  end
end

function ui:remove_all_select_item()
  self:give_back_auto_cache(TEMPLATE_KEY_SELECT_ITEM)
  for key, item in pairs(self.v_select_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_select_item_list[key] = nil
  end
end

function ui:is_have_story_fragment()
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    local node_cfg = ShareRes.get_chapter_node_cfg(self.v_module_param)
    if node_cfg and node_cfg.NodeType == Config.ENTER_NODE_TYPE.FIGHT_NODE and node_cfg.Param and 0 ~= node_cfg.Param then
      return not ChapterMgr:check_node_is_first_save_suc(node_cfg.Id)
    end
  end
end

function ui:close_story_full_bg()
  self.v_uiobjects.FullBg2:SetActive(false)
end

function ui:open_story_full_bg(story_bg)
  if story_bg then
    ResMgr:load_set_icon(self.v_uicompents.FullBg2_img, story_bg, function()
      self.v_uiobjects.FullBg2:SetActive(true)
    end, true, self)
  end
end

function ui:record_group_id(group_id)
  self.v_record_group_id = group_id
end

function ui:check_ui_chapter_detail()
  local is_chapter = self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE or self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
    local chapter_id = self.v_chapter_id
    local pass_param = {}
    pass_param.pass_id = self.v_module_param
    local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
    if (not chapter_cfg or chapter_cfg.ChapterMode ~= Config.Chapter_Mode.HARD) and is_chapter then
      chapter_id = ChapterMgr:get_chapter_by_hard_chapter_id(chapter_id)
    end
    local area_gather = ShareRes.get_chapter_area_gather(chapter_id)
    if area_gather then
      pass_param.is_hard = is_chapter
      local ui_chapter_detail = UIMgr:get_ui("ui_chapter_detail", true)
      if not ui_chapter_detail:visible() then
        ui_chapter_detail:ui_show(chapter_id, pass_param)
      else
        ui_chapter_detail:refresh(chapter_id, false, pass_param)
      end
    end
  end
end

function ui:check_need_destory_story()
  self.v_is_close_story = false
  if not StoryMgr:is_playing_story() then
    self.v_is_close_story = UIMgr:try_get_visible_ui("uistory") ~= nil
  end
end

function ui:on_detail_view_show()
  if self.v_is_close_story then
    UIMgr:try_destory_ui("uistory")
    UIMgr:try_destory_ui("ui_blackfade")
  end
  TimeLineSeqPlayer.after_enter_settle()
end

function ui:set_click_settle_cb(cb)
  self.v_click_settle_cb = cb
end

function ui:refresh_title_teach()
  local teach_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(self.v_param.point_id)
  local floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_point_id(self.v_param.point_id, self.v_param.floor_index)
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_param.point_id)
  assert(teach_cfg, "未找到对应角色教学关卡" .. self.v_param.point_id)
  assert(floor_cfg, "教学关卡未找到指定层" .. self.v_param.point_id)
  assert(point_cfg, "未找到教学关卡配置" .. self.v_param.point_id)
  self.v_fight_cost = self.v_first_pass and floor_cfg.FightCost[1] or floor_cfg.FightCost[2]
  self.v_uicompents.StageID_txt.text = teach_cfg.StageName
  self.v_uicompents.StageName_txt.text = floor_cfg.PointName
  if point_cfg.PointDesc then
    self.v_uicompents.ChallengeDesc_txt.text = point_cfg.PointDesc
  end
end

function ui:refresh_point_award_teach()
  local award = Util.get_buddy_teach_award(self.v_param.buddy_id, self.v_param.point_id, self.v_param.floor_index)
  local type = self.v_first_pass and -1 or nil
  local data_list = ShareRes.get_item_obj_use_award_list(award, nil, function(award_cfg)
    return {
      id = award_cfg.ItemId,
      count = award_cfg.Num,
      check_first_pass = self.v_first_pass,
      star = 0,
      type = type
    }
  end)
  if data_list then
    table.sort(data_list, function(a, b)
      if a.star ~= b.star then
        return a.star < b.star
      end
      return false
    end)
  end
  self:show_award(data_list)
end

function ui:_on_story_begin()
  if self.v_on_story_show_hide then
    if SceneMgr:check_main_scene() then
      self:try_clear_select_param()
    end
    self:do_hide(true)
  end
end

function ui:set_settle_no_click_active(is_active)
  self.v_uiobjects.SettleNoClick:SetActive(is_active)
end

function ui:set_no_click_active(is_active)
  self.v_uiobjects.NoClick:SetActive(is_active)
end

function ui:on_unlock_anima_end()
  self:set_no_click_active(false)
end

function ui:refresh_treasure_chest(node_cfg)
  if not (node_cfg and node_cfg.BoxGroupId) or 0 == node_cfg.BoxGroupId then
    self.v_uiobjects.BoxTips:SetActive(false)
    return
  end
  local finish_count, max_count = TreasureChestMgr:get_scene_treasure_chest_count(node_cfg.BoxGroupId)
  self.v_uicompents.BoxNum_txt.text = Util.format_str("{1}/{2}", finish_count, max_count)
  self.v_uiobjects.BoxTips:SetActive(true)
end

function ui:try_record_select_param(fight_type)
  local is_long_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
  local is_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
  if is_long_chapter or is_chapter then
    ChapterMgr:set_record_select_chapter_id(self.v_chapter_id)
    ChapterMgr:set_record_select_param_id(self.v_module_param)
  end
end

function ui:response_click_escape()
  if SceneMgr:check_main_scene() then
    self:do_hide()
    return UIMgr.RESPONCE_ESCAPE_TYPE.ESCAPE_CUSTOM
  end
  return UIMgr.RESPONCE_ESCAPE_TYPE.AUTO_CALL
end

return ui
