local Const = require("const")
local AssetCache = require("manager.res.asset_cache")
local BTNNAME_INFO = require("uimodule.battle_setting.battle_setting_cfg").BTNNAME_INFO
local CSKeyCode = UnityEngine.KeyCode
local INPUT_CODE = Config.INPUT_CODE
local Vec3 = require("base.vec3")
local TOUCH_EFFECT_PATH = "TouchEffect"
local TypeEffectStatus = _ENV.TypeEffectStatus
local UnityCamera = typeof(UnityEngine.Camera)
local CSInput = UnityEngine.Input
local _min = math.min
local M = Util.create_class()
local TOUCH_EFFECT_MAX_COUNT = 2
M.inputs = {}
local GPG_INPUTOR_NAME = "GooglePlayGamesInputor"

function M:_init()
  self:_init_google_play_games_inputor()
end

function M:_init_google_play_games_inputor()
  if not CS.GoogleDeviceUtilities.IsGooglePlayGames then
    return
  end
  local find_obj = UnityFind(GPG_INPUTOR_NAME)
  if find_obj then
    return
  end
  local obj = Global.res_mgr:create_emptygameobj(GPG_INPUTOR_NAME, true)
  obj:AddComponent(typeof(CS.GooglePlayGamesInputor))
end

function M:late_update()
end

function M:get_last_interaction_time(...)
  return self.v_last_time
end

function M:change_gm_touch_effect_state()
  self.v_gm_touch_effect = not self.v_gm_touch_effect
  if self.v_gm_touch_effect then
    self:init_touch_effect()
  else
    self:destroy_touch_effect()
  end
end

function M:init_touch_effect()
  if not self.v_touch_effect_list then
    self.v_touch_effect_list = {}
    for i = 0, TOUCH_EFFECT_MAX_COUNT - 1 do
      local touch_effect = ResMgr:load_gameobj(Path.get_res_path(TOUCH_EFFECT_PATH))
      touch_effect.transform:SetParent(Global.ui_mgr:get_wcanvas().transform, false)
      touch_effect.transform:SetPositionA(0, 0, 0)
      local camera_go = Util.get_child_gameobj("UITouchEffectCamera", touch_effect)
      local touch_camera = Util.get_component(nil, camera_go, UnityCamera)
      local ui_touch_effect = Util.get_child_gameobj("UITouchEffect", touch_effect)
      local pos = Vec3.New(0, 0, 0)
      self.v_touch_effect_list[i] = {
        go = touch_effect,
        camera = touch_camera,
        ui_go = ui_touch_effect,
        pos = pos
      }
    end
  end
end

function M:destroy_touch_effect()
  if self.v_touch_effect_list then
    for _, data in pairs(self.v_touch_effect_list) do
      local go = data.go
      if not go:IsNull() then
        ResMgr:destroy_gameobj(go)
      end
    end
    self.v_touch_effect_list = nil
  end
end

function M:check_touch_effect()
  local touch_count = CSInput.touchCount
  for _, data in pairs(self.v_touch_effect_list) do
    local ui_go = data.ui_go
    ui_go:SetActive(false)
  end
  if touch_count > 0 then
    local max_count = _min(touch_count, TOUCH_EFFECT_MAX_COUNT)
    local touch_list = CSInput.touches
    for i = 0, max_count - 1 do
      local now_touch = touch_list[i]
      local effect_data = self.v_touch_effect_list[i]
      local camera = effect_data.camera
      local pos = now_touch.position
      effect_data.pos:Set(pos.x, pos.y, 1)
      local world_pos = camera:ScreenToWorldPoint(effect_data.pos)
      local ui_go = effect_data.ui_go
      local trans = ui_go.transform
      trans:SetActive(true)
      trans:SetPositionA(world_pos.x, world_pos.y, 1)
    end
  else
    local touch_x = CSInput.mousePosition.x
    local touch_y = CSInput.mousePosition.y
    local effect_data = self.v_touch_effect_list[0]
    local camera = effect_data.camera
    local ui_go = effect_data.ui_go
    effect_data.pos:Set(touch_x, touch_y, 1)
    local world_pos = camera:ScreenToWorldPoint(effect_data.pos)
    local trans = ui_go.transform
    trans:SetActive(true)
    trans:SetPositionA(world_pos.x, world_pos.y, 1)
  end
end

function M:touch_effect_show()
  if self.v_touch_effect_list then
    if CSInput:GetMouseButtonUp(0) then
      for _, data in pairs(self.v_touch_effect_list) do
        local ui_go = data.ui_go
        ui_go:SetActive(false)
      end
    elseif CSInput:GetMouseButton(0) then
      M:check_touch_effect()
    end
  end
end

function M.on_gesture(e, ...)
  if SceneMgr and SceneMgr:check_main_scene() then
    SignBoardGirlMgr:reset_stand_by_time()
  end
  if not Global.camera then
    return
  end
  if SceneMgr and (SceneMgr:get_game_pause() or not SceneMgr:is_can_controlled()) then
    return
  end
  M.v_last_time = Date.now()
  if "UIELEMENT" == e then
    local x, y, swip_x, swip_y = ...
    if Global.show_click_pos then
      Global.ui_mgr:get_ui("click_test"):set_image_pos(x, y)
    end
    if Global.camera and Global.camera:check_click_swip() then
      Global.camera:on_touch_swipe(swip_x, swip_y)
    end
    return
  end
  if "TOUCH_UP" == e then
    local x, y = ...
    if Global.show_click_pos then
      Global.ui_mgr:get_ui("click_test"):set_image_pos(x, y)
    end
    Global.camera:on_touch_up()
    Global.camera:on_refresh_touch_effect(false)
  elseif "TOUCH_DOWN" == e then
    Global.camera:on_touch_down()
  end
  if "TAP" == e then
  elseif "SWIPE" == e then
    local _, _, touch_count, pointer_id = ...
    if not (not UNITY_EDITOR and (UNITY_IOS or UNITY_ANDROID)) or 1 == touch_count and -1 == Global.joystick_pointer_id or 2 == touch_count and -1 ~= Global.joystick_pointer_id and Global.joystick_pointer_id ~= pointer_id then
      Global.camera:on_swipe(...)
    end
    if UNITY_IOS or UNITY_ANDROID then
      if UNITY_ANDROID and SDKManager:is_support_key_mouse() then
        if Global.joystick then
          if not Global.joystick_pointer then
            Global.camera:on_touch_swipe(...)
          end
        else
          Global.camera:on_touch_swipe(...)
        end
      elseif not (1 ~= touch_count or Global.joystick) or 2 == touch_count and -1 ~= Global.joystick_pointer_id and Global.joystick_pointer_id ~= pointer_id then
        Global.camera:on_touch_swipe(...)
      end
    elseif Global.joystick then
      if not Global.joystick_pointer then
        Global.camera:on_touch_swipe(...)
      end
    else
      Global.camera:on_touch_swipe(...)
    end
    if UNITY_EDITOR then
      Global.camera:on_refresh_touch_effect(true)
    end
    if 2 == touch_count then
      Global.camera:on_refresh_touch_effect(true)
    end
  elseif "PINCH" == e then
    local _, editor_mode, touch_count = ...
    editor_mode = 1 == editor_mode and true or false
    if UNITY_EDITOR or editor_mode or 2 == touch_count and not Global.joystick then
      Global.camera:on_pinch(...)
    end
  elseif "LONGTAP2" == e then
  elseif "SWIPEEND" == e then
    local swipe_direction = (...)
    Global.camera:on_touch_swipe_end(swipe_direction)
  elseif "PINCHEND" == e then
    Global.camera:on_pinch_end()
  end
end

local is_cull_ui = false
local KEY_HANDLER = {
  [CSKeyCode.F1] = function()
    UnityEngine.Time.timeScale = 0
    Global.stop_update = true
  end,
  [CSKeyCode.F2] = function()
    UnityEngine.Time.timeScale = 0.05
    Global.stop_update = false
  end,
  [CSKeyCode.F3] = function()
    UnityEngine.Time.timeScale = 0.2
    Global.stop_update = false
  end,
  [CSKeyCode.F4] = function()
    UnityEngine.Time.timeScale = 0.5
    Global.stop_update = false
  end,
  [CSKeyCode.F5] = function()
    UnityEngine.Time.timeScale = 1
    Global.stop_update = false
  end,
  [CSKeyCode.F6] = function()
    UnityEngine.Time.timeScale = 2
    Global.stop_update = false
  end,
  [CSKeyCode.F7] = function()
    Global.enable_hurt_stop = not Global.enable_hurt_stop
    if Global.show_skill_area_type == Config.SHOW_SKILL_AREA_TYPE.NONE then
      Global.show_skill_area_type = Config.SHOW_SKILL_AREA_TYPE.SHAPE
    end
  end,
  [CSKeyCode.F8] = function()
    local value = (Global.show_skill_area_type + 1) % 3
    Global.show_skill_area_type = value
  end,
  [CSKeyCode.E] = function()
    Global.DEBUG_BATTLE_STATUS = true
  end,
  [CSKeyCode.F] = function()
    SceneMgr:cur_scene_npc_suicide()
  end,
  [CSKeyCode.Z] = function()
    Global.camera:close_camera_aimed()
  end,
  [CSKeyCode.M] = function()
    if Global.camera then
      local pos = Global.camera:get_camera_forward_pos()
    end
  end,
  [CSKeyCode.T] = function()
    if Global.camera then
      Global.camera:gm_print_info()
    end
  end,
  [CSKeyCode.Y] = function()
    is_cull_ui = not is_cull_ui
    local ui_camera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
    local mask = is_cull_ui and UnityEngine.LayerMask.GetMask("UI3D") or UnityEngine.LayerMask.GetMask("UI", "UI3D")
    ui_camera.cullingMask = mask
  end
}

function M.on_key(key)
  local input_code = M.get_key_input_code(key)
  local msg = MsgGame:mq_publish2(Const.MSG_KEY_DOWN)
  if not input_code then
    msg.mm_x = key
  else
    msg.mm_x = input_code
  end
  if SceneMgr and (SceneMgr:get_game_pause() or not SceneMgr:is_can_controlled()) then
    return
  end
  local ui_fight = UIMgr:try_get_ui("fight")
  if not ui_fight or not ui_fight.v_uiobjects.Main.activeSelf then
    return
  end
  if UIMgr:try_get_visible_ui("uilogin") then
    return
  end
  if GuideMgr and GuideMgr:get_cur_guider() then
    return
  end
  local ui_timeline = UIMgr:try_get_visible_ui("ui_timeline")
  if ui_timeline and not ui_timeline.is_show_ui then
    return
  end
  local handle_func = KEY_HANDLER[key]
  if UNITY_EDITOR and handle_func then
    handle_func()
  end
  if input_code and ui_fight:is_inputcode_enable(input_code) then
    M.inputs[input_code] = true
    msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_INPUT_CODE)
    msg.mm_x = input_code
  end
end

function M.get_key_input_code(key)
  local input_code
  local keycode_inputcode_map = BattleSettingMgr:get_keycode_inputcode_map()
  if keycode_inputcode_map and keycode_inputcode_map[key] then
    input_code = keycode_inputcode_map[key]
  end
  return input_code
end

function M.on_key_up(key)
  local input_code = M.get_key_input_code(key)
  local msg = MsgGame:mq_publish2(Const.MSG_KEY_UP)
  if not input_code then
    msg.mm_x = key
  else
    msg.mm_x = input_code
  end
  if key == CSKeyCode.Escape then
    local has_response = M.on_click_escape()
    if has_response then
      return
    end
  end
  if SceneMgr and (SceneMgr:get_game_pause() or not SceneMgr:is_can_controlled()) then
    return
  end
  local ui_fight = UIMgr:try_get_ui("fight")
  if not ui_fight or not ui_fight.v_uiobjects.Main.activeSelf then
    return
  end
  if GuideMgr and GuideMgr:get_cur_guider() then
    return
  end
  local ui_timeline = UIMgr:try_get_visible_ui("ui_timeline")
  if ui_timeline and not ui_timeline.is_show_ui then
    return
  end
  if input_code and ui_fight:is_inputcode_enable(input_code) then
    M.inputs[input_code] = nil
    msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_INPUT_KEY_UP_CODE)
    msg.mm_x = input_code
  end
end

function M:release_all_input_key()
  for input_code, _ in pairs(M.inputs) do
    local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_INPUT_KEY_UP_CODE)
    msg.mm_x = input_code
    M.inputs[input_code] = nil
  end
end

function M.on_click_escape()
  if StoryMgr and StoryMgr:get_curr_step_is_showing_skip() then
    local ui_story = UIMgr:try_get_visible_ui("uistory")
    if ui_story then
      ui_story:click_skip_cancel_btn()
    end
    return true
  end
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    UIMgr:get_ui("ui_player_exit_tip"):ui_show()
  else
    SDKManager:exit_game()
  end
end

function M.has_input(input_code)
  return M.inputs[input_code]
end

return M
