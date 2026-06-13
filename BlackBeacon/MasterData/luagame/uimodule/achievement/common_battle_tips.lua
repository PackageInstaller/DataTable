local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local commonDef = require("cs_share.common_define")
local MODEL = {
  v_achievement_icon = {
    "AchievementIcon",
    BIND_TYPE.IMAGE
  },
  v_char_icon = {
    "CharIcon",
    BIND_TYPE.IMAGE
  },
  v_title_name = {
    "TitleName",
    BIND_TYPE.TEXT
  },
  v_bg1 = {
    "Bg1",
    BIND_TYPE.IMAGE
  },
  v_bg2 = {
    "Bg2",
    BIND_TYPE.IMAGE
  },
  v_btn_task_detail = {
    "BtnTaskDetail",
    BIND_TYPE.BUTTON
  },
  v_btn_task_finish = {
    "BtnTaskFinish",
    BIND_TYPE.BUTTON
  },
  v_btn_task_jump = {
    "BtnTaskJump",
    BIND_TYPE.BUTTON
  },
  v_task_finish = {
    "TaskFinish",
    BIND_TYPE.TEXT
  },
  v_task_get = {
    "TaskGet",
    BIND_TYPE.TEXT
  },
  v_task_name = {
    "TaskName",
    BIND_TYPE.TEXT
  },
  v_task_next_step = {
    "TaskNextStep",
    BIND_TYPE.TEXT
  },
  v_task_step_max = {
    "TaskStepMax",
    BIND_TYPE.TEXT
  },
  v_task_step_now = {
    "TaskStepNow",
    BIND_TYPE.TEXT
  },
  v_task_type_icon = {
    "TaskTypeIcon",
    BIND_TYPE.IMAGE
  },
  v_sp_task_tips = {
    "SPTaskTips",
    BIND_TYPE.OBJECT
  }
}
local MAZE_DATA_STATE = Config.MAZE_DATA_STATE
local ICON_PREFIX = "Icon/BattleItem/"
local Fade_Anim_Time = 0.3
local Fade_In_PosX = 0
local Fade_Out_PosX = -607
local Single_Stay_Time = 2.5
local Multi_Stay_Time = 1.5
local TaskPopWinTipsStayTime = ShareRes.get_comm_value("TaskPopWinTipsStayTime")
local treasure_chest_max_count = ShareRes.get_comm_value("BattleTreasureChestAwardMaxShowCount")
local _insert = table.insert
local _remove = table.remove
local MAZA_DATA_UPDATE_EVACUATE_KEY = "MAZA_DATA_UPDATE_EVACUATE_KEY"
local MAZA_DATA_UPDATE_EXPLORE_KEY = "MAZA_DATA_UPDATE_EXPLORE_KEY"
local COMMON_BATTLE_LEFT_PICK_UP_TIPS = "COMMON_BATTLE_LEFT_PICK_UP_TIPS"
local UI_HOLD_TIPS = {
  "uidrawcard",
  "uidrawcard_trigger_panel"
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:register_exist_auto_template(MAZA_DATA_UPDATE_EVACUATE_KEY, self.v_uiobjects.EvacuateTem, self.v_uiobjects.EvacuateProgress)
  self:register_exist_auto_template(MAZA_DATA_UPDATE_EXPLORE_KEY, self.v_uiobjects.ExploreTem, self.v_uiobjects.ExploreProgress)
  self:register_exist_auto_template(COMMON_BATTLE_LEFT_PICK_UP_TIPS, self.v_uiobjects.PickUpTem, self.v_uiobjects.LeftPickUpContent)
  self.v_evacuate_cg = self.v_uiobjects.EvacuateObj:GetComponent("CanvasGroup")
  self.v_explore_cg = self.v_uiobjects.ExploreObj:GetComponent("CanvasGroup")
  self.v_drop_data_queue = {}
end

function ui:ui_before_show(data)
  if data.task_id then
    self:task_ui_before_show(data.task_id)
  end
end

function ui:ui_on_show(data)
  self:register_event()
  if data.task_id then
    local task_id = data.task_id
    if self:check_hold_task() then
      if not self.v_hold_task_id then
        self.v_hold_task_id = task_id
      end
      return
    end
    self:task_ui_on_show(task_id)
  end
  if data.chapter_drop_data then
    self:drop_ui_on_show(data.chapter_drop_data)
  end
  if data.node_data then
    self:save_ui_on_show(data.node_data)
  end
  if data.maze_data then
    self:maze_ui_on_show(data.maze_data)
  end
  if data.task_complete_tip then
    self:task_complete_ui_on_show(data.task_complete_tip)
  end
  if data.task_event_data then
    self:refresh_task_event_info(data.task_event_data)
  end
  if data.damage_orn_id then
    self:refresh_orn_damage_info(data.damage_orn_id)
  end
  if data.drop_data then
    self:drop_data_enqueue(data.drop_data)
  end
  if data.left_pick_up_award_list then
    self:refresh_left_pick_up_tips(data.left_pick_up_award_list, data.treasure_chest_id)
  end
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_RELEASE_COMMON_BATTLE_TIPS_HOLD_TASK, self.release_hold_task, self)
end

function ui:release_hold_task()
  if self.v_hold_task_id then
    self:task_ui_on_show(self.v_hold_task_id, true)
    self.v_hold_task_id = nil
  end
end

function ui:check_hold_task()
  for _, hold_ui in pairs(UI_HOLD_TIPS) do
    if Global.ui_mgr:try_get_visible_ui(hold_ui) then
      return true
    end
  end
  return false
end

function ui:task_complete_ui_on_show(task_complete_tip)
  if task_complete_tip then
    self.v_uicompents.TaskCompleteTipsText_txt.text = task_complete_tip
    self.v_uiobjects.TaskCompleteTips:SetActive(true)
    
    local function callback()
      self.v_task_complete_tips_timer = nil
      self.v_uiobjects.TaskCompleteTips:SetActive(false)
      self:check_next()
    end
    
    self.v_task_complete_tips_timer = Timer:add_timer(nil, 2.5, callback)
  end
end

function ui:maze_ui_on_show(maze_data)
  self:show_maze_data_tips(maze_data)
end

function ui:save_ui_on_show(node_data)
  self:show_save_suc_tips(node_data)
end

function ui:drop_ui_on_show(chapter_drop_data)
  self:on_chapter_drop_count_change(chapter_drop_data)
end

function ui:show_save_suc_tips(node_data)
  local node_cfg = node_data.node_cfg
  local is_first_save = node_data.is_first_save
  local cb = node_data.cb
  if node_cfg and is_first_save and not Util.is_empty(node_cfg.FinishTips) then
    local tips_text = node_cfg.FinishTips
    self.v_uicompents.SavePointTIpsText_txt.text = tips_text
    local pd = self.v_uicompents.SavePointTIpsAnima_pd
    pd:Play()
    self.v_uiobjects.SavePointTIps:SetActive(true)
    
    local function callback()
      self.v_show_save_suc_tips_timer = nil
      self.v_uiobjects.SavePointTIps:SetActive(false)
      pd:Stop()
      if cb then
        cb()
      end
      self:check_next()
    end
    
    self.v_show_save_suc_tips_timer = Timer:add_timer(nil, pd.duration, callback)
  end
end

function ui:on_chapter_drop_count_change(data)
  local item_cfg = ShareRes.create("battle.battle_item", data.id)
  ResMgr:load_set_icon(self.v_uicompents.StageProgressIcon_img, ICON_PREFIX .. item_cfg.Icon)
  self.v_uicompents.StageProgressName_txt.text = item_cfg.Name
  self.v_uicompents.StageProgressAdd_txt.text = "+" .. data.change_value
  self.v_uicompents.StageProgressNow_txt.text = data.count
  local chapter_id = TowerMgr:get_cur_fight_info_param()
  if chapter_id then
    local item_id, max_count = ChapterMgr:get_next_unlock_chapter_need_item(chapter_id)
    self.v_uicompents.StageProgressMax_txt.text = max_count
  end
  local pd = self.v_uicompents.StageProgressTipsAnima_pd
  
  local function callback()
    self.v_drop_count_change_timer = nil
    self.v_uiobjects.StageProgressTips:SetActive(false)
    pd:Stop()
    self:check_next()
  end
  
  pd:Play()
  self.v_uiobjects.StageProgressTips:SetActive(true)
  self.v_drop_count_change_timer = Timer:add_timer(nil, pd.duration, callback)
end

function ui:show_maze_data_tips(maze_data)
  local uiobj = self.v_uiobjects
  uiobj.MazeTips:SetActive(true)
  if maze_data.state == MAZE_DATA_STATE.ALL_CNT_CHANGE then
    self:set_maze_evacuate_obj_count(maze_data.evacuate_cnt, maze_data.evacuate_cnt_limit)
    self:set_maze_explore_obj_count(maze_data.explore_cnt, maze_data.explore_cnt_limit)
    self:start_dotween(uiobj.EvacuateObj, self.v_evacuate_cg)
    self:start_dotween(uiobj.ExploreObj, self.v_explore_cg)
  elseif maze_data.state == MAZE_DATA_STATE.EVACUATE_CNT_CHANGE then
    self:set_maze_evacuate_obj_count(maze_data.evacuate_cnt, maze_data.evacuate_cnt_limit)
    self:start_dotween(uiobj.EvacuateObj, self.v_evacuate_cg)
  elseif maze_data.state == MAZE_DATA_STATE.EXPLORE_CNT_CHANGE then
    self:set_maze_explore_obj_count(maze_data.explore_cnt, maze_data.explore_cnt_limit)
    self:start_dotween(uiobj.ExploreObj, self.v_explore_cg)
  end
end

function ui:start_dotween(dotween_obj, cg)
  if self.v_maze_sequence then
    self.v_maze_sequence:Kill(false)
    self.v_maze_sequence = nil
  end
  cg.alpha = 0
  dotween_obj:SetActive(true)
  self.v_maze_sequence = Util.create_sequence()
  self.v_maze_sequence:Append(cg:DOFade(1, 0.4))
  self.v_maze_sequence:AppendInterval(2.2)
  self.v_maze_sequence:Append(cg:DOFade(0, 0.4))
  self.v_maze_sequence:AppendCallback(function()
    dotween_obj:SetActive(false)
    self:check_next()
  end)
end

function ui:set_maze_evacuate_obj_count(cur_count, max_count)
  self:give_back_auto_cache(MAZA_DATA_UPDATE_EVACUATE_KEY)
  for index = 1, max_count do
    local evacuate_obj = self:get_auto_cache(MAZA_DATA_UPDATE_EVACUATE_KEY)
    local light = Util.get_child("Complete", evacuate_obj)
    light:SetActive(index <= cur_count)
  end
end

function ui:set_maze_explore_obj_count(cur_count, max_count)
  self:give_back_auto_cache(MAZA_DATA_UPDATE_EXPLORE_KEY)
  for index = 1, max_count do
    local explore_obj = self:get_auto_cache(MAZA_DATA_UPDATE_EXPLORE_KEY)
    local light = Util.get_child("Complete", explore_obj)
    light:SetActive(index <= cur_count)
  end
end

function ui:task_ui_before_show(task_id)
  self.v_queue = self.v_queue or {}
  _insert(self.v_queue, task_id)
  self.v_anim_stay_time = #self.v_queue > 1 and Multi_Stay_Time or Single_Stay_Time
end

function ui:task_ui_on_show(task_id, direct_show)
  if not self.v_tips_rect_trans then
    self.v_tips_rect_trans = self:get_rect_transform(nil, self.v_uiobjects.Tips)
  end
  if self.v_queue and (1 == #self.v_queue or direct_show and #self.v_queue >= 1) then
    self:refresh_panel(task_id)
  end
end

function ui:refresh_panel(task_id)
  self.v_uiobjects.Tips:SetActive(true)
  local achievement_map = ShareRes.get_achievement_map()
  local achievement_group_id = achievement_map.TaskIdToGroupId[task_id]
  local achievement_group_cfg = ShareRes.get_achievement_group_cfg(achievement_group_id)
  local achievement_id
  for k, v in pairs(achievement_map.GroupIdToAchievements[achievement_group_id]) do
    if task_id == ShareRes.get_achievements(v).TaskId then
      achievement_id = v
      break
    end
  end
  if 1 == achievement_group_cfg.Classify then
    self.v_char_icon.gameObject:SetActive(true)
    self.v_achievement_icon.gameObject:SetActive(false)
    ResMgr:load_set_icon(self.v_char_icon, achievement_group_cfg.Photo, nil, true)
  elseif 2 == achievement_group_cfg.Classify then
    self.v_char_icon.gameObject:SetActive(false)
    self.v_achievement_icon.gameObject:SetActive(true)
    ResMgr:load_set_icon(self.v_achievement_icon, achievement_group_cfg.Photo, nil, true)
  end
  self.v_title_name.text = ShareRes.get_achievements(achievement_id).Name
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.common_tips_complete_UI_SOUND)
  self:show_anim(self.v_tips_rect_trans, self.v_anim_stay_time)
end

function ui:check_next()
  if self.v_queue and #self.v_queue > 0 then
    local next = self.v_queue[1]
    self:clear_sequence()
    self:refresh_panel(next)
  elseif not self.v_drop_count_change_timer and not self.v_show_save_suc_tips_timer and not self.v_task_complete_tips_timer and not self.v_orn_damage_timer and not self.v_drop_data_sequence then
    self:ui_hide()
  end
end

function ui:refresh_task_event_info(task_data)
  local task_info = task_data.task_info
  local task_cfg = task_data.task_cfg
  local pop_win_type = task_data.pop_win_type
  self.v_uiobjects.SPTaskTips:SetActive(true)
  self.v_bg1.gameObject:SetActive(false)
  self.v_bg2.gameObject:SetActive(false)
  self.v_task_type_icon.gameObject:SetActive(true)
  self.v_task_get.gameObject:SetActive(false)
  self.v_task_finish.gameObject:SetActive(false)
  self.v_task_next_step.gameObject:SetActive(false)
  self.v_btn_task_detail.gameObject:SetActive(false)
  self.v_btn_task_jump.gameObject:SetActive(false)
  self.v_btn_task_finish.gameObject:SetActive(false)
  self.v_task_step_now.text = 0
  self.v_task_step_max.text = 100
  self.v_task_name.text = task_cfg.Name
  TaskMgr:set_task_type_icon(self.v_task_type_icon, task_cfg.TaskType)
  if pop_win_type == commonDef.TASK_POP_TYPE.Check then
    self.v_bg1.gameObject:SetActive(true)
    self.v_btn_task_detail.gameObject:SetActive(true)
    self.v_task_get.gameObject:SetActive(true)
  elseif pop_win_type == commonDef.TASK_POP_TYPE.Jump then
    self.v_bg1.gameObject:SetActive(true)
    self.v_btn_task_jump.gameObject:SetActive(true)
    self.v_task_next_step.gameObject:SetActive(true)
    local finish_count, all_count = TaskMgr:get_task_progress(task_data)
    self.v_task_step_now.text = finish_count
    self.v_task_step_max.text = all_count
  elseif pop_win_type == commonDef.TASK_POP_TYPE.Finished then
    self.v_bg1.gameObject:SetActive(true)
    self.v_btn_task_finish.gameObject:SetActive(true)
    self.v_task_finish.gameObject:SetActive(true)
  elseif pop_win_type == commonDef.TASK_POP_TYPE.AutoFinished then
    self.v_bg2.gameObject:SetActive(true)
    self.v_task_finish.gameObject:SetActive(true)
  end
  self:set_button_listener(self.v_btn_task_detail, function()
    UIMgr:get_ui("ui_task_new"):ui_show(1, task_data.task_info.task_id)
  end)
  self:set_button_listener(self.v_btn_task_jump, function()
    local jump_id = TaskMgr:get_need_jump_id(task_data)
    if jump_id and jump_id > 0 then
      SysOpenMgr:jump_to_sys(jump_id, true)
    else
      Log.Error("跳转id为0")
    end
  end)
  self:set_button_listener(self.v_btn_task_finish, function()
    TaskMgr:request_get_event_reward_with_task_data(task_data, function()
      MsgGame:mq_publish2(Const.MSG_ON_CENTER_TASK_RECEIVE)
    end)
  end)
  local trans = self:get_rect_transform(nil, self.v_sp_task_tips.gameObject)
  self:show_event_task_anim(trans, TaskPopWinTipsStayTime)
end

function ui:refresh_orn_damage_info(damage_orn_id)
  local orn_id = damage_orn_id
  local orn_cfg = ShareRes.get_ornaments(orn_id)
  if orn_cfg then
    local quality_path = BattleOrnamentMgr:get_ornament_bg_icon(orn_cfg.Quality)
    ResMgr:load_set_icon(self.v_uicompents.OrnQuality_img, quality_path)
    ResMgr:load_set_icon(self.v_uicompents.OrnIcon_img, orn_cfg.Icon)
    self.v_uicompents.OrnName_txt.text = orn_cfg.Name
  else
    self:check_next()
    return
  end
  local pd = self.v_uicompents.OrnBrokenTipsPd_pd
  self.v_uiobjects.OrnBrokenTips:SetActive(true)
  if self.v_orn_damage_timer then
    Timer:remove_timer(self.v_orn_damage_timer)
    self.v_orn_damage_timer = nil
  end
  
  local function callback()
    self.v_orn_damage_timer = nil
    self.v_uiobjects.OrnBrokenTips:SetActive(false)
    pd:Stop()
    self:check_next()
  end
  
  self.v_orn_damage_timer = Timer:add_timer("orn_damage_timer", pd.duration, callback)
  pd:Stop()
  pd:Play()
end

function ui:drop_data_enqueue(data)
  self.v_drop_data_queue[#self.v_drop_data_queue + 1] = data
  self:refresh_drop_data()
end

function ui:refresh_drop_data()
  if self.v_drop_data_sequence then
    self:check_next()
    return
  end
  local item_data = self.v_drop_data_queue[1]
  if not item_data then
    self:check_next()
    return
  end
  table.remove(self.v_drop_data_queue, 1)
  local cfg = ShareRes.get_battle_item_cfg(item_data.item_id)
  ResMgr:load_set_icon(self.v_uicompents.GoldItemIcon_img, "Icon/BattleItem/" .. cfg.Icon)
  self.v_uiobjects.GoldTipsObj:SetActive(true)
  self:do_drop_data_anima(item_data)
end

function ui:do_drop_data_anima(item_data)
  local old_count = FightBagMgr:get_last_fight_res_by_id(item_data.item_id)
  self.v_uicompents.GoldNum_txt.text = old_count
  local cur_value = FightBagMgr:get_fight_item_num_by_id(item_data.item_id)
  FightBagMgr:set_last_fight_res_by_id(item_data.item_id, cur_value)
  self.v_uiobjects.AddNum:SetActive(true)
  local change_value = cur_value - old_count
  if 0 == change_value then
    self:check_next()
    return
  end
  self.v_roll_item_data = item_data
  local operator = change_value > 0 and "+" or "-"
  local pos_x, pos_y, pos_z = self.v_uicompents.GoldNum_rect:GetPositionA()
  self.v_uicompents.AddNum_rect:SetPositionA(pos_x + 1, pos_y, pos_z)
  Util.change_component_alpha2(self.v_uicompents.AddNum_txt, 1)
  self.v_uicompents.AddNum_txt.text = operator .. change_value
  if not self.v_drop_data_sequence then
    self.v_drop_data_sequence = Util.create_sequence()
    self.v_drop_data_sequence:Append(self.v_uiobjects.AddNum.transform:DOMoveX(pos_x, 1))
    self.v_drop_data_sequence:Join(self.v_uicompents.AddNum_txt:DOFade(0, 1))
    self.v_drop_data_sequence:SetAutoKill(false)
    self.v_drop_data_sequence:AppendCallback(function()
      self:do_drop_data_num_roll_anima(old_count, cur_value)
    end)
    self.v_drop_data_sequence:AppendInterval(1)
    self.v_drop_data_sequence:OnComplete(function()
      self:clear_drop_data_sequence()
      self:clear_wrap_text_tween()
      self.v_uiobjects.GoldTipsObj:SetActive(false)
      self:refresh_drop_data()
    end)
  else
    if self.v_wrap_text_tween then
      self.v_wrap_text_tween:Pause()
    end
    self.v_drop_data_sequence:Restart()
  end
end

function ui:do_drop_data_num_roll_anima(start_value, end_value)
  if Util.almost_zero(start_value - end_value) then
    return
  end
  local duration = self:_get_duration(end_value, start_value)
  if not self.v_wrap_text_tween then
    self.v_wrap_text_tween = CSHelper.WrapTextTweenTo2(self.v_uicompents.GoldNum_txt, start_value, end_value, duration)
  else
    self.v_wrap_text_tween:ChangeStartValue(start_value)
    self.v_wrap_text_tween:ChangeEndValue(end_value)
    self.v_wrap_text_tween:Restart()
  end
end

function ui:_get_duration(end_value, start_value)
  local dec = end_value - start_value
  if dec > 50 then
    return 0.75
  elseif dec > 25 and dec <= 50 then
    return 0.5
  elseif dec <= 25 then
    return 0.25
  end
end

function ui:clear_drop_data_sequence()
  if self.v_drop_data_sequence then
    self.v_drop_data_sequence:Kill(false)
    self.v_drop_data_sequence = nil
  end
end

function ui:clear_wrap_text_tween()
  if self.v_wrap_text_tween then
    self.v_wrap_text_tween:Kill(false)
    self.v_wrap_text_tween = nil
  end
end

function ui:show_anim(trans, stay_time)
  if trans then
    local _, y = trans:GetAnchoredPositionA()
    self.v_tip_anchor_pos_y = y
    local rect_trans_width = trans:GetRectWH()
    trans:SetAnchoredPositionA(rect_trans_width * -1, self.v_tip_anchor_pos_y)
    local sequence = Util.create_sequence()
    self.v_show_sequence = sequence
    sequence:Join(trans:DOAnchorPosX(Fade_In_PosX, Fade_Anim_Time))
    sequence:AppendInterval(stay_time)
    sequence:OnComplete(function()
      self:hide_anim(trans)
    end)
  end
end

function ui:hide_anim(trans)
  local sequence = Util.create_sequence()
  self.v_hide_sequence = sequence
  local rect_trans_width = trans:GetRectWH()
  sequence:Join(trans:DOAnchorPosX(rect_trans_width * -1, Fade_Anim_Time))
  sequence:OnComplete(function()
    _remove(self.v_queue, 1)
    self:check_next()
  end)
end

function ui:show_event_task_anim(trans, stay_time)
  if trans then
    local _, y = trans:GetAnchoredPositionA()
    self.v_tip_anchor_pos_y = y
    local rect_trans_width = trans:GetRectWH()
    trans:SetAnchoredPositionA(rect_trans_width * -1, self.v_tip_anchor_pos_y)
    local sequence = Util.create_sequence()
    self.v_show_sequence = sequence
    sequence:Join(trans:DOAnchorPosX(Fade_In_PosX, Fade_Anim_Time))
    sequence:AppendInterval(stay_time)
    sequence:OnComplete(function()
      self:hide_event_task_anim(trans)
    end)
  end
end

function ui:hide_event_task_anim(trans)
  local sequence = Util.create_sequence()
  self.v_hide_sequence = sequence
  local rect_trans_width = trans:GetRectWH()
  sequence:Join(trans:DOAnchorPosX(rect_trans_width * -1, Fade_Anim_Time))
  sequence:OnComplete(function()
    self:ui_hide()
  end)
end

function ui:clear_sequence()
  if self.v_hide_sequence then
    self.v_hide_sequence:Kill(false)
    self.v_hide_sequence = nil
  end
  if self.v_show_sequence then
    self.v_show_sequence:Kill(false)
    self.v_show_sequence = nil
  end
end

function ui:refresh_left_pick_up_tips(award_list, treasure_chest_id)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.common_pickup_tips_UI_SOUND)
  self.v_uiobjects.LeftPickUpTips:SetActive(true)
  self.v_uicompents.Ani_LeftPickUpTips_In_pd:Play()
  self:give_back_auto_cache(COMMON_BATTLE_LEFT_PICK_UP_TIPS)
  local delay_time = 0
  local obj_list = {}
  for idx, award_data in ipairs(award_list) do
    if idx > treasure_chest_max_count then
      break
    end
    local item_id = award_data.id
    local item_obj = self:get_auto_cache(COMMON_BATTLE_LEFT_PICK_UP_TIPS)
    table.insert(obj_list, item_obj)
    local item_quality = Util.get_image("QuailityBg_", item_obj)
    local item_icon = Util.get_image("ItemIcon_", item_obj)
    local item_name_obj = Util.get_child_gameobj("ItemName_", item_obj)
    local item_num_obj = Util.get_child_gameobj("ItemName_/X/ItemNum_", item_obj)
    local item_pd_in_obj = Util.get_child_gameobj("Ani_PickUpTem_In_", item_obj)
    local item_name = item_name_obj:GetComponent(typeof(CS.TMPro.TMP_Text))
    local item_num = item_num_obj:GetComponent(typeof(CS.TMPro.TMP_Text))
    local childCount = item_quality.transform.childCount
    for childIndex = 0, childCount - 1 do
      item_quality.transform:GetChild(childIndex).gameObject:SetActive(false)
    end
    local item_cfg = ShareRes.get_item_cfg(item_id)
    local quality_icon_name
    if item_cfg.Quality <= 3 then
      quality_icon_name = "Fight_list_pz3"
      if childCount > 2 then
        item_quality.transform:GetChild(2).gameObject:SetActive(true)
      end
    elseif 4 == item_cfg.Quality then
      quality_icon_name = "Fight_list_pz2"
      if childCount > 1 then
        item_quality.transform:GetChild(1).gameObject:SetActive(true)
      end
    else
      quality_icon_name = "Fight_list_pz1"
      if childCount > 0 then
        item_quality.transform:GetChild(0).gameObject:SetActive(true)
      end
    end
    ResMgr:load_set_icon(item_quality, "UIfight/" .. quality_icon_name, nil, true)
    local icon_path = UtilUI.get_item_icon(item_id)
    ResMgr:load_set_icon(item_icon, icon_path)
    item_name.text = item_cfg.Name
    item_num.text = award_data.count
    item_obj:SetActive(false)
    delay_time = delay_time + 0.1
    self.v_delay_left_pick_up_item_in = Timer:add_timer("delay_left_pick_up_item_in" .. tostring(idx), delay_time, function()
      if not Util.is_nil(item_obj) then
        item_obj:SetActive(true)
        item_pd_in_obj:SetActive(true)
      end
    end)
  end
  delay_time = delay_time + 2
  self.v_delay_left_pick_up_tips = Timer:add_timer("delay_left_pick_up_tips", delay_time, function()
    for _, item_obj in pairs(obj_list) do
      local item_pd_in_obj = Util.get_child_gameobj("Ani_PickUpTem_In_", item_obj)
      item_pd_in_obj:SetActive(false)
      local item_pd_out_obj = Util.get_child_gameobj("Ani_PickUpTem_Out_", item_obj)
      item_pd_out_obj:SetActive(true)
    end
    if not self.on_left_pick_up_tips_out_stop then
      function self.on_left_pick_up_tips_out_stop()
        for _, item_obj in pairs(obj_list) do
          local item_pd_out_obj = Util.get_child_gameobj("Ani_PickUpTem_Out_", item_obj)
          
          item_pd_out_obj:SetActive(false)
        end
        self.v_uiobjects.LeftPickUpTips:SetActive(false)
        self:ui_hide()
        local msg = MsgGame:mq_publish2(Const.MSG_TREASURE_CHEST_OPEN_FINISH)
        msg.mm_x = treasure_chest_id
      end
    end
    self.v_uicompents.Ani_LeftPickUpTips_Out_pd:stopped("+", self.on_left_pick_up_tips_out_stop)
    self.v_uicompents.Ani_LeftPickUpTips_Out_pd:Play()
  end)
end

function ui:ui_on_hide()
  if self.v_delay_left_pick_up_item_in then
    Timer:remove_timer(self.v_delay_left_pick_up_item_in)
    self.v_delay_left_pick_up_item_in = nil
  end
  if self.v_delay_left_pick_up_tips then
    Timer:remove_timer(self.v_delay_left_pick_up_tips)
    self.v_delay_left_pick_up_tips = nil
  end
  if self.v_drop_count_change_timer then
    self.v_uicompents.StageProgressTipsAnima_pd:Stop()
    Timer:remove_timer(self.v_drop_count_change_timer)
    self.v_drop_count_change_timer = nil
  end
  if self.v_show_save_suc_tips_timer then
    self.v_uicompents.SavePointTIpsAnima_pd:Stop()
    Timer:remove_timer(self.v_show_save_suc_tips_timer)
    self.v_show_save_suc_tips_timer = nil
  end
  if self.v_task_complete_tips_timer then
    Timer:remove_timer(self.v_task_complete_tips_timer)
    self.v_task_complete_tips_timer = nil
  end
  if self.v_orn_damage_timer then
    Timer:remove_timer(self.v_orn_damage_timer)
    self.v_orn_damage_timer = nil
  end
  self:clear_drop_data_sequence()
  self:clear_wrap_text_tween()
  self:clear_sequence()
  self.v_uiobjects.Tips:SetActive(false)
  self.v_queue = nil
  self.v_tips_rect_trans = nil
  self.v_uiobjects.SPTaskTips:SetActive(false)
  if self.on_left_pick_up_tips_out_stop then
    self.v_uicompents.Ani_LeftPickUpTips_Out_pd:stopped("-", self.on_left_pick_up_tips_out_stop)
    self.on_left_pick_up_tips_out_stop = nil
  end
  self.v_uiobjects.LeftPickUpTips:SetActive(false)
  self.v_uiobjects.TimeStopTips:SetActive(false)
end

return ui
