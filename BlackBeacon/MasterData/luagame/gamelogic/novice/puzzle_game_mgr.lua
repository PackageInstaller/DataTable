local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
end

function M:on_reconnect()
end

function M:on_gs2c_puzzle_game_list(data)
  self.v_activity_id = data.activity_id
  self.v_stage_cfgs = {}
  self.v_stage_map = {}
  for _, puzzle_game in ipairs(data.puzzle_games) do
    self.v_stage_map[puzzle_game.id] = puzzle_game
  end
  local cfgs = ShareRes.create("activity.puzzle_game_episode")
  for _, cfg in pairs(cfgs) do
    if cfg.ActivityId == self.v_activity_id then
      self.v_stage_cfgs[cfg.SortId] = cfg
    end
  end
end

function M:on_gs2c_puzzle_game_update(data)
  if data.activity_id ~= self.v_activity_id then
    return
  end
  local puzzle_game = data.puzzle_game
  self.v_stage_map[puzzle_game.id] = puzzle_game
end

function M:send_pass_stage(activity_id, stage_id, pass_second, cb)
  Network:call("c2gs_puzzle_game_pass_episode", {
    activity_id = activity_id,
    id = stage_id,
    pass_second = pass_second
  }, function(ok, resp)
    if ok and cb then
      cb()
    end
  end)
end

function M:get_activity_id()
  return self.v_activity_id
end

function M:get_stage_data(stage_id)
  return self.v_stage_map and self.v_stage_map[stage_id]
end

function M:is_stage_passed(stage_id)
  local data = self.v_stage_map and self.v_stage_map[stage_id]
  return data and data.pass_second > 0
end

function M:get_stage_cfg(stage_id)
  return self.v_stage_cfgs[stage_id]
end

function M:get_stage_list()
  local list = {}
  for _, cfg in ipairs(self.v_stage_cfgs) do
    local data = self:get_stage_data(cfg.Id)
    local tbl = {
      id = cfg.Id,
      pass_second = data and data.pass_second or -1,
      start_time = data and data.start_time or -1,
      grade = data and data.grade or 0,
      cfg = cfg
    }
    _tinsert(list, tbl)
  end
  return list
end

function M:get_next_stage_cfg(cur_stage_cfg)
  local next_stage_sort_id = cur_stage_cfg.SortId + 1
  for _, cfg in ipairs(self.v_stage_cfgs) do
    if cfg.SortId == next_stage_sort_id then
      return cfg
    end
  end
end

return M
