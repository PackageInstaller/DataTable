local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local RECOMMEND_ELEMENT_KEY = "RECOMMEND_ELEMENT_KEY_TEAM"
local CommonDefine = require("cs_share.common_define")
local TEAM_BUDDY_TYPE = CommonDefine.TEAM_BUDDY_TYPE
local FORMATION_TYPE = CommonDefine.FORMATION_TYPE
local Rect = UnityEngine.Rect
local _tinsert = table.insert
local TOWER_TYPE = Config.TOWER_TYPE
local AssetBarView = require("ui.asset_bar.asset_bar")
local FIGHT_TYPE2TOWER = {
  [CommonDefine.CHALLENGE_TYPE.CHALLENGE_RING] = TOWER_TYPE.CHALLENGE_RING,
  [CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE] = TOWER_TYPE.CURSE_RING,
  [CommonDefine.CHALLENGE_TYPE.CUT_GRASS] = TOWER_TYPE.CUT_GRASS
}
local POINT_INFO_CLASS = require("uimodule.chapter.point_info_common")
local ModelRtView = require("ui.model_rt_view.model_rt_view_team")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local DEFAULT_STARTING_POS = CHAPTER_CONFIG.DEFAULT_STARTING_POS
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local TRIGGER_SOUND_TYPE = CHARACTER_CONFIG.TRIGGER_SOUND_TYPE
local team_name_max_len = 8
local TEAM_MAX_POS = 3
local Act_ID = CommonDefine.ACTY_TYPE.BUDDY_TEACH
local MODEL_PARAM = MODEL_CONFIG.UI_TEAM_MODEL_PARAM
local UnityShader = UnityEngine.Shader
local APPLY_CUSTOM_DIST_FOG = UnityShader.PropertyToID("_APPLY_CUSTOM_DIST_FOG")

function ui:ui_finish_load()
  self:set_button("Button_return", function()
    self:on_go_back()
  end)
  self:set_button("BtnMain", function()
    self:on_go_main()
  end)
  self:set_button("Direct", function()
    self:click_direct_btn()
  end)
  for pos = 1, 3 do
    self:set_button("SelectHeroBtn" .. pos, function()
      self:click_hero_btn(pos)
    end)
    self:set_button("HeroClickBtn" .. pos, function()
      self:click_hero_btn(pos)
    end)
  end
  self:set_button("StartFight", function()
    if self.v_is_exit then
      local function cb()
        self:click_return_btn()
      end
      
      Util.show_notify_popup_message(cb, "活动已结束", nil, "确定", nil, nil, true)
      return
    end
    if not self:is_can_fight() then
      return
    end
    self:check_power_and_fight()
  end)
  self:set_button("BtnAssist", function()
    self:click_hero_btn(3, true)
  end)
  self:set_button("BtnResetAssist", function()
    self:update_pos_hero(3, 0, nil, true)
  end)
  self:set_button("QuickTeam", function()
    self:enable_inside_list(true)
  end)
  self.v_buddy_to_fashion_map = {}
  self:register_exist_auto_template(RECOMMEND_ELEMENT_KEY, self.v_uiobjects.EleTem, self.v_uiobjects.EleContent)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_inside_list_view = self:get_panel("inside_list")
  self.v_list_in_eff = Util.get_child_gameobj("Animation/Ani_QuickTeamList_In", self.v_object)
  self.v_list_out_eff = Util.get_child_gameobj("Animation/Ani_QuickTeamList_Out", self.v_object)
end

function ui:on_go_back()
  if SceneMgr:check_main_scene() then
    self:click_return_btn()
    FormationMgr:send_save_fight_team(self.v_fight_team_id, nil, true)
    return
  end
  self:do_exit_tower()
end

function ui:on_go_main()
  FormationMgr:send_save_fight_team(self.v_fight_team_id, nil, true)
  AssistMgr:clear_assist_buddy_info()
  if SceneMgr:check_main_scene() then
    local function sure_cb()
      UIMgr:go_to_main()
      
      UIMgr:clear_all_cache_ui_custom_data()
    end
    
    if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_PONDER then
      Util.show_conform_tip("退出后当前进度将重制，是否退出？", "取消", "确定", nil, sure_cb)
    else
      sure_cb()
    end
    return
  end
  self:do_exit_tower(true)
end

function ui:do_exit_tower(back_to_main)
  local function exit_cb()
    if back_to_main then
      UIMgr:clear_ui_stack()
    end
    Global.scene_mgr:on_enter_main_scene()
  end
  
  TowerMgr:on_exit_tower(exit_cb)
end

function ui:click_return_btn()
  AssistMgr:clear_assist_buddy_info()
  self:ui_hide()
end

function ui:click_direct_btn()
  if self.is_fixed_point then
    Util.show_banner_tip("存在试用角色，预设编队不可用")
    return
  end
  if self:check_is_weekly() then
    Util.show_banner_tip("当前玩法不可用")
    return
  end
  UIMgr:get_ui("uiteam_preset_tips"):ui_show(true, self.v_fight_team_id)
end

function ui:enable_inside_list(is_show)
  if is_show then
    local team_data = {
      formation_type = self.v_formation_type,
      pos_data = UtilTable.copy_table(self.v_pos_data),
      point_id = self.v_point_id,
      node_id = self.v_node_id,
      need_enable_rt_view = true,
      ban_buddys = self.v_ban_buddys,
      fixed_buddys = self.v_fixed_buddys,
      offer_robot_list = self.v_offer_robot_list
    }
    self.v_inside_list_view:set_enable(true, team_data)
    self.v_list_in_eff:SetActive(false)
    self.v_list_in_eff:SetActive(true)
    self:show_queck_team_desc()
  else
    self.v_list_out_eff:SetActive(false)
    self.v_list_out_eff:SetActive(true)
    self:_update_recommend_element()
    self:_init_point_info()
  end
end

function ui:click_hero_btn(pos, is_assist)
  local pos_buddy_data = self.v_pos_data[pos]
  if pos_buddy_data then
    if pos_buddy_data.ban then
      return
    end
    if pos_buddy_data.is_fixed then
      Util.show_banner_tip("无法对系统指定角色进行编辑")
      return
    end
  end
  local team_data = {
    select_pos = pos,
    formation_type = self.v_formation_type,
    pos_data = self.v_pos_data,
    point_id = self.v_point_id,
    node_id = self.v_node_id,
    need_enable_rt_view = true,
    ban_buddys = self.v_ban_buddys,
    fixed_buddys = self.v_fixed_buddys,
    offer_robot_list = self.v_offer_robot_list
  }
  if not is_assist and pos_buddy_data then
    is_assist = self:is_boddy_assist(pos_buddy_data.buddy_id)
  end
  if is_assist then
    UIMgr:get_ui("char_assist"):ui_show(team_data, true, self.v_ban_buddys, nil, nil, nil, nil, true)
    self:set_model_disable()
  else
    local function cb()
      self:set_model_disable()
    end
    
    UIMgr:remove_stace_by_ui_name("character")
    UIMgr:remove_stace_by_ui_name("character_enter")
    UIMgr:get_ui("character_enter"):ui_show(team_data, cb)
  end
  if not SceneMgr:check_main_scene() then
    self:change_ui_plane_distance(false)
  end
end

function ui:check_power_and_fight()
  if self.v_do_fight_lock then
    return
  end
  if not self:check_fight() then
    return
  end
  if self.v_point_recommend_power and self.v_point_recommend_power > 0 then
    local tips
    local rate = self.v_point_recommend_power - self.v_team_max_power
    local interval_cfg = ShareRes.create("combat_recommend.combat_recommend_interval")
    for i, cfg in ipairs(interval_cfg) do
      if self.v_point_recommend_power >= cfg.CombatLeft and self.v_point_recommend_power <= cfg.CombatRight then
        if not (rate < cfg.Range[1]) then
          if rate < cfg.Range[2] then
            tips = cfg.Text[1]
            break
          end
          tips = cfg.Text[2]
        end
        break
      end
    end
    if tips then
      UIMgr:get_ui("uinotice_tips"):ui_show(function()
        self:do_fight()
      end, nil, tips)
      return
    end
  end
  local need_check_up_more_buddy = FormationMgr:if_need_check_up_more_buddy()
  if need_check_up_more_buddy then
    local cur_num, empty_num = 0, 0
    for _, data in ipairs(self.v_pos_data) do
      if 0 ~= data.buddy_id then
        cur_num = cur_num + 1
      elseif not data.ban then
        empty_num = empty_num + 1
      end
    end
    if empty_num > 0 then
      local robot_num = self.v_offer_robot_list and #self.v_offer_robot_list or 0
      local own_list = CharacterMgr:get_buddy_map()
      local own_num = robot_num
      for _, v in pairs(own_list) do
        if not self:is_buddy_ban(v.id) then
          own_num = own_num + 1
          if own_num >= 3 then
            break
          end
        end
      end
      if cur_num < own_num then
        local uinotice_tips = UIMgr:get_ui("uinotice_tips")
        uinotice_tips:ui_show(function()
          self:do_fight()
        end, nil, "检测到编队未满编，\n是否进入战斗？")
        uinotice_tips:set_ex_param({
          tog_text = "离线前不再弹出",
          tog_on_cb = function()
            FormationMgr:set_need_check_up_more_buddy(false)
          end
        })
        return
      end
    end
  end
  self:do_fight()
end

function ui:do_fight()
  self.v_do_fight_lock = true
  SceneMgr:set_heros_team_pos(self.v_pos_data)
  if self:check_is_long_chapter() and self.v_floor_num then
    self:tp_next_floor()
  elseif self:check_is_weekly() then
    self:start_fight_with_weekly()
  else
    self:start_fight()
  end
  local fight_type = self.v_fight_type
  local is_long_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
  local is_chapter = fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
  if is_long_chapter or is_chapter then
    ChapterMgr:set_record_select_chapter_id()
    ChapterMgr:set_record_select_param_id()
  end
end

function ui:is_can_fight()
  local back_type = Config.BACK_TYPE.NONE
  if self.v_fight_type == Config.CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
    back_type = TimeLimitedActMgr:get_is_can_fight(self.v_chapter_id, self.v_point_id)
  end
  if back_type == Config.BACK_TYPE.GO_TO_MAIN then
    local function confirmCb()
      UIMgr:go_to_main()
    end
    
    Util.show_notify_popup_message(confirmCb, "活动已结束", nil, "确定", nil, nil, true)
  elseif back_type == Config.BACK_TYPE.GO_TO_BACK then
    Util.show_message_tip("关卡已刷新，请返回活动主界面重置")
  end
  return back_type == Config.BACK_TYPE.NONE
end

function ui:start_fight()
  local tower_type = FIGHT_TYPE2TOWER[self.v_fight_type]
  
  local function callback(ok)
    if not ok then
      return
    end
    if TowerMgr then
      local fight_team_send_data = FormationMgr:get_fight_team_send_data(self.v_fight_team_id)
      TowerMgr:on_new_enter_tower(self.v_fight_type, self.v_point_id, self.v_chapter_id or self.v_floor_num, tower_type, fight_team_send_data, self.v_node_id, nil, self.v_args)
    end
  end
  
  FormationMgr:change_fight_team(self.v_fight_team_id, self.v_pos_data, self.v_cur_starting_pos)
  FormationMgr:send_save_fight_team(self.v_fight_team_id, callback)
  UIMgr:remove_stace_by_ui_name("weekly_battle_detail")
  UIMgr:remove_stace_by_ui_name("choose_genres_view")
  UIMgr:remove_stace_by_ui_name("endless_prewar")
  UIMgr:remove_stace_by_ui_name("uimain_close_new")
end

function ui:start_fight_with_weekly()
  local rune_info = WeeklyMgr:get_weekly_buddy_list(self.v_fight_type, self.v_point_id, true)
  
  local function save_cb(ok)
    if not ok then
      return
    end
    self:ui_hide()
    UIMgr:get_ui("weekly_pvp_stage"):ui_show()
  end
  
  WeeklyMgr:request_set_week_acty_pvp_formation(rune_info, save_cb)
end

function ui:check_fight()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_val = point_cfg.FightCost[2]
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.CHAPTER then
    local first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
    if first_fight then
      cost_val = point_cfg.FightCost[1]
    end
    local point_data = ChapterMgr:get_point_data_by_id(self.v_chapter_id, self.v_point_id)
    if not point_data then
      Util.show_message_tip(2043)
      return
    end
    local daily_fight_Num = point_cfg.FightNum
    local cur_fight_num = point_data.buy_challenge_cnt + daily_fight_Num
    if cur_fight_num <= point_data.daily_challenge_cnt then
      Util.show_message_tip(1058)
      self:buy_challenge_num()
      return
    end
  elseif self.v_fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    cost_val = Util.get_buddy_teach_fight_cost(self.v_buddy_id, self.v_point_id, self.v_floor_num)
  end
  if not self:check_enter_fight_limit(true) then
    return
  end
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  if cost_val > cur_val then
    Util.show_message_tip(2216)
    return
  end
  local min_fight_num = point_cfg.MinFightCount
  local cur_num = 0
  for _, data in ipairs(self.v_pos_data) do
    if 0 ~= data.buddy_id then
      cur_num = cur_num + 1
    end
  end
  if min_fight_num > cur_num then
    Util.show_message_tip(2318, min_fight_num)
    return
  end
  if 0 == self.v_pos_data[self.v_cur_starting_pos].buddy_id then
    Util.show_message_tip(2217)
    return
  end
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER and not self.v_node_id then
    Log.Error("节点id为空，请检查错误", debug.traceback())
    return
  end
  return true
end

function ui:buy_challenge_num()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_id = point_cfg.BuyFightNumCost[1]
  local cost_num = point_cfg.BuyFightNumCost[2]
  local item_cfg = ShareRes.get_item_cfg(cost_id)
  
  local function sure_callback()
    local item_num = BagMgr:get_item_num(cost_id)
    if item_num < cost_num then
      Util.show_message_tip(2115)
      return
    end
    ChapterMgr:buy_challenge_num(self.v_chapter_id, self.v_point_id)
  end
  
  local tip = string.format("是否使用%s增加1次挑战次数", item_cfg.Name .. "：" .. cost_num)
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip)
end

function ui:check_fixed_team()
  return self.is_fixed_point
end

function ui:ui_before_show()
  self.v_hero_viewort_rect = {}
  local hero_content = self.v_uiobjects.Hero
  local content_pos = hero_content.transform.localPosition
  local canvas_size = Util.get_rect_transform(nil, self.canvas.gameObject).sizeDelta
  local x, y, w, h
  for index = 1, 3 do
    local hero_ui = self.v_uicompents["HeroPos" .. index .. "_rect"]
    local hero_pos = hero_ui.transform.localPosition
    local hero_rect = Util.get_rect_transform(nil, hero_ui).rect
    x = (content_pos.x + hero_pos.x) / canvas_size.x + 0.5
    y = (content_pos.y + hero_pos.y) / canvas_size.y + 0.5
    w = hero_rect.width / canvas_size.x
    h = hero_rect.height / canvas_size.y
    self.v_hero_viewort_rect[index] = Rect(x, y, w, h)
  end
end

function ui:ui_after_show(chapter_id, point_id, fight_type, buddy_id, node_id, floor_num, args)
  if self.v_chapter_id ~= chapter_id or self.v_point_id ~= point_id or self.v_node_id ~= node_id then
    self:ui_hide()
    UIMgr:get_ui("team"):ui_show(chapter_id, point_id, fight_type, buddy_id, node_id, floor_num)
    return
  end
  self.v_inside_list_view:set_enable(false)
  self:enable_inside_list(fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER)
  self:set_model_enable()
end

function ui:ui_on_show(chapter_id, point_id, fight_type, buddy_id, node_id, floor_num, args)
  UnityShader.SetGlobalFloat(APPLY_CUSTOM_DIST_FOG, 1)
  AssistMgr:try_hide_add_assist_friend_tips()
  AssistMgr:clear_assist_buddy_info()
  FixedBuddyMgr:clear_cache_data()
  self:set_fight_show(false)
  local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
  local ring_cfg = ring_id and ShareRes.get_curse_ring_config(ring_id)
  local id_list = {
    Config.PLAYER_SP_ITEMID
  }
  if ring_cfg and ring_cfg.IsQuickFight then
    table.insert(id_list, 1, Config.CURSE_COST_ID)
  end
  self.v_asset_bar:reset_by_id_list(id_list)
  self.v_asset_bar:on_create()
  if not self.v_model_view then
    self:change_bg_state(true)
    self.v_model_view = ModelRtView:new(function()
      self:change_bg_state(false)
    end, true, self.v_hero_viewort_rect)
  end
  self.v_do_fight_lock = false
  self.is_need_reset_weekly_pvp_data = true
  self.v_dont_revert_team_when_remove_assist = false
  self.v_ban_buddys = ChapterMgr:get_floor_ban_buddy_map(point_id, node_id, floor_num)
  self.v_fixed_buddys = ChapterMgr:get_floor_fixed_buddy_map(point_id, node_id, floor_num)
  self.v_offer_robot_list = ChapterMgr:get_team_offer_robot_list(point_id, node_id, floor_num)
  self.is_fixed_point = ChapterMgr:check_fixed_team_by_point_id(point_id, node_id, floor_num)
  self.v_enter_fight_limit = ChapterMgr:get_enter_fight_limit(point_id, node_id, floor_num)
  self.v_chapter_id = chapter_id
  self.v_point_id = point_id
  self.v_buddy_id = buddy_id
  self.v_node_id = node_id
  self.v_floor_num = floor_num
  self.v_args = args
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_node_cfg = ShareRes.get_chapter_node_cfg(self.v_node_id)
  if self.v_point_cfg and self.v_point_cfg.FightType > 0 then
    self.v_fight_type = self.v_point_cfg.FightType
  else
    self.v_fight_type = fight_type or CommonDefine.CHALLENGE_TYPE.CHAPTER
  end
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    self.v_floor_num = self.v_floor_num or 1
  end
  self.v_formation_type = CommonDefine.CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  self.v_fight_team_id = self.v_point_cfg.FightTeamId
  self.can_use_assist = self.v_point_cfg.IsAssistBuddy
  self.v_starting_toggle_tab = nil
  self.v_model_idx_list = {}
  self:load_fight_team_to_view()
  self:init_starting_toggle()
  self:_update_recommend_element()
  self:_update_cost_info()
  self:_init_point_info()
  self:_refresh_btns()
  self:register_event()
  if not SceneMgr:check_main_scene() and not Util.is_destroy(Global.hero) then
    Global.hero:set_obj_enable(false)
  end
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_PRE_TP_ROOM, self._on_pre_tp_room, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self._update_cost_info, self)
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.check_and_refresh_weapon, self)
  self:bind_auto_mq(Const.MSG_ON_WEAPEN_FASHION_CHANGE, self.refresh_weapon_fashion, self)
  self:bind_auto_mq(Const.MSG_ON_TEAM_CHANGE, self._apply_prefab_to_fight_team, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self._response_show_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_CHECK_EXIT_TEAM_VIEW, self._check_team_view_exit, self)
  MsgGame:mq_publish2(Const.MSG_ON_SETTLEMENT_WIN_OPEN)
end

function ui:_check_team_view_exit(msg)
  if not msg or msg.mm_x ~= self.v_point_id then
    return
  end
  self.v_is_exit = true
end

function ui:load_fight_team_to_view()
  AssistMgr:clear_assist_buddy_info()
  local starting_pos, pos_data = DEFAULT_STARTING_POS
  if self:check_is_weekly() then
    pos_data = {}
    local weekly_pos_data = WeeklyMgr:get_hurdle_team_data(self.v_fight_type, self.v_point_id, true)
    if weekly_pos_data then
      for i, v in pairs(weekly_pos_data) do
        local pos = v.pos or v.buddy_pos
        pos_data[i] = {
          buddy_type = TEAM_BUDDY_TYPE.PLAYER,
          buddy_id = v.buddy_id,
          pos = pos,
          ban = false
        }
        if v.is_first_pos then
          starting_pos = pos
        end
      end
    end
  elseif self:check_is_minesweeper() then
    pos_data = {}
  else
    local _pos_data, replaced_by_fixed, remove_by_pos_ban, remove_by_id_ban = FormationMgr:get_correct_fight_team(self.v_point_id, self.v_node_id, self.v_floor_num)
    if replaced_by_fixed or remove_by_pos_ban or remove_by_id_ban then
      Util.show_banner_tip("关卡编队已自动调整")
    end
    pos_data = _pos_data
    starting_pos = FormationMgr:get_fight_team_start_pos(self.v_fight_team_id)
  end
  self.v_pos_data = pos_data
  for i = 1, 3 do
    if not self.v_pos_data[i] then
      self.v_pos_data[i] = {
        buddy_type = TEAM_BUDDY_TYPE.PLAYER,
        buddy_id = 0,
        pos = i
      }
    end
  end
  local fixed_starting_pos = FormationMgr:get_team_fixed_starting_pos(self.v_point_id, self.v_node_id, self.v_floor_num)
  self.v_fixed_starting_pos = fixed_starting_pos
  self.v_cur_starting_pos = fixed_starting_pos and fixed_starting_pos or starting_pos
  if self.v_starting_toggle_tab then
    self.v_starting_toggle_tab:set_toggle_by_index(self.v_cur_starting_pos)
  end
  for pos, data in ipairs(pos_data) do
    local model_idx = self.v_model_idx_list[pos]
    if model_idx then
      self.v_model_view:remove_npc_by_index(model_idx)
      self.v_model_idx_list[pos] = nil
    end
  end
  for pos, data in ipairs(pos_data) do
    if data.buddy_type == TEAM_BUDDY_TYPE.HELP_FIGHT then
      data.buddy_id = 0
    end
    self:_update_pos(pos, data.buddy_id, data.robot_id)
  end
  self:update_assist_btn()
  self:update_fight_val()
  self.v_uiobjects.FirstLock:SetActive(self.v_fixed_starting_pos ~= nil)
  self:check_starting_empty()
end

function ui:check_starting_empty()
  if not self.v_starting_toggle_tab then
    return
  end
  if self.v_fixed_starting_pos then
    self.v_starting_toggle_tab:set_toggle_by_index(self.v_fixed_starting_pos)
    return
  end
  if self:is_pos_empty(self.v_cur_starting_pos) then
    for pos, data in ipairs(self.v_pos_data) do
      if 0 ~= data.buddy_id then
        self.v_cur_starting_pos = pos
        self.v_starting_toggle_tab:set_toggle_by_index(self.v_cur_starting_pos)
        return
      end
    end
    self.v_cur_starting_pos = -1
    self.v_starting_toggle_tab:set_toggle_by_index(-1)
  else
    self.v_starting_toggle_tab:set_toggle_by_index(self.v_cur_starting_pos)
  end
end

function ui:is_pos_empty(idx)
  return not idx or -1 == idx or not self.v_pos_data or not self.v_pos_data[idx] or 0 == self.v_pos_data[idx].buddy_id
end

function ui:init_starting_toggle()
  local pages = {
    self.v_uicompents.First1_tog,
    self.v_uicompents.First2_tog,
    self.v_uicompents.First3_tog
  }
  self.v_toggle_list = pages
  self.v_starting_toggle_tab = ToggleTab:new(self)
  self.v_starting_toggle_tab:init_by_toggles(pages, function(idx)
    if -1 == idx then
      return
    end
    if self.v_fixed_starting_pos and self.v_fixed_starting_pos ~= idx then
      Util.show_banner_tip("关卡锁定首发角色")
      self.v_starting_toggle_tab:set_toggle_by_index(self.v_fixed_starting_pos)
      return
    end
    if self.v_cur_starting_pos ~= idx and self:is_pos_empty(idx) then
      Util.show_banner_tip("空位置不可设为首发")
      self.v_starting_toggle_tab:set_toggle_by_index(self.v_cur_starting_pos)
      return
    end
    if self:is_pos_empty(idx) and self.v_fixed_starting_pos ~= idx then
      self.v_starting_toggle_tab:set_toggle_by_index(-1)
      return
    end
    self:click_starting_toggle(idx)
    self:update_toggle_alpha(idx)
  end, -1, false)
  self:check_starting_empty()
end

function ui:_apply_prefab_to_fight_team(msg)
  if self.v_is_fixed or self:check_is_weekly() then
    return
  end
  AssistMgr:clear_assist_buddy_info()
  local prefab_team_id = msg.mm_x
  FormationMgr:apply_prefab_to_fight_team(prefab_team_id, self.v_fight_team_id)
  self:load_fight_team_to_view()
end

function ui:update_toggle_alpha(select_index)
  for index, toggle in ipairs(self.v_toggle_list) do
    local color_a = index == select_index and 255 or 153
    color_a = color_a / 255
    local toggle_img = Util.get_image(nil, toggle.gameObject)
    local img_color = toggle_img.color
    img_color.a = color_a
    toggle_img.color = img_color
    local text = Util.get_text("Text", toggle.gameObject)
    local text_color = text.color
    text_color.a = color_a
    text.color = text_color
  end
end

function ui:click_starting_toggle(idx)
  for index = 1, 3 do
    self.v_uicompents["StartingTag" .. index .. "_img"]:SetActive(index == idx)
  end
  self.v_cur_starting_pos = idx
  if self:check_is_weekly() then
    WeeklyMgr:update_weekly_buddy_team_first_pos(idx, self.v_fight_type, self.v_point_id, true)
  end
  FormationMgr:set_fight_start_pos(self.v_fight_team_id, self.v_point_id, idx)
end

function ui:get_point_id()
  return self.v_point_id
end

function ui:update_pos_hero(pos, buddy_id, robot_id, from_assist)
  if from_assist then
    if 0 == buddy_id then
      AssistMgr:clear_assist_buddy_info()
    end
  else
    if self:is_boddy_assist(buddy_id) then
      AssistMgr:clear_assist_buddy_info()
    end
    for old_pos, data in pairs(self.v_pos_data) do
      if data.buddy_id == buddy_id then
        self:_remove_npc_by_pos(old_pos)
        self:_update_pos(old_pos, 0)
      end
    end
  end
  if 0 ~= pos then
    self:_remove_npc_by_pos(pos)
    self:_update_pos(pos, buddy_id, robot_id)
  end
  self:update_assist_btn()
  self:update_fight_val()
  self:check_starting_empty()
end

function ui:_remove_npc_by_pos(pos)
  if self.v_model_idx_list[pos] then
    local idx = self.v_model_idx_list[pos]
    self.v_model_view:remove_npc_by_index(idx)
    self.v_model_idx_list[pos] = nil
  end
end

function ui:_update_pos(pos, buddy_id, robot_id)
  self:_update_team_data(pos, buddy_id, robot_id)
  self:_load_npc_by_pos_data(pos, buddy_id, robot_id)
  self:_record_robot(buddy_id, robot_id)
  self:_refresh_pos_ui(pos, buddy_id, robot_id)
end

function ui:_update_team_data(pos, buddy_id, robot_id)
  if 0 == buddy_id then
    local is_assist_before = self:is_boddy_assist(self.v_pos_data[pos])
    if is_assist_before then
      AssistMgr:clear_assist_buddy_info()
    end
  else
    local buddy_type = TEAM_BUDDY_TYPE.PLAYER
    local is_assist = self:is_boddy_assist(buddy_id)
    local is_robot = robot_id and 0 ~= robot_id
    if is_assist then
      buddy_type = TEAM_BUDDY_TYPE.HELP_FIGHT
    elseif is_robot then
      buddy_type = TEAM_BUDDY_TYPE.ROBOT
    end
    self.v_pos_data[pos].buddy_type = buddy_type
  end
  self.v_pos_data[pos].buddy_id = buddy_id
  self.v_pos_data[pos].robot_id = robot_id
  if self.v_formation_type == FORMATION_TYPE.WEEK_ACTY_PVP_TEAM then
    WeeklyMgr:update_weekly_team_data(self.v_point_id, pos, buddy_id, true, true)
  else
    FormationMgr:change_fight_team(self.v_fight_team_id, self.v_pos_data, self.v_cur_starting_pos)
  end
end

function ui:_load_npc_by_pos_data(pos, buddy_id, robot_id)
  if 0 == buddy_id then
    return
  end
  local buddy_type = TEAM_BUDDY_TYPE.PLAYER
  local is_assist = self:is_boddy_assist(buddy_id)
  local is_robot = robot_id and 0 ~= robot_id
  if is_assist then
    buddy_type = TEAM_BUDDY_TYPE.HELP_FIGHT
  elseif is_robot then
    buddy_type = TEAM_BUDDY_TYPE.ROBOT
  end
  local model_id, fashion_id
  if buddy_type == TEAM_BUDDY_TYPE.ROBOT then
    model_id = FixedBuddyMgr:get_fashion_model_id(robot_id)
    fashion_id = FixedBuddyMgr:get_fashion_id(robot_id)
  elseif buddy_type == TEAM_BUDDY_TYPE.HELP_FIGHT then
    model_id, fashion_id = self:get_boddy_assist_fashion_model(buddy_id)
  else
    model_id = FashionMgr:get_fashion_model_id(buddy_id)
    fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  end
  self.v_buddy_to_fashion_map[buddy_id] = model_id
  local model_idx = self.v_model_idx_list[pos]
  if model_idx then
    self.v_model_view:remove_npc_by_index(model_idx)
  end
  local new_model_idx = self:load_char_model(model_id, buddy_id, nil, nil, nil, nil, pos, robot_id, fashion_id)
  self.v_model_idx_list[pos] = new_model_idx
end

function ui:_record_robot(buddy_id, robot_id)
  if buddy_id then
    FixedBuddyMgr:set_cache_fixed_data(buddy_id, robot_id)
    local buddy_assist = self:is_boddy_assist(buddy_id)
    CharacterMgr:record_team_trail_info(buddy_id, robot_id, robot_id and 0 ~= robot_id, buddy_assist)
  end
end

function ui:_refresh_pos_ui(pos, buddy_id, robot_id)
  local show = 0 ~= buddy_id
  self.v_uiobjects["HeroClickBtn" .. pos]:SetActive(show)
  self.v_uiobjects["HeroInfo" .. pos]:SetActive(show)
  self.v_uiobjects["SelectHeroBtn" .. pos]:SetActive(not show)
  if not show then
    local ban_pos = self.v_pos_data[pos].ban == true
    self.v_uiobjects["LockIcon" .. pos]:SetActiveEx(ban_pos)
    self.v_uiobjects["SelectIcon" .. pos]:SetActiveEx(not ban_pos)
    return
  end
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  local name_txt = self.v_uicompents["HeroName" .. pos .. "_txt"]
  name_txt.text = buddy_cfg.Name
  local element_cfg = ShareRes.create("buddy.buddy_element", buddy_cfg.Element)
  local icon = self.v_uicompents["HeroType" .. pos .. "_img"]
  ResMgr:load_set_icon(icon, element_cfg.ElementIconPath)
  local is_assist = self:is_boddy_assist(buddy_id)
  self.v_uiobjects["AssistTip" .. pos]:SetActive(is_assist)
  self.v_uiobjects["Trial" .. pos]:SetActiveEx(robot_id and 0 ~= robot_id)
  self.v_uiobjects["StartingTag" .. pos]:SetActiveEx(self.v_cur_starting_pos == pos)
  local lock_obj = self.v_uiobjects["HeroLock" .. pos]
  if lock_obj then
    lock_obj:SetActiveEx(true == self.v_pos_data[pos].is_fixed)
  end
end

function ui:_update_recommend_element()
  local point_cfg = self.v_point_cfg
  local node_cfg_desc = self.v_node_cfg and self.v_node_cfg.TeamDesc
  local show_desc = self:check_is_weekly() or node_cfg_desc or 1 == point_cfg.ShowDesc_Team and point_cfg.PointDesc ~= nil
  self.v_uiobjects.StageDesc:SetActive(show_desc)
  if show_desc then
    local name_str, desc_str
    if self:check_is_weekly() then
      local episode_cfg = ShareRes.get_weekly_pvp_epi_cfg(self.v_point_id)
      if not episode_cfg then
        Log.Error("获取pvp关卡信息失败, id :", self.v_point_id)
        return
      end
      name_str = WeeklyMgr:get_pvp_team_ui_name(self.v_point_id)
      local epi_group_id = WeeklyMgr:get_cur_stage_episode_group_id()
      local group_cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(epi_group_id)
      desc_str = group_cfg.StageDesc
    else
      name_str = point_cfg.PointName
      desc_str = node_cfg_desc or point_cfg.PointDesc
    end
    self.v_uicompents.Title_txt.text = name_str
    self.v_uicompents.Describe_txt.text = desc_str
  end
  local elements = point_cfg.RecommendElement
  self:give_back_auto_cache(RECOMMEND_ELEMENT_KEY)
  if elements and next(elements) then
    self.v_uiobjects.RecommendEle:SetActive(true)
    for _, element_id in ipairs(elements) do
      local obj = self:get_auto_cache(RECOMMEND_ELEMENT_KEY)
      local icon = Util.get_image("EleIcon", obj)
      local element_cfg = ShareRes.get_element_cfg(element_id)
      ResMgr:load_set_icon(icon, element_cfg.ElementIconPath)
    end
  else
    self.v_uiobjects.RecommendEle:SetActive(false)
  end
end

function ui:_update_cost_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_val = point_cfg.FightCost[1]
  local first_fight = false
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    first_fight = not ActivityMgr:invoke(Act_ID, "get_floor_has_passed", self.v_buddy_id, self.v_point_id)
    cost_val = Util.get_buddy_teach_fight_cost(self.v_buddy_id, self.v_point_id, self.v_floor_num)
  elseif self.v_chapter_id then
    first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
  end
  if not first_fight then
    cost_val = point_cfg.FightCost[2]
  end
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL then
    cost_val = point_cfg.FightCost[2] * ChapterMaterialMgr:get_curr_multiple_num()
  elseif self.v_fight_type == CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
    cost_val = point_cfg.FightCost[1] * TimeLimitedActMgr:get_fight_challenge_multiple()
  end
  local set_icon_suc = false
  if self.v_fight_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    local ring_id = ShareRes.get_ring_id_by_point_id(self.v_point_id)
    local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
    if ring_cfg and not ring_cfg.FastChallengeId then
      cost_val = ring_cfg.ConsumeCount * FateBookMgr:get_quick_fight_challenge_multiple()
      if Util.is_more_than_zero(ring_cfg.ConsumeId) then
        local path = ShareRes.get_item_icon_path(ring_cfg.ConsumeId)
        ResMgr:load_set_icon(self.v_uicompents.CostIcon_img, path)
        set_icon_suc = true
      end
    end
  end
  if not set_icon_suc then
    local path = ShareRes.get_item_icon_path(Config.PLAYER_SP_ITEMID)
    ResMgr:load_set_icon(self.v_uicompents.CostIcon_img, path)
  end
  self.v_uicompents.CostAmount_txt.text = cost_val
end

function ui:_init_point_info()
  self:release_point_info_obj()
  if self.v_point_cfg.PointDesc ~= nil then
    return
  end
  local path = Path.get_language_full_prefab_path(CHAPTER_CONFIG.POINT_INFO_RES_PATH)
  local point_info_obj = ResMgr:load_gameobj(path)
  point_info_obj.transform:SetParent(self.v_uiobjects.InfoParent.transform, false)
  self.v_point_info_obj = point_info_obj
  self.v_point_info_lua_obj = POINT_INFO_CLASS:ui_wrap_ex(self, point_info_obj, false)
  self.v_point_info_lua_obj:set_enable(true, self.v_chapter_id, self.v_point_id)
  self.v_point_info_lua_obj:update_info_btn_visible(true)
  self.v_point_info_lua_obj:set_enable(false)
end

function ui:release_point_info_obj()
  if self.v_point_info_obj then
    ResMgr:destroy_gameobj(self.v_point_info_obj)
    self.v_point_info_obj = nil
  end
  if self.v_point_info_lua_obj then
    self.v_point_info_lua_obj:set_enable(false)
    self.v_point_info_lua_obj:ui_destroy()
    self.v_point_info_lua_obj = nil
  end
end

function ui:_refresh_btns()
  self.v_uiobjects.Cost:SetActive(self.v_node_id == nil)
  self.v_uiobjects.TeamNow:SetActive(not self:check_is_weekly() and not self:check_is_minesweeper())
end

function ui:ui_on_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:ui_on_hide()
  if SceneMgr and SceneMgr:check_main_scene() then
    UnityShader.SetGlobalFloat(APPLY_CUSTOM_DIST_FOG, 1)
  else
    UIMgr:revert_game_raw_img_active()
    UnityShader.SetGlobalFloat(APPLY_CUSTOM_DIST_FOG, 0)
  end
  self.v_is_init = true
  self:release_point_info_obj()
  self.v_pos_data = {}
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
  self.v_model_idx_list = nil
  self.v_select_team_id = nil
  self.v_cur_starting_pos = nil
  self.v_fixed_starting_pos = nil
  self.v_floor_num = nil
  self.v_node_id = nil
  self.v_is_exit = nil
  self.v_asset_bar:on_hide()
  if self:check_is_weekly() then
    self:reset_weekly_temp_data()
  end
  self:set_fight_show(true)
  if not SceneMgr:check_main_scene() and not Util.is_destroy(Global.hero) then
    Global.hero:set_obj_enable(false)
  end
end

function ui:ui_on_destroy()
  AssistMgr:clear_assist_buddy_info()
  self.v_asset_bar:on_destory()
end

function ui:reset_weekly_temp_data()
  if self:check_is_weekly() == true and true == self.is_need_reset_weekly_pvp_data then
    WeeklyMgr:reset_pvp_temp_hurdle_data()
  end
end

function ui:refresh_view_with_char_enter_view_hide()
  if not SceneMgr:check_main_scene() then
    self:change_ui_plane_distance(true)
    UIMgr:force_close_game_raw_img()
  end
  self:update_fight_val()
end

function ui:update_assist_btn()
  self.can_use_assist = self.v_point_cfg.IsAssistBuddy and not self.v_pos_data[3].ban
  local sys_open = AssistMgr:get_sys_open()
  local is_anybody_boddy_assist = self:is_anybody_boddy_assist()
  self.v_uiobjects.BtnAssist:SetActive(sys_open and self.can_use_assist and not is_anybody_boddy_assist)
  self.v_uiobjects.BtnResetAssist:SetActive(is_anybody_boddy_assist)
end

function ui:update_fight_val()
  local is_anybody_boddy_assist = self:is_anybody_boddy_assist()
  local max_zhan_li, temp_zhan_li = 0, 0
  local buddy_info, pos
  for _, data in pairs(self.v_pos_data) do
    pos = data.pos or data.buddy_pos
    if 3 == pos and is_anybody_boddy_assist then
      buddy_info = AssistMgr:get_assist_buddy_info()
    elseif data.robot_id then
      buddy_info = FixedBuddyMgr:get_fixed_buddy_info(data.robot_id)
    else
      buddy_info = CharacterMgr:get_buddy_by_id(data.buddy_id)
    end
    if buddy_info then
      temp_zhan_li = buddy_info.power or 0
      max_zhan_li = max_zhan_li < temp_zhan_li and temp_zhan_li or max_zhan_li
    end
    local zhan_li_txt = self.v_uicompents["ZhanliNum" .. pos .. "_txt"]
    zhan_li_txt.text = temp_zhan_li
  end
  self.v_uicompents.ZhanliNow_txt.text = max_zhan_li
  local cfg, point_recommend_power
  if self.v_node_id then
    cfg = ShareRes.get_chapter_node_cfg(self.v_node_id)
    point_recommend_power = cfg.RecomFightVal
  end
  if not point_recommend_power then
    cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
    point_recommend_power = cfg.RecomFightVal
  end
  self.v_uicompents.ZhanliNeed_txt.text = point_recommend_power or 0
  self.v_uiobjects.ZhanliNeedBg:SetActive(point_recommend_power >= 0)
  self.v_team_max_power = max_zhan_li
  self.v_point_recommend_power = point_recommend_power
  self:check_enter_fight_limit()
end

function ui:load_char_model(model_id, npc_id, is_reload, npc_param, hide_weapon, cb, team_pos, robot_id, fashion_id)
  local function load_cb()
    if cb then
      cb()
    end
    self.v_model_view:hide_model_node(false)
    self.v_model_view:set_view_param(npc_id, team_pos, fashion_id)
  end
  
  local use_weapon_res, use_weapon_id = self:get_boddy_assist_weapon(npc_id)
  local params = {
    model_id = model_id,
    npc_id = npc_id,
    is_reload = is_reload,
    hide_weapon = hide_weapon,
    cb = load_cb,
    team_pos = team_pos,
    fixed_id = robot_id,
    use_weapon_id = use_weapon_id,
    use_weapon_res = use_weapon_res
  }
  local new_model_idx = self.v_model_view:load_npc(params)
  return new_model_idx
end

function ui:random_play_buddy_sound()
  local buddy_list = {}
  for _, data in pairs(self.v_pos_data) do
    if 0 ~= data.buddy_id then
      _tinsert(buddy_list, data.buddy_id)
    end
  end
  if #buddy_list <= 0 then
    return
  end
  local buddy_id = buddy_list[math.random(1, #buddy_list)]
  CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.GOTO_TEAM, buddy_id)
end

function ui:edit_formation_name(obj)
  local input = Util.get_component(nil, obj, UnityEngine.UI.InputField)
  self.v_uicompents.InputMask_img.gameObject:SetActive(true)
  input:ActivateInputField()
end

function ui:_on_check_input_len(obj)
  local input = Util.get_component(nil, obj, UnityEngine.UI.InputField)
  local len = Util.get_string_len(input.text)
  if len > team_name_max_len then
    input.text = self.v_input_team_name
    return
  end
  self.v_input_team_name = input.text
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_chapter_id, self.v_point_id, self.v_fight_type, self.v_buddy_id, self.v_node_id, self.v_floor_num
end

function ui:set_model_enable()
  if self.v_model_view and not self.v_model_view:is_visible() then
    self.v_model_view:set_visible(true)
    self:change_bg_state(false)
    local buddy_id, model_id, is_assist, is_robot
    for pos, data in pairs(self.v_pos_data) do
      buddy_id = data.buddy_id
      is_assist = self:is_boddy_assist(buddy_id)
      is_robot = data.robot_id and 0 ~= data.robot_id
      if is_robot then
        model_id = FixedBuddyMgr:get_fashion_model_id(data.robot_id)
      elseif is_assist then
        model_id = self:get_boddy_assist_fashion_model(buddy_id)
      else
        model_id = FashionMgr:get_fashion_model_id(buddy_id)
      end
      if self.v_buddy_to_fashion_map[buddy_id] ~= model_id then
        self:_load_npc_by_pos_data(pos, buddy_id)
        self.v_buddy_to_fashion_map[buddy_id] = model_id
      end
    end
  end
end

function ui:set_model_disable()
  if self.v_model_view then
    self.v_model_view:set_visible(false)
  end
end

function ui:_response_show_ui_event(msg)
  if nil == msg then
    return
  end
  local show_ui_name = msg.mm_obj
  if show_ui_name == self.v_ui_name then
    Global.sound_mgr:set_bgm_volume(nil, 1, 1)
    self:set_model_enable()
  end
end

function ui:change_bg_state(is_on)
  self.v_uiobjects.FullScreenBackground:SetActive(is_on)
end

function ui:check_is_weekly()
  if WeeklyMgr:check_fight_type_is_pvp_weekly(self.v_fight_type) == true then
    return true
  end
  return false
end

function ui:check_is_minesweeper()
  return self.v_fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER
end

function ui:check_is_long_chapter()
  return self.v_fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
end

function ui:tp_next_floor()
  local function callback(ok)
    if not ok then
      Log.Error("进入塔失败")
      
      return
    end
    local fight_team_send_data = FormationMgr:get_fight_team_send_data(self.v_fight_team_id, nil, true)
    local tower = TowerMgr:get_tower()
    if tower then
      tower:on_node_tp_next_floor(self.v_floor_num, fight_team_send_data)
    else
      Log.Error("塔不存在")
    end
  end
  
  local fight_team_send_data = FormationMgr:get_fight_team_send_data(self.v_fight_team_id, nil, true)
  FormationMgr:change_fight_team(self.v_fight_team_id, fight_team_send_data.buddys, self.v_cur_starting_pos)
  FormationMgr:send_save_fight_team(self.v_fight_team_id, callback)
end

function ui:set_fight_show(is_show)
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    local msg = {
      mm_x = "fight",
      mm_y = "Main",
      mm_obj = is_show
    }
    fight:on_set_uiobject_visible(msg)
  end
end

function ui:_on_pre_tp_room(msg)
  if TowerMgr and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    self:ui_hide()
  end
end

function ui:change_ui_plane_distance(is_visible)
  local canvas = self:get_canvas()
  canvas.planeDistance = is_visible and 100 or 0
  local graph_ray_com = Util.get_component(nil, canvas, UnityEngine.UI.GraphicRaycaster)
  if graph_ray_com then
    graph_ray_com.enabled = is_visible
  end
end

function ui:is_anybody_boddy_assist()
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_info()
  if not assist_info then
    return
  end
  for pos, data in ipairs(self.v_pos_data) do
    if 0 ~= data.buddy_id and data.buddy_id == assist_info.id then
      return true
    end
  end
end

function ui:is_boddy_assist(buddy_id)
  if not buddy_id or 0 == buddy_id then
    return
  end
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_info()
  if not assist_info then
    return
  end
  if buddy_id == assist_info.id then
    return true
  end
end

function ui:get_boddy_assist_fashion_model(buddy_id)
  if not buddy_id or 0 == buddy_id then
    return
  end
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_info()
  if not assist_info then
    return
  end
  if buddy_id == assist_info.id then
    return FashionMgr:get_fashion_model_id_by_fashion_id(assist_info.fashion), assist_info.fashion
  end
end

function ui:get_boddy_assist_weapon(buddy_id)
  if not buddy_id or 0 == buddy_id then
    return
  end
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_info()
  if not assist_info then
    return
  end
  if buddy_id == assist_info.id then
    if assist_info.equip_fashion then
      local weapon_fashion_res = ShareRes.get_weapon_fashion_cfg(assist_info.equip_fashion)
      if weapon_fashion_res and weapon_fashion_res.WeaponRes then
        return weapon_fashion_res.WeaponRes
      end
    end
    return nil, assist_info.weapon_info and assist_info.weapon_info.id
  end
end

function ui:get_old_assist_pos()
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_old_info()
  if not assist_info then
    return
  end
  for pos, data in ipairs(self.v_pos_data) do
    if assist_info.id == data.buddy_id then
      return pos
    end
  end
end

function ui:get_challeng_assist_data()
  if not self.can_use_assist then
    return
  end
  local assist_info = AssistMgr:get_assist_buddy_info()
  if not assist_info then
    return
  end
  local ChallengAssistBuddy
  for pos, data in ipairs(self.v_pos_data) do
    if assist_info.id == data.buddy_id then
      ChallengAssistBuddy = {
        {
          buddy_id = assist_info.id,
          buddy_pos = pos,
          element_id = assist_info.element_id,
          idx = assist_info.idx
        }
      }
    end
  end
  return ChallengAssistBuddy
end

function ui:is_buddy_ban(buddy_id)
  return self.v_ban_buddys and self.v_ban_buddys[buddy_id]
end

function ui:refresh_weapon_fashion()
  if not self.v_model_view then
    return
  end
  if not self.v_pos_data then
    return
  end
  for pos, data in ipairs(self.v_pos_data) do
    if not data.robot_id then
      self.v_model_view:refresh_npc_weapon(data.buddy_id)
    end
  end
end

function ui:check_and_refresh_weapon(msg)
  if not msg or not msg.mm_obj then
    return
  end
  if not self.v_model_view then
    return
  end
  local equip_info = msg.mm_obj
  local owner = equip_info.owner or 0
  if 0 == owner or self:is_boddy_assist(owner) then
    return
  end
  for pos, data in ipairs(self.v_pos_data) do
    if not data.robot_id and data.buddy_id == owner then
      self.v_model_view:refresh_npc_weapon(data.buddy_id)
    end
  end
end

function ui:check_quick_change_team(pos_list)
  local buddy_id, robot_id
  for pos, data in ipairs(pos_list) do
    local old_data = self.v_pos_data[pos]
    if data.buddy_id == old_data.buddy_id and data.robot_id == old_data.robot_id then
      data.skip = true
    end
  end
  for pos, data in ipairs(pos_list) do
    if not data.skip and data.buddy_type ~= TEAM_BUDDY_TYPE.HELP_FIGHT then
      return true
    end
  end
end

function ui:quick_change_team(pos_list)
  for pos, data in ipairs(pos_list) do
    local old_data = self.v_pos_data[pos]
    if data.buddy_id == old_data.buddy_id and data.robot_id == old_data.robot_id then
      data.skip = true
    end
  end
  for pos, data in ipairs(pos_list) do
    if not data.skip and data.buddy_type ~= TEAM_BUDDY_TYPE.HELP_FIGHT then
      self:update_pos_hero(pos, data.buddy_id, data.robot_id)
    end
  end
end

function ui:show_queck_team_desc()
  self.v_uiobjects.StageDesc:SetActive(true)
  self.v_uicompents.Title_txt.text = Util.format_str("快速编队")
  self.v_uicompents.Describe_txt.text = Util.format_str("点击快速上阵/下阵角色")
end

local limit_color = Util.get_unity_color_by_hex(tonumber("909090", 16))
local limit_pass_color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))

function ui:check_enter_fight_limit(show_tips)
  self.v_uiobjects.TeamCondition:SetActive(self.v_enter_fight_limit ~= nil)
  if not self.v_enter_fight_limit then
    return true
  end
  self.v_uicompents.ConditionDesc_txt.text = self.v_enter_fight_limit.desc
  local finish_count = 0
  local count = self.v_enter_fight_limit.count
  local ele = self.v_enter_fight_limit.ele
  local job = self.v_enter_fight_limit.job
  for _, data in ipairs(self.v_pos_data) do
    if 0 ~= data.buddy_id then
      local buddy_cfg = ShareRes.create("buddy.buddy", data.buddy_id)
      if (0 == ele or buddy_cfg.Element == ele) and (0 == job or buddy_cfg.Job == job) then
        finish_count = finish_count + 1
      end
    end
  end
  local is_pass = count <= finish_count
  self.v_uiobjects.ConditionCheck:SetActive(is_pass)
  self.v_uicompents.ConditionDesc_txt.color = is_pass and limit_pass_color or limit_color
  if not is_pass and show_tips then
    Util.show_message_tip(self.v_enter_fight_limit.desc)
  end
  return is_pass
end

return ui
