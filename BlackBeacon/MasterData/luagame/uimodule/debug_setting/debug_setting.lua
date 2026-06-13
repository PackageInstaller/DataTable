local Util = require("utils.util")
local M = Util.create_class()
local Local_Storage = require("utils.localstorage")
local Setting_Key = Global.config.START_SETTING_KEY

local function int2bool(val)
  return 1 == val and true or false
end

local function bool2int(boolval)
  return boolval and 1 or 0
end

function M:_init()
  self.v_version = 4
  self.v_role_list = {
    1001001,
    0,
    0
  }
  self.v_fixed_buddy_list = {}
  self.v_monster_id = 0
  self.v_born_pos = {
    x = 0,
    y = 0,
    z = 0
  }
  self.v_tower_id = 211
  self.v_camera_id = 0
  self.v_enter_chapter = 1
  self.v_no_play_sound = 0
  self.v_show_res_log = 0
  self.v_client_only = 0
  self.v_need_reload = 0
  self.v_check_game_update = 0
  self.v_room_id = 0
  self.v_born_key = ""
  self.v_god_id = 3001039
  self.v_operate_charId = 0
  self.v_is_show_all_arrow_fx = 1
  self:load_setting()
end

function M:get_role_list()
  return self.v_role_list
end

function M:get_fixed_buddy_list()
  return self.v_fixed_buddy_list
end

function M:get_challenge_type()
  return self.v_challenge_type
end

function M:get_fixed_buddy_by_role_id(role_id)
  for key, fixed_id in pairs(self.v_fixed_buddy_list) do
    if fixed_id > 0 then
      local cfg = ShareRes.get_fixed_buddy_config(fixed_id)
      if cfg and cfg.BuddyId == role_id then
        return fixed_id
      end
    end
  end
end

function M:get_monster_id()
  return self.v_monster_id
end

function M:get_tower_id()
  return self.v_tower_id
end

function M:get_tower_floor_id()
  return self.v_tower_floor_id
end

function M:get_tower_room_id()
  return self.v_tower_room_id
end

function M:get_born_pos()
  return self.v_born_pos
end

function M:get_camera_id()
  return self.v_camera_id
end

function M:get_room_id()
  return self.v_room_id
end

function M:get_born_key()
  return self.v_born_key
end

function M:get_god_id()
  return Util.is_more_than_zero(self.v_god_id) and self.v_god_id or 3001039
end

function M:get_operate_char_id()
  return self.v_operate_charId or 0
end

function M:set_role_list(role_list)
  for i = 1, 3 do
    self.v_role_list[i] = role_list[i] or 0
  end
end

function M:set_fixed_buddy_list(fixed_buddy_list)
  for i = 1, 3 do
    self.v_fixed_buddy_list[i] = fixed_buddy_list[i]
  end
end

function M:set_challenge_type(challenge_type)
  self.v_challenge_type = Util.is_empty(challenge_type) and 0 or tonumber(challenge_type)
end

function M:set_monster_id(monster_id)
  self.v_monster_id = monster_id or 0
end

function M:set_born_pos(x, y, z)
  local born_pos = self.v_born_pos
  born_pos.x = x or 0
  born_pos.y = y or 0
  born_pos.z = z or 0
end

function M:set_tower_id(tower_id)
  self.v_tower_id = tower_id or 0
end

function M:set_tower_floor_id(floor_id)
  self.v_tower_floor_id = floor_id or 0
end

function M:set_tower_room_id(room_id)
  self.v_tower_room_id = room_id or 0
end

function M:set_camera_id(camera_id)
  self.v_camera_id = camera_id or 0
end

function M:set_client_only(is_on)
  self.v_client_only = bool2int(is_on)
end

function M:set_enter_chapter(is_on)
  self.v_enter_chapter = bool2int(is_on)
end

function M:set_no_play_sound(is_on)
  self.v_no_play_sound = bool2int(is_on)
end

function M:set_show_res_load_log(is_on)
  self.v_show_res_log = bool2int(is_on)
end

function M:set_room_id(room_id)
  self.v_room_id = room_id or 0
end

function M:set_born_key(key)
  self.v_born_key = key or ""
end

function M:set_open_skill(is_on)
  self.v_is_open_skill = bool2int(is_on)
end

function M:set_jump_scene_show(is_on)
  self.v_is_jump_scene_show = bool2int(is_on)
end

function M:set_god_id(id)
  self.v_god_id = id
end

function M:set_operate_char_id(id)
  self.v_operate_charId = id
end

function M:set_all_arrow_fx_visibility(visible)
  self.v_is_show_all_arrow_fx = visible
end

function M:is_enter_chapter()
  return int2bool(self.v_enter_chapter)
end

function M:is_no_play_sound()
  return int2bool(self.v_no_play_sound)
end

function M:is_client_only()
  return int2bool(self.v_client_only)
end

function M:is_show_res_load_log()
  return int2bool(self.v_show_res_log)
end

function M:is_open_skill()
  return int2bool(self.v_is_open_skill)
end

function M:is_jump_scene_show()
  return int2bool(self.v_is_jump_scene_show)
end

function M:is_show_all_arrow_fx()
  return int2bool(self.v_is_show_all_arrow_fx)
end

function M:load_setting()
  local setting_tbl = Local_Storage:load_table(Setting_Key)
  if setting_tbl then
    self:check_version(setting_tbl)
  end
end

function M:check_version(setting_tbl)
  local now_version = self.v_version
  local save_version = setting_tbl.version
  local born_pos = setting_tbl.born_pos
  if now_version == save_version then
    self.v_role_list[1] = setting_tbl.role1_id
    self.v_role_list[2] = setting_tbl.role2_id
    self.v_role_list[3] = setting_tbl.role3_id
    self.v_monster_id = setting_tbl.monster_id
    self.v_fixed_buddy_list[1] = setting_tbl.fixed_buddy1
    self.v_fixed_buddy_list[2] = setting_tbl.fixed_buddy2
    self.v_fixed_buddy_list[3] = setting_tbl.fixed_buddy3
    self.v_challenge_type = setting_tbl.challenge_type
    self.v_born_pos.x = born_pos.x
    self.v_born_pos.y = born_pos.y
    self.v_born_pos.z = born_pos.z
    self.v_tower_id = setting_tbl.tower_id
    self.v_tower_floor_id = setting_tbl.tower_floor_id
    self.v_tower_room_id = setting_tbl.tower_room_id
    self.v_camera_id = setting_tbl.camera_id
    self.v_enter_chapter = setting_tbl.enter_chapter
    self.v_no_play_sound = setting_tbl.no_play_sound
    self.v_show_res_log = setting_tbl.show_res_log
    self.v_room_id = setting_tbl.room_id
    self.v_born_key = setting_tbl.born_key
    self.v_is_open_skill = setting_tbl.is_open_skill
    self.v_is_jump_scene_show = setting_tbl.is_jump_scene_show
    self.v_god_id = setting_tbl.god_id
    self.v_operate_charId = setting_tbl.operate_charid
  end
end

function M:delete_setting()
  Local_Storage:delete_key(Setting_Key)
end

function M:save_setting()
  local save_setting = {
    version = self.v_version,
    role1_id = self.v_role_list[1],
    role2_id = self.v_role_list[2],
    role3_id = self.v_role_list[3],
    fixed_buddy1 = self.v_fixed_buddy_list[1],
    fixed_buddy2 = self.v_fixed_buddy_list[2],
    fixed_buddy3 = self.v_fixed_buddy_list[3],
    challenge_type = self.v_challenge_type,
    monster_id = self.v_monster_id,
    born_pos = self.v_born_pos,
    tower_id = self.v_tower_id,
    tower_floor_id = self.v_tower_floor_id,
    tower_room_id = self.v_tower_room_id,
    camera_id = self.v_camera_id,
    enter_chapter = self.v_enter_chapter,
    no_play_sound = self.v_no_play_sound,
    show_res_log = self.v_show_res_log,
    room_id = self.v_room_id,
    born_key = self.v_born_key,
    is_open_skill = self.v_is_open_skill,
    is_jump_scene_show = self.v_is_jump_scene_show,
    god_id = self.v_god_id,
    operate_charid = self.v_operate_charId,
    is_show_all_arrow_fx = self.v_is_show_all_arrow_fx
  }
  Local_Storage:save_table(Setting_Key, save_setting)
  Util.show_message_tip(2172)
end

return M
