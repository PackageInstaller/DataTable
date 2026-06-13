local M = Util.create_class()
local commonDef = require("cs_share.common_define")
local Teach_Act_ID = commonDef.ACTY_TYPE.BUDDY_TEACH
local Shop_Helper = require("uimodule.shop.shop_helper")

function M:_init()
end

function M:check_condition(condition_id, show_tips)
  if not condition_id or 0 == condition_id then
    return true
  end
  local condition = ShareRes.create("condition.condition", condition_id)
  assert(condition, "no such condition " .. condition_id)
  local func_name
  if 1 == condition.Is_Client then
    local client_type = ShareRes.create("condition.client_condition_type", condition.Type)
    func_name = client_type.Name
  else
    local condition_type = ShareRes.create("condition.condition_type", condition.Type)
    func_name = condition_type.Name
  end
  assert(func_name, "no such condition type " .. condition.Type)
  Util.assert(M[func_name], "no such condition method ", condition_id, condition.Type, func_name)
  local ret = M[func_name](condition.Param, condition.Value, condition_id)
  if not ret and show_tips then
    Util.show_message_tip(condition.Desc)
  end
  return ret
end

function M.cond_buddy_lv_reach(params, value)
  local buddy_id = params[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info or value > buddy_info.lv then
    return false
  end
  return true
end

function M.cond_buddy_brk_reach(params, value)
  local buddy_id = params[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info or value > buddy_info.break_lv then
    return false
  end
  return true
end

function M.cond_buddy_advance_reach(params, value)
  local buddy_id = params[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info or value > buddy_info.advance then
    return false
  end
  return true
end

function M.cond_get_award()
  return false
end

function M.cond_player_lv_reach(params, value)
  local player_lv = PlayerMgr:get_player_base_info().lv
  if value > player_lv then
    return false
  end
  return true
end

function M.cond_pass_tower_floor_num(params, value)
  local tower_id = params[1]
  local target_floor_num = value
  local cur_num = TowerMgr:get_tower_history_floor_num(tower_id)
  return target_floor_num <= cur_num
end

function M.cond_episode_had_pass(params, value)
  local params_id = params[1]
  if ShareRes.get_comm_value("GuideTowerFightId") == params_id then
    return not NewbieTowerMgr:is_pass_tower()
  end
  local ring_id = ShareRes.get_ring_id_by_point_id(params_id)
  if ring_id then
    return ChallengeRingPlusMgr:check_ring_is_pass(ring_id)
  end
  local pass = ActivityMgr:invoke(Teach_Act_ID, "check_point_has_passed", params_id)
  if pass then
    return true
  end
  local star_count = ChapterMaterialMgr:get_material_star_num_with_epi_id(params_id)
  if star_count > 0 then
    return true
  end
  local climbing_tower_star_count = ClimbingTowerMgr:get_star_with_epi_id(params_id)
  if climbing_tower_star_count > 0 then
    return true
  end
  local complete = ChapterMgr:check_episode_complete(params_id)
  return complete
end

function M.cond_have_item_cnt(params, value)
  local item_id = params[1]
  local item_count = BagMgr:get_item_num(item_id)
  return value <= item_count
end

function M.cond_buddy_favorability_lv_reach(params, value)
  local buddy_id = params[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  return buddy_info and value <= buddy_info.favor_lv
end

function M.cond_have_buddy_num(params, value)
  local list = CharacterMgr:get_all_buddys()
  if not list then
    return false
  end
  return value <= #list
end

local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}

function M.cond_has_com_task(params, value)
  local state = TaskMgr:get_task_state(params[1])
  return state == TASK_STATE.COMPLETE
end

function M.cond_guide_complete(params, value)
  local list = GuideMgr:get_complete_guides()
  local guide_id = params[1]
  local check_complete = 1 == value
  if check_complete then
    return nil ~= list[guide_id]
  else
    return nil == list[guide_id]
  end
end

function M.cond_chapter_episode(params, value)
  local chapter_id = params[1]
  local point_id = params[2]
  local pass = 1 == params[3]
  local chapter_data = ChapterMgr:get_chapter_data_by_chapter_id(chapter_id)
  if not chapter_data then
    return not pass
  end
  local point_data = chapter_data.episode_list
  if not point_data then
    return not pass
  end
  if pass then
    for _, data in pairs(point_data) do
      if data.id == point_id and value <= data.complete_cnt then
        return true
      end
    end
    return false
  else
    for _, data in pairs(point_data) do
      if data.id == point_id and data.complete_cnt > 0 then
        return false
      end
    end
    return true
  end
end

function M.cond_chapter_episode_has_pass(params, value)
  local point_id = params[1]
  local chapter_cfg = ChapterMgr:get_chapter_by_episode(point_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_point_id(point_id)
  local dict = ChapterMgr:get_chapter_node_data_dict(chapter_cfg.Id)
  if not dict then
    return false
  end
  for key, node_cfg in pairs(node_cfg_list) do
    if node_cfg.NodeType ~= commonDef.CHAPTER_NODE_TYPE.BRANCH_LINE then
      if not dict[key] then
        return false
      end
      if dict[key].state == commonDef.CHAPTER_NODE_STATE.UNLOCK then
        return false
      end
    end
  end
  return true
end

function M.cond_chapter_episode_point_has_pass(params, value)
  local epi_id = params[1]
  local point_id = params[2]
  local pass = 1 == params[3]
  local chapter_cfg = ChapterMgr:get_chapter_by_episode(epi_id)
  local state = ChapterMgr:get_node_state(chapter_cfg.Id, point_id)
  local res = false
  if state == commonDef.CHAPTER_NODE_STATE.FINISHED then
    res = true
  else
    res = false
  end
  if not pass then
    res = not res
  end
  return res
end

function M.cond_chapter_episode_no_point_has_pass(params, value)
  local point_id = params[1]
  local pass = 1 == params[2]
  local chapter_cfg = ChapterMgr:get_chapter_by_episode(point_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_point_id(point_id)
  local dict = ChapterMgr:get_chapter_node_data_dict(chapter_cfg.Id)
  local res = false
  if not dict then
    res = false
    if pass then
      return res
    else
      return not res
    end
  end
  for key, node_cfg in pairs(node_cfg_list) do
    if node_cfg.NodeType ~= commonDef.CHAPTER_NODE_TYPE.BRANCH_LINE then
      if not dict[key] then
        res = false
        if pass then
          return res
        else
          return not res
        end
      end
      if dict[key].state == commonDef.CHAPTER_NODE_STATE.UNLOCK then
        res = false
        if pass then
          return res
        else
          return not res
        end
      end
    end
  end
end

function M.cond_chapter_node_finish(params, value)
  local chapter_point_id = params[1]
  local chapter_node_cfg = ShareRes.get_chapter_node_cfg(chapter_point_id)
  if chapter_node_cfg then
    local chapter_cfg = ChapterMgr:get_chapter_by_episode(chapter_node_cfg.EpisodeId)
    local dict = ChapterMgr:get_chapter_node_data_dict(chapter_cfg.Id)
    if not dict or not dict[chapter_point_id] then
      return false
    end
    return dict[chapter_point_id].state == commonDef.CHAPTER_NODE_STATE.FINISHED
  end
end

function M.cond_week_acty_perpare_epi_star(params, value)
  local epi_id = params[1]
  local need_star = params[2]
  local is_lock = WeeklyMgr:check_hurdle_lock(epi_id)
  if is_lock then
    return false
  end
  local star_map = WeeklyMgr:get_hurdle_star_map(epi_id)
  local star_count = 0
  for idx = 1, 3 do
    if star_map[idx] then
      star_count = star_count + 1
    end
  end
  return need_star <= star_count
end

function M.cond_episode_star_finish(params)
  local epi_id = params[1]
  local need_star = params[2]
  local star_count = JumpTeamMgr:get_epi_star(epi_id)
  if not star_count then
    return false
  end
  return need_star <= star_count
end

function M.cond_new_material_star_finish(params)
  local epi_id = params[1]
  local need_star = params[2]
  local star_count = ChapterMaterialMgr:get_material_epi_star_num(epi_id)
  if not star_count then
    return false
  end
  return need_star <= star_count
end

function M.cond_buddy_level(params)
  local buddy_id = params[1]
  local buddy_break_lv = params[2]
  local buddy_level = params[3]
  return CharacterMgr:cond_buddy_level(buddy_id, buddy_break_lv, buddy_level)
end

function M.cond_daily_active_val(params)
  local val = params[1]
  local active_point = TaskMgr:get_daily_active_point_reward()
  return val <= active_point
end

function M.cond_weekly_active_val(params)
  local val = params[1]
  local active_point = TaskMgr:get_weekly_active_point_reward()
  return val <= active_point
end

function M.cond_gift_shop_goods(params)
  if not SysOpenMgr:get_is_ui_open("gift_shop") then
    return false
  end
  local goods_id = params[1]
  local goods_cfg = ShareRes.get_gift_shop_cfg(goods_id)
  local is_open = Shop_Helper.check_gift_open(goods_cfg)
  if is_open then
    return not Shop_Helper.check_sold_out(goods_cfg)
  end
  return false
end

function M.cond_gift_shop_goods_soldout(params)
  return not M.cond_gift_shop_goods(params)
end

function M.cond_stamina_cost(params)
  local cond_val = params[1]
  local now_val = PlayerSundryMgr:get_player_var_value("stamina_cost")
  return cond_val <= now_val
end

function M.cond_challeng_week_acty_epi(params)
  local cond_val = params[1]
  local now_val = PlayerSundryMgr:get_player_var_value("challeng_week_acty_epi")
  return cond_val <= now_val
end

function M.cond_challeng_curse_ring_epi(params)
  local cond_val = params[1]
  local now_val = PlayerSundryMgr:get_player_var_value("challeng_curse_ring_epi")
  return cond_val <= now_val
end

function M.cond_activity_daily_first_trigger_catch_cat(params, value)
  if 1 == value then
    return NoviceMgr:get_catch_cat_act_daily_open()
  else
    return not NoviceMgr:get_catch_cat_act_daily_open()
  end
end

function M.cond_activity_daily_first_trigger_monkey_typer(params, value)
  if 1 == value then
    return NoviceMgr:get_monkey_typer_act_daily_open()
  else
    return not NoviceMgr:get_monkey_typer_act_daily_open()
  end
end

function M.cond_activity_daily_first_trigger_puzzle_game(params, value)
  if 1 == value then
    return NoviceMgr:get_puzzle_game_act_daily_open()
  else
    return not NoviceMgr:get_puzzle_game_act_daily_open()
  end
end

function M.cond_item_expiring(params, value)
  local item_id = params[1]
  if 1 == value then
    return BagMgr:check_item_expiring(item_id)
  else
    return not BagMgr:check_item_expiring(item_id)
  end
end

function M.cond_have_enter_skin_try_out(params)
  local activity_id = params[1]
  local novice_activity_list = NoviceMgr:get_novice_activity_list()
  if novice_activity_list[activity_id] and 0 == novice_activity_list[activity_id].is_end then
    return 1 == NoviceMgr:get_skin_tryout_localdata(activity_id)
  end
  return false
end

function M.cond_is_activity_activated(params)
  local activity_id = params[1]
  local activity = NoviceMgr:get_novice_activity_list()[activity_id]
  return activity and 0 == activity.is_end
end

function M.cond_have_enter_char_try_out()
  if BuddyTryoutMgr:check_activity_open() then
    local buddy_list = BuddyTryoutMgr:get_buddy_list()
    for _, data in pairs(buddy_list) do
      if not data.is_new then
        return true
      end
    end
  end
  return false
end

function M.cond_is_char_try_out_activated()
  return BuddyTryoutMgr:check_activity_open()
end

function M.cond_passport_daily_active_achieve(params)
  local PASSPORT_SYS_ID = 54
  if SysOpenMgr:get_sys_is_open(PASSPORT_SYS_ID) then
    local daily_active_score = PassPortMgr:get_daily_active_score()
    local goal = params[1]
    if daily_active_score >= goal then
      return true
    end
  end
  return false
end

function M.cond_is_sys_open(params)
  local sys_id = params[1]
  return SysOpenMgr:get_sys_is_open(sys_id)
end

function M.cond_role_talent_level_count(params, value)
  local need_talent_level = params[1]
  local count = CharacterMgr:get_role_count_with_talent_lv(need_talent_level)
  return value <= count
end

function M.cond_different_relic_count(value)
  local count = CharacterMgr:get_role_count_with_talent_lv()
  return value <= count
end

function M.cond_buddy_combat_effectiveness(params)
  local buddy_id = params[1]
  local need_value = params[2]
  local value = CharacterMgr:get_buddy_combat_effectiveness(buddy_id)
  return need_value <= value
end

function M.cond_more_buddy_combat_effectiveness(params, value)
  local need_value = params[1]
  local count = CharacterMgr:get_buddy_count_with_combat_effectiveness(need_value)
  return value <= count
end

function M.cond_role_event_complete(params, value)
  local event_id = params[1]
  local ret = TaskMgr:get_buddy_event_complete(event_id)
  if 1 == value then
    return ret
  else
    return not ret
  end
end

function M.cond_journey_event_finish(params)
  local event_id = params[1]
  local ret = JourneyEventMgr:get_event_is_finish(event_id)
  return ret
end

function M.cond_appoint_num_buddy_break_cnt(params, value)
  local break_lv = params[1]
  local times = value
  local buddy_map = CharacterMgr:get_buddy_map()
  for k, buddy in pairs(buddy_map) do
    if break_lv <= buddy.break_lv - 1 then
      times = times - 1
      if times <= 0 then
        return true
      end
    end
  end
  return times <= 0
end

function M.cond_buddy_active(params)
  local buddy_id = params[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  return nil ~= buddy_info
end

function M.cond_player_have_item(params)
  local ret = false
  if params and next(params) then
    for _, item_id in pairs(params) do
      if item_id and item_id > 0 then
        local item_count = BagMgr:get_item_num(item_id)
        if item_count > 0 then
          return true
        end
      end
    end
  else
    ret = false
  end
  return ret
end

function M.cond_building_level(_, _, condition_id)
  return BuildingMgr:check_condition(condition_id)
end

function M.cond_need_finish_nodes(params, value, condition_id)
  local count = 0
  for key, node_id in pairs(params) do
    if node_id > 0 and not ChapterMgr:check_node_is_first_save_suc(node_id) then
      count = count + 1
    end
  end
  return value <= count
end

function M.cond_building_can_level_up(params, value, condition_id)
  local building_type = Config.CommonDefine.BUILDING_TYPE.TOWER
  local building_level = BuildingMgr:get_building_level(building_type)
  building_level = building_level + 1
  if 1 == value then
    return BuildingMgr:building_level_up_check(building_type, building_level)
  end
  return not BuildingMgr:building_level_up_check(building_type, building_level)
end

function M.cond_adventrue_can_get_award(params, value, condition_id)
  if 1 == value then
    return BuildingMgr:check_adventrue_can_get_award()
  end
  return not BuildingMgr:check_adventrue_can_get_award()
end

function M.cond_factory_is_full(params, value, condition_id)
  if 1 == value then
    return BuildingMgr:check_has_factory_is_full()
  end
  return not BuildingMgr:check_has_factory_is_full()
end

function M.cond_mail_award(params, value)
  if 1 == value then
    return MailMgr:check_all_mail_award()
  end
  return not MailMgr:check_all_mail_award()
end

function M.cond_shop_free_gift(params, value)
  if 1 == value then
    return Shop_Helper.check_shop_free_gift()
  end
  return not Shop_Helper.check_shop_free_gift()
end

function M.cond_weekly_is_reset(params, value)
  if 1 == value then
    return WeeklyMgr:is_weekly_reset()
  end
  return not WeeklyMgr:is_weekly_reset()
end

function M.cond_gift_buy_cout(params, value)
  local gift_id = params[1]
  if not gift_id then
    return false
  end
  local gift_cfg = ShareRes.get_gift_shop_cfg(gift_id)
  if not gift_cfg then
    return false
  end
  local SKIN_GIFT_SHOP_SHELF = 10000
  local WEAPON_SKIN_GIFT_SHOP_SHELF = 10001
  if gift_cfg.Paging == SKIN_GIFT_SHOP_SHELF or gift_cfg.Paging == WEAPON_SKIN_GIFT_SHOP_SHELF then
    return false
  end
  if not Shop_Helper.check_gift_open(gift_cfg) then
    return false
  end
  local buy_count = RechargeMgr:get_gift_buy_count(gift_id)
  if 1 == value then
    return buy_count > 0
  else
    return buy_count < 1
  end
end

function M.cond_check_ring_challenge_red(params, value)
  if 1 == value then
    return ChallengeRingPlusMgr:get_challenge_red()
  end
  return not ChallengeRingPlusMgr:get_challenge_red()
end

function M.cond_climbing_tower_max_star(params, value)
  local _, curr, max = ClimbingTowerMgr:get_main_btn_info()
  return max <= curr
end

return M
