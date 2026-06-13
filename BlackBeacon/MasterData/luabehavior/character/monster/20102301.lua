local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

local function init_variable(self)
  self.is_receive_missile_list = {
    [2010230101001] = 1,
    [2010230101002] = 2,
    [2010230101003] = 3,
    [2010230101004] = 4,
    [2010230102501] = 1,
    [2010230102502] = 2,
    [2010230102503] = 3,
    [2010230102504] = 4
  }
end

function M:_init(npc)
  Base._init(self)
  self.test_timer = 1.5
  self.point_axis = {
    [1] = {x = 0, z = 0},
    [2] = {x = 0, z = 0},
    [3] = {x = 0, z = 0},
    [4] = {x = 0, z = 0},
    [5] = {x = 0, z = 0}
  }
  init_variable(self)
  self.outrange_point_dis1 = nil
  self.outrange_point_dis2 = nil
  self.outrange_point_num1 = nil
  self.outrange_point_num2 = nil
  self.step_point = {}
  self.backward_hit_set = false
  self.camera_check_set = false
  self.removed_miss_list = {
    [2010230101201] = true,
    [2010230101203] = true,
    [2010110100100301] = true,
    [2010230101207] = true,
    [2010230101210] = true,
    [2010230101212] = true,
    [2010230101214] = true,
    [2010230101216] = true,
    [2010230102609] = true,
    [2010230102611] = true,
    [2010230102613] = true
  }
  self.hitfloor_missile_list = {
    [2010230101801] = true,
    [2010230101802] = true,
    [2010230101803] = true,
    [2010230101804] = true
  }
  self.control = 0
  self.enemy_1 = nil
  self.enemy_2 = nil
  self.ai_state = 1
  self.skill_set = 0
  self.miss_skill_times = 0
  self.miss_recount_times = 0
  self.miss_flash_times = 0
  self.last_skill_set = 0
  self.preload_missile_list = {}
  self.preload_set = false
  self.preload_break_set = false
  self.recount_layer = 0
  self.first_battle_set = 0
  self.laydown_count = 0
  self.atk_derive_count = 0
  self.preload_destory_missile = nil
  self.reflow_balls_timer = 0
  self.stun_info = {set = false, time = 0}
  self.reflow_info = {set = false, time = 0}
  self.state_info = {state = 1, time = 0}
  self.double_clutch = {
    20102301001,
    8,
    2,
    0,
    8,
    get_skill_cfg(20102301001).CastTime,
    get_skill_cfg(20102301001).AfterTime,
    true,
    nil
  }
  self.lift_up = {
    20102301002,
    8,
    2,
    0,
    8,
    get_skill_cfg(20102301002).CastTime,
    get_skill_cfg(20102301002).AfterTime,
    true,
    nil
  }
  self.bump_spin = {
    20102301003,
    9,
    2,
    0,
    5,
    get_skill_cfg(20102301003).CastTime,
    get_skill_cfg(20102301003).AfterTime,
    true,
    nil
  }
  self.step_back_swing = {
    20102301004,
    7,
    2,
    0,
    5,
    get_skill_cfg(20102301004).CastTime,
    get_skill_cfg(20102301004).AfterTime,
    true,
    nil
  }
  self.recount_atk = {
    20102301005,
    99,
    3,
    0,
    5,
    get_skill_cfg(20102301005).CastTime,
    get_skill_cfg(20102301005).AfterTime,
    false,
    nil
  }
  self.spin_eight = {
    20102301006,
    8,
    2,
    0,
    5,
    get_skill_cfg(20102301006).CastTime,
    get_skill_cfg(20102301006).AfterTime,
    false,
    20102301026
  }
  self.backward_hit = {
    20102301007,
    8,
    2,
    0,
    5,
    get_skill_cfg(20102301007).CastTime,
    get_skill_cfg(20102301007).AfterTime,
    false,
    nil
  }
  self.pupu = {
    20102301027,
    10,
    2,
    0,
    5,
    get_skill_cfg(20102301027).CastTime,
    get_skill_cfg(20102301027).AfterTime,
    false,
    nil
  }
  self.double_pupu = {
    20102301028,
    8,
    2,
    0,
    5,
    get_skill_cfg(20102301028).CastTime,
    get_skill_cfg(20102301028).AfterTime,
    false,
    nil
  }
  self.snipe = {
    20102301008,
    10,
    2,
    0,
    5,
    get_skill_cfg(20102301008).CastTime,
    get_skill_cfg(20102301008).AfterTime,
    false,
    nil
  }
  self.preload_balls = {
    20102301010,
    13,
    1,
    0,
    5,
    get_skill_cfg(20102301010).CastTime,
    get_skill_cfg(20102301010).AfterTime,
    false,
    nil
  }
  self.roadsblock_balls = {
    20102301017,
    12,
    1,
    0,
    5,
    get_skill_cfg(20102301017).CastTime,
    get_skill_cfg(20102301017).AfterTime,
    false,
    nil
  }
  self.moon_step = {
    20102301011,
    6,
    2,
    0,
    5,
    get_skill_cfg(20102301011).CastTime,
    get_skill_cfg(20102301011).AfterTime,
    false,
    nil
  }
  self.moon_step_move = {
    20102301015,
    6,
    2,
    0,
    5,
    get_skill_cfg(20102301011).CastTime,
    get_skill_cfg(20102301011).AfterTime,
    false,
    nil
  }
  self.backward_balls_line_balls = {
    [1] = 2010230101201,
    [2] = 2010230101202,
    [3] = 2010230101203,
    [4] = 2010230101204,
    [5] = 2010110100100301,
    [6] = 2010230101206,
    [7] = 2010230101207,
    [8] = 2010230101208,
    [9] = 2010230101209,
    [10] = 2010230101210,
    [11] = 2010230101211,
    [12] = 2010230101212,
    [13] = 2010230101213,
    [14] = 2010230101214,
    [15] = 2010230101215,
    [16] = 2010230101216
  }
  self.crush_lift_up = {
    20102301014,
    5,
    2,
    0,
    8,
    get_skill_cfg(20102301014).CastTime,
    get_skill_cfg(20102301014).AfterTime,
    true,
    nil
  }
  self.be_counted = {
    [1] = 20102301023,
    [2] = 20102301020,
    [3] = 20102301021,
    [4] = 20102301022
  }
  self.die_skill = 20102301034
  self.target_dead_pos = nil
end

function M:on_born_behavior()
  self:xRay()
end

function M:on_start()
  set_keyframe_enable(self.npc, 2010230100409, false, true)
  self.enemy_1 = get_scene_hero_by_poskey(21)
  self.enemy_2 = get_scene_hero_by_poskey(22)
  change_follow_target(1, self.npc, {
    12,
    14,
    {
      x = 0,
      y = -5,
      z = -1.8
    },
    1,
    0.6
  })
  for i, _ in pairs(self.is_receive_missile_list) do
    listen_missile_begin_pos(self.npc, i, self.preload_missile_note, self)
  end
end

function M:moon_step_point_check(num)
  local now_dis = get_npc_distance(self.target, 2, self.point_axis[num].x, self.point_axis[num].z, true)
  if self.outrange_point_dis1 == nil then
    self.outrange_point_dis1 = now_dis
    self.outrange_point_num1 = num
  elseif nil == self.outrange_point_dis2 then
    self.outrange_point_dis2 = now_dis
    self.outrange_point_num2 = num
  end
  if self.outrange_point_dis1 then
    if now_dis > self.outrange_point_dis1 then
      self.outrange_point_dis1 = now_dis
      self.outrange_point_num1 = num
    end
  elseif self.outrange_point_dis2 and now_dis > self.outrange_point_dis2 then
    self.outrange_point_dis2 = now_dis
    self.outrange_point_num2 = num
  end
end

function M:skill_cast()
  if not self.target then
    return
  end
  if 99 == self.skill_set then
    local moon_step_choice = math.random() * 100
    local check_now_dis = get_npc_distance(self.target, 3, nil, true)
    
    local function five_point()
      abort_skill(self.npc)
      if not self.target then
        return false
      end
      for i, _ in pairs(self.point_axis) do
        self:moon_step_point_check(i)
      end
      local point_ran = math.random() * 10
      if point_ran > 5 then
        self.step_point.x = self.point_axis[self.outrange_point_num1].x
        self.step_point.z = self.point_axis[self.outrange_point_num1].z
        self.outrange_point_num1 = nil
        self.outrange_point_dis1 = nil
        self.outrange_point_num2 = nil
        self.outrange_point_dis2 = nil
      else
        self.step_point.x = self.point_axis[self.outrange_point_num2].x
        self.step_point.z = self.point_axis[self.outrange_point_num2].z
        self.outrange_point_num1 = nil
        self.outrange_point_dis1 = nil
        self.outrange_point_num2 = nil
        self.outrange_point_dis2 = nil
      end
      enable_shadow(self.npc, false)
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 96
      return
    end
    
    local function center_reflow()
      abort_skill(self.npc)
      self.step_point.x, self.step_point.z = get_scene_map_pos_postion("center")
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 97
      enable_shadow(self.npc, false)
      return
    end
    
    local function pull_back()
      abort_skill(self.npc)
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 95
      enable_shadow(self.npc, false)
      return
    end
    
    local function center_cast()
      abort_skill(self.npc)
      self.step_point.x, self.step_point.z = get_scene_map_pos_postion("center")
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 94
      enable_shadow(self.npc, false)
      return
    end
    
    local function behind_atk()
      abort_skill(self.npc)
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 98
      enable_shadow(self.npc, false)
      return
    end
    
    if check_now_dis <= 4 and 99 ~= self.last_skill_set then
      center_cast()
    end
    if self.first_battle_set < 2 then
      five_point()
      self.first_battle_set = 2
    elseif 4 == self.first_battle_set then
      pull_back()
      self.first_battle_set = 5
    elseif self.last_skill_set > 30 and self.last_skill_set < 90 then
      behind_atk()
    elseif self.last_skill_set < 20 and self.last_skill_set > 0 then
      five_point()
    elseif moon_step_choice >= 0 and moon_step_choice <= 45 then
      behind_atk()
    elseif moon_step_choice > 45 then
      five_point()
    end
  end
  if 1 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.double_clutch[1])
    self.skill_set = 11
  elseif 2 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.lift_up[1])
    self.skill_set = 12
  elseif 3 == self.skill_set then
    if self.ai_state >= 2 and self.preload_set == false then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.bump_spin[1])
      cast_missile(self.npc, self.npc, nil, nil, 2010230101001, 1)
      cast_missile(self.npc, self.npc, nil, nil, 2010230101002, 1)
      cast_missile(self.npc, self.npc, nil, nil, 2010230101003, 1)
      cast_missile(self.npc, self.npc, nil, nil, 2010230101004, 1)
      cast_magic(self.npc, self.npc, 20102301102, 1)
      self.skill_set = 13
    else
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.bump_spin[1])
      self.skill_set = 13
    end
  elseif 4 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.step_back_swing[1])
    self.skill_set = 14
  elseif 5 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.recount_atk[1])
  end
  if 21 == self.skill_set then
    if self.ai_state >= 2 then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.spin_eight[9])
    else
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.spin_eight[1])
    end
  elseif 22 == self.skill_set then
    if not self.npc or not self.target then
      return
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.backward_hit[1])
  end
  if 31 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.snipe[1])
  elseif 32 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.preload_balls[1])
    self.skill_set = 42
  elseif 33 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.roadsblock_balls[1])
    self.skill_set = 41
  elseif 34 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.pupu[1])
  elseif 35 == self.skill_set then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.double_pupu[1])
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == self.target then
    for i, _ in pairs(self.removed_miss_list) do
      if self.removed_miss_list[m2_cfg.Id] then
        remove_missile(m2)
      end
    end
  end
  if m1_owner == self.npc and m1_cfg.Id == 2010230103101 then
    for i, v in pairs(self.hitfloor_missile_list) do
      if self.hitfloor_missile_list[m2_cfg.Id] then
        remove_missile(m2)
      end
    end
  end
end

function M:combo_break()
  if self.backward_hit_set == true then
    if self.target then
      local dis_check = check_npc_distance(self.npc, self.target, 9.5, true)
      if dis_check and check_magic(self.npc, 20102301106) then
        abort_skill(self.npc)
        cast_skill(self.npc, self.target, self.recount_atk[1])
        self.skill_set = 0
        self.backward_hit_set = false
      end
    elseif check_magic(self.npc, 20102301106) then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.recount_atk[1])
      self.skill_set = 0
      self.backward_hit_set = false
    end
  end
  local now_angle = get_target_angel(self.npc, self.target, false)
  if 1 == self.atk_derive_count then
    if check_magic(self.npc, 20102301101) or check_magic(self.npc, 20102301105) then
    else
      return
    end
    if self.state_info.state <= 2 then
      if 13 == self.skill_set and check_magic(self.npc, 20102301105) then
        abort_skill(self.npc)
        self.skill_set = 21
        abort_magic_by_id(self.npc, 20102301101)
        self:skill_cast()
        self.atk_derive_count = 2
      elseif 11 == self.skill_set and self.state_info.state <= 1 then
        abort_skill(self.npc)
        self.skill_set = 3
        abort_magic_by_id(self.npc, 20102301101)
        self:skill_cast()
        self.atk_derive_count = 2
      elseif 12 == self.skill_set then
        abort_skill(self.npc)
        self.skill_set = 22
        abort_magic_by_id(self.npc, 20102301101)
        self:skill_cast()
        self.atk_derive_count = 2
      elseif 14 == self.skill_set then
        abort_skill(self.npc)
        self.skill_set = 1
        abort_magic_by_id(self.npc, 20102301101)
        self:skill_cast()
        self.atk_derive_count = 2
      elseif 0 ~= self.skill_set then
        self.stun_info.set = true
        abort_magic_by_id(self.npc, 20102301101)
        if 1 == self.ai_state then
          local random_set = math.random() * 100 + self.miss_recount_times * 3
          if random_set >= 90 then
            self.atk_derive_count = 99
          else
            self.miss_recount_times = self.miss_recount_times + 1
            self.atk_derive_count = 0
          end
        end
        return
      end
    end
  end
  if 2 == self.atk_derive_count and (now_angle >= 120 or now_angle > -120) then
    if check_magic(self.npc, 20102301101) or check_magic(self.npc, 20102301105) then
    else
      return
    end
    local atk_choice = math.random() * 100
    local now_angle = get_target_angel(self.npc, self.target, false)
    if atk_choice + self.miss_skill_times * 7 >= 60 then
      if (13 == self.skill_set or 22 == self.skill_set or 1 == self.skill_set) and atk_choice >= 80 and now_angle >= -180 and now_angle <= -80 or now_angle < 180 and now_angle >= 80 then
        if 2 == self.ai_state then
          if self.backward_hit_set == true then
            return
          end
          abort_skill(self.npc)
          self.skill_set = 21
          abort_magic_by_id(self.npc, 20102301101)
          self:skill_cast()
          self.atk_derive_count = 99
        end
      elseif (22 == self.skill_set or 1 == self.skill_set) and atk_choice >= 60 and now_angle >= -180 and now_angle <= -80 or now_angle < 180 and now_angle >= 80 then
        if 2 == self.ai_state then
          if self.backward_hit_set == true then
            return
          end
          abort_skill(self.npc)
          self.skill_set = 3
          abort_magic_by_id(self.npc, 20102301101)
          self:skill_cast()
          self.atk_derive_count = 99
        end
      elseif 0 ~= self.skill_set then
        self.stun_info.set = true
        if 2 == self.ai_state then
          self.miss_skill_times = self.miss_skill_times + 1
          abort_magic_by_id(self.npc, 20102301101)
          return
        elseif 1 == self.ai_state then
          abort_magic_by_id(self.npc, 20102301101)
          self.atk_derive_count = 99
        end
      end
    end
  elseif 99 == self.atk_derive_count and check_magic(self.npc, 20102301101) then
    local atk_choice = math.random() * 100 + self.miss_recount_times * 30
    if self.state_info.state <= 2 and atk_choice >= 80 then
      abort_skill(self.npc)
      self.skill_set = 5
      abort_magic_by_id(self.npc, 20102301101)
      self:skill_cast()
      self.stun_info.set = true
      self.atk_derive_count = 0
    elseif self.state_info.state > 2 and atk_choice >= 8 then
      abort_skill(self.npc)
      self.skill_set = 31
      abort_magic_by_id(self.npc, 20102301101)
      self:skill_cast()
      self.stun_info.set = true
      self.atk_derive_count = 0
    elseif 0 ~= self.atk_derive_count then
      self.stun_info.set = true
      abort_magic_by_id(self.npc, 20102301101)
      self.atk_derive_count = 0
      self.miss_recount_times = self.miss_recount_times + 1
      return
    end
  end
end

function M:preload_missile_note(owner, pos_x, pos_z, missile_cfg, missile)
  self.preload_missile_list[missile_cfg.Id] = missile
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if self.npc ~= npc then
    return
  end
  if skill_id == self.moon_step[1] then
    set_can_searched(self.npc, false)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 100104, 1)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 2010230100701 then
    if not self.npc or not self.target then
      return
    end
    local now_pos = get_npc_pos(self.npc)
    cast_magic(self.npc, hit_target, 20102301206, 1)
    cast_missile(self.npc, nil, now_pos.x, now_pos.z, 2010230101601, 1)
    self.backward_hit_set = true
  end
  if hit_target == self.npc and check_magic(hit_target, 20102301104) and 4 == missile_cfg.MissileTypeTag then
    if not self.npc or not self.target then
      return
    end
    local pos_save = {}
    local mons_pos = get_npc_pos(hit_target)
    local hitter_pos = get_npc_pos(npc)
    pos_save = mons_pos + (hitter_pos - mons_pos) * 0.2
    abort_skill(self.npc)
    self.skill_set = 90
    abort_magic_by_id(self.npc, 20102301104)
    cast_skill(self.npc, self.npc, self.be_counted[2])
    set_skill_end_to_idle(self.npc, false)
    cast_missile(hit_target, nil, pos_save.x, pos_save.z, 2010230102402, 1)
  end
end

function M:create_balls()
  if not self.npc or not self.target then
    return
  end
  local now_time = get_npc_time(self.npc)
  local tar_pos = get_npc_pos(self.target)
  local ran_deg = math.random() * 360
  local ran_len = math.random() * 8
  local pos = get_npc_offset_position(self.target, nil, ran_deg, ran_len)
  if now_time >= self.reflow_balls_timer then
    local time_gap = now_time - self.reflow_info.time
    if time_gap >= 8 then
      cast_missile(self.npc, self.target, pos.x, pos.z, 2010230103301, 1)
      self.reflow_balls_timer = now_time + math.random() * 3
    elseif time_gap >= 3 and tiem_gap < 8 then
      cast_missile(self.npc, self.target, pos.x, pos.z, 2010230103303, 1)
      self.reflow_balls_timer = now_time + math.random() * 2
    else
      cast_missile(self.npc, self.target, pos.x, pos.z, 2010230103305, 1)
      self.reflow_balls_timer = now_time + math.random()
    end
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if not self.target or not self.npc then
    local skill_list = {
      [self.moon_step[1]] = true,
      [self.moon_step_move[1]] = true,
      [self.be_counted[1]] = true,
      [self.be_counted[2]] = true,
      [self.be_counted[3]] = true
    }
    if skill_list[skill_id] then
    else
      self.atk_derive_count = 0
      return
    end
  end
  if skill_id == self.moon_step[1] or skill_id == self.moon_step_move[1] then
  else
    if 1 == self.reflow_info.set and 35 == self.last_skill_set then
      self.skill_set = 35
      self.last_skill_set = 35
      self:skill_cast()
    elseif 1 == self.reflow_info.set then
      self.skill_set = 35
      self.last_skill_set = 35
      self:skill_cast()
    end
    if 2 == self.reflow_info.set then
      self.skill_set = 31
      self.last_skill_set = 31
      self:skill_cast()
    end
  end
  if skill_id == self.be_counted[2] then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.be_counted[3], 1)
    self.laydown_count = self.laydown_count + 1
  elseif skill_id == self.be_counted[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.be_counted[4], 1)
    set_skill_end_to_idle(self.npc, true)
  elseif skill_id == self.be_counted[4] then
    if 3 == self.laydown_count then
      abort_skill(self.npc)
      self.step_point.x, self.step_point.z = get_scene_map_pos_postion("center")
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 97
      enable_shadow(self.npc, false)
      cast_magic(self.npc, self.npc, 100104, 1)
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.target, 20102301401, 1)
      cast_magic(self.npc, self.target, 20102301402, 1)
      self.ai_state = 2
      set_keyframe_enable(self.npc, 2010230100409, true, true)
    elseif 3 ~= self.ai_state then
      self.skill_set = 0
    end
  end
  if skill_id == self.moon_step[1] then
    if 98 == self.skill_set then
      if not self.npc then
        return
      end
      local tar_pos = {}
      if self.target then
        tar_pos = get_npc_offset_position(self.target, nil, 180, 5.5)
      elseif self.target_dead_pos then
        tar_pos = get_position_offset_position(get_npc_pos(self.npc), self.target_dead_pos, 180, 5.5)
      end
      self.step_point.x = tar_pos.x
      self.step_point.z = tar_pos.z
    elseif 95 == self.skill_set then
      if not self.npc then
        return
      end
      local tar_pos = {}
      local mons_pos = get_npc_pos(self.npc)
      local hero_pos
      if self.target then
        hero_pos = get_npc_pos(self.target)
      elseif self.target_dead_pos then
        hero_pos = self.target_dead_pos
      end
      tar_pos = get_position_offset_position(hero_pos, mons_pos, 0, 5.5)
      self.step_point.x = tar_pos.x
      self.step_point.z = tar_pos.z
    elseif 93 == self.skill_set then
    end
    cast_skill(self.npc, nil, self.moon_step_move[1], self.step_point.x, self.step_point.z)
  elseif skill_id == self.moon_step_move[1] then
    if self.target then
      lookat_npc(self.npc, self.target, 1)
    else
      lookat_position(self.npc, self.target_dead_pos.x, self.target_dead_pos.z, 1)
    end
    set_can_searched(self.npc, true)
    abort_magic_by_id(self.npc, 100104)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 20102301201)
    abort_magic_by_id(self.npc, 20102301202)
    abort_magic_by_id(self.npc, 201026010142)
    abort_magic_by_id(self.npc, 201026010144)
    abort_magic_by_id(self.npc, 20102301203)
    abort_magic_by_id(self.npc, 20102301204)
    abort_magic_by_id(self.npc, 20102301205)
    abort_magic_by_id(self.npc, 20102301210)
    enable_shadow(self.npc, true)
    if 97 == self.skill_set then
      abort_skill(self.npc)
      local now_time = get_npc_time(self.npc)
      local end_pos
      cast_skill(self.npc, self.target, 20102301029)
      for i = 1, 16 do
        end_pos = get_npc_offset_position(self.npc, nil, i * 45 + 45, 4.2)
        cast_missile(self.npc, nil, end_pos.x, end_pos.z, self.backward_balls_line_balls[i], 1)
      end
      self.reflow_info.time = now_time + 10
      self.reflow_info.set = 1
      self:skill_cast()
      return
    elseif 93 == self.skill_set then
      abort_skill(self.npc)
      local now_time = get_npc_time(self.npc)
      self.skill_set = 31
      self.last_skill_set = 31
      self:skill_cast()
      return
    elseif 98 == self.skill_set then
      abort_skill(self.npc)
      local random_set = math.random() * 10
      self.skill_set = 2
      self.last_skill_set = 2
      self.lift_up[3] = get_npc_time(self.npc) + self.lift_up[2]
      self:skill_cast()
      return
    elseif 94 == self.skill_set then
      abort_skill(self.npc)
      self.skill_set = 34
      self.last_skill_set = 34
      self:skill_cast()
      return
    elseif 95 == self.skill_set then
      abort_skill(self.npc)
      self.skill_set = 22
      self.last_skill_set = 22
      self:skill_cast()
      return
    elseif 96 == self.skill_set then
      abort_skill(self.npc)
      local random_set = math.random() * 10
      self.skill_set = 31
      self.last_skill_set = 31
      self:skill_cast()
      return
    else
      self.skill_set = 0
      return
    end
  end
  if 41 == self.skill_set and skill_id == self.roadsblock_balls[1] then
    if 1 == self.ai_state then
      abort_skill(self.npc)
      self.skill_set = 34
      self:skill_cast()
      return
    elseif 2 == self.ai_state then
      abort_skill(self.npc)
      self.skill_set = 35
      self:skill_cast()
      return
    end
  elseif 42 == self.skill_set and skill_id == self.preload_balls[1] then
    abort_skill(self.npc)
    self.skill_set = 31
    self:skill_cast()
    return
  end
  if 0 ~= self.skill_set and self.skill_set < 90 then
    if true == self.stun_info.set then
      if 1 == self.ai_state then
        self.stun_info.time = get_npc_time(self.npc) + 3
      elseif 2 == self.ai_state then
        self.stun_info.time = get_npc_time(self.npc) + 3
      end
    end
    self.skill_set = 0
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 0 ~= self.skill_set and 97 ~= self.skill_set and 98 ~= self.skill_set and 90 ~= self.skill_set and 96 ~= self.skill_set and 95 ~= self.skill_set and 93 ~= self.skill_set then
    if self.stun_info.set == true then
      if 1 == self.ai_state then
        self.stun_info.time = get_npc_time(self.npc) + 3
      elseif 2 == self.ai_state then
        self.stun_info.time = get_npc_time(self.npc) + 3
      end
    end
    self.skill_set = 0
  end
  if skill_id == self.be_counted[4] then
    if 3 == self.laydown_count then
      abort_skill(self.npc)
      self.step_point.x, self.step_point.z = get_scene_map_pos_postion("center")
      cast_skill(self.npc, nil, self.moon_step[1])
      self.skill_set = 97
      enable_shadow(self.npc, false)
      cast_magic(self.npc, self.npc, 100104, 1)
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.target, 20102301401, 1)
      cast_magic(self.npc, self.target, 20102301402, 1)
      self.ai_state = 2
      set_keyframe_enable(self.npc, 2010230100409, true, true)
    else
      self.skill_set = 0
    end
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 20102301102 == magic_id then
    self.preload_break_set = true
  end
end

function M:on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 20102301102 == magic_id then
    self.preload_set = true
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if 1 == self.reflow_info.set or 2 == self.reflow_info.set then
    return
  end
  local now_time = get_npc_time(self.npc)
  if self.stun_info.set == true then
    if now_time >= self.stun_info.time then
      self.stun_info.set = false
    else
      return
    end
  end
  local now_angle = get_target_angel(self.npc, self.target, true)
  if 1 == self.ai_state then
    if 0 == self.skill_set then
      local now_hp = get_npc_attr(self.npc, 1)
      local max_hp = get_npc_attr(self.npc, 4)
      if now_hp / max_hp <= 0.7 and 99 ~= self.last_skill_set then
        abort_skill(self.npc)
        self.step_point.x, self.step_point.z = get_scene_map_pos_postion("center")
        cast_skill(self.npc, nil, self.moon_step[1])
        self.skill_set = 97
        enable_shadow(self.npc, false)
        cast_magic(self.npc, self.npc, 100104, 1)
        cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
        self.laydown_count = 3
        self.ai_state = 2
        set_keyframe_enable(self.npc, 2010230100409, true, true)
        return
      end
    end
    local dis_with_wall = get_npc_distance(self.npc, 3, nil, true)
    if dis_with_wall <= 4 and 99 ~= self.last_skill_set and 0 == self.skill_set and 0 == self.skill_set then
      self.skill_set = 99
      self.last_skill_set = 99
      self:skill_cast()
      return
    end
    local atk_choice = math.random() * 100
    local flash_choice = math.random() * 100 + self.miss_flash_times * 12
    if flash_choice >= 110 and self.last_skill_set < 90 and 0 == self.skill_set then
      self.skill_set = 99
      self.last_skill_set = 99
      self.miss_flash_times = 0
      self:skill_cast()
      return
    elseif self.miss_flash_times >= 3 and 99 ~= self.last_skill_set then
      self.skill_set = 99
      self.last_skill_set = 99
      self.first_battle_set = 4
      self.miss_flash_times = 0
      self:skill_cast()
      return
    end
    if self.state_info.state <= 2 and 0 == self.skill_set then
      if now_angle >= -180 and now_angle <= 70 then
        if 1 == self.state_info.state then
          if atk_choice >= 40 then
            self.skill_set = 1
            self.last_skill_set = 1
            self.atk_derive_count = 1
            self.miss_flash_times = self.miss_flash_times + 1
          else
            self.skill_set = 3
            self.last_skill_set = 3
            self.atk_derive_count = 1
            self.miss_flash_times = self.miss_flash_times + 1
          end
        elseif now_time >= self.pupu[3] then
          self.skill_set = 34
          self.last_skill_set = 34
          self.miss_flash_times = self.miss_flash_times + 1
          self.pupu[3] = now_time + self.pupu[2]
        else
          self.skill_set = 2
          self.last_skill_set = 2
          self.atk_derive_count = 1
          self.miss_flash_times = self.miss_flash_times + 1
        end
      elseif 0 ~= self.skill_set or 2 == self.state_info.state then
      elseif now_angle >= 70 and now_angle < 180 then
        self.skill_set = 4
        self.last_skill_set = 4
        self.atk_derive_count = 1
        self.miss_flash_times = self.miss_flash_times + 1
      elseif now_angle <= -70 and now_angle >= -180 then
        self.skill_set = 3
        self.last_skill_set = 3
        self.atk_derive_count = 1
        self.miss_flash_times = self.miss_flash_times + 1
      end
    elseif self.state_info.state > 2 and 0 == self.skill_set then
      local now_time = get_npc_time(self.npc)
      if atk_choice >= 0 and atk_choice < 50 and now_time >= self.roadsblock_balls[3] then
        abort_skill(self.npc)
        self.skill_set = 33
        self.last_skill_set = 33
        self.roadsblock_balls[3] = now_time + self.roadsblock_balls[2]
        self.miss_flash_times = self.miss_flash_times + 1
      elseif atk_choice >= 50 and atk_choice < 100 and now_time >= self.preload_balls[3] and false == self.preload_set then
        abort_skill(self.npc)
        self.skill_set = 32
        self.last_skill_set = 32
        self.preload_balls[3] = now_time + self.preload_balls[2]
        self.miss_flash_times = self.miss_flash_times + 1
      else
        if 99 == self.last_skill_set then
          return
        end
        abort_skill(self.npc)
        self.skill_set = 99
        self.last_skill_set = 99
      end
    end
    self:skill_cast()
  elseif 2 == self.ai_state then
    if 0 == self.skill_set then
      local now_hp = get_npc_attr(self.npc, 1)
      local max_hp = get_npc_attr(self.npc, 4)
      if now_hp / max_hp <= 0.35 and 0 == self.reflow_info.set and 99 ~= self.last_skill_set then
        abort_skill(self.npc)
        self.step_point.x, self.step_point.z = get_scene_map_pos_postion("P5")
        cast_skill(self.npc, nil, self.moon_step[1])
        self.skill_set = 93
        self.last_skill_set = 93
        self.reflow_info.set = 2
        self.reflow_info.time = now_time + 16
        enable_shadow(self.npc, false)
        cast_magic(self.npc, self.npc, 100104, 1)
        cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
        self:skill_cast()
        return
      end
    end
    local dis_with_wall = get_npc_distance(self.npc, 3, nil, true)
    if dis_with_wall <= 2 and 99 ~= self.last_skill_set and 0 == self.skill_set and 0 == self.skill_set then
      self.skill_set = 99
      self.last_skill_set = 99
      self:skill_cast()
      return
    end
    local atk_choice = math.random() * 100
    local flash_choice = math.random() * 100 + self.miss_flash_times * 15
    if flash_choice >= 110 and self.last_skill_set < 90 and 1 == self.state_info.state then
      self.skill_set = 99
      self.last_skill_set = 99
      self.miss_flash_times = 0
      self:skill_cast()
      return
    elseif self.miss_flash_times >= 4 and self.state_info.state >= 1 and 99 ~= self.last_skill_set then
      self.skill_set = 99
      self.last_skill_set = 99
      self.first_battle_set = 4
      self.miss_flash_times = 0
      self:skill_cast()
      return
    end
    if self.state_info.state <= 2 and 0 == self.skill_set then
      if now_angle >= -180 and now_angle <= 70 then
        if 1 == self.state_info.state then
          if atk_choice >= 40 and now_time >= self.double_clutch[3] then
            self.skill_set = 1
            self.last_skill_set = 1
            self.atk_derive_count = 1
            self.miss_flash_times = self.miss_flash_times + 1
            self.double_clutch[3] = now_time + self.double_clutch[2]
          elseif atk_choice < 40 and atk_choice >= 0 and now_time >= self.bump_spin[3] then
            self.skill_set = 3
            self.last_skill_set = 3
            self.atk_derive_count = 1
            self.miss_flash_times = self.miss_flash_times + 1
            self.bump_spin[3] = now_time + self.bump_spin[2]
          end
        elseif now_time >= self.lift_up[3] and 2 == self.state_info.state then
          self.skill_set = 2
          self.last_skill_set = 2
          self.atk_derive_count = 1
          self.miss_flash_times = self.miss_flash_times + 1
          self.lift_up[3] = now_time + self.lift_up[2]
        elseif now_time >= self.double_pupu[3] and 2 == self.state_info.state then
          self.skill_set = 34
          self.last_skill_set = 34
          self.miss_flash_times = self.miss_flash_times + 1
          self.double_pupu[3] = now_time + self.double_pupu[2]
        end
      elseif now_angle >= 70 and now_angle < 180 and 1 == self.state_info.state then
        self.skill_set = 4
        self.last_skill_set = 4
        self.atk_derive_count = 1
      end
    elseif self.state_info.state > 2 and 0 == self.skill_set then
      local now_time = get_npc_time(self.npc)
      if atk_choice >= 0 and atk_choice < 50 and now_time >= self.roadsblock_balls[3] then
        abort_skill(self.npc)
        self.skill_set = 33
        self.last_skill_set = 33
        self.roadsblock_balls[3] = now_time + self.roadsblock_balls[2]
      elseif atk_choice >= 50 and atk_choice < 100 and now_time >= self.preload_balls[3] and false == self.preload_set then
        abort_skill(self.npc)
        self.skill_set = 32
        self.last_skill_set = 32
        self.preload_balls[3] = now_time + self.preload_balls[2]
      elseif now_time >= self.double_pupu[3] then
        abort_skill(self.npc)
        self.skill_set = 35
        self.last_skill_set = 35
        self.double_pupu[3] = now_time + self.double_pupu[2]
      else
        if 0 ~= self.skill_set or 99 == self.last_skill_set then
          return
        end
        abort_skill(self.npc)
        self.skill_set = 99
        self.last_skill_set = 99
      end
    end
    self:skill_cast()
  elseif 3 == self.ai_state then
    if true == self.tantacle_laydown_set or is_cast_skill_time(self.npc) then
      return
    end
    local now_time = get_npc_time(self.npc)
    local random_skill = math.random() * 100
    if now_time >= self.roadsblock_balls[3] and random_skill >= 30 then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.roadsblock_balls[1], 1)
      self.roadsblock_balls[3] = now_time + self.roadsblock_balls[2]
      self.stun_info.set = true
    elseif now_time >= self.double_pupu[3] and random_skill >= 30 then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.double_pupu[1], 1)
      self.double_pupu[3] = now_time + self.double_pupu[2]
      self.stun_info.set = true
    elseif now_time >= self.snipe[3] and random_skill >= 30 then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.snipe[1], 1)
      self.stun_info.set = true
      self.snipe[3] = now_time + self.snipe[2]
    end
  end
end

function M:balls_load_set()
  if not self.target then
    return
  end
  if self.preload_set == true and check_npc_distance(self.npc, self.target, 12, true) then
    for i, v in pairs(self.preload_missile_list) do
      remove_missile(v)
      cast_missile(self.npc, self.target, nil, nil, 2010230101800 + self.is_receive_missile_list[i], 1)
    end
    cast_missile(self.npc, self.npc, nil, nil, 2010230103101, 1)
    self.preload_break_set = false
    self.preload_set = false
    self.preload_missile_list = {}
  elseif true == self.preload_break_set and self.skill_set >= 90 then
    for i, v in pairs(self.preload_missile_list) do
      remove_missile(v)
    end
    self.preload_break_set = false
    self.preload_set = false
    self.preload_missile_list = {}
  end
  if check_magic(self.npc, 20102301103) then
    for i = 1, 4 do
      local now_pos = get_npc_pos(self.target)
      local tar_pos = {}
      local tar_length = math.random() * 2 + 2.5
      local tar_degree = math.random() * 360
      tar_pos = get_npc_offset_position(self.target, nil, tar_degree, tar_length)
      if 4 == i then
        tar_pos = get_npc_offset_position(self.target, nil, 0, 3.5)
      end
      cast_missile(self.npc, self.target, tar_pos.x, tar_pos.z, 2010230101901, 1)
    end
    abort_magic_by_id(self.npc, 20102301103)
  end
end

function M:dis_check()
  local now_dis = get_npc_distance(self.npc, 1, self.target, true)
  local now_time = get_npc_time(self.npc)
  if 1 ~= self.state_info.state and now_dis <= 4.5 then
    self.miss_skill_times = 0
    self.state_info.state = 1
    self.state_info.time = now_time + 5
  elseif 2 ~= self.state_info.state and now_dis > 4.5 and now_dis <= 9.5 then
    self.miss_skill_times = 0
    self.state_info.state = 2
    self.state_info.time = now_time + 5
  elseif 3 ~= self.state_info.state and now_dis > 9.5 then
    self.miss_skill_times = 0
    self.state_info.state = 3
    self.state_info.time = now_time + 5
  end
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    change_follow_target(0)
    time_scale_immune(npc, true)
    cast_magic(npc, npc, 399931, 0)
    cast_magic(npc, npc, 399932, 0)
    cast_magic(npc, npc, 399933, 0)
    set_npc_dead(self.npc, nil, true)
    cast_skill(self.npc, self.npc, self.die_skill)
    if self.preload_set == true and check_npc_distance(self.npc, self.target, 12, true) then
      for i, v in pairs(self.preload_missile_list) do
        remove_missile(v)
        cast_missile(self.npc, self.target, nil, nil, 2010230101800 + self.is_receive_missile_list[i], 1)
      end
      cast_missile(self.npc, self.npc, nil, nil, 2010230103101, 1)
      self.preload_break_set = false
      self.preload_set = false
      self.preload_missile_list = {}
    end
  elseif npc == self.target then
    self.target_dead_pos = get_npc_pos(npc)
  end
end

function M:on_superarmor_break(npc, camp)
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if now_time < self.test_timer then
    self.point_axis[1].x, self.point_axis[1].z = get_scene_map_pos_postion("P1")
    self.point_axis[2].x, self.point_axis[2].z = get_scene_map_pos_postion("P2")
    self.point_axis[3].x, self.point_axis[3].z = get_scene_map_pos_postion("P3")
    self.point_axis[4].x, self.point_axis[4].z = get_scene_map_pos_postion("P4")
    self.point_axis[5].x, self.point_axis[5].z = get_scene_map_pos_postion("P5")
    return
  end
  if now_time >= self.state_info.time and 0 == self.skill_set and 99 ~= self.last_skill_set and self.state_info.state >= 2 and 0 == self.reflow_info.set then
    self.skill_set = 99
    self.last_skill_set = 99
    self.first_battle_set = 4
    self:skill_cast()
  end
  if 1 == self.reflow_info.set and now_time >= self.reflow_info.time then
    self.reflow_info.set = 0
    self.reflow_info.time = -1
  end
  if 2 == self.reflow_info.set and now_time >= self.reflow_info.time then
    self.reflow_info.set = 4
    self.reflow_info.time = -1
  elseif 2 == self.reflow_info.set then
    self:create_balls()
  end
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 100, 100)
  self:dis_check()
  self:balls_load_set()
  self:skill_main_logic()
  self:combo_break()
end

function M:on_hero_reborn(reborned_hero)
  self.skill_set = 0
  self.control = 0
  self.last_skill_set = 0
  self.atk_derive_count = 0
  change_follow_target(1, self.npc, {
    12,
    14,
    {
      x = 0,
      y = -5,
      z = -1.8
    },
    1,
    0.6
  })
end

function M:on_remove()
  for i, _ in pairs(self.is_receive_missile_list) do
    unlisten_missile_begin_pos(self.npc, i, self)
  end
end

return M
