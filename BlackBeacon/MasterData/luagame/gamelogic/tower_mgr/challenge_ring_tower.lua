local Base = require("gamelogic.tower_mgr.tower")
local M = Util.create_child_mt(Base)
local RING_BY_TOWER_CFG_PATH = "activity.rings_of_challenge_ring_by_tower"
local _max = math.max

function M:_init(...)
  Base._init(self, ...)
end

function M:update_tower_info(tower_info)
  self.v_tower_info = tower_info
  local floor_idx = self.v_tower_info.cur_floor_idx
  self:update_floor_info(floor_idx)
end

function M:enter_next_floor()
  local floor_num = self:get_tower_cur_floor_num()
  self:update_fight_state(false)
  SceneMgr:set_scene_show(false, function()
    ChallengeRingMgr:on_get_chal_ring_towerinfo(self.v_tower_id)
    ChallengeRingMgr:change_now_ring()
    SceneMgr:set_game_pause(false)
    self:on_enter_floor(floor_num)
  end)
end

function M:update_fight_state(is_show)
  local ui_fight = UIMgr:try_get_visible_ui("fight")
  if ui_fight and not ui_fight.v_object:IsNull() then
    ui_fight.v_object:SetActive(is_show)
  end
end

function M:on_enter()
  self:enter_base_logic()
  self:on_enter_ring(#self.v_tower_info.floor_list, true)
end

function M:on_enter_ring(floor, is_first)
  if is_first then
    floor = _max(self.v_tower_info.cur_floor_idx, 1)
  end
  if not self:update_floor_info(floor) then
    return
  end
  self.floor_enter_count = self.floor_enter_count + 1
  local enter_room_num = 0
  if floor == self.v_tower_info.cur_floor_idx then
    enter_room_num = self.v_tower_info.cur_room_num or 0
  end
  self.v_ring_list_cfg = ShareRes.create(RING_BY_TOWER_CFG_PATH, self.v_tower_id)
  if not self.v_ring_list_cfg then
    Log.Error("挑战之环配置不存在, 塔id = ", self.v_tower_id)
  end
  if enter_room_num < 1 then
    local start_room_id = self.v_ring_list_cfg[floor].StartRoomId
    if not start_room_id then
      Log.Error("起始房间不存在, floor idx = ", floor)
    end
    enter_room_num = self:get_tower_room_num(start_room_id)
  end
  self:enter_room(enter_room_num, 0, is_first)
end

function M:update_floor_info(floor)
  local floor_info = self:get_floor_Info(floor)
  if not floor_info then
    return false
  end
  self.v_floor_num = floor
  self.v_floor_info = floor_info
  self.v_floor_status = floor_info.status
  self.v_floor_room_map = self.v_floor_info.room_tbl
  self.v_room_num = 0
  self:init_room_status()
  return true
end

function M:on_tp_room(room_num)
  UIMgr:try_hide_ui("ui_challenge_ring")
  SceneMgr:set_game_pause(false)
  self:enter_room(room_num, 0)
end

function M:get_tower_room_num(room_id)
  local result_num = 1
  for _, data in pairs(self.v_floor_room_map) do
    local room_num = data.room_num
    local now_room_id = data.room_id
    if room_id == now_room_id then
      result_num = room_num
      break
    end
  end
  return result_num
end

function M:on_exit()
  Base.on_exit(self)
  ChallengeRingMgr:exit_tower()
  SceneMgr:set_game_pause(false)
  MsgGame:mq_publish2(Const.MSG_ON_CR_OPEN_PAUSE_BTN)
end

function M:is_fight_room(room_num)
  local room_id = self.v_floor_room_map[room_num].room_id
  local room_cfg = ShareRes.create("tower.tower_room", room_id)
  return Util.is_fight_room(room_cfg.Type)
end

function M:is_challenge_ring_tower()
  return true
end

function M:get_tower_pass()
  return false
end

function M:tp_next_floor()
  self:on_enter_floor(self.v_floor_num + 1)
end

function M:check_pass_all_room()
  return false
end

local PRELOAD_RES = {
  "Fx_UI_Card_06",
  "Fx_UI_Card_01",
  "Fx_UI_Card_02",
  "Fx_UI_Card_03",
  "Fx_UI_battle_treasure_light_gn",
  "Fx_UI_battle_treasure_light_bu",
  "Fx_UI_battle_treasure_light_vt",
  "Fx_UI_battle_treasure_light_gld",
  "Fx_Baoshi",
  "Fx_UI_Card_06_1",
  "Fx_UI_Card_05"
}

function M:get_preload_res()
  return PRELOAD_RES
end

return M
