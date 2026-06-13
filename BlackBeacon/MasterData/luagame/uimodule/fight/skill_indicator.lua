local M = {}
local CSInput = UnityEngine.Input
local CSHelper = _ENV.CSHelper
local RectTransformUtility = UnityEngine.RectTransformUtility
local UnityCamera = typeof(UnityEngine.Camera)
local JoystickType = typeof(CS.Game.SkillJoyStick)
local SkillKeys = {}
local MathX = require("base.mathx")
local _tan = math.tan
local _clamp = MathX.Clamp
local _lerp = MathX.lerp_number
local _dist_vec2A = MathX.dist_vec2A
local _get_angle_vec2A = MathX.get_angle2A
local _rotate_vec2 = MathX.rotate_vec2
local _abs = math.abs
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local CHEST_POINT = "Bip001 Chest"
local TYPE_EFFECT_STATUS = TypeEffectStatus
local TYPE_EFFECT_STATE = TypeEffectStage
local EFFECT_STAGE_START = 0
local EFFECT_STAGE_END = 2
local NEED_RED = false
local IS_UPDATE_POS = false
local TEMP_VEC2 = Vec2.New()
local TEMP_UNITY_VEC3 = UnityVector3()
local _cur_wh_ratio = Global.screen_width / Global.screen_height
local get_button_drag_state_str = "get_button_drag_state"
local FX_text_kong = "FX_text_kong"
local deg2Rad = math.rad(1)
local WHITE = "FFFFFF"
local RED = "FF0000"
local INDICATOR_COLOR_TYPE = {
  BLUE = 1,
  RED = 2,
  GREEN = 3
}
local cancle_r2 = 0
local distance_cancle_r2 = 90000
local AREA_TYPE = {CIRCLE = 1, SECTOR = 2}

local function reduce_distance(center_x, center_y, distance, x, y)
  local dir_x, dir_y = x - center_x, y - center_y
  local len = math.sqrt(dir_x * dir_x + dir_y * dir_y)
  if distance > len then
    return x, y
  end
  local offsetx, offsety = dir_x / len * distance, dir_y / len * distance
  return center_x + offsetx, center_y + offsety
end

local function get_nearest_tar(x, z, range, tar_camp)
  local all_char = SceneMgr:get_all_char()
  local tar
  for _, char in pairs(all_char) do
    if not (Util.is_target_camp(Global.hero, char, tar_camp) and char:is_can_searched()) or char:is_destroy() or not char:is_monster() then
    else
      local px, pz = char:get_pos2()
      local dist = _dist_vec2A(x, z, px, pz)
      if range > dist then
        range = dist
        tar = char
      end
    end
  end
  return tar
end

local function is_null_obj(obj)
  return not obj or obj:IsNull()
end

local AREA_ON_UPDATE = {
  [AREA_TYPE.CIRCLE] = function(area, hero_pos, rx, ry)
    local obj = area.effect.gameobj
    obj.transform:SetLocalScaleA(area.sizex, 1, area.sizex)
    obj.transform:SetPositionA(hero_pos.x, hero_pos.y, hero_pos.z)
  end,
  [AREA_TYPE.SECTOR] = function(area, hero_pos, rx, ry)
    local obj = area.effect.gameobj
    obj.transform:SetLocalScaleA(area.sizex, 1, area.sizex)
    obj.transform:SetPositionA(hero_pos.x, hero_pos.y, hero_pos.z)
    obj.transform:SetEulerY(Util.get_eulery(rx, ry))
  end
}
local INDI_TYPE = {
  CIRCLE = 1,
  ARROW = 2,
  FIXED_ARROW = 3,
  SCREEN_CIRCLE = 4,
  LOCK_TAR_CIRCLE = 5,
  TARGET_POS_ARROW = 6,
  SECTOR_ARROW = 7
}
local INDICATOR_ON_ENABLE = {
  [INDI_TYPE.SCREEN_CIRCLE] = function(cfg)
    cfg.fov_cache = nil
    cfg.ratio_cache_x = nil
    cfg.ratio_cache_y = nil
    cfg.half_x = nil
    cfg.half_y = nil
  end
}
local NO_RED_TYEP = {
  [INDI_TYPE.SCREEN_CIRCLE] = true
}

local function _ARROW_UPDATE_FUNC(indi, hero_pos, rx, ry, area_r, key, obj)
  obj = obj or indi.effect.gameobj
  if is_null_obj(obj) then
    return
  end
  local target_pos, pos_x, pos_y, pos_z
  if M.behavior_attach_target_enable and M.setting_attach_target_enable then
    local target = Global.hero:get_target()
    if not Util.is_destroy(target) then
      pos_x, pos_y, pos_z = target:get_pos()
      local dist = _dist_vec2A(pos_x, pos_z, hero_pos.x, hero_pos.z)
      if dist <= indi.sizey then
        TEMP_VEC2:Set(pos_x - hero_pos.x, pos_z - hero_pos.z)
        TEMP_VEC2:SetNormalize()
        TEMP_VEC2 = TEMP_VEC2 * dist
        pos_x, pos_z = TEMP_VEC2:Get()
        target_pos = Util.VEC3_TEMP:Set1(hero_pos.x + pos_x, hero_pos.y, hero_pos.z + pos_z)
        key.show_x, key.show_z = pos_x, pos_z
        key.cx, key.cy = pos_x, pos_z
      end
    end
  end
  if not target_pos then
    M.process_key(key)
    pos_x, pos_z = rx, ry
  end
  obj.transform:SetPositionA(hero_pos.x, hero_pos.y, hero_pos.z)
  obj.transform:SetLocalScaleA(indi.sizex, 1, indi.sizey)
  obj.transform:SetEulerY(Util.get_eulery(pos_x, pos_z))
  if not target_pos then
    Util.VEC3_TEMP_1:Set(obj.transform:GetPositionA())
    target_pos = Util.VEC3_TEMP:Set1(obj.transform:GetForwardA()):Mul(indi.sizey):Add(Util.VEC3_TEMP_1)
  end
  M.set_skill_indi_in_camera(target_pos, hero_pos, nil, key)
end

local INDI_ON_UPDATE = {
  [INDI_TYPE.CIRCLE] = function(indi, hero_pos, rx, ry, area_r, key)
    local obj = indi.effect.gameobj
    if is_null_obj(obj) then
      return
    end
    local target_pos, pos_x, pos_z
    if M.behavior_attach_target_enable and M.setting_attach_target_enable then
      local target = Global.hero:get_target()
      if not Util.is_destroy(target) then
        local _
        pos_x, _, pos_z = target:get_pos()
        if area_r >= _dist_vec2A(pos_x, pos_z, hero_pos.x, hero_pos.z) then
          key.show_x, key.show_z = pos_x, pos_z
          M.set_key_cur_pos(key.keycode, pos_x, pos_z)
          Util.VEC3_TEMP:Set(pos_x, hero_pos.y, pos_z)
          target_pos = Util.VEC3_TEMP
        end
      end
    end
    if not target_pos then
      pos_x, pos_z = hero_pos.x + rx * area_r, hero_pos.z + ry * area_r
    end
    obj.transform:SetLocalScaleA(indi.sizex, 1, indi.sizex)
    obj.transform:SetPositionA(pos_x, hero_pos.y, pos_z)
    if not target_pos then
      M.process_key(key)
      local skill_indi_posx, skill_indi_posy, skill_indi_posz = obj.transform:GetPositionA()
      Util.VEC3_TEMP:Set1(skill_indi_posx, skill_indi_posy, skill_indi_posz):Sub(hero_pos):SetNormalize()
      Util.VEC3_TEMP:Mul(indi.sizex / 2.0)
      Util.VEC3_TEMP.x = Util.VEC3_TEMP.x + skill_indi_posx
      Util.VEC3_TEMP.y = Util.VEC3_TEMP.y + skill_indi_posy
      Util.VEC3_TEMP.z = Util.VEC3_TEMP.z + skill_indi_posz
      target_pos = Util.VEC3_TEMP
    end
    M.set_skill_indi_in_camera(target_pos, hero_pos, nil, key)
  end,
  [INDI_TYPE.LOCK_TAR_CIRCLE] = function(indi, hero_pos, rx, ry, area_r, key)
    local obj = indi.effect.gameobj
    if is_null_obj(obj) then
      return
    end
    local x, y, z = hero_pos.x + rx * area_r, hero_pos.y, hero_pos.z + ry * area_r
    local tar = get_nearest_tar(x, z, area_r * 0.3, 4)
    if tar then
      local tx, tz = tar:get_pos2()
      if area_r < _dist_vec2A(tx, tz, hero_pos.x, hero_pos.z) then
        key.show_x, key.show_z = x, z
      else
        key.show_x, key.show_z = tx, tz
      end
    else
      key.show_x, key.show_z = x, z
    end
    indi.tar = tar
    if indi.with_line then
      local angle = _get_angle_vec2A(key.show_x - hero_pos.x, key.show_z - hero_pos.z) or 0
      local len = _dist_vec2A(hero_pos.x, hero_pos.z, key.show_x, key.show_z)
      obj.transform:SetLocalScaleA(1, 1, len)
      obj.transform:SetEulerY(-angle + 90)
      obj.transform:SetPositionA(hero_pos.x, hero_pos.y, hero_pos.z)
    else
      obj.transform:SetLocalScaleA(indi.sizex, 1, indi.sizex)
      obj.transform:SetPositionA(key.show_x, hero_pos.y, key.show_z)
    end
  end,
  [INDI_TYPE.ARROW] = function(indi, hero_pos, rx, ry, area_r, key)
    _ARROW_UPDATE_FUNC(indi, hero_pos, rx, ry, area_r, key)
  end,
  [INDI_TYPE.FIXED_ARROW] = function(indi, hero_pos, rx, ry, area_r, key)
    local obj = indi.effect.gameobj
    if is_null_obj(obj) then
      return
    end
    obj.transform:SetPositionA(hero_pos.x, hero_pos.y, hero_pos.z)
    obj.transform:SetLocalScaleA(indi.sizex, 1, indi.sizey)
    obj.transform:SetEulerY(Global.hero:get_dir())
    Util.VEC3_TEMP_1:Set(obj.transform:GetPositionA())
    local target_pos = Util.VEC3_TEMP:Set(obj.transform:GetForwardA()):Mul(indi.sizey):Add(Util.VEC3_TEMP_1)
    M.set_skill_indi_in_camera(target_pos, hero_pos, nil, key)
  end,
  [INDI_TYPE.SCREEN_CIRCLE] = function(indi, hero_pos, rx, ry, area_r, key)
    local obj = indi.effect.gameobj
    if is_null_obj(obj) then
      return
    end
    local cam = Global.camera
    local cur_cam_fov = cam:get_fov()
    if indi.fov_cache ~= cur_cam_fov then
      indi.fov_cache = cur_cam_fov
      local screen_max_y = _tan(deg2Rad * cur_cam_fov * 0.5) * 2
      local screen_max_x = screen_max_y * _cur_wh_ratio
      indi.ratio_cache_x = Global.screen_width / screen_max_x
      indi.ratio_cache_y = Global.screen_height / screen_max_y
      indi.half_x = screen_max_x * 0.5
      indi.half_y = screen_max_y * 0.5
    end
    obj.transform:SetParent(cam:get_camera_trans())
    local lock_cfg = indi.lock_cfg
    local search_range = lock_cfg.range_ratio * area_r
    local tar_camp = lock_cfg.tar_camp
    local x, y, z = hero_pos.x + rx * area_r, hero_pos.y, hero_pos.z + ry * area_r
    if indi.rx_cahce ~= rx or indi.ry_cahce ~= ry then
      indi.rx_cahce = rx
      indi.ry_cahce = ry
      indi.tar = get_nearest_tar(x, z, search_range, tar_camp)
    end
    local tar = indi.tar
    if tar then
      local trans = indi.tar:get_setting_point(CHEST_POINT) or tar.transform
      local _, y, _ = trans:GetPositionA()
      if search_range < _abs(y - hero_pos.y) then
        indi.tar = nil
      end
    end
    if indi.tar then
      if not indi.vx then
        indi.vx, indi.vy, indi.vz = x, y, z
      end
      local tar = indi.tar
      local px, pz = tar:get_pos2()
      local lerp_ratio = lock_cfg.lerp_ratio
      local trans = indi.tar:get_setting_point(CHEST_POINT) or tar.transform
      local _, ty, _ = trans:GetPositionA()
      y = ty
      indi.vx, indi.vy, indi.vz = _lerp(indi.vx, px, lerp_ratio), _lerp(indi.vy, y, lerp_ratio), _lerp(indi.vz, pz, lerp_ratio)
      x, z = reduce_distance(hero_pos.x, hero_pos.z, area_r, indi.vx, indi.vz)
      y = indi.vy
      local keycode = key.keycode
      M.set_cur_pos(keycode, x, z)
    else
      indi.vx, indi.vy, indi.vz = x, y, z
    end
    local sx, sy = cam:get_camera():GetWorldToScreenPointA(x, y, z)
    local fx = sx / indi.ratio_cache_x - indi.half_x
    local fy = sy / indi.ratio_cache_y - indi.half_y
    fx = _clamp(fx, -indi.half_x, indi.half_x)
    fy = _clamp(fy, -indi.half_y, indi.half_y)
    obj.transform:SetLocalPositionA(fx, fy, 1)
  end,
  [INDI_TYPE.TARGET_POS_ARROW] = function(indi, hero_pos, rx, ry, area_r, key)
    local obj = indi.effect.gameobj
    local trans = obj.transform
    if is_null_obj(obj) then
      return
    end
    local vec3 = M.v_extra_pos_vec3
    if not vec3 then
      return
    end
    trans:SetLocalPositionA(vec3.x, vec3.y, vec3.z)
    trans:SetLocalScaleA(indi.sizex, 1, indi.sizey)
    trans:SetEulerY(Util.get_eulery(rx, ry))
  end,
  [INDI_TYPE.SECTOR_ARROW] = function(indi, hero_pos, rx, ry, area_r, key)
    indi.sizex, indi.sizey = 1.5, 1.5
    _ARROW_UPDATE_FUNC(indi, hero_pos, rx, ry, area_r, key)
    local sector_obj = indi.effect.sector_obj
    local sector_sizex = indi.sizex1 and indi.sizex1 / indi.sizex or indi.sizex
    local sector_sizey = indi.sizey1 and indi.sizez1 / indi.sizez or indi.sizey
    sector_obj.transform:SetLocalScaleA(sector_sizex, 1, sector_sizey)
  end
}
local SPECAIL_KEYS = {
  [Config.INPUT_CODE.AIM_JOYSTICK] = true
}

local function change_effect_obj(effect, color_type)
  if not effect then
    return
  end
  if effect.color_type == color_type then
    return
  end
  effect.color_type = color_type
  if is_null_obj(effect.red_color_obj) or is_null_obj(effect.blue_color_obj) then
    return
  end
  if color_type == INDICATOR_COLOR_TYPE.BLUE then
    effect.blue_color_obj:SetActive(true)
    effect.red_color_obj:SetActive(false)
    effect.green_color_obj:SetActive(false)
  elseif color_type == INDICATOR_COLOR_TYPE.RED then
    effect.blue_color_obj:SetActive(false)
    effect.red_color_obj:SetActive(true)
    effect.green_color_obj:SetActive(false)
  elseif color_type == INDICATOR_COLOR_TYPE.GREEN then
    effect.blue_color_obj:SetActive(false)
    effect.red_color_obj:SetActive(false)
    effect.green_color_obj:SetActive(true)
  end
  effect.gameobj:SetActive(false)
  effect.gameobj:SetActive(true)
end

local function create_effect(path, indi_type)
  local effect = {}
  effect.path_cache = path
  effect.gameobj = ResPoolMgr:get_effect_res(path, true)
  local geted = not is_null_obj(effect.gameobj)
  assert(geted, "技能指示特效路径错误" .. path)
  effect.normalobj = effect.gameobj
  effect.red_color_obj = Util.get_child("Red", effect.gameobj)
  effect.blue_color_obj = Util.get_child("Blue", effect.gameobj)
  effect.green_color_obj = Util.get_child("Green", effect.gameobj)
  if indi_type == INDI_TYPE.SECTOR_ARROW then
    effect.arrow_obj = Util.get_child("Arrow", effect.gameobj)
    effect.sector_obj = Util.get_child("Sector", effect.arrow_obj)
  end
  change_effect_obj(effect, INDICATOR_COLOR_TYPE.BLUE)
  return effect
end

local function destory_effect(cfg)
  if not cfg or not cfg.effect then
    return
  end
  local effect = cfg.effect
  if effect.gameobj and not effect.gameobj.gameObject:IsNull() then
    ResPoolMgr:release(effect.gameobj)
  end
  cfg.effect = nil
end

function M.init(parent_ui)
  M.parent_ui = parent_ui
  M.indicator_inverse = false
  M.setting_attach_target_enable = BattleSettingMgr:get_indicator_attach_target_enable() == Config.SETTING.INDICATOR_ATTACH_TARGET.ON
  M.start_drag_ratio = BattleSettingMgr:get_start_drag_ratio()
  M.behavior_attach_target_enable = false
  M.can_drag_state_map = {}
end

function M.init_uikey(key_code, btn_tf, idx)
  local key = {}
  key.is_new = true
  key.keycode = key_code
  key.is_force_red = nil
  key.v_bg_img = Util.get_image("JoyStickBg", btn_tf)
  local thumb = Util.get_child_gameobj("Thumb" .. idx .. "_", key.v_bg_img.transform)
  key.v_thunmb_img = Util.get_image("Image", thumb)
  key.joy_stick = btn_tf.gameObject:GetComponent(JoystickType)
  key.joy_stick_r = key.joy_stick.MovementRange
  key.start_drag_value = key.joy_stick_r * M.start_drag_ratio
  
  function key.joy_stick.UpdateAction(x, y)
    if M.can_drag(x, y, key.start_drag_value, key_code) then
      M.joy_stick_update(key, x, y)
    end
  end
  
  if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER then
    function key.joy_stick.UpdatePressAfterDragAction(x, y)
      if M.can_drag(x, y, key.start_drag_value, key_code) then
        M.joy_stick_update(key, x, y)
      end
    end
  end
  SkillKeys[key_code] = key
  M.update_skill_active_location()
end

function M.can_drag(x, y, start_drag_value, key_code)
  local com_value = (x * x + y * y) ^ 0.5
  local is_drag = M.can_drag_state_map[key_code]
  if not is_drag and start_drag_value > com_value then
    return false
  end
  if not M.can_drag_state_map[key_code] then
    M.can_drag_state_map[key_code] = true
  end
  return true
end

function M.joy_stick_update(key, x, y)
  local inverse_factor = M.indicator_inverse and -1 or 1
  x = x * inverse_factor
  y = y * inverse_factor
  local _, camera_y = Global.camera:get_euler_angles()
  x, y = _rotate_vec2(x, y, camera_y)
  key.cx = x
  key.cy = y
end

function M.set_indicator_inverse(is_inverse)
  M.indicator_inverse = is_inverse
end

local cancle_btn

function M.init_cancle_ui(cancle_obj)
  local rect = Util.get_rect_transform(nil, cancle_obj)
  cancle_btn = cancle_obj
  local size_x = rect:GetSizeDeltaA()
  local halfr = size_x / 2
  cancle_r2 = halfr * halfr
  if not Util.is_client_only() and BattleSettingMgr:get_skill_cancel_type() == Config.SETTING.CANCEL_SKILL_TYPE.DISTANCE then
    cancle_btn:SetActive(false)
  end
  for _, key in pairs(SkillKeys) do
    key.joy_stick.CancleRect = rect.component
  end
end

function M.on_key_down(key_code)
  M.set_indicator_enable(key_code, true)
end

function M.on_key_up(key_code)
  M.set_indicator_enable(key_code, false)
end

local function process_cfg(cfg, key)
  if not cfg or cfg.res == FX_text_kong then
    return
  end
  local effect = cfg.effect
  if effect and effect.path_cache == cfg.res and not key.is_new then
    local obj = effect.gameobj
    if obj and not obj:IsNull() then
      return
    end
  end
  if effect then
    destory_effect(cfg)
  end
  if not cfg.res then
    return
  end
  if NO_RED_TYEP[cfg.type] then
    key.no_red = true
  end
  cfg.effect = create_effect(cfg.res, cfg.type)
end

function M.get_tar(key_code)
  local key = SkillKeys[key_code]
  local indi = key and key.indi
  return indi and indi.tar
end

function M.clear_tar(key_code)
  local key = SkillKeys[key_code]
  if key and key.indi then
    key.indi.tar = nil
  end
end

function M.process_key(key)
  key.show_x = nil
  key.show_z = nil
end

function M.update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
  local key = SkillKeys[key_code]
  destory_effect(key.area)
  destory_effect(key.indi)
  key.area = area_cfg
  key.indi = indi_cfg
  key.keycode = key_code
  if not Util.is_client_only() then
    key.joy_stick.Sensitivity = BattleSettingMgr:get_indicator_skill_sensitivity()
  else
    key.joy_stick.Sensitivity = sensitivity
  end
  key.v_enable = key.v_enable or false
  key.cx = 0
  key.cy = 0
  process_cfg(area_cfg, key)
  process_cfg(indi_cfg, key)
  if key.v_enable then
    M.set_indicator_enable(key_code, true, true)
  end
  M.process_key(key)
  key.is_new = nil
end

function M.set_indicator_enable(key_code, enable, lock_tar, extra_posx, extra_posz, force_red, reset_to_last_drag)
  local key = SkillKeys[key_code]
  if not key then
    return
  end
  if extra_posx and extra_posz then
    local _, height = Util.raycast_by_role(Global.hero, extra_posx, extra_posz)
    M.v_extra_pos_vec3 = Vec3.New(extra_posx, height, extra_posz)
  end
  if enable then
    M.set_skill_active_location(key)
    if not reset_to_last_drag then
      key.joy_stick:ResetCanClePos()
    end
    local on_enable = INDICATOR_ON_ENABLE[key.indi.type]
    if on_enable then
      on_enable(key.indi)
    end
  elseif not enable and key.v_enable and not reset_to_last_drag then
    M.reset_key(key)
  end
  key.v_enable = enable
  key.is_force_red = force_red
  M.set_skill_show(key_code, enable, lock_tar)
  M.set_ui_show(key_code, enable, reset_to_last_drag)
  if not enable then
    M.can_drag_state_map[key_code] = nil
  end
  if not enable and Global.camera then
    local fight_ui = UIMgr:get_ui("fight")
    if fight_ui and key_code then
      local back_time = fight_ui:get_skill_indi_backtime(key_code)
      if back_time then
        M.v_back_time = Global.time + back_time
      else
        Global.camera:reset_target_offset(true)
      end
    else
      Global.camera:reset_target_offset(true)
    end
  end
end

function M.disable_all()
  for keycode, _ in pairs(SkillKeys) do
    if not SPECAIL_KEYS[keycode] then
      M.set_indicator_enable(keycode, false)
    end
  end
end

function M.reset_key(key)
  key.joy_stick:ResetCanClePos()
  M.cancle = false
end

function M.set_ui_show(key_code, enable, reset_to_last_drag)
  local key = SkillKeys[key_code]
  key.v_bg_img:SetActive(enable)
  if enable and reset_to_last_drag then
    key.joy_stick:ResetToLastPos()
  else
    key.joy_stick:ResetLocalPos()
  end
  M.on_update()
end

local function set_key_cancled(cancled, key)
  local area = key.area
  local indi = key.indi
  local color, alpha, color_type
  if key.is_force_red then
    color, alpha, color_type = WHITE, 1, INDICATOR_COLOR_TYPE.GREEN
  elseif cancled then
    color, alpha, color_type = RED, 0.7, INDICATOR_COLOR_TYPE.RED
  else
    color, alpha, color_type = WHITE, 1, INDICATOR_COLOR_TYPE.BLUE
  end
  Util.set_color(key.v_thunmb_img, color, alpha)
  Util.set_color(key.v_bg_img, color, alpha)
  change_effect_obj(indi.effect, color_type)
  change_effect_obj(area.effect, color_type)
end

local function set_effect_acitve(info, enable)
  if info and info.effect then
    local obj = info.effect.gameobj
    if obj and not obj:IsNull() then
      local status = Util.get_component(nil, obj, TYPE_EFFECT_STATUS)
      local effect_stage = Util.get_component(nil, obj, TYPE_EFFECT_STATE)
      if enable then
        obj:SetActiveEx(true)
        if effect_stage then
          effect_stage:PlayEffectStage(EFFECT_STAGE_START)
        end
        if status then
          status:RestartEffects()
        end
      elseif effect_stage then
        effect_stage:PlayEffectStage(EFFECT_STAGE_END)
      else
        obj:SetActiveEx(false)
      end
    end
  end
end

function M.set_skill_show(key_code, enable, lock_tar)
  local key = SkillKeys[key_code]
  if not key then
    return
  end
  local indi = key.indi
  local area = key.area
  set_effect_acitve(indi, enable)
  set_effect_acitve(area, enable)
  if not enable or not indi then
    return
  end
  if indi.type == INDI_TYPE.ARROW or indi.type == INDI_TYPE.SECTOR_ARROW then
    local dir_vec = Global.hero:get_dir_vec()
    key.cx = dir_vec.x * key.joy_stick_r
    key.cy = dir_vec.z * key.joy_stick_r
  elseif indi.type == INDI_TYPE.CIRCLE then
    key.cx = 0
    key.cy = 0
  end
  local tar = Global.hero:get_target()
  if not lock_tar or not tar then
    return
  end
  local hero_x, hero_z = Global.hero:get_pos2()
  local distance = key.area.sizex / 2
  local tx, tz = tar:get_pos2()
  tx, tz = reduce_distance(hero_x, hero_z, distance, tx, tz)
  M.set_cur_pos(key_code, tx, tz)
end

function M.on_update()
  if SceneMgr:global_hero_is_destroyed() or not Global.camera then
    return
  end
  if M.v_back_time and M.v_back_time < Global.time then
    M.v_back_time = nil
    Global.camera:reset_target_offset(true)
  end
  NEED_RED = false
  IS_UPDATE_POS = false
  local _, cancel_type, cur_pos_x, cur_pos_y, dx, dy, touch_index, touch_count, touch, camara_com, result_pos, result, hero_pos, indi, area, indi_type, r, sizex, vec3, diff_x, diff_z, obj, last_cancle_state
  camara_com = UIMgr.root_camera
  for index, key in pairs(SkillKeys) do
    if not key.v_enable then
    else
      if nil ~= key and not key.no_red then
        NEED_RED = true
      end
      IS_UPDATE_POS = true
      if not Util.is_client_only() then
        cancel_type = BattleSettingMgr:get_skill_cancel_type()
      end
      if cancel_type then
        last_cancle_state = M.cancle
        if cancel_type == Config.SETTING.CANCEL_SKILL_TYPE.BUTTON then
          dx, dy = key.joy_stick:GetCanClePos()
          M.cancle = dx * dx + dy * dy < cancle_r2
        elseif cancel_type == Config.SETTING.CANCEL_SKILL_TYPE.DISTANCE then
          cur_pos_x, cur_pos_y = CSHelper.GetMousePosition()
          if not UNITY_EDITOR and (UNITY_ANDROID or UNITY_IOS) and CSInput.touchCount > 1 and M.parent_ui then
            touch_index = M.parent_ui.touch_index
            touch_count = CSInput.touchCount
            if touch_count >= touch_index + 1 and touch_index > -1 then
              cur_pos_x, cur_pos_y = CSHelper.GetTouch(touch_index)
            end
          end
          local dx, dy = CSHelper.ScreenPointToLocalPointInRectangle(key.joy_stick.BaseRectTrans, cur_pos_x, cur_pos_y, camara_com)
          result = dx * dx + dy * dy
          M.cancle = result > distance_cancle_r2
        end
      else
        dx, dy = key.joy_stick:GetCanClePos()
        M.cancle = dx * dx + dy * dy < cancle_r2
      end
      hero_pos = Global.hero:get_pos_vec3()
      indi = key.indi
      area = key.area
      if indi then
        indi_type = indi.type
      end
      if indi_type and indi_type == INDI_TYPE.TARGET_POS_ARROW then
        sizex = area.sizex / 2
        vec3 = M.v_extra_pos_vec3
        if vec3 then
          diff_x = vec3.x - hero_pos.x
          diff_z = vec3.z - hero_pos.z
          M.cancle = diff_x * diff_x + diff_z * diff_z > sizex * sizex
        end
      end
      set_key_cancled(M.cancle, key)
      r = key.joy_stick_r
      if area and AREA_ON_UPDATE[area.type] and area.effect then
        obj = area.effect.gameobj
        if not is_null_obj(obj) then
          AREA_ON_UPDATE[area.type](area, hero_pos, key.cx / r, key.cy / r)
        end
      end
      if indi and INDI_ON_UPDATE[indi.type] and indi.effect then
        INDI_ON_UPDATE[indi.type](indi, hero_pos, key.cx / r, key.cy / r, area.sizex / 2, key)
      end
      if last_cancle_state ~= M.cancle then
        M.parent_ui:set_cancle_image(M.cancle)
      end
    end
  end
  if (Util.is_client_only() or BattleSettingMgr:get_skill_cancel_type() == Config.SETTING.CANCEL_SKILL_TYPE.BUTTON) and not Util.is_nil(cancle_btn) then
    cancle_btn:SetActiveEx(NEED_RED)
  end
  if IS_UPDATE_POS then
    Global.hero:update_face_pos()
  end
end

function M.set_key_cur_pos(key_code, wx, wy)
  local hero_pos = Global.hero:get_pos_vec3()
  local key = SkillKeys[key_code]
  assert(key, "no such key" .. key_code)
  local area = key.area
  local max_ui_r = key.joy_stick_r
  local dx, dy = wx - hero_pos.x, wy - hero_pos.z
  if area and 0 ~= area.sizex then
    local max_r = area.sizex / 2
    Util.VEC3_TEMP:Set(dx, 0, dy)
    Util.VEC3_TEMP:ClampMagnitude(max_r)
    dx, dy = Util.VEC3_TEMP.x, Util.VEC3_TEMP.z
    key.cx, key.cy = dx / max_r * max_ui_r, dy / max_r * max_ui_r
  else
    key.cx, key.cy = dx / 10 * max_ui_r, dy / 10 * max_ui_r
  end
end

function M.set_cur_pos(key_code, wx, wy)
  M.set_key_cur_pos(key_code, wx, wy)
  M.on_update()
end

function M.get_cur_pos(key_code)
  local key = SkillKeys[key_code]
  assert(key, "no such key" .. key_code)
  local wx, wy
  local area = key.area
  local hero_pos = Global.hero:get_pos_vec3()
  local r = key.joy_stick_r
  local rx, ry = (key.cx or 0) / r, (key.cy or 0) / r
  local indi = key.indi
  if not indi then
    return
  end
  local type
  if indi then
    type = indi.type
  end
  local extra_pos = M.v_extra_pos_vec3
  if key.show_x and key.show_z then
    if type == INDI_TYPE.ARROW or indi.type == INDI_TYPE.SECTOR_ARROW then
      local area_r = area.sizex / 2
      wx, wy = hero_pos.x + key.show_x * area_r, hero_pos.z + key.show_z * area_r
    else
      wx, wy = key.show_x, key.show_z
    end
    return wx, wy
  end
  if indi.vx and indi.vz then
    return indi.vx, indi.vz
  end
  local use_pos = hero_pos
  if type and type == INDI_TYPE.TARGET_POS_ARROW and extra_pos then
    use_pos = extra_pos
  end
  if area then
    local area_r = area.sizex / 2
    wx, wy = use_pos.x + rx * area_r, use_pos.z + ry * area_r
  else
    local virturl_r = 10
    wx, wy = use_pos.x + rx * virturl_r, use_pos.z + ry * virturl_r
  end
  return wx, wy
end

function M.on_uifight_delete()
  for keycode, key in pairs(SkillKeys) do
    destory_effect(key.indi)
    destory_effect(key.area)
  end
  M.v_extra_pos_vec3 = nil
  M.parent_ui = nil
  UtilTable.clear_map(SkillKeys)
  SkillKeys = {}
  cancle_btn = nil
end

function M.set_is_force_red(key_code, is_force_red)
  local key = SkillKeys[key_code]
  key.is_force_red = is_force_red
end

function M.get_key(key_code)
  local key = SkillKeys[key_code]
  if not key then
    return
  end
  return key
end

function M.set_skill_active_location(key)
  local skill_active
  if not Util.is_client_only() then
    skill_active = BattleSettingMgr:get_skill_active_location()
  else
    skill_active = Config.SETTING.SKILL_ACTIVE_LOCATION.FIXED
  end
  if skill_active == Config.SETTING.SKILL_ACTIVE_LOCATION.FIXED then
    key.joy_stick.NeedFloowTouch = false
  else
    key.joy_stick.NeedFloowTouch = true
  end
end

function M.update_skill_active_location()
  for _, key in pairs(SkillKeys) do
    M.set_skill_active_location(key)
  end
end

function M.set_skill_indi_in_camera(target_pos, hero_pos, camera_obj, key)
  camera_obj = camera_obj or Global.camera:get_camera_obj()
  local far_pos = Util.VEC3_TEMP_1:SetB(target_pos):Sub(hero_pos):SetNormalize():Add(target_pos)
  local target_pos_in = CSHelper.IsInCameraA(camera_obj, target_pos:Get())
  local far_pos_in = CSHelper.IsInCameraA(camera_obj, far_pos:Get())
  if target_pos_in and not far_pos_in then
    Global.camera:stop_target_offset()
  elseif target_pos_in and far_pos_in then
    Global.camera:reset_target_offset()
  elseif not target_pos_in and not key.is_force_red then
    Global.camera:start_target_offset((target_pos - hero_pos) * 0.5)
  end
end

function M.get_indicator_key_pos(key_code)
  local key = SkillKeys[key_code]
  if not key then
    return 0, 0
  end
  return key.cx or 0, key.cy or 0
end

function M.set_attach_target_enable(enable)
  M.behavior_attach_target_enable = enable
end

function M.reset_start_drag_ratio()
  M.start_drag_ratio = BattleSettingMgr:get_start_drag_ratio()
  for _, key in pairs(SkillKeys) do
    key.start_drag_value = key.joy_stick_r * M.start_drag_ratio
  end
end

return M
