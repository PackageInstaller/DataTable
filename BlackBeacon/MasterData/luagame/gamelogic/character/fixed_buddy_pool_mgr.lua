local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local DEFAULT_STARTING_POS = CHAPTER_CONFIG.DEFAULT_STARTING_POS
local CommonDefine = require("cs_share.common_define")
local _os_time = os.time
local _insert = table.insert

function M:init_sys()
  Base.init_sys(self)
  self.v_cache_char_fight_val = {}
  self.v_select_buddy_data = {}
  self.v_select_point_id = nil
  self:reset_data()
end

function M:on_reconnect()
  self:reset_data()
end

function M:reset_data()
  self.v_team_data = {}
  self.v_select_point_id = nil
end

function M:creat_team_data(point_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  local fixed_pool_list = point_cfg.ReplaceFormation
  if #fixed_pool_list <= 0 then
    Log.Error("固定编队库信息空了 关卡id = ", point_id)
    return
  end
  self.v_select_point_id = point_id
  for idx, fixed_pool_id in ipairs(fixed_pool_list) do
    local pool_cfg = ShareRes.get_fixed_char_pool(fixed_pool_id)
    Util.assert(pool_cfg, "缺少固定角色库的配置信息，库id = " .. fixed_pool_id)
    local char_list = pool_cfg.RobotList
    local data = char_list[1]
    local buddy_id = data.BuddyId
    local fixed_id = data.RobotId
    local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
    local fixed_fight_val = FixedBuddyMgr:get_fixed_fight_val(fixed_id)
    local play_fight_val = CharacterMgr:get_buddy_combat_effectiveness(buddy_id)
    local is_use_pool = false
    if not buddy_info or buddy_info and fixed_fight_val > play_fight_val then
      buddy_info = FixedBuddyMgr:get_fixed_buddy_info(fixed_id)
      is_use_pool = true
    end
    self:update_team_data(idx, buddy_id, fixed_id, is_use_pool)
  end
end

function M:get_team_data(point_id)
  if #self.v_team_data <= 0 then
    self:creat_team_data(point_id)
  end
  for i = 1, 3 do
    if not self.v_team_data[i] then
      self:update_team_data(i, 0)
    end
  end
  return self.v_team_data
end

function M:add_team_pos_data(pos, buddy_id)
  if pos == DEFAULT_STARTING_POS then
    return
  end
  if not self.v_select_point_id then
    return
  end
  self:update_team_data(pos, buddy_id)
end

function M:update_team_data(pos, buddy_id, fixed_id, is_use_pool)
  if not pos then
    Log.Error("空位置" .. debug.traceback())
    return
  end
  local insert = true
  for _, data in pairs(self.v_team_data) do
    if data.buddy_id == buddy_id then
      data.buddy_id = 0
    end
    if data.pos == pos then
      data.buddy_id = buddy_id
      insert = false
    end
  end
  if insert then
    local new_data = {
      pos = pos,
      buddy_id = buddy_id,
      fixed_id = fixed_id,
      is_use_pool = is_use_pool,
      point_id = self.v_select_point_id
    }
    self.v_team_data[pos] = new_data
  end
end

function M:get_buddy_pos(buddy_id)
  if not self.v_team_data or #self.v_team_data <= 0 then
    return
  end
  for _, data in pairs(self.v_team_data) do
    if data.buddy_id == buddy_id then
      return data.pos, data.fixed_id
    end
  end
end

return M
