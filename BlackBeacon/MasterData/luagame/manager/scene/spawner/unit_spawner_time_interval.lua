local Base = require("manager.scene.spawner.unit_spawner_base")
local M = Util.create_child_mt(Base)
local Math = require("base.mathx")
local CommDefine = require("cs_share.common_define")
local LOGIC_OTHER_PARAMETER = CommDefine.LOGIC_OTHER_PARAMETER

function M:_init(logic_runner, action_cfg)
  Base._init(self, logic_runner, action_cfg)
  self.v_auto_remove_self = false
  self.v_time_interval_waves = {}
  self.v_active_unit_count_map = {}
  self.v_weight_map = {}
  self.v_total_weight = 0
  for index, wave_cfg in pairs(self.v_action_cfg.timeIntervalKinds) do
    self.v_time_interval_waves[index] = {
      UnitID = wave_cfg.UnitID,
      Weight = wave_cfg.Weight,
      Limit = wave_cfg.Limit,
      OrientationType = wave_cfg.OrientationType,
      UnitLevel = wave_cfg.UnitLevel,
      AIDifficultyTag = wave_cfg.AIDifficultyTag
    }
    self.v_active_unit_count_map[wave_cfg.UnitID] = 0
    self.v_total_weight = wave_cfg.Weight + self.v_total_weight
    self.v_weight_map[index] = self.v_total_weight
  end
  self.v_duration = 0
  local interval = self.v_action_cfg.SpawnTimeInterval
  self.v_spawn_timer = Timer:add_timer(nil, interval, self.on_spawn_timer_trigger, self, nil, interval, true)
end

function M:on_spawn_timer_trigger()
  local suc = self:spawn_unit()
  if suc then
    self.v_duration = self.v_duration + self.v_action_cfg.SpawnTimeInterval
  end
  if self.v_action_cfg.SpawnDuration > 0 and self.v_duration >= self.v_action_cfg.SpawnDuration then
    if not Util.is_empty(self.v_remove_event_name) then
      self.v_logic_runner:on_spawner_unit_clear(self.v_remove_event_name)
    end
    self.v_logic_runner:remove_spawner_behavior(self)
    return false
  end
  return true
end

function M:spawn_unit()
  if self.v_max_active_unit_count <= self.v_cur_active_count then
    return true
  end
  local use_wave_index
  for _ = 1, 5 do
    local random_weight = math.random(0, self.v_total_weight)
    local index = UtilTable.binary_search(self.v_weight_map, random_weight)
    local check_wave_info = self.v_time_interval_waves[index]
    if not check_wave_info then
    else
      local active_count = self.v_active_unit_count_map[check_wave_info.UnitID]
      if active_count < check_wave_info.Limit then
        use_wave_index = index
        break
      else
      end
      goto lbl_37
    end
    ::lbl_37::
  end
  if not use_wave_index or not self.v_time_interval_waves[use_wave_index] then
    return false
  end
  local use_wave_info = self.v_time_interval_waves[use_wave_index]
  local uuid = SceneMgr:get_uuid()
  local nLevel
  local nAutoLevel = use_wave_info.UnitLevel
  if nAutoLevel and 0 ~= nAutoLevel then
    nLevel = self.v_logic_runner:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
  end
  local born_pos = self:get_unit_born_position(uuid)
  local born_dir = born_pos and self:get_unit_born_dir(born_pos.x, born_pos.z, use_wave_info.OrientationType)
  self.v_logic_runner:_push_to_need_add(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, use_wave_info.UnitID, nil, nil, nil, born_dir, 0, 0, 4, nLevel, nil, nil, born_pos, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, self.v_ai_difficulty_tag, nAutoLevel)
  self:add_npc_tag(uuid, use_wave_info.UnitID)
  return true
end

function M:add_npc_tag(uuid, unit_id)
  self.v_npc_uuid_map[uuid] = unit_id
  self.v_active_unit_count_map[unit_id] = self.v_active_unit_count_map[unit_id] + 1
  self.v_cur_active_count = self.v_cur_active_count + 1
end

function M:remove_npc_tag(uuid)
  local unit_id = self.v_npc_uuid_map[uuid]
  if unit_id then
    self.v_npc_uuid_map[uuid] = nil
    self.v_active_unit_count_map[unit_id] = self.v_active_unit_count_map[unit_id] - 1
    self.v_cur_active_count = self.v_cur_active_count - 1
  end
end

function M:on_destroy()
  Base.on_destroy(self)
  if self.v_spawn_timer then
    Timer:remove_timer(self.v_spawn_timer)
    self.v_spawn_timer = nil
  end
end

return M
