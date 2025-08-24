local Vec3 = require("base.vec3")
local M = {}
Global.BloodHelper = M
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local BLOOD_TYPE = {
  NORMAL = 1,
  NORMAL_HERO = 2,
  NORMAL_HEAL = 3,
  NORMAL_CRIT = 4,
  NORMAL_HERO_CRIT = 5,
  SHILED_BLOCK_RED = 6,
  SHILED_BLOCK_WHITE = 7,
  ABNOR_TRI_HURT = 8,
  ABNOR_FONT = 9,
  ABNOR_DMG_HURT = 10
}
M.BLOOD_TYPE = BLOOD_TYPE
local ROOT_NAME = {
  [BLOOD_TYPE.NORMAL] = "NormalHurtRoot",
  [BLOOD_TYPE.NORMAL_HERO] = "HeroNormalHurtRoot",
  [BLOOD_TYPE.NORMAL_HEAL] = "HpRoot",
  [BLOOD_TYPE.NORMAL_CRIT] = "NormalCritHurtRoot",
  [BLOOD_TYPE.NORMAL_HERO_CRIT] = "HeroNormalCritHurtRoot",
  [BLOOD_TYPE.SHILED_BLOCK_RED] = "ShieldHurtRoot",
  [BLOOD_TYPE.SHILED_BLOCK_WHITE] = "HeroShieldHurtRoot",
  [BLOOD_TYPE.ABNOR_TRI_HURT] = "AbnormalTriggerHurtRoot",
  [BLOOD_TYPE.ABNOR_FONT] = "AbnormalFontHurtRoot",
  [BLOOD_TYPE.ABNOR_DMG_HURT] = "AbnormalEffectHurtRoot"
}
M.ROOT_NAME = ROOT_NAME
local BLOOD_ATTACH = "Bip001 Chest"
local HURT_ANIM = {
  [BLOOD_TYPE.ABNOR_DMG_HURT] = "AbnormalEffect",
  [BLOOD_TYPE.ABNOR_TRI_HURT] = "AbnormalTrigger",
  [BLOOD_TYPE.ABNOR_FONT] = "AbnormalFont",
  [BLOOD_TYPE.SHILED_BLOCK_RED] = "ShieldHurt",
  [BLOOD_TYPE.SHILED_BLOCK_WHITE] = "HeroShieldHurt",
  [BLOOD_TYPE.NORMAL_HERO] = {
    [true] = "HeroMainHurt",
    [false] = "HeroSubHurt"
  },
  [BLOOD_TYPE.NORMAL_HERO_CRIT] = {
    [true] = "HeroMainHurtCrit",
    [false] = "HeroSubHurtCrit"
  },
  [BLOOD_TYPE.NORMAL] = {
    [true] = "MainHurt",
    [false] = "SubHurt"
  },
  [BLOOD_TYPE.NORMAL_CRIT] = {
    [true] = "MainHurtCrit",
    [false] = "SubHurtCrit"
  },
  [true] = {
    [true] = "MainHurtCrit",
    [false] = "MainHurt"
  },
  [false] = {
    [true] = "SubHurtCrit",
    [false] = "SubHurt"
  }
}
local FREQUENT_USE_BLOOD = {
  [BLOOD_TYPE.NORMAL_HERO] = true,
  [BLOOD_TYPE.NORMAL_HERO_CRIT] = true,
  [BLOOD_TYPE.NORMAL] = true,
  [BLOOD_TYPE.NORMAL_CRIT] = true
}
local POOL_NAME = {}
local STRING_TAG = "string"
local TABLE_TAG = "table"
local Common_Hurt_Hud = require("uimodule.fight.hud.common_damage_hud")

function M.get_anim_prefab(is_main_hurt, is_crit, blood_type)
  if HURT_ANIM[blood_type] then
    local _type = type(HURT_ANIM[blood_type])
    if _type == STRING_TAG then
      return HURT_ANIM[blood_type]
    elseif _type == TABLE_TAG then
      return HURT_ANIM[blood_type][is_main_hurt]
    end
  else
    return HURT_ANIM[is_main_hurt][is_crit]
  end
end

function M.get_lua_obj_pool(is_main_hurt, is_crit, blood_type)
  local prefab_name = M.get_anim_prefab(is_main_hurt, is_crit, blood_type)
  local pool_name = POOL_NAME[prefab_name]
  if not pool_name then
    pool_name = "common_hud_pool_" .. prefab_name
    POOL_NAME[prefab_name] = pool_name
  end
  return LuaObjPoolMgr.get_pool(pool_name) or LuaObjPoolMgr.register(pool_name, 15, Common_Hurt_Hud)
end

local _tween_handler_dic = {}

function M.cache_tween_handler(handler, action)
  _tween_handler_dic[handler] = action
end

function M.remove_single_handler(handler)
  _tween_handler_dic[handler] = nil
  handler:Kill(false)
end

function M.clear_tween_handler()
  for handler, action in pairs(_tween_handler_dic) do
    handler:Kill(false)
    action:do_cb()
  end
  _tween_handler_dic = {}
end

local _is_ignore = false

function M.ignore(is_ignore)
  _is_ignore = is_ignore
end

function M.play_hurt_dmg(npc, base_dmg, element_dmg, element_type, is_crit, attach_point, suc_immune, init_deg)
  if not npc then
    return
  end
  local pos_base, init_pos = M.get_pos(npc, attach_point, 20, 10)
  local pos_element = Vec3.New(pos_base.x, pos_base.y + 40, pos_base.z)
  if npc.get_floating_text_hud_visible ~= nil and npc:get_floating_text_hud_visible() == false then
    return
  end
  local blood_type
  if npc.uuid == Global.hero_uuid then
    blood_type = is_crit and BLOOD_TYPE.NORMAL_HERO_CRIT or BLOOD_TYPE.NORMAL_HERO
  else
    blood_type = is_crit and BLOOD_TYPE.NORMAL_CRIT or BLOOD_TYPE.NORMAL
  end
  if 0 ~= base_dmg then
    M.play_blood_animation(blood_type, npc, base_dmg, 1, is_crit, attach_point, element_dmg < base_dmg, pos_base, init_pos, init_deg)
  end
  if 0 ~= element_dmg or true == suc_immune then
    M.play_blood_animation(blood_type, npc, element_dmg, element_type, is_crit, attach_point, base_dmg <= element_dmg, pos_element, init_pos, init_deg)
  end
end

function M.play_abnor_trigger_hurt_dmg(npc, abnor_hurt, element_type, attach_point, init_deg)
  if not npc then
    return
  end
  local pos_base, init_pos = M.get_pos(npc, attach_point, 20, 10)
  local pos_element = Vec3.New(pos_base.x, pos_base.y + 40, pos_base.z)
  if npc.get_floating_text_hud_visible ~= nil and npc:get_floating_text_hud_visible() == false then
    return
  end
  if 0 ~= abnor_hurt then
    M.play_blood_animation(BLOOD_TYPE.ABNOR_TRI_HURT, npc, abnor_hurt, element_type, false, attach_point, true, pos_element, init_pos, init_deg)
  end
end

function M.play_abnor_hurt_dmg(npc, abnor_hurt, element_type, attach_point, init_deg)
  if not npc then
    return
  end
  local pos_base, init_pos = M.get_pos(npc, attach_point, 20, 10)
  local pos_element = Vec3.New(pos_base.x, pos_base.y + 40, pos_base.z)
  if npc.get_floating_text_hud_visible ~= nil and npc:get_floating_text_hud_visible() == false then
    return
  end
  if 0 ~= abnor_hurt then
    M.play_blood_animation(BLOOD_TYPE.ABNOR_DMG_HURT, npc, abnor_hurt, element_type, false, attach_point, true, pos_element, init_pos, init_deg)
  end
end

function M.play_abnor_font(npc, element_type, attach_point, init_deg)
  if not npc then
    return
  end
  local pos_base, init_pos = M.get_pos(npc, attach_point)
  local pos_element = Vec3.New(pos_base.x, pos_base.y + 40, pos_base.z)
  if npc.get_floating_text_hud_visible ~= nil and npc:get_floating_text_hud_visible() == false then
    return
  end
  M.play_blood_animation(BLOOD_TYPE.ABNOR_FONT, npc, 0, element_type, false, attach_point, true, pos_element, init_pos, init_deg)
end

function M.play_shiled_block(npc, blocked_val, attach_point, init_deg)
  if not npc then
    return
  end
  local pos_base, init_pos = M.get_pos(npc, attach_point)
  local pos_element = Vec3.New(pos_base.x, pos_base.y + 40, pos_base.z)
  if npc.get_floating_text_hud_visible ~= nil and npc:get_floating_text_hud_visible() == false then
    return
  end
  local blood_type = npc.uuid == Global.hero_uuid and BLOOD_TYPE.SHILED_BLOCK_WHITE or BLOOD_TYPE.SHILED_BLOCK_RED
  M.play_blood_animation(blood_type, npc, blocked_val, nil, nil, attach_point, nil, pos_element, init_pos, init_deg)
end

function M.get_pos(npc, attach_point)
  if not npc then
    return Vec3.zero
  end
  local point_name = attach_point or BLOOD_ATTACH
  local attach = npc:get_setting_point(point_name)
  if not attach then
    Log.Error("角色缺少挂点，伤害飘字失败，", npc.uuid, npc:get_npc_id(), point_name, debug.traceback())
    return Vec3.zero
  end
  local attach_pos = attach.position
  Util.VEC3_TEMP:Set(attach_pos.x, attach_pos.y, attach_pos.z)
  local camera = Global.camera:get_camera()
  Util.VEC3_TEMP.x = Util.VEC3_TEMP.x
  Util.VEC3_TEMP.y = Util.VEC3_TEMP.y
  local position = camera:WorldToViewportPoint(Util.VEC3_TEMP)
  if Global.ui_dynamic_canvas then
    position.x = position.x * Global.ui_dynamic_canvas:get_rect_size_delta_x()
    position.y = position.y * Global.ui_dynamic_canvas:get_rect_size_delta_y()
  end
  return position, attach_pos
end

function M.play_blood_animation(blood_type, npc, damage, exhartype, is_crit, point, is_main_hurt, pos, init_pos, init_deg)
  if _is_ignore then
    return
  end
  if npc and not npc:is_role() then
    return
  end
  local damage_font_size = BattleSettingMgr:get_damage_font_size()
  if damage_font_size == Config.SETTING.DAMAGE_FONT_SIZE_TYPE.HIDE then
    return
  end
  is_crit = is_crit or false
  is_main_hurt = is_main_hurt or false
  local pool = M.get_lua_obj_pool(is_main_hurt, is_crit, blood_type)
  pool:new_obj(blood_type, npc, damage, exhartype, is_crit, point, is_main_hurt, pos, init_pos, init_deg)
end

function M.preload_common_hud()
  local time
  for index, blood_type in pairs(BLOOD_TYPE) do
    time = nil ~= FREQUENT_USE_BLOOD[blood_type] and 4 or 2
    for i = 1, time do
      M.play_blood_animation(blood_type, nil, 1, nil, false, nil, true)
    end
  end
end

return M
