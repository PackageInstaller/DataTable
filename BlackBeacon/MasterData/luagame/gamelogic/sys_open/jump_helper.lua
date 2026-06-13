local jump_func = {
  shop = {
    [1] = "_jump_to_shop"
  },
  chapter_inf = {
    [1] = "_jump_to_chapter_inf"
  },
  chapter = {
    [1] = "_jump_to_chapter"
  },
  material_stage = {
    [1] = "_jump_to_material_stage"
  },
  web_view = {
    [1] = "_jump_to_web_view_with_uuid"
  },
  url_web_view = {
    [1] = "_jump_to_target_url"
  },
  weekly_battle_detail = {
    [1] = "_jump_to_weekly_pve"
  },
  challenge_ring_plus_main = {
    [1] = "_jump_to_challenge_ring_plus_main"
  },
  ui_chapter_detail = {
    [1] = "_jump_to_ui_chapter_detail",
    [2] = "_jump_to_ui_chapter_detail_toteam"
  },
  team = {
    [1] = "_jump_to_ui_jump_team"
  },
  new_ui_item_synthesis = {
    [1] = "_jump_to_new_ui_item_synthesis"
  },
  hero_skill_teach = {
    [1] = "_jump_to_hero_skill_teach"
  },
  infinite_main = {
    [1] = "_jump_to_infinite_main"
  },
  weekly_pvp_detail_stage1 = {
    [1] = "_jump_to_weekly_pvp_detail_stage1"
  },
  weekly_pvp_shop = {
    [1] = "_jump_to_weekly_pvp_shop"
  },
  challenge_ring_plus_contribute_shop = {
    [1] = "_jump_to_challenge_ring_plus_contribute_shop"
  },
  uidrawcard = {
    [1] = "_jump_to_drawcard_after_uimain"
  },
  uimainclose = {
    [1] = "_jump_to_uimainclose"
  },
  character_enter = {
    [1] = "_jump_to_character_enter_with_id"
  },
  ui_activity = {
    [1] = "_jump_to_ui_activity"
  },
  character = {
    [1] = "_jump_to_character_with_id",
    [2] = "_jump_to_character_with_break_lv"
  },
  use_select_item_tips = {
    [1] = "_jump_to_use_item"
  },
  boss_challenge_point_detail = {
    [1] = "_jump_to_boss_challenge_detail"
  },
  fate_book_point_detail = {
    [1] = "_jump_to_fate_book_point_detail"
  },
  ui_monthtask = {
    [1] = "_jump_to_ui_monthtask"
  },
  uibag = {
    [1] = "_jump_to_bag"
  },
  ui_fashionable_dress_shop = {
    [1] = "_jump_to_ui_fashionable_dress_shop"
  },
  ui_time_limited_activity_main = {
    [1] = "_jump_to_ui_time_limited_activity"
  },
  ui_activity_summer_stage = {
    [1] = "_ui_activity_summer_stage"
  },
  ui_activity_summer_shop = {
    [1] = "_ui_activity_summer_shop"
  },
  ui_maze_game_main = {
    [1] = "_ui_maze_game_main"
  }
}
local helper = {}
local CharacterConfig = require("uimodule.character.character_config")
local ShopCfg = require("uimodule.shop.shop_config")
local PanelType = CharacterConfig.PANEL_TYPE
local JumpCfg = ShareRes.create("sysopen.sys_jump")
local TcsType = ShareRes.create("item.item_subtype", "treasure_chest_select").SubtypeId

function helper.jump_to_sys(jump_cfg, ...)
  local name_list = jump_func[jump_cfg.ui_name]
  if name_list then
    local func_name = name_list[jump_cfg.func_id]
    if func_name then
      return helper[func_name](jump_cfg, ...)
    end
  else
    if not jump_cfg.ui_name then
      Log.Error("获取跳转界面失败， 跳转ID:", jump_cfg.Id, debug.traceback())
      return
    end
    UIMgr:get_ui(jump_cfg.ui_name):ui_show(...)
  end
  return true
end

function helper.get_jump_cfg(jump_id)
  if not jump_id then
    return
  end
  return JumpCfg[jump_id]
end

function helper.get_jump_ui_name(jump_id)
  if not jump_id or not JumpCfg[jump_id] then
    return nil
  end
  return JumpCfg[jump_id].ui_name
end

function helper.get_jump_show(jump_id)
  if not jump_id or not JumpCfg[jump_id] then
    return false
  end
  local jump_cfg = JumpCfg[jump_id]
  return not jump_cfg.show_condition or Condition:check_condition(jump_cfg.show_condition)
end

function helper._jump_to_shop(jump_cfg, ...)
  local param = jump_cfg.param
  local ui = UIMgr:get_ui(jump_cfg.ui_name)
  if ui:visible() then
    ui:reopen(param[1], tonumber(param[2]), ...)
  else
    ui:ui_show(param[1], tonumber(param[2]), ...)
  end
  return true
end

function helper._jump_to_chapter_inf(jump_cfg, ...)
  local param = jump_cfg.param
  local chapter_id = tonumber(param[1])
  local chapter_cfg = ShareRes.get_inf_chapter_cfg(chapter_id)
  if Condition:check_condition(chapter_cfg.Condition, true) == true then
    UIMgr:get_ui(jump_cfg.ui_name):ui_show(chapter_id)
  end
  return true
end

function helper._jump_to_chapter(jump_cfg, ...)
  local param = jump_cfg.param
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(tonumber(param[1]))
  return true
end

function helper._jump_to_material_stage(jump_cfg, ...)
  local param = jump_cfg.param
  if not param[1] or "" == param[1] then
    UIMgr:get_ui("chapter"):ui_show(2)
    return
  end
  local material_type_id = tonumber(param[1])
  local open, material_type = ChapterMaterialMgr:check_chapter_material_type_is_open(material_type_id, true)
  if not open then
    return
  end
  local is_need_check = false
  local epi_id = -1
  local type_cfg_list = ShareRes.get_chapter_material_list_with_type(material_type)
  local need_select_index
  if param[2] and "" ~= param[2] then
    epi_id = tonumber(param[2])
    is_need_check = true
  else
    for i, data in pairs(type_cfg_list) do
      if epi_id < data.Id then
        local open_child = ChapterMaterialMgr:check_chapter_material_epi_is_open(data.Id)
        if open_child then
          epi_id = data.Id
        end
      end
    end
  end
  if is_need_check then
    local is_have = false
    for i, data in pairs(type_cfg_list) do
      if data.Id == epi_id then
        is_have = true
        break
      end
    end
    if false == is_have and -1 ~= epi_id then
      Log.Error(string.format("类型为%s的材料类型不存在Id:%s", material_type, epi_id))
      return
    elseif -1 ~= epi_id then
      local open_child = ChapterMaterialMgr:check_chapter_material_epi_is_open(epi_id, true)
      if not open_child then
        return
      end
    end
  end
  if -1 == epi_id then
    epi_id = nil
  end
  if param[3] and "" ~= param[3] then
    need_select_index = tonumber(param[3])
  end
  if -1 == need_select_index then
    need_select_index = nil
  end
  ChapterMaterialMgr:before_in_material_level_win(material_type)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(material_type, epi_id, need_select_index)
  return true
end

function helper._jump_to_web_view_with_uuid(jump_cfg, ...)
  local param = jump_cfg.param
  local target_tag = SDKManager:is_third_party_channel() and 2 or 1
  local banner_list = ShareRes.create("activity_banner.activity_banner")
  local qus_id
  for _, data in pairs(banner_list) do
    if jump_cfg.Id == data.JumpId then
      qus_id = data.QuestionnaireId[target_tag]
    end
  end
  if qus_id then
    local url = string.format(param[target_tag], Global.player_uuid .. "-" .. qus_id)
    SDKManager:open_web_view(url)
  end
  return true
end

function helper._jump_to_target_url(jump_cfg, ...)
  local param = jump_cfg.param
  local target_tag = SDKManager:is_third_party_channel() and 2 or 1
  local url = param[target_tag] or param[1]
  SDKManager:open_web_view(url)
  return true
end

function helper._jump_to_weekly_pve(jump_cfg, ...)
  local param = jump_cfg.param
  local epi_id = tonumber(param[1])
  local is_lock = WeeklyMgr:check_hurdle_lock(epi_id)
  if is_lock then
    Util.show_message_tip(2093)
    return
  end
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(epi_id)
  return true
end

function helper._jump_to_challenge_ring_plus_main(jump_cfg, ...)
  local param = jump_cfg.param
  local default_difficulty_index = tonumber(param[1])
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(default_difficulty_index)
  return true
end

function helper._jump_to_ui_chapter_detail(jump_cfg, ...)
  local param = jump_cfg.param
  local chapter_id = param[1]
  local node_id = param[2]
  local is_need_select = param[3]
  if (not chapter_id or "" == chapter_id) and (not node_id or "" == node_id) then
    local node_cfg = ChapterMgr:get_newest_node_info()
    if not node_cfg then
      return
    end
    local point_id = node_cfg.EpisodeId
    if not point_id then
      return
    end
    local chapter_cfg = ChapterMgr:get_chapter_by_episode(point_id)
    if not chapter_cfg then
      return
    end
    chapter_id = chapter_cfg.Id
    node_id = node_cfg.Id
  elseif Util.is_empty(node_id) then
    chapter_id = tonumber(chapter_id)
    if not JumpTeamMgr:check_chapter_is_open(chapter_id, true) then
      return
    end
    local point_data = ChapterMgr:get_chapter_newst_point_data(chapter_id)
    local node_info = ChapterMgr:get_cur_chapter_newest_node_info(point_data.id, chapter_id)
    node_id = node_info and node_info.Id
  else
    chapter_id = tonumber(chapter_id)
    node_id = tonumber(node_id)
    if not helper.check_chapter_epi_is_oepn(node_id) then
      return
    end
  end
  local chapter_config = ShareRes.get_chapter_cfg(chapter_id)
  if not ResMgr:check_is_can_fight_with_res(chapter_config) then
    return
  end
  local is_select
  if not is_need_select or "" == is_need_select then
    is_select = false
  else
    is_need_select = tonumber(is_need_select)
    is_select = 1 == is_need_select
  end
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(chapter_id, nil, is_select, nil, node_id)
  return true
end

function helper._jump_to_ui_chapter_detail_toteam(jump_cfg, ...)
  local param = jump_cfg.param
  local chapter_id = param[1]
  local node_id = param[2]
  local jump = "SpJump" == param[3]
  chapter_id = tonumber(chapter_id)
  node_id = tonumber(node_id)
  if not helper.check_chapter_epi_is_oepn(node_id) then
    return
  end
  local is_select = true
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(chapter_id, nil, is_select, nil, node_id, jump)
  return true
end

function helper.check_chapter_epi_is_oepn(node_id)
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  if node_cfg then
    return JumpTeamMgr:get_chapter_main_line_normal_is_can_fight(node_cfg.EpisodeId, node_id, true)
  else
    return JumpTeamMgr:get_chapter_main_line_hard_is_can_fight(node_id, true)
  end
  return false
end

function helper._jump_to_ui_jump_team(jump_cfg, ...)
  local param = jump_cfg.param
  if not param or 0 == #param then
    Log.Error("未配置跳转参数 跳转Id:" .. tostring(jump_cfg.Id))
    return
  end
  local epi_id = tonumber(jump_cfg.param[1])
  local params2, params3
  if param[2] and 0 ~= param[2] then
    params2 = tonumber(param[2])
  end
  if param[3] and 0 ~= param[3] then
    params3 = tonumber(param[3])
  end
  local is_open = JumpTeamMgr:get_epi_is_open(epi_id, params2, true)
  if not is_open then
    return
  end
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(nil, epi_id)
  return true
end

function helper.jump_to_new_ui_item_synthesis(item_id, target_count, go_to_main_when_hide)
  local combine_id = BagMgr:get_item_combine_id(item_id)
  helper._jump_to_new_ui_item_synthesis(nil, combine_id, target_count, go_to_main_when_hide)
end

function helper._jump_to_new_ui_item_synthesis(jump_cfg, ...)
  local exchange_id, target_count, go_to_main_when_hide = ...
  if exchange_id then
    local item_exchange_cfg = ShareRes.get_all_item_combine_cfg()[exchange_id]
    local condition = item_exchange_cfg and item_exchange_cfg.Condition
    if condition and condition > 0 and not Condition:check_condition(condition, true) then
      return false
    end
  end
  local new_ui_item_synthesis = UIMgr:get_ui("new_ui_item_synthesis")
  if not new_ui_item_synthesis:visible() then
    new_ui_item_synthesis:ui_show(...)
  else
    new_ui_item_synthesis:jump_to_target_synthesis(...)
  end
  new_ui_item_synthesis:set_go_to_main_when_hide(go_to_main_when_hide)
  return true
end

function helper._jump_to_hero_skill_teach(jump_cfg, ...)
  UIMgr:get_ui("hero_skill_teach"):ui_show()
  return true
end

function helper._jump_to_infinite_main(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show()
  return true
end

function helper._jump_to_weekly_pvp_detail_stage1(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show()
  return true
end

function helper._jump_to_weekly_pvp_shop(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show()
  return true
end

function helper._jump_to_challenge_ring_plus_contribute_shop(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show()
  return true
end

function helper._jump_to_drawcard_after_uimain(jump_cfg, ...)
  local param = jump_cfg.param
  local pool_id
  if param and 0 ~= #param then
    pool_id = param[1]
  end
  if not SceneMgr:check_main_scene() then
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("当前场景不可回到主界面"))
  else
    local function after_show_callback()
      local uimain = UIMgr:try_get_visible_ui("uimain")
      
      if uimain then
        uimain:delay_enter_draw(pool_id)
      end
    end
    
    if UIMgr:get_cur_show_ui_name() == "uimain" then
      after_show_callback()
    else
      UIMgr:go_to_main(after_show_callback)
    end
  end
  return true
end

function helper._jump_to_uimainclose(jump_cfg, ...)
  if not SceneMgr:check_main_scene() then
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("当前场景不可回到主界面"))
  else
    local function after_show_callback()
      local uimain = UIMgr:try_get_visible_ui("uimain")
      
      if uimain then
        uimain:open_ui_main_close_win_with_cb()
      end
    end
    
    UIMgr:go_to_main(after_show_callback)
  end
  return true
end

function helper._jump_to_character_enter_with_id(jump_cfg, ...)
  local buddy_id = jump_cfg.param[1]
  if "" ~= buddy_id then
    buddy_id = tonumber(buddy_id)
    if not CharacterMgr:get_buddy_by_id(buddy_id) then
      Util.show_message_tip(2094)
      return
    end
    local ui = UIMgr:get_ui("character_enter")
    ui:select_char(buddy_id)
    ui:ui_show()
  else
    UIMgr:get_ui("character_enter"):ui_show()
  end
  return true
end

function helper._jump_to_ui_activity(jump_cfg, ...)
  local activity_id = jump_cfg.param[1]
  if "" ~= activity_id then
    activity_id = tonumber(activity_id)
  else
    activity_id = nil
  end
  local dir_jump
  if jump_cfg.param[2] == "SpJump" then
    dir_jump = true
  end
  local ui = UIMgr:try_get_visible_ui("ui_activity")
  if ui then
    ui:refresh(11, true, dir_jump)
  else
    UIMgr:get_ui("ui_activity"):ui_show(activity_id, dir_jump)
  end
  return true
end

function helper._jump_to_character_with_id(jump_cfg, ...)
  local buddy_id = tonumber(jump_cfg.param[1])
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info then
    Log.Error("尝试跳转到未拥有角色")
    return false
  end
  UIMgr:get_ui("character"):ui_show(false, PanelType.ATTR_PANEL, nil, buddy_id)
  return true
end

function helper._jump_to_character_with_break_lv(jump_cfg, ...)
  local break_lv = tonumber(jump_cfg.param[1])
  local buddy_map = CharacterMgr:get_buddy_map()
  if not buddy_map then
    return false
  end
  for k, buddy in pairs(buddy_map) do
    if break_lv <= buddy.break_lv - 1 then
      local buddy_id = buddy.id
      UIMgr:get_ui("character"):ui_show(false, PanelType.ATTR_PANEL, nil, buddy_id)
      return true
    end
  end
  return false
end

function helper._jump_to_use_item(jump_cfg, ...)
  for _, param_str in ipairs(jump_cfg.param) do
    if "" ~= param_str then
      local item_id = tonumber(param_str)
      local item_info = BagMgr:get_item(item_id)
      if item_info then
        local item_cfg = ShareRes.get_item_cfg(item_id)
        if item_cfg.Subtype == TcsType then
          UIMgr:get_ui("use_select_item_tips"):ui_show(item_id, item_info.uuid)
          return true
        else
          Log.Error("跳转id:", jump_cfg.Id, "配置了错误类型的宝箱道具:", item_id)
        end
      end
    end
  end
  Log.Error("跳转失败，请检查跳转显示条件和跳转参数配置的宝箱道具是否一致：", jump_cfg.Id)
  return false
end

function helper._jump_to_boss_challenge_detail(jump_cfg, ...)
  local boss_id = tonumber(jump_cfg.param[1])
  local boss_cfg = ShareRes.get_boss_fight_cfg(boss_id)
  if not boss_cfg then
    Log.Error("跳转失败，没有对应的bossID：", boss_id)
    return false
  end
  UIMgr:get_ui("boss_challenge_point_detail"):ui_show(boss_id)
  return true
end

function helper._jump_to_fate_book_point_detail(jump_cfg, ...)
  local ACTY_TYPE = Config.CommonDefine.ACTY_TYPE
  local ActivityCfg = require("gamelogic.activity.activity_config")
  local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID
  if not SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.CURSE_CIRCLE], true) then
    return false
  end
  local show_type = tonumber(jump_cfg.param[1])
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(show_type)
  if not group_ids then
    return false
  end
  local is_unlock = false
  local last_lock_gourp, first_in_time_group
  if group_ids then
    for _, group_id in pairs(group_ids) do
      if ChallengeRingPlusMgr:check_ring_group_is_in_time(group_id) then
        if ChallengeRingPlusMgr:check_ring_group_is_unlock(group_id) then
          is_unlock = true
          break
        elseif not first_in_time_group then
          first_in_time_group = group_id
        end
      else
        last_lock_gourp = last_lock_gourp or group_id
      end
    end
  end
  if not is_unlock then
    local lock_group = first_in_time_group or last_lock_gourp
    if lock_group then
      ChallengeRingPlusMgr:check_ring_group_is_unlock(lock_group, true)
    end
    return false
  end
  UIMgr:get_ui("fate_book_point_detail"):ui_show(show_type)
end

function helper._jump_to_ui_monthtask(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(nil, tonumber(jump_cfg.param[1]))
  return true
end

function helper._jump_to_bag(jump_cfg, ...)
  UIMgr:get_ui(jump_cfg.ui_name):ui_show(tonumber(jump_cfg.param[1]))
  return true
end

function helper._jump_to_ui_fashionable_dress_shop(jump_cfg, ...)
  local gift_id = tonumber(jump_cfg.param[1])
  if nil == gift_id then
    return
  end
  local gift_cfg = ShareRes.get_gift_shop_cfg(gift_id)
  local award_id = gift_cfg.AwardID
  if not award_id then
    return
  end
  local award = ShareRes.get_award_item_data(award_id)
  local fashion_id = award[1][1]
  if gift_cfg.Paging == ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF then
    UIMgr:get_ui("ui_fashionable_dress_shop"):ui_show(nil, fashion_id, gift_cfg)
  else
    UIMgr:get_ui("ui_fashionable_dress_shop"):ui_show(fashion_id, nil, gift_cfg)
  end
end

function helper._jump_to_ui_time_limited_activity(jump_cfg, ...)
  local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
  if version_activity_id then
    TimeLimitedActMgr:open_version_activity_win(version_activity_id)
  end
end

function helper._ui_activity_summer_stage(jump_cfg, ...)
  local activity_id = tonumber(jump_cfg.param[1])
  UIMgr:get_ui("ui_activity_summer_stage"):ui_show(activity_id)
  return true
end

function helper._ui_activity_summer_shop(jump_cfg, ...)
  local activity_id = tonumber(jump_cfg.param[1])
  local shop_id = tonumber(jump_cfg.param[2])
  UIMgr:get_ui("ui_activity_summer_shop"):ui_show(activity_id, shop_id)
  return true
end

function helper._ui_maze_game_main(jump_cfg, ...)
  local activity_id = tonumber(jump_cfg.param[1])
  UIMgr:get_ui("ui_maze_game_main"):ui_show(activity_id)
  return true
end

return helper
