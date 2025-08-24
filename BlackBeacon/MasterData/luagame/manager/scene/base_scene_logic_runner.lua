local CommDefine = require("cs_share.common_define")
local SAVE_NPC_TYPE = CommDefine.SAVE_NPC_TYPE
local NPC_STATE = {LIVE = 1, DEAD = 2}
local Base = require("manager.scene.scene_behavior")
local M = Util.create_child_mt(Base)

function M:_init(logic_id)
  Base._init(self)
  self.m_LogicID = logic_id
end

function M:init_server_data()
  self:_init_server_save_npc()
  self:_init_hide_scene_effect_status_obj()
  self:_init_update_plat_moved()
  self:_init_remove_area()
end

function M:on_scene_ready()
  self:init_server_data()
  if self.on_tp_revive_room then
    self:on_tp_revive_room()
  end
  local sync_var_key = "on_scene_ready"
  if BehaviorShareMgr:get_sync_var(sync_var_key) then
    return
  end
  BehaviorShareMgr:set_sync_var(sync_var_key, true)
  self:on_enter()
  if TowerMgr:is_long_chapter() then
    local tower = TowerMgr:get_tower()
    local is_chapter_node_continue = tower and tower:is_execute_node_continue_suc()
    if is_chapter_node_continue then
      local progress = TowerMgr:get_tower_progress()
      self:on_chapter_node_continue(progress.node_id)
    end
  end
end

function M:get_sync_var(key)
  if self.m_mTowerSync and self.m_mTowerSync[key] then
    return self.m_mTowerSync[key]
  end
  return BehaviorShareMgr:get_sync_var(key)
end

function M:sync_tower_var(data)
  self.m_mTowerSync = data
end

function M:sync_remove_tp_point(data)
  self.m_mRemoveTpPoint = data
end

function M:sync_remove_area(data)
  self.v_on_enter_remove_area = data
end

function M:sync_update_plat_moved(data)
  self.v_on_enter_update_plat_moved = data
end

function M:sync_hide_scene_effect_status_obj(data)
  self.v_on_enter_hide_scene_effect_status_obj = data
end

function M:sync_server_save_npc_data(data)
  self.v_on_enter_server_save_npc = data
end

function M:_init_remove_area()
  if not self.v_on_enter_remove_area then
    return
  end
  for k, v in pairs(self.v_on_enter_remove_area) do
    self:remove_area(v.key, v.tag)
  end
end

function M:_init_update_plat_moved()
  if not self.v_on_enter_update_plat_moved then
    return
  end
  for k, v in pairs(self.v_on_enter_update_plat_moved) do
    self:update_plat_moved(v.name, v.anim)
  end
end

function M:_init_hide_scene_effect_status_obj()
  if not self.v_on_enter_hide_scene_effect_status_obj then
    return
  end
  for k, v in pairs(self.v_on_enter_hide_scene_effect_status_obj) do
    self:hide_scene_effect_status_obj(v.effect_name)
  end
end

function M:_init_server_save_npc()
  if not self.v_on_enter_server_save_npc then
    return
  end
  for name, info in pairs(self.v_on_enter_server_save_npc) do
    if info.state == NPC_STATE.LIVE then
      if not info.type or info.type == SAVE_NPC_TYPE.ORDINARY then
        self:AddPosKeyNpc(info.camp, info.res_id, info.pok_key, info.offset_x, info.offset_z, info.rotation, info.s_camp, info.level, name, info.params, info.group)
      elseif info.type == SAVE_NPC_TYPE.CD then
        self:add_cd_pos_key_npc(info.camp, info.res_id, info.pok_key, info.offset_x, info.offset_z, info.rotation, info.s_camp, info.level, name, info.cd)
        self:set_cd_npc_can_hit(name, info.can_hit)
      end
    end
  end
end

function M:set_scene_timeline_speed(sTimeLineName, nSpeed)
  Base.set_scene_timeline_speed(self, sTimeLineName, nSpeed)
end

function M:set_scene_plat_speed(sPlatPath, nSpeed, sAnimName, IsMove)
  Base.set_scene_plat_speed(self, sPlatPath, nSpeed, sAnimName, IsMove)
end

function M:on_enter()
end

function M:on_frame()
end

function M:play_pre_fight_story()
end

function M:run_event(event_name, ...)
end

function M:on_fight_end(is_win)
end

function M:load_variable(data)
end

function M:get_save_variable()
end

function M:fight_end(isWin)
  SceneMgr:c2gs_call_scene("fight_end", isWin, self:get_save_variable(), FightDataMgr:get_use_time())
end

return M
