local Base = require("manager.scene.base_scene_logic_runner")
local M = Util.create_child_mt(Base)

function M:_init(logic_id)
  Base._init(self, logic_id)
end

function M:run_event(event_name, ...)
  if self[event_name] then
    self[event_name](self, ...)
  end
end

function M:get_save_variable()
  if self.on_save then
    return self:on_save()
  end
end

function M:load_variable(data)
  if not next(data) then
    return
  end
  if self.on_load then
    return self:on_load(data)
  end
end

function M:add_npc_by_pos_key(self_camp, res_id, pos_key, offset_x, offset_z, tgt_pos_key, tgt_offset_x, tgt_offset_z, camp, level, cur_hp, npc_group)
  local args_map = {
    uuid = SceneMgr:get_uuid(),
    offset_x = offset_x,
    offset_z = offset_z,
    tgt_pos_key = tgt_pos_key,
    tgt_offset_x = tgt_offset_x,
    tgt_offset_z = tgt_offset_z,
    camp = camp,
    level = level,
    cur_hp = cur_hp,
    npc_group = npc_group
  }
  return Base.add_npc_by_pos_key(self, self_camp, res_id, pos_key, args_map)
end

function M:get_npc_count_by_res_id(res_id)
  return SceneMgr:get_npc_count_by_res_id(res_id)
end

function M:set_can_searched(npc, is_can_searched)
  npc:set_can_searched(is_can_searched)
end

function M:check_activate(npc)
  return npc and not npc:is_destroy() and not npc:is_die()
end

function M:get_npc_pos(npc)
  return npc:get_pos_vec3()
end

local function check_npc(npc)
  return npc and not npc:is_destroy()
end

function M:check_npc_status(npc, status)
  if not check_npc(npc) then
    return false
  end
  return npc:is_in_state(status)
end

function M:check_magic(npc, magic_id)
  return 0 ~= npc.magic_mgr:get_magic_num(magic_id)
end

function M:get_scene_powerbar_val(type)
end

function M:get_room_type()
  local tower = TowerMgr and TowerMgr:get_tower()
  local room = tower and tower:get_room()
  return room and room:get_room_type()
end

function M:get_fight_time()
  assert(nil, "客户端暂未实现此api")
  return SceneMgr:GetStopwatchObj():GetValue()
end

function M:is_in_challenge()
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    return fight_ui:get_is_in_challenge()
  end
  return false
end

function M:reset_functional_npc(npcId)
  SceneMgr:c2gs_call_scene("reset_functional_npc", npcId)
end

function M:get_best_conf_monster_level(nRound)
  local tower = TowerMgr and TowerMgr:get_tower()
  if not tower then
    return 0
  end
  local tower_id = tower:get_tower_id()
  local cfg = ShareRes.create("activity.best_config_monster_level")[tower_id]
  if not cfg then
    return 0
  end
  return cfg.RoundLevel[nRound] or cfg.RoundLevel[#cfg.RoundLevel]
end

function M:get_formation_attr_sum(attr_id, is_include_god)
  local hero_list = SceneMgr:get_hero_list()
  local ret = 0
  for _, hero in pairs(hero_list) do
    ret = ret + hero.attr_mgr:get_attr(attr_id)
  end
  if is_include_god then
    local god_npc = SceneMgr:get_god_npc()
    if god_npc then
      ret = ret + god_npc.attr_mgr:get_attr(attr_id)
    end
  end
  return ret
end

function M:get_npc_count_by_kind(nKind)
  assert(nil, "客户端暂未实现此api")
  return SceneMgr:get_npc_count_by_kind(nKind)
end

function M:restore_change_item_count(hst_id)
  SceneMgr:c2gs_call_scene("restore_change_item_count", hst_id)
end

function M:check_route_status(roomNum, targetRoomNum)
  assert(nil, "客户端暂未实现此api")
  return SceneMgr:GetBattlePlayer():CheckRouteStatus(roomNum, targetRoomNum)
end

function M:get_tower_floor_info()
  local tower = TowerMgr and TowerMgr:get_tower()
  if not tower then
    return
  end
  return tower:get_room_num(), tower:get_floor_num()
end

return M
