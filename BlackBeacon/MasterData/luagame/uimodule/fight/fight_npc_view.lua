local Base = require("ui.uiobject")
local CommonDefind = require("cs_share.common_define")
local FUN_NPC_HELPER = require("gamelogic.functional_npc.functional_npc_helper")
local Seri = require("seri")
local FUNCTIONAL_NPC_TYPE = CommonDefind.FUNCTIONAL_NPC_TYPE
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE
local PointListener = CS.Game.PointEventListener
local ui = Util.create_child_mt(Base)
local treasure_chest_tips_win_delay_time = ShareRes.get_comm_value("TreasureChestTipsWinDelayTime") or 0.5
local NPC_TRIGGER_FUN = {
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Dialog] = "_trigger_dialog_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Treasure] = "_trigger_reward_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.TASK] = "_trigger_task_group_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Challenge] = "_trigger_challenge_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NoFightGame] = "_trigger_no_fight_game_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.ChallengeRing] = "_trigger_challenge_ring_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Door] = "_trigger_random_door_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.InitBox] = "_trigger_init_box_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NormalDrop] = "_trigger_reward_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Casting] = "_trigger_casting_npc",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.RUNE_SHOP] = "_trigger_rune_shop",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.ORNAMENTS_SHOP] = "_trigger_ornaments_shop",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.CHOOSE_NPC] = "_trigger_choose_npc",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.GAME_NPC] = "_trigger_mini_game_npc"
}
local CHECK_IS_GET_NPC_MAP = {
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Dialog] = true,
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NoFightGame] = true,
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Treasure] = true,
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NormalDrop] = true,
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Challenge] = true,
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.ChallengeRing] = true
}
local SHOW_DIALOG = {NOT_SHOW = 0, SHOW = 1}

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self.v_fight = self.v_parent_ui
  if not self.v_fight then
    return
  end
  self.v_fight_components = self.v_fight.v_uicompents
  self:_regist_client_event()
end

function ui:ui_on_hide()
  if not self.v_fight then
    return
  end
  self.v_fight:change_button(false)
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_TOG_FUNCTIONAL_NPC, self._on_trigger_npc, self)
  self:bind_auto_mq(Const.MSG_TRIGGER_TREASURE_CHEST, self._on_trigger_treasure_chest, self)
  self:bind_auto_mq(Const.MSG_ON_TREASURE_CHEST_AWARD_WIN_OPEN, self.on_treasure_chest_award_win_open, self)
  self:bind_auto_mq(Const.MSG_TOG_FUNCTIONAL_CHAT_ROLE_NPC, self.on_chat_role_npc_refresh, self)
  self:bind_auto_mq(Const.MSG_FIGHT_CNT_TIPS_FINISH, self._on_challenge_finish, self)
  self:bind_auto_mq(Const.MSG_ON_ENTER_ROOM, self.response_enter_room_event, self)
  self:bind_auto_mq(Const.MSG_UI_FIGHT_INPUT_CODE, self.on_input_code_down, self)
  self:bind_auto_mq(Const.MSG_KEY_UP, self.on_input_code_up, self)
end

function ui:_on_trigger_treasure_chest(msg)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    self.v_fight:change_button(false, true)
    return
  end
  local npc = msg.mm_x
  local is_in = msg.mm_y
  if is_in then
    local data = npc.data
    if data.is_get then
      self.v_fight:change_button(false, true)
      return
    end
    self.v_fight:change_button(true, true)
    local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", data.id)
    local icon_name = "Fight_btn_bx_ckfg"
    if treasure_chest_cfg and treasure_chest_cfg.InteractIcon then
      icon_name = treasure_chest_cfg.InteractIcon
    end
    self.v_fight:refresh_interact_btn_icon(icon_name)
    
    local function callback()
      if not data.is_can_open then
        if treasure_chest_cfg.CanNotInteractTips and treasure_chest_cfg.CanNotInteractTips ~= "" then
          local ui_fight = UIMgr:try_get_ui("fight")
          if not ui_fight then
            Util.show_message_tip(2179)
            return
          end
          ui_fight:show_dbm_with_banner(treasure_chest_cfg.CanNotInteractTips, 3, 1)
        else
          Util.show_message_tip(2179)
        end
      else
        self.v_fight:change_button(false, true)
        local body = {
          id = data.id
        }
        self:play_treasure_chest_interact_sound(data.id)
        if treasure_chest_cfg and treasure_chest_cfg.TreasureChestType == CommonDefind.TREASURE_CHEST_TYPE.ENTITY then
          npc:hide_effect()
          npc:on_treasure_chest_open()
        else
          npc:play_end_effect()
        end
        npc:player_anim("arder_switch", nil, true)
        if npc.cfg and 1 == npc.cfg.IsPlayInteractAnima then
          Global.hero:play_interact_anim()
          Joystick.on_joystick("end")
        end
        if data.custom_event_name and "" ~= data.custom_event_name then
          BehaviorMgr:call_scene_logic_event_fun("on_treasure_chest_open", data.custom_event_name)
        end
        Timer:add_timer("treasure_chest_open_delay_send_msg", treasure_chest_tips_win_delay_time, function()
          Network:call("c2gs_battle_episode_box", body, function(ok, resp)
            if ok then
              data.is_get = true
            end
          end)
        end)
      end
    end
    
    local btn_interact = self.v_fight_components.Btn_Interact_btn
    Util.remove_longpress(nil, btn_interact.gameObject, self.v_ui_root)
    Util.remove_point_up(nil, btn_interact.gameObject, self.v_ui_root)
    Util.remove_point_down(nil, btn_interact.gameObject, self.v_ui_root)
    self:set_button_listener(btn_interact, function()
      callback()
    end)
  else
    self.v_fight:change_button(false, true)
  end
end

function ui:on_treasure_chest_award_win_open(msg)
  local treasure_chest_id = msg.mm_x
  local award_list = msg.mm_obj
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", treasure_chest_id)
  local have_exp_item = false
  for i, v in pairs(award_list) do
    if v.ItemId == Config.EXP_ITEMID then
      have_exp_item = true
    end
  end
  if have_exp_item then
    PlayerMgr:try_show_exp_up_tips()
  end
  if treasure_chest_cfg.TreasureChestType == CommonDefind.TREASURE_CHEST_TYPE.LIGHT_POINT then
    local data = {}
    data.left_pick_up_award_list = award_list
    data.treasure_chest_id = treasure_chest_id
    UIMgr:get_ui("common_battle_tips"):ui_show(data)
  else
    UIMgr:try_show_ui("battle_award_show_panel", nil, award_list, treasure_chest_id)
  end
end

function ui:play_treasure_chest_interact_sound(treasure_chest_id)
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", treasure_chest_id)
  local open_sound = treasure_chest_cfg.BoxOpenSound
  if open_sound and "" ~= open_sound then
    Global.sound_mgr:play_sound_by_id(open_sound)
  end
end

function ui:on_input_code_down(msg)
  if not msg or msg.mm_x ~= Config.INPUT_CODE.INPUT_INTERACT or not self.v_fight then
    return
  end
  local btn_interact = self.v_fight_components.Btn_Interact_btn
  if not btn_interact or not btn_interact.gameObject.activeSelf then
    return
  end
  local click_event = btn_interact.onClick
  local click_cb = Global.listener_mgr:get_listener(self.v_object, click_event)
  if click_cb then
    click_cb()
    return
  end
  local down_listener = PointListener.Get(btn_interact.gameObject, true)
  if Util.is_nil(down_listener) then
    return
  end
  self.v_interact_key_code_down = true
  local down_event = down_listener.onDown
  local down_cb = Global.listener_mgr:get_listener(btn_interact.gameObject, down_event)
  if down_cb then
    down_cb()
  end
  self.v_interact_key_code_timer = Timer:add_timer("interact_key_code_timer", 0.2, function()
    local long_press_event = PointListener.Get(btn_interact.gameObject, true).onLongPress
    local long_press_cb = Global.listener_mgr:get_listener(btn_interact.gameObject, long_press_event)
    if long_press_cb then
      long_press_cb()
    end
    self:remove_interact_key_code_timer()
  end)
end

function ui:remove_interact_key_code_timer()
  if self.v_interact_key_code_timer then
    Timer:remove_timer(self.v_interact_key_code_timer)
    self.v_interact_key_code_timer = nil
  end
end

function ui:on_input_code_up(msg)
  if not msg or msg.mm_x ~= Config.INPUT_CODE.INPUT_INTERACT or not self.v_fight then
    return
  end
  if not self.v_interact_key_code_down then
    return
  end
  self.v_interact_key_code_down = false
  self:remove_interact_key_code_timer()
  local btn_interact = self.v_fight_components.Btn_Interact_btn
  if not btn_interact or not btn_interact.gameObject.activeSelf then
    return
  end
  local up_listener = PointListener.Get(btn_interact.gameObject, true)
  if Util.is_nil(up_listener) then
    return
  end
  local up_event = up_listener.onUp
  local up_cb = Global.listener_mgr:get_listener(btn_interact.gameObject, up_event)
  if up_cb then
    up_cb()
  end
end

function ui:_on_trigger_npc(msg)
  local npc_data = msg.mm_x
  if not npc_data then
    self.v_fight:change_button(false, true)
    return
  end
  if npc_data.npc_cfg.InteractRange and npc_data.npc_cfg.InteractRange < 0 then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    self.v_fight:change_button(false, true)
    return
  end
  local npc = scene_logic:get_func_npc(npc_data.npc_id)
  if not (npc and npc:get_finish_load()) or not npc.v_gameobj_active then
    self.v_fight:change_button(false, true)
    return
  end
  local is_in = msg.mm_y
  self:check_interact_btn_show(npc_data, is_in)
end

function ui:check_interact_btn_show(npc_data, is_in)
  local npc_cfg = npc_data.npc_cfg
  local show_type = npc_cfg.ShowType
  local fun = NPC_TRIGGER_FUN[show_type]
  if npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.CHOOSE_NPC or npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.GAME_NPC then
    fun = NPC_TRIGGER_FUN[npc_cfg.Type]
  end
  local is_show_dialog = npc_cfg.HaveDialogue
  local is_get = npc_data.is_get
  local check_is_get = CHECK_IS_GET_NPC_MAP[show_type]
  local btn_interact = self.v_fight_components.Btn_Interact_btn
  if check_is_get and is_get and is_show_dialog == SHOW_DIALOG.NOT_SHOW then
    self.v_fight:change_button(false, true)
    return
  end
  local is_long_press = false
  if npc_cfg.LongPress == true and npc_cfg.LongPressTime and npc_cfg.LongPressTime > 0 then
    is_long_press = true
  end
  if is_in then
    self.v_fight:change_button(true, true, is_long_press)
    local icon_name = "Fight_btn_rw_ck3"
    if npc_cfg and npc_cfg.InteractIcon then
      icon_name = npc_cfg.InteractIcon
    end
    self.v_fight:refresh_interact_btn_icon(icon_name)
    
    local function callback()
      if npc_data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.QUANTUM_CAMERA_NPC then
        local msg = MsgGame:mq_publish2(Const.MSG_ON_INTERACT_QUANTUM_CAMERA_NPC)
        msg.mm_x = tonumber(npc_data.npc_cfg.Arg[1])
        msg.mm_y = npc_data.npc_id
        return
      end
      local scene_logic = SceneMgr:get_scene_logic()
      if not scene_logic then
        self.v_fight:change_button(false, true)
        return
      end
      local npc = scene_logic:get_func_npc(npc_data.npc_id)
      if Util.is_destroy(npc) then
        return
      end
      if npc_data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.ABILITY_REBUILD_NPC then
        npc:on_interact()
        return
      end
      Joystick.on_joystick("end")
      self:set_uiobject_visible("Main", true)
      if npc_cfg.IsNewInteractNPC then
        if npc_data.npc_cfg.IsPlayInteractAnima and npc_data.npc_cfg.IsPlayInteractAnima > 0 then
          Global.hero:play_interact_anim()
        end
        FunctionalNpcMgr:request_interact_with_exhibition_npc(npc_cfg.NPCName, function()
          local msg = MsgGame:mq_publish2(Const.MSG_ON_INTERACT_NPC_SUCCESS)
          msg.mm_obj = npc_data
        end)
      else
        self:check_show_dialog(is_show_dialog, fun, npc_data)
        self.v_fight:click_interact_btn()
      end
      local sound_name = npc_cfg.PlayInteractSoundName
      if nil ~= sound_name and "" ~= sound_name then
        Global.sound_mgr:play_sound_by_id(sound_name)
      end
      if check_is_get then
        scene_logic:recheck_hero_contact_npc()
      end
    end
    
    Util.remove_longpress(nil, btn_interact.gameObject, self.v_ui_root)
    Util.remove_point_up(nil, btn_interact.gameObject, self.v_ui_root)
    Util.remove_point_down(nil, btn_interact.gameObject, self.v_ui_root)
    if is_long_press then
      FunctionalNpcMgr:add_interaction_npc_hud(npc_data)
      self.v_ui_root = btn_interact.gameObject
      local is_long_click = false
      Util.set_longpress(nil, btn_interact.gameObject, self.v_ui_root, function()
        local interacting_sound_name = npc_cfg.PlayInteractingSoundName
        if nil ~= interacting_sound_name and "" ~= interacting_sound_name then
          Global.sound_mgr:play_sound_by_id(interacting_sound_name)
        end
        Global.hero:play_interact_anim()
        is_long_click = true
        FunctionalNpcMgr:set_rich_callback(callback)
        FunctionalNpcMgr:set_is_need_update(npc_data, true)
      end)
      Util.set_point_up(nil, btn_interact.gameObject, self.v_ui_root, function()
        FunctionalNpcMgr:set_is_need_update(npc_data, false)
        if is_long_click then
          local interacting_sound_name = npc_cfg.PlayInteractingSoundName
          if nil ~= interacting_sound_name and "" ~= interacting_sound_name then
            Global.sound_mgr:stop_sound_by_id(interacting_sound_name)
          end
        end
        is_long_click = false
      end)
      Util.set_point_down(nil, btn_interact.gameObject, self.v_ui_root, function()
        is_long_click = false
      end)
      self:remove_button_listener(btn_interact)
    else
      self:set_button_listener(btn_interact, function()
        callback()
      end)
    end
  else
    self.v_fight:change_button(false, true)
    if is_long_press then
      FunctionalNpcMgr:release_interaction_npc_hud(npc_data.npc_id, true)
    end
  end
end

function ui:on_chat_role_npc_refresh(msg)
  local npc_lua = msg.mm_x
  if not npc_lua then
    return
  end
  local npc_data = npc_lua.data
  if not npc_data then
    return
  end
  local is_in = msg.mm_y
  if is_in then
    if FunctionalNpcMgr then
      FunctionalNpcMgr:add_role_npc_bubble_chat(npc_lua)
    end
  elseif FunctionalNpcMgr then
    FunctionalNpcMgr:release_role_npc_bubble_chat(npc_data.npc_id)
  end
end

function ui:ui_update()
  if FunctionalNpcMgr then
    FunctionalNpcMgr:update_interaction_npc_hud()
    FunctionalNpcMgr:update_role_npc_bubble_chat_pos()
  end
end

function ui:check_show_dialog(is_show_dialog, fun, npc_data)
  if is_show_dialog == SHOW_DIALOG.SHOW then
    local cb
    if fun then
      function cb()
        self[fun](self, npc_data)
      end
    end
    UIMgr:get_ui("uinpc_dialog"):ui_show(npc_data, cb)
  elseif fun then
    self[fun](self, npc_data)
    if npc_data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.FIXED_DROP then
      Global.hero:play_interact_anim()
    else
      local is_play_anim = true
      if npc_data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION and npc_data.npc_cfg.LongPress == true then
        is_play_anim = false
      end
      if npc_data.npc_cfg.IsPlayInteractAnima and npc_data.npc_cfg.IsPlayInteractAnima > 0 and is_play_anim then
        Global.hero:play_interact_anim()
      end
    end
  end
end

function ui:_trigger_dialog_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  local npc_id = npc_data.npc_id
  
  local function cb()
    local scene_logic = SceneMgr:get_scene_logic()
    local npc_obj = scene_logic:get_func_npc(npc_id)
    npc_obj:create_drop_item(function()
      SceneMgr:c2gs_call_scene("on_func_npc_interact_end", npc_id)
      BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", npc_id)
    end)
  end
  
  FunctionalNpcMgr:interact_with_reawrd_npc(npc_data, cb)
end

function ui:_trigger_reward_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  
  local function cb()
    local npc = scene_logic:get_func_npc(npc_data.npc_id)
    if npc then
      npc:player_anim("interact")
    else
      Log.Error("get functional npc failure! npc_id=", npc_data.npc_id)
    end
  end
  
  FunctionalNpcMgr:interact_with_reawrd_npc(npc_data, cb)
end

function ui:_trigger_task_group_npc(npc_data)
  local task_id = npc_data.mArgs.groupId
  UIMgr:get_ui("battle_challenge_task"):ui_show(npc_data, task_id)
end

function ui:_trigger_challenge_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local npc = scene_logic:get_func_npc(npc_data.npc_id)
  if npc then
    SceneMgr:c2gs_call_scene("on_npc_show_start", npc_data.npc_id)
    local action_name
    if FUN_NPC_HELPER.is_role_npc(npc_data.npc_id) then
      FunctionalNpcMgr:on_interact_with_npc(npc_data)
      action_name = npc_data.npc_cfg.InteractOverAction
      if action_name and "" ~= action_name then
        npc:player_anim(action_name, function()
          npc:player_anim(Config.ACT_DEFINE.Idle2)
        end)
      end
    else
      FunctionalNpcMgr:on_interact_with_npc(npc_data)
    end
  else
    Log.Error("get functional npc failure! npc_id=", npc_data.npc_id)
  end
end

function ui:_trigger_no_fight_game_npc(npc_data)
  local npc_id = npc_data.npc_id
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  local game_id = tonumber(npc_cfg.Arg[1])
  local game_cfg = ShareRes.create("no_fight_game.no_fight_game_introduce", game_id)
  UIMgr:get_ui("no_fight_game"):ui_show(npc_data, game_cfg)
end

function ui:_trigger_challenge_ring_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  FunctionalNpcMgr:interact_with_challenge_ring_npc(npc_data)
end

function ui:_trigger_rune_shop(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  FunctionalNpcMgr:interact_with_rune_shop_npc(npc_data)
end

function ui:_trigger_ornaments_shop(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  FunctionalNpcMgr:interact_with_ornaments_shop_npc(npc_data)
end

function ui:_trigger_choose_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  FunctionalNpcMgr:interact_choose_npc(npc_data)
end

function ui:_trigger_mini_game_npc(npc_data)
  local is_get = npc_data.is_get
  if is_get then
    return
  end
  FunctionalNpcMgr:interact_game_npc(npc_data)
end

function ui:_on_challenge_finish(msg)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local npc_map = scene_logic:get_func_npc_list()
  if next(npc_map) == nil then
    return
  end
  for _, v in pairs(npc_map) do
    if not v:is_destroy() and v.data.npc_cfg.Type == CommonDefind.FUNCTIONAL_NPC_TYPE.CHALLENGE then
      v:remove_challenge_effect()
      local cfg = ShareRes.create("scene.scene_tips", msg.mm_x)
      if cfg and cfg.Type == CommonDefind.FIGHT_TIPS_TYPE.TIMER then
        SceneMgr:c2gs_call_scene("time_counter_end", msg.mm_x)
      end
    end
  end
end

function ui:response_enter_room_event(msg)
  if not self.v_fight then
    return
  end
  self.v_fight:change_button(false)
end

function ui:set_uiobject_visible(obj_name, is_visible)
  self.v_fight:set_ui_node_visible(obj_name, OBJ_VISIBLE_TYPE.BUDDY, is_visible)
  self.v_fight:set_uiobject_visible(obj_name, is_visible)
end

function ui:_on_trigger_door(msg)
  if msg.mm_x == false then
    self.v_fight:change_button(false)
    return
  end
  self.v_fight:change_button(msg.mm_y)
  local btn_interact = self.v_fight_components.Btn_Interact_btn
  self:set_button_ex_listener(btn_interact, function()
    local msg2 = MsgGame:mq_publish2(Const.MSG_INTERACT_TRANSMIT_DOOR)
    msg2.mm_x = msg.mm_obj
  end)
end

function ui:_trigger_random_door_npc(npc_data, is_in)
  if not is_in then
    return
  end
  local transmit_data = npc_data.transmit_data
  local connect_data = transmit_data.connect
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  tower:enter_room(connect_data.target_room_num, connect_data.target_dir)
end

function ui:_trigger_init_box_npc(npc_data)
  local npc_id = npc_data.npc_id
  Global.camera:set_npc_focus_pos(false, npc_id, 0.2)
end

function ui:_trigger_casting_npc(npc_data)
  local cast_id = npc_data.mArgs[1]
  local npc_id = npc_data.npc_id
  if not cast_id then
    Log.Error("npc args is not exist, npc id = ", npc_id)
    return
  end
  UIMgr:get_ui("ui_rune_cast"):ui_show(cast_id)
end

return ui
