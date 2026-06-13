local M = Util.create_class()
local _floor = math.floor
local TypeTMP = typeof(CS.TMPro.TextMeshProUGUI)
local TypeUIContainer = typeof(CS.UIContainer)
local TypeDOTween = typeof(CS.DG.Tweening.DOTweenAnimation)
local EMPTY_STR = ""
local TMP_Sprite_Color_Template = "<sprite index=%s color=%s>"
local TMP_Sprite_Template = "<sprite=%s>"
local UIDYNAMIC_CANVAS = "uidynamic_canvas"
local vec3 = require("base.vec3")
local quat = require("base.quat")
local TEMP_QUAT = quat.New()
local TEMP_VEC3 = Util.VEC3_TEMP
local BLOOD_TYPE = Global.BloodHelper.BLOOD_TYPE
M.BLOOD_TYPE = BLOOD_TYPE
local ROOT_NAME = Global.BloodHelper.ROOT_NAME
M.ROOT_NAME = ROOT_NAME
local LANGUAGE_INDEX = Config.CommonDefine.LANGUAGE_INDEX
local BLOOD_ATTACH = Global.BloodHelper.BLOOD_ATTACH
local LIVE_TIME = ShareRes.get_comm_value("DamageNumLifeTime") or 1
local BLOOD_CONFIG = {
  [M.BLOOD_TYPE.NORMAL] = {
    dotween_id = 1001001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.NORMAL_HERO] = {
    dotween_id = 1002001,
    color = tonumber("EF2832", 16)
  },
  [M.BLOOD_TYPE.NORMAL_HEAL] = {
    dotween_id = 1003001,
    color = tonumber("2CF07E", 16)
  },
  [M.BLOOD_TYPE.NORMAL_CRIT] = {
    dotween_id = 1003001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.NORMAL_HERO_CRIT] = {
    dotween_id = 1003001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.SHILED_BLOCK_RED] = {
    dotween_id = 1003001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.SHILED_BLOCK_WHITE] = {
    dotween_id = 1003001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.ABNOR_TRI_HURT] = {
    dotween_id = 1001001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.ABNOR_DMG_HURT] = {
    dotween_id = 1001001,
    color = tonumber("FFFFFF", 16)
  },
  [M.BLOOD_TYPE.ABNOR_FONT] = {
    dotween_id = 1001001,
    color = tonumber("FFFFFF", 16)
  }
}
local ABNOR_TYPE_COUNT = UtilTable.hash_lenth(Config.FightDefine.ELEMENT_TYPE)
local ABNOR_ICON_INDEX_OFFSET = -1
local ABNOR_FONT_INDEX_ADD_OFFSET = 26
local ABNOR_FONT_INDEX_MULT_OFFSET = 10
local ABNOR_FONT_INDEX_SPECIAL_OFFSET = 86
local SHIELD_DMG_INDEX_ADD_OFFSET = 16
local ABNORMAL_TYPE_DESC = Config.FightDefine.ELEMENT_TO_AB_ATTR
local PHYSICS = Config.FightDefine.ELEMENT_TYPE.BASE

function M:_init(...)
  self.v_target_deg = 0
  self.v_random_angle = 0
  self.v_go_bind_pos_x, self.v_go_bind_pos_y, self.v_go_bind_pos_z = nil, nil, nil
  self:play_hurt_anim(...)
end

function M:get_tmp_string(exhartype, damage, color)
  local offset = 6
  return offset
end

function M:get_abnor_hurt_tmp_string(element_id, damage)
  local offset
  if ABNORMAL_TYPE_DESC[element_id] then
    local index = element_id + ABNOR_ICON_INDEX_OFFSET
    offset = ABNOR_FONT_INDEX_ADD_OFFSET + index * ABNOR_FONT_INDEX_MULT_OFFSET
  end
  return offset
end

function M:get_abnor_font_tmp_string(element_id)
  local offset
  if ABNORMAL_TYPE_DESC[element_id] then
    local index = element_id + ABNOR_ICON_INDEX_OFFSET
    local text_offset = (LANGUAGE_INDEX[Global.curr_text_language] + ABNOR_ICON_INDEX_OFFSET) * ABNOR_TYPE_COUNT
    offset = index + ABNOR_FONT_INDEX_SPECIAL_OFFSET + text_offset
  end
  return offset
end

function M:get_shield_block_tmp_string(damage)
  local offset = SHIELD_DMG_INDEX_ADD_OFFSET
  return offset
end

function M:load_gameobj(is_main_hurt, is_crit, callback, blood_type)
  local ui = UIMgr:get_ui(UIDYNAMIC_CANVAS, true)
  if not ui then
    return
  end
  local prefab_name = Global.BloodHelper.get_anim_prefab(is_main_hurt, is_crit, blood_type)
  local random_data = ShareRes.get_comm_string_value(prefab_name)
  local rotate_max, rotate_min, dist_max, dist_min = random_data[1], random_data[2], random_data[3], random_data[4]
  if rotate_min and rotate_max and not Util.almost_zero(rotate_min - rotate_max) then
    self.v_random_rotate_max = rotate_max
    self.v_random_rotate_min = rotate_min
    FightDataMgr:set_damage_hud_random_range_data(rotate_min, rotate_max, 5, blood_type)
  end
  if dist_min and dist_max and not Util.almost_zero(dist_min - dist_max) then
    self.v_random_dist_max = dist_max
    self.v_random_dist_min = dist_min
  end
  self.v_root_name = ROOT_NAME[blood_type] or ROOT_NAME[BLOOD_TYPE.NORMAL]
  ResPoolMgr:get_ui_font_async(prefab_name, function(go)
    self.v_go = go
    self:init_container()
    self.v_go_trans = go.transform
    self.v_rect_tf = Util.get_rect_transform(nil, go)
    self.v_font_num_init_scale = self.FontNum_TMP.transform:GetLocalScaleA3()
    self.v_damage_tmp = Util.get_component(nil, self.FontNum_TMP, TypeTMP)
    self.canvas_grp = Util.get_canvas_group(nil, self.FontNum_TMP)
    self.v_dotween = Util.get_component(nil, self.DOTween, TypeDOTween).component
    self.v_dotween_canvas = Util.get_canvas_group(nil, self.DOTween)
    self.v_submove_dotween = Util.get_component(nil, self.SubMove, TypeDOTween)
    self.v_submove_canvas = Util.get_canvas_group(nil, self.SubMove)
    self:init_dotween_data()
    local uidynamic_canvas = UIMgr:try_get_loaded_ui(UIDYNAMIC_CANVAS)
    if not uidynamic_canvas then
      Global.BloodHelper.get_lua_obj_pool(is_main_hurt, is_crit, blood_type):destroy_obj(self)
      return
    end
    self.v_go_trans:SetParent(uidynamic_canvas:get_root_trans_by_name(self.v_root_name))
    callback()
  end)
end

function M:init_dotween_data()
  local end_value_x, end_value_y, end_value_z = self.v_dotween:GetEndValue()
  self.v_move_duration = self.v_dotween.duration
  local init_pos_x, init_pos_y, init_pos_z = self.v_dotween.transform:GetLocalPositionA3()
  self.v_init_dotween_pos = vec3.New()
  self.v_init_dotween_pos:Set(init_pos_x, init_pos_y, init_pos_z)
  self.v_end_dir = vec3.New()
  self.v_end_dir:Set(end_value_x - init_pos_x, end_value_y - init_pos_y, end_value_z - init_pos_z)
  self.v_end_dir:SetNormalize()
  self.v_init_dist = math.sqrt(end_value_x * end_value_x + end_value_y * end_value_y + end_value_z * end_value_z)
  self.v_tmp_init_pos_x, self.v_tmp_init_pos_y, self.v_tmp_init_pos_z = self.FontNum_TMP.transform:GetLocalPositionA3()
end

function M:init_container()
  local ui_container = Util.get_component(nil, self.v_go, TypeUIContainer)
  if ui_container then
    local list_name = ui_container.ListName
    local list_objects = ui_container.ListObj
    for i = 0, list_name.Count - 1 do
      local name = list_name[i]
      local object = list_objects[i]
      self[name] = object
    end
  end
end

function M:set_text(exhartype, damage, blood_info, is_crit, blood_type)
  damage = math.abs(damage)
  local offset, color
  if blood_type == BLOOD_TYPE.ABNOR_TRI_HURT or blood_type == BLOOD_TYPE.ABNOR_DMG_HURT then
    offset = self:get_abnor_hurt_tmp_string(exhartype, damage)
  elseif blood_type == BLOOD_TYPE.NORMAL_HERO or blood_type == BLOOD_TYPE.NORMAL_HERO_CRIT then
    offset = self:get_tmp_string(exhartype, damage, blood_info.color)
    color = blood_info.color
  elseif blood_type == BLOOD_TYPE.ABNOR_FONT then
    offset = self:get_abnor_font_tmp_string(exhartype)
    damage = 0
  elseif blood_type == BLOOD_TYPE.SHILED_BLOCK_RED or blood_type == BLOOD_TYPE.SHILED_BLOCK_WHITE then
    offset = self:get_shield_block_tmp_string(damage)
  elseif exhartype and exhartype <= PHYSICS then
    offset = self:get_tmp_string(exhartype, damage, blood_info.color)
    color = blood_info.color
  else
    offset = self:get_abnor_hurt_tmp_string(exhartype, damage)
  end
  if not offset then
    return
  end
  if color then
    self.v_damage_tmp:SetCommonDamageHudText(damage, offset, color)
  else
    self.v_damage_tmp:SetCommonDamageHudText(damage, offset)
  end
end

function M:play_anim(is_main_hurt, is_crit, position, blood_type)
  local ui = UIMgr:get_ui(UIDYNAMIC_CANVAS, true)
  if ui then
    ui:add_damage_hud_to_update_list(self)
  end
  self.canvas_grp.alpha = 1
  self.v_dotween_canvas.alpha = 1
  self.v_submove_canvas.alpha = 0
  local damage_font_size = BattleSettingMgr:get_damage_font_size()
  if damage_font_size ~= Config.SETTING.DAMAGE_FONT_SIZE_TYPE.HIDE then
    self.FontNum_TMP:ResetAttr()
    self.FontNum_TMP.transform:SetLocalPositionA(self.v_tmp_init_pos_x, self.v_tmp_init_pos_y, self.v_tmp_init_pos_z)
    self.v_go_trans:SetLocalScaleA(1, 1, 1)
    local scale = self.v_font_num_init_scale * damage_font_size
    self.FontNum_TMP.transform:SetLocalScaleA(scale, scale, scale)
    self.v_go_trans:SetAnchoredPositionA(position.x, position.y)
    self.v_blood_type = blood_type
    local need_reevaluate = self:check_need_reevaluate()
    self.v_dotween:DORestart(need_reevaluate)
    self.v_submove_dotween:DORestart()
    if self.v_remove_timer then
      Timer:remove_timer(self.v_remove_timer)
      self.v_remove_timer = nil
    end
    self.v_remove_timer = Timer:add_timer(nil, LIVE_TIME, function()
      local uidynamic_canvas = UIMgr:try_get_loaded_ui(UIDYNAMIC_CANVAS, true)
      if uidynamic_canvas then
        uidynamic_canvas:remove_damage_hud_at_update_list(self)
      end
      Global.BloodHelper.get_lua_obj_pool(is_main_hurt, is_crit, blood_type):destroy_obj(self)
    end)
  end
end

function M:check_need_reevaluate()
  if self.v_random_rotate_max and self.v_random_rotate_min then
    self.v_random_angle = FightDataMgr:try_get_damage_hud_random_angle(self.v_blood_type)
  end
  local deg
  local temp_deg = (self.v_target_deg + self.v_random_angle) % 360
  if temp_deg > 0 then
    deg = 360 - temp_deg
  else
    deg = math.abs(temp_deg)
  end
  TEMP_QUAT:SetEuler(0, 0, deg + 45)
  TEMP_VEC3:SetA(self.v_end_dir)
  TEMP_VEC3:MulQuat(TEMP_QUAT)
  local dist = self.v_init_dist
  if self.v_random_dist_max and self.v_random_dist_min then
    local coeffcient = math.random(self.v_random_dist_min, self.v_random_dist_max)
    dist = dist + coeffcient
  end
  TEMP_VEC3:Mul(dist)
  self.v_dotween.endValueV3 = TEMP_VEC3
  self.v_dotween.transform:SetLocalPositionA(self.v_init_dotween_pos:Get())
  return true
end

function M:play_hurt_anim(blood_type, npc, damage, exhartype, is_crit, point, is_main_hurt, pos, init_pos, init_deg)
  damage = _floor(damage)
  if init_deg then
    self.v_target_deg = init_deg
  end
  if is_crit and blood_type == M.BLOOD_TYPE.NORMAL then
    blood_type = M.BLOOD_TYPE.NORMAL_CRIT
  end
  local blood_info = BLOOD_CONFIG[blood_type]
  if not blood_info then
    return
  end
  local position
  if not pos then
    if not npc and not Util.is_destroy(Global.hero) then
      npc = Global.hero
    end
    if npc then
      position = Global.BloodHelper.get_pos(npc, point or BLOOD_ATTACH)
    else
      position = Util.VEC3_TEMP.zero
    end
  else
    position = pos
  end
  if init_pos then
    self.v_go_bind_pos_x, self.v_go_bind_pos_y, self.v_go_bind_pos_z = init_pos.x, init_pos.y, init_pos.z
  end
  if self.v_go and not self.v_go:IsNull() then
    self:set_text(exhartype, damage, blood_info, is_crit, blood_type)
    self:play_anim(is_main_hurt, is_crit, position, blood_type)
  else
    self:load_gameobj(is_main_hurt, is_crit, function()
      self:set_text(exhartype, damage, blood_info, is_crit, blood_type)
      self:play_anim(is_main_hurt, is_crit, position, blood_type)
    end, blood_type)
  end
end

function M:on_release()
  if self.v_go then
    ResPoolMgr:release(self.v_go)
    self.v_go = nil
    self.v_go_trans = nil
    self.v_rect_tf = nil
  end
end

function M:on_destroy()
  if not Util.is_nil(self.v_go_trans) then
    self.v_go_trans:SetLocalPositionA(-10000, -10000, 0)
  end
  self.v_go_bind_pos_x, self.v_go_bind_pos_y, self.v_go_bind_pos_z = nil, nil, nil
  if self.v_remove_timer then
    Timer:remove_timer(self.v_remove_timer)
    self.v_remove_timer = nil
  end
  FightDataMgr:remove_damage_hud_random_angle(self.v_random_angle, self.v_blood_type)
  self.v_target_deg = 0
  self.v_random_angle = 0
end

function M:update()
  if not Util.is_nil(self.v_go_trans) and self.v_go_bind_pos_x and self.v_go_bind_pos_y and self.v_go_bind_pos_z then
    Util.set_ui_follow_pos(self.v_rect_tf.component, self.v_go_bind_pos_x, self.v_go_bind_pos_y, self.v_go_bind_pos_z)
  end
end

return M
