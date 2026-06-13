local Base = import("character.base.base_monster")
local M = Util.create_class()
local CommonMonster = import("common.monster")
local check_magic_id = {
  [1] = 399983,
  [2] = 399984,
  [3] = 399985,
  [4] = 399986
}
local trap_magic_id = {}

function M:_init()
  self.control = nil
  self.trapid = nil
  self.target = nil
  self.splash_timer = nil
  self.walk_set = nil
  self.TEMP_POS = {}
  Base._init(self)
  self.skill01 = {
    300103101,
    5,
    0,
    0,
    0,
    get_skill_cfg(300103101).CastTime,
    get_skill_cfg(300103101).AfterTime
  }
  self.pos = {
    [1] = {x = 0, z = 0}
  }
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc ~= self.npc then
    return
  end
  if get_sync_var("shot_score") and not self.koufen then
    set_sync_var("shot_score", get_sync_var("shot_score") + 20)
  end
end

function M:cast_skill(skill_instant_ID)
  if not self.target then
    return
  end
  if 300103101 == skill_instant_ID[1] then
    cast_skill(self.npc, self.target, skill_instant_ID[1], nil, nil)
  end
end

function M:control_set()
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  CommonMonster.remove_timer(self)
  self:dir_change()
  self:wander_main_logic()
  self:arrive_target()
  self:control_set()
  CommonMonster.search_target(self, 30, 8)
  if self.target and self.control == nil then
    self.control = 0
    self.pos2 = get_npc_pos(self.target)
  end
  if 0 == self.control and check_magic(self.npc, check_magic_id[1]) then
    self.trapid = 1
    self.walk_set = self.trapid
    self.control = 1
  end
end

function M:arrive_target()
  if not self.trapid then
    return
  end
  if 6 == self.walk_set and check_npc_distance_to_pos(self.npc, self.pos2.x, self.pos2.z, 3, 1) then
    self:cast_skill(self.skill01)
    self.koufen = true
    self.walk_set = 7
  end
end

function M:dir_change()
  if not self.trapid then
    return
  end
  if 5 == self.walk_set and check_npc_distance_to_pos(self.npc, self.pos[1].x, self.pos[1].z, 1, 1) then
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.pos2)
    self.skillTime = os.time()
    self.walk_set = 6
  end
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not self.trapid then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if self.walk_set == self.trapid then
    self.pos[1].x, self.pos[1].z = get_scene_map_pos_postion("go5")
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.pos[1])
    self.walk_set = 5
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if missile_cfg.Id == 31010030401 then
    cast_magic(self.npc, self.npc, 4031023, 1)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300103101 == skill_id then
    if get_sync_var("shot_score") and get_sync_var("shot_score") - 20 >= 0 then
      set_sync_var("shot_score", get_sync_var("shot_score") - 20)
    elseif get_sync_var("shot_score") and get_sync_var("shot_score") - 20 < 0 then
      set_sync_var("shot_score", 0)
    end
  end
end

return M
