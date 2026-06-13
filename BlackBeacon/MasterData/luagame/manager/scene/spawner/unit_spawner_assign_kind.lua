local Base = require("manager.scene.spawner.unit_spawner_base")
local M = Util.create_child_mt(Base)
local Math = require("base.mathx")
local CommDefine = require("cs_share.common_define")
local LOGIC_OTHER_PARAMETER = CommDefine.LOGIC_OTHER_PARAMETER

function M:_init(logic_runner, action_cfg)
  Base._init(self, logic_runner, action_cfg)
  self.v_random_wave_infos = {}
  self.v_cumulative_counts = {}
  self.v_total_spawn_count = 0
  for index, wave_cfg in pairs(self.v_action_cfg.assignKindWaves) do
    self.v_random_wave_infos[index] = {
      UnitID = wave_cfg.UnitID,
      UnitCount = wave_cfg.UnitCount,
      AIDifficultyTag = wave_cfg.AIDifficultyTag,
      unitLevel = wave_cfg.UnitLevel,
      OrientationType = wave_cfg.OrientationType
    }
    self.v_total_spawn_count = wave_cfg.UnitCount + self.v_total_spawn_count
    self.v_cumulative_counts[index] = self.v_total_spawn_count
  end
  self.v_remain_spawn_count = self.v_total_spawn_count
  self:spawn_unit()
end

function M:spawn_unit()
  local create_count = self.v_remain_spawn_count > 0 and math.min(self.v_max_active_unit_count - self.v_cur_active_count, self.v_remain_spawn_count) or 0
  if create_count > 0 then
    for _ = 1, create_count do
      local random_index = math.random(1, self.v_remain_spawn_count)
      local start_index, end_index = 1, #self.v_cumulative_counts
      while start_index < end_index do
        local mid = math.floor((start_index + end_index) / 2)
        if random_index > self.v_cumulative_counts[mid] then
          start_index = mid + 1
        else
          end_index = mid
        end
      end
      local wave_info = self.v_random_wave_infos[start_index]
      if not wave_info then
      else
        local uuid = SceneMgr:get_uuid()
        local nLevel
        local nAutoLevel = wave_info.UnitLevel
        if nAutoLevel and 0 ~= nAutoLevel then
          nLevel = self.v_logic_runner:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
        end
        local born_pos = self:get_unit_born_position(uuid)
        local born_dir = born_pos and self:get_unit_born_dir(born_pos.x, born_pos.z, wave_info.OrientationType)
        self.v_logic_runner:_push_to_need_add(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, wave_info.UnitID, nil, nil, nil, born_dir, 0, 0, 4, nLevel, nil, nil, born_pos, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, self.v_ai_difficulty_tag, nAutoLevel)
        self:add_npc_tag(uuid)
        wave_info.UnitCount = wave_info.UnitCount - 1
        for i = start_index, #self.v_cumulative_counts do
          self.v_cumulative_counts[i] = self.v_cumulative_counts[i] - 1
        end
        if wave_info.UnitCount <= 0 then
          table.remove(self.v_random_wave_infos, start_index)
          table.remove(self.v_cumulative_counts, start_index)
        end
      end
    end
  end
end

function M:on_destroy()
  Base.on_destroy(self)
end

return M
