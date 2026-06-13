local Base = require("manager.scene.spawner.unit_spawner_base")
local M = Util.create_child_mt(Base)
local CommDefine = require("cs_share.common_define")
local LOGIC_OTHER_PARAMETER = CommDefine.LOGIC_OTHER_PARAMETER

function M:_init(logic_runner, action_cfg)
  Base._init(self, logic_runner, action_cfg)
  self.v_total_spawn_count = self.v_action_cfg.TotalSpawnCount
  self.v_remain_spawn_count = self.v_total_spawn_count
  self.v_unit_group_id = self.v_action_cfg.UnitGroupID
  self.v_group_config = ShareRes.get_monster_group_config(self.v_unit_group_id)
  self.v_max_unit_index = #self.v_group_config.unitList
  self.v_cur_unit_index = 0
  self:spawn_unit()
end

function M:spawn_unit()
  local create_npc_count = math.min(self.v_max_active_unit_count - self.v_cur_active_count, self.v_total_spawn_count - self.v_cur_active_count)
  if create_npc_count > 0 then
    local index = self.v_cur_unit_index
    for _ = 1, create_npc_count do
      index = index + 1
      index = index <= self.v_max_unit_index and index or 1
      local unit_cfg = self.v_group_config.unitList[index]
      local uuid = SceneMgr:get_uuid()
      local sMonsterKey = unit_cfg.UnitKey
      local nLevel = unit_cfg.Level
      local nAutoLevel = unit_cfg.AutoLevel
      if nAutoLevel and 0 ~= nAutoLevel then
        nLevel = self.v_logic_runner:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
      end
      local born_pos = self:get_unit_born_position(uuid)
      self.v_logic_runner:_push_to_need_add(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, unit_cfg.UnitID, unit_cfg.InitPos, unit_cfg.OffSetX or 0, unit_cfg.OffSetZ or 0, unit_cfg.Rotate, 0, 0, 0 == unit_cfg.Camp and 4 or unit_cfg.Camp, nLevel, nil, self.v_unit_group_id, born_pos, sMonsterKey, nil, unit_cfg.MagicId, unit_cfg.IsLookAtRole, nil, nil, nil, nil, nil, nil, self.v_ai_difficulty_tag, nAutoLevel)
      self:add_npc_tag(uuid)
    end
    self.v_cur_unit_index = index
  end
end

function M:on_destroy()
  Base.on_destroy(self)
end

return M
