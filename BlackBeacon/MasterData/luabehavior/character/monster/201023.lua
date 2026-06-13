local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local ret = 0
local fall_pos

function M:_init()
  Base._init(self)
  self.skill01 = {
    20102301,
    0,
    4,
    0,
    6,
    get_skill_cfg(20102301).CastTime,
    get_skill_cfg(20102301).AfterTime,
    0
  }
  self.skill14 = {
    20102314,
    0,
    10,
    0,
    6,
    get_skill_cfg(20102314).CastTime,
    get_skill_cfg(20102314).AfterTime,
    0
  }
  self.skill13 = {
    20102313,
    0,
    10,
    0,
    6,
    get_skill_cfg(20102313).CastTime,
    get_skill_cfg(20102313).AfterTime,
    0
  }
  self.skill12 = {
    20102312,
    0,
    10,
    0,
    6,
    get_skill_cfg(20102312).CastTime,
    get_skill_cfg(20102312).AfterTime,
    0
  }
  self.skill11 = {
    20102311,
    3.72,
    1.5,
    5,
    15,
    get_skill_cfg(20102311).CastTime,
    get_skill_cfg(20102311).AfterTime,
    self.skill12
  }
  self.skill17 = {
    20102317,
    2.5,
    3,
    0,
    10,
    get_skill_cfg(20102317).CastTime,
    get_skill_cfg(20102317).AfterTime,
    0
  }
  self.wander = {
    3,
    7,
    2.2
  }
  self.wander_timer = 2
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.spawn = 0
  self.control = 0
  self.skill_next_id = 0
  self.spawn = 0
  self.turn_switch = 1
  self.stand_timer = 0
  self.stand_switch = 1
  self.born_skill = 20102314
end

function M:spawn_skill()
  if get_target_angel(self.npc, self.target) > 90 then
    if is_cast_skill_time(self.npc) then
      return
    end
    if 1 == self.turn_switch then
      self.turn_switch = 0
      cast_skill(self.npc, self.target, 20102314, nil, nil)
    end
  end
  if 0 == self.spawn then
    set_lock_velocity(self.npc, 1)
  end
  self.spawn = 1
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc then
    if 20102301 == skill_id or 20102317 == skill_id then
      self.control = 0
    elseif 20102314 == skill_id then
      self.turn_switch = 1
      self.control = 0
    elseif 20102317 == skill_id then
      time_scale_immune(self.npc, false)
    elseif 20102312 == skill_id then
      local npc_angle1 = get_target_angel(self.npc, self.target, true)
      if npc_angle1 < -80 then
        cast_skill(self.npc, self.target, 20102315, nil, nil)
        self.turn_switch = 1
      elseif npc_angle1 > 80 then
        cast_skill(self.npc, self.target, 20102316, nil, nil)
        self.turn_switch = 1
      else
        cast_skill(self.npc, self.target, 20102313, nil, nil)
      end
    elseif 20102318 == skill_id then
      set_skill_end_to_idle(self.npc, false)
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, 20102319)
    elseif 20102319 == skill_id then
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102320)
      self.stand_timer = get_npc_time(self.npc) + get_skill_cfg(20102320).CastTime
      cast_magic(self.npc, self.npc, 2023088, 0)
    elseif 20102322 == skill_id then
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102320)
    elseif 20102320 == skill_id then
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102321)
      self.turn_switch = 1
    end
  end
end

function M:on_skill_begin(npc, skill_id)
  if npc == self.npc then
    if 20102321 == skill_id then
      abort_magic_by_id(self.npc, 2023088)
      set_skill_end_to_idle(self.npc, true)
      self.turn_switch = 1
    elseif 20102318 == skill_id then
      time_scale_immune(self.npc, false)
      self.turn_switch = 0
      abort_magic_by_id(self.npc, 2023046)
      cast_magic(self.npc, self.target, 2001077, 0)
      cast_magic(self.npc, self.npc, 2001077, 0)
    elseif 20102317 == skill_id then
      time_scale_immune(self.npc, true)
      set_skill_end_to_idle(self.npc, true)
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    if check_magic(self.npc, 2023046) and 4 == missile_cfg.MissileTypeTag then
      cast_magic(self.npc, self.npc, 2023050, 0)
      self.control = 0
      abort_magic_by_id(self.npc, 2023050)
      abort_magic_by_id(self.npc, 2023046)
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102318)
      set_skill_end_to_idle(self.npc, false)
    end
    if check_magic(self.npc, 2023088) then
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102322, nil, nil)
    end
  end
end

function M:cast_skill(skill_instant_ID)
  if 0 ~= self.control then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
  else
    return
  end
  if 20102317 == skill_instant_ID[1] and get_target_angel(self.npc, self.target) > 90 then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time > skill_instant_ID[3] then
    fall_pos = get_npc_pos(self.target)
    if 20102311 == skill_instant_ID[1] then
      self.turn_switch = 0
      self.skill01[3] = npc_time + 3
      self.skill17[3] = npc_time + math.random(3, 5)
    elseif skill_instant_ID[1] == self.skill17[1] then
      self.turn_switch = 0
      self.skill17[3] = npc_time + math.random(2, 4)
    else
      skill_instant_ID[3] = npc_time + skill_instant_ID[2]
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, skill_instant_ID[1], fall_pos.x, fall_pos.z)
    self.control = 1
  else
    return
  end
  self.skill_next_id = skill_instant_ID[8]
  if 0 == self.skill_next_id then
    self.wander_timer_skill_makeup = skill_instant_ID[6] + skill_instant_ID[7]
  else
    self.skill_next_time = npc_time + skill_instant_ID[6]
    self.control = 2
  end
end

function M:cast_next_skill()
  if is_cast_skill_time(self.npc) then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if 2 == self.control and npc_time >= self.skill_next_time then
    if is_cast_skill_time(self.npc) then
      return
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill_next_id[1])
    self.skill_next_next_id = self.skill_next_id[8]
    self.skill_next_time = npc_time + self.skill_next_id[6]
    if 0 == self.skill_next_next_id or check_npc_status(self.npc, 2) then
      self.wander_timer_skill_makeup = self.skill_next_id[6] + self.skill_next_id[7]
      self.wander_timer = npc_time + self.wander_timer_skill_makeup
      self.control = 0
    else
      self.skill_next_id = self.skill_next_next_id
      self.skill_next_next_id = 0
    end
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if check_magic(self.npc, 2023088) and 1 == self.stand_switch then
    local npc_time = get_npc_time(self.npc)
    if npc_time > self.stand_timer then
      self.stand_switch = 1
      abort_skill(self.npc)
      cast_skill(self.npc, nil, 20102321)
    end
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time < self.wander_timer then
    return
  end
  ret = self:cast_skill(self.skill17)
end

function M:move_leave_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time < self.wander_timer then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max then
    self:move_leave_wander()
  elseif not distance_max then
    self:move_approch_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_superarmor_break(npc, camp)
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  if check_magic(self.npc, 100174) then
    return
  end
  self:skill_main_logic()
  self:cast_next_skill()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  self:wander_main_logic()
  self:spawn_skill()
end

return M
