local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local _sort = table.sort
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local DEFAULT_STARTING_POS = CHAPTER_CONFIG.DEFAULT_STARTING_POS
local common_def = require("cs_share.common_define")
local CHAL_TYPE2FORMN_TYPE = common_def.CHAL_TYPE2FORMN_TYPE
local TEAM_BUDDY_TYPE = common_def.TEAM_BUDDY_TYPE
local PlayerPrefs = UnityEngine.PlayerPrefs

function M:init_sys()
  Base.init_sys(self)
  self:reset_data()
  self:set_need_check_up_more_buddy(true)
end

function M:on_reconnect()
end

function M:reset_data()
  self.v_prefab_team_list = {}
  self.v_fight_team_list = {}
  self.v_formation_list = {}
  self.v_change_formation = {}
end

function M:on_prefab_team_list(prefab_team_list)
  for _, data in pairs(prefab_team_list) do
    self.v_prefab_team_list[data.id] = data
  end
end

function M:on_prefab_team_update(prefab_team)
  self.v_prefab_team_list[prefab_team.id] = prefab_team
end

function M:on_fight_team_list(fight_team_list)
  for _, data in pairs(fight_team_list) do
    self.v_fight_team_list[data.id] = data
  end
end

function M:on_fight_team_update(fight_team)
  self.v_fight_team_list[fight_team.id] = fight_team
end

function M:save_prefab_team(prefab_team_id, name, buddys, main_pos, callback)
  local prefab_team = self:get_prefab_team_data(prefab_team_id)
  if name then
    prefab_team.name = name
  end
  if buddys then
    prefab_team.buddys = buddys
  end
  if main_pos then
    prefab_team.main_pos = main_pos
  end
  Network:protect_call("c2gs_prefab_team_save", {prefab_team = prefab_team}, function(ok, resp)
    if callback then
      callback(ok)
    end
  end)
end

function M:send_save_fight_team(team_id, callback, do_check)
  local fight_team_send_data = self:get_fight_team_send_data(team_id)
  if do_check and not fight_team_send_data.buddys[fight_team_send_data.main_pos] then
    return
  end
  Network:protect_call("c2gs_fight_team_save", {fight_team = fight_team_send_data}, function(ok, resp)
    if callback then
      callback(ok)
    end
  end)
end

function M:get_prefab_team_list()
  return self.v_prefab_team_list
end

function M:get_prefab_team_data(prefab_team_id)
  if not self.v_prefab_team_list[prefab_team_id] then
    self.v_prefab_team_list[prefab_team_id] = {
      name = "",
      id = prefab_team_id,
      buddys = {},
      main_pos = 1
    }
  end
  return self.v_prefab_team_list[prefab_team_id]
end

function M:get_fight_team_data(team_id, point_id, if_shallow_copy)
  if not team_id then
    local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
    team_id = point_cfg.FightTeamId
  end
  if not team_id then
    Log.Error("获取战斗编队失败,team_id, point_id:", team_id, ",", point_id)
    return
  end
  if not self.v_fight_team_list[team_id] then
    self.v_fight_team_list[team_id] = {
      id = team_id,
      buddys = {},
      main_pos = 1
    }
  end
  if if_shallow_copy then
    return self.v_fight_team_list[team_id]
  else
    return UtilTable.copy_table(self.v_fight_team_list[team_id])
  end
end

function M:get_fight_team_send_data(team_id, point_id, clear_assist)
  local fight_team = self:get_fight_team_data(team_id, point_id)
  local buddys = {}
  for pos, data in pairs(fight_team.buddys) do
    if 0 ~= data.buddy_id and (not clear_assist or data.buddy_type ~= TEAM_BUDDY_TYPE.HELP_FIGHT) then
      buddys[pos] = data
    end
  end
  fight_team.buddys = buddys
  return fight_team
end

function M:get_new_fight_team_send_data(point_id, node_id, floor_num)
  local fight_team = self:get_fight_team_data(nil, point_id)
  local correct_fight_team_buddys = self:get_correct_fight_team(point_id, node_id, floor_num)
  local buddys = {}
  for pos, data in ipairs(correct_fight_team_buddys) do
    if 0 ~= data.buddy_id then
      buddys[pos] = data
    end
  end
  fight_team.buddys = buddys
  return fight_team
end

function M:get_fight_team_start_pos(team_id, point_id)
  return self:get_fight_team_data(team_id, point_id).main_pos
end

function M:set_fight_start_pos(team_id, point_id, pos)
  self:get_fight_team_data(team_id, point_id, true).main_pos = pos
end

function M:change_fight_team(team_id, new_data, main_pos)
  local fight_team = self:get_fight_team_data(team_id, nil, true)
  if new_data then
    local buddys = {}
    for _, data in pairs(new_data) do
      if data.buddy_id and 0 ~= data.buddy_id then
        buddys[data.pos] = data
      end
    end
    fight_team.buddys = buddys
  end
  if main_pos then
    fight_team.main_pos = main_pos
  end
end

function M:apply_fight_to_prefab_team(fight_team_id, prefab_team_id)
  local fight_team = self:get_fight_team_data(fight_team_id)
  self:save_prefab_team(prefab_team_id, nil, fight_team.buddys, fight_team.main_pos)
  return fight_team
end

function M:apply_prefab_to_fight_team(prefab_team_id, fight_team_id)
  local prefab_team_data = self:get_prefab_team_data(prefab_team_id)
  local team_pos_data = UtilTable.copy_table(prefab_team_data.buddys)
  self:change_fight_team(fight_team_id, team_pos_data, prefab_team_data.main_pos)
end

function M:get_team_from_config(point_id, node_id, floor_num)
  local cfg = ChapterMgr:get_chapter_team_config(point_id, node_id, floor_num)
  local team_data = {}
  if cfg then
    for pos, fixed_robot_id in pairs(cfg.BuddyId) do
      if 0 ~= fixed_robot_id then
        local buddy_type = TEAM_BUDDY_TYPE.ROBOT
        local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_robot_id)
        local buddy_id = fixed_buddy_cfg.BuddyId
        if cfg.PowerCamp then
          local real_own_buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
          if real_own_buddy_info and real_own_buddy_info.power > fixed_buddy_cfg.Power then
            buddy_type = TEAM_BUDDY_TYPE.PLAYER
            fixed_robot_id = nil
          end
        end
        team_data[pos] = {
          buddy_type = buddy_type,
          buddy_id = buddy_id,
          pos = pos,
          ban = false,
          robot_id = fixed_robot_id,
          is_fixed = true
        }
      end
    end
    for pos, is_ban in pairs(cfg.BanPos) do
      if is_ban then
        team_data[pos] = {
          buddy_type = 0,
          buddy_id = 0,
          pos = pos,
          ban = true
        }
      end
    end
  end
  for pos = 1, 3 do
    if not team_data[pos] then
      team_data[pos] = {
        buddy_type = 0,
        buddy_id = 0,
        pos = pos
      }
    end
  end
  return team_data, cfg
end

function M:get_team_fixed_starting_pos(point_id, node_id, floor_num)
  local cfg = ChapterMgr:get_chapter_team_config(point_id, node_id, floor_num)
  return cfg and cfg.MainPos
end

function M:get_correct_fight_team(point_id, node_id, floor_num)
  local buddy_was_replaced, pos_was_ban, buddy_was_ban = false, false, false
  local fight_team_buddy = self:get_fight_team_data(nil, point_id).buddys
  local buddys = {}
  local fixed_buddy_map = ChapterMgr:get_floor_fixed_buddy_map(point_id, node_id, floor_num)
  for pos, data in pairs(fight_team_buddy) do
    if 0 ~= data.buddy_id and data.buddy_type == TEAM_BUDDY_TYPE.PLAYER and (not fixed_buddy_map or not fixed_buddy_map[data.buddy_id]) then
      buddys[pos] = data
    end
  end
  local first_replaced_fight_team_buddy, first_empty_pos
  local cfg_team_data, team_config = self:get_team_from_config(point_id, node_id, floor_num)
  local ban_buddys = ChapterMgr:get_floor_ban_buddy_map(point_id, node_id, floor_num)
  for pos, cfg_value in ipairs(cfg_team_data) do
    local ser_value = buddys[pos]
    if ser_value then
      if cfg_value.is_fixed and 0 ~= cfg_value.buddy_id then
        buddy_was_replaced = true
        if not first_replaced_fight_team_buddy and (not ban_buddys or not ban_buddys[ser_value.buddy_id]) then
          first_replaced_fight_team_buddy = ser_value.buddy_id
        end
      elseif cfg_value.ban then
        pos_was_ban = true
      elseif ban_buddys and ban_buddys[ser_value.buddy_id] then
        buddy_was_ban = true
        cfg_value.buddy_id = 0
      else
        cfg_value.buddy_id = ser_value.buddy_id
        cfg_value.buddy_type = TEAM_BUDDY_TYPE.PLAYER
      end
    end
    buddys[pos] = cfg_value
    if not first_empty_pos and not cfg_value.ban and 0 == cfg_value.buddy_id then
      first_empty_pos = pos
    end
  end
  if first_replaced_fight_team_buddy and first_empty_pos then
    buddys[first_empty_pos].buddy_type = TEAM_BUDDY_TYPE.PLAYERz
    buddys[first_empty_pos].buddy_id = first_replaced_fight_team_buddy
  end
  if first_empty_pos and team_config and 1 == team_config.FillRobot and team_config.RobotPool and 0 ~= #team_config.RobotPool then
    self:auto_fill_robot(buddys, ban_buddys, team_config.RobotPool)
  end
  return buddys, buddy_was_replaced, pos_was_ban, buddy_was_ban
end

function M:auto_fill_robot(buddys, ban_buddys, robot_pool)
  local used_buddy_map = {}
  local empty_pos_list = {}
  for i, data in ipairs(buddys) do
    if 0 ~= data.buddy_id then
      used_buddy_map[data.buddy_id] = true
    elseif not data.ban then
      empty_pos_list[#empty_pos_list + 1] = i
    end
  end
  local empty_pos_num = #empty_pos_list
  if 0 == empty_pos_num then
    return
  end
  local empty_pos_start_idx = 1
  for _, fixed_robot_id in ipairs(robot_pool) do
    local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_robot_id)
    local buddy_id = fixed_buddy_cfg.BuddyId
    if used_buddy_map[buddy_id] or ban_buddys[buddy_id] then
    else
      local empty_pos = empty_pos_list[empty_pos_start_idx]
      local post_data = buddys[empty_pos]
      post_data.buddy_type = TEAM_BUDDY_TYPE.ROBOT
      post_data.buddy_id = buddy_id
      post_data.robot_id = fixed_robot_id
      empty_pos_start_idx = empty_pos_start_idx + 1
      if empty_pos_num < empty_pos_start_idx then
        break
      end
    end
  end
end

function M:get_formation_info_by_id(formation_type, formation_id, fight_type)
  Log.Error("使用了已废弃的获取阵容方法 get_formation_info_by_id")
end

function M:cache_team_preset_show(fight_team_id)
  self.v_need_show_team_preset = true
  self.v_team_preset_fight_team_id = fight_team_id
end

function M:clear_cache_team_preset_show()
  self.v_need_show_team_preset = false
  self.v_team_preset_fight_team_id = nil
end

function M:check_team_preset_show()
  if self.v_need_show_team_preset then
    self.v_need_show_team_preset = false
    UIMgr:get_ui("uiteam_preset_tips"):ui_show(false, self.v_team_preset_fight_team_id)
  end
end

function M:if_need_check_up_more_buddy()
  return 1 == PlayerPrefs.GetInt("need_check_up_more_buddy", 0)
end

function M:set_need_check_up_more_buddy(bool_val)
  return PlayerPrefs.SetInt("need_check_up_more_buddy", bool_val and 1 or 0)
end

return M
