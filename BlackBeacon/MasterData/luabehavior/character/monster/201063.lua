local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local hit = false

function M:_init()
  Base._init(self)
  self.nomal_atk = {
    2010260102,
    5,
    0,
    2,
    3,
    get_skill_cfg(2010260102).CastTime,
    get_skill_cfg(2010260102).AfterTime,
    0
  }
  self.dive = {
    2010260103,
    9,
    0,
    2,
    99,
    get_skill_cfg(2010260103).CastTime,
    get_skill_cfg(2010260103).AfterTime,
    0
  }
  self.undergrand = {
    2010260104,
    0,
    0,
    2,
    99,
    get_skill_cfg(2010260104).CastTime,
    get_skill_cfg(2010260104).AfterTime,
    0
  }
  self.undershoot = {
    2010260105,
    0,
    0,
    2,
    99,
    get_skill_cfg(2010260105).CastTime,
    get_skill_cfg(2010260105).AfterTime,
    0
  }
  self.retreat_shoot = {
    2010260106,
    5,
    0,
    2,
    99,
    get_skill_cfg(2010260106).CastTime,
    get_skill_cfg(2010260106).AfterTime,
    0
  }
  self.stab = {
    2010260107,
    7,
    0,
    2,
    10,
    get_skill_cfg(2010260107).CastTime,
    get_skill_cfg(2010260107).AfterTime,
    0
  }
  self.roar = {
    2010260108,
    7,
    0,
    2,
    99,
    get_skill_cfg(2010260108).CastTime,
    get_skill_cfg(2010260108).AfterTime,
    0
  }
  self.break_begin = {
    2010260110,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260110).CastTime,
    get_skill_cfg(2010260110).AfterTime,
    0
  }
  self.break_continued = {
    2010260111,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260111).CastTime,
    get_skill_cfg(2010260111).AfterTime,
    0
  }
  self.break_end = {
    2010260112,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260112).CastTime,
    get_skill_cfg(2010260112).AfterTime,
    0
  }
  self.counter_break_begin = {
    2010260113,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260113).CastTime,
    get_skill_cfg(2010260113).AfterTime,
    0
  }
  self.counter_break_continued = {
    2010260114,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260114).CastTime,
    get_skill_cfg(2010260114).AfterTime,
    0
  }
  self.counter_break_end = {
    2010260115,
    7,
    0,
    1,
    3,
    get_skill_cfg(2010260115).CastTime,
    get_skill_cfg(2010260115).AfterTime,
    0
  }
  self.Enter_Attack_Range = 20
  self.stun_timer = 0
  self.control = 0
  self.wander_time = 0
  self.wander_control = 0
  self.birth_time = 0
  self.is_birth = false
  self.born_skill = 2010260101
  self.die_skill = 2010260116
  self.wandering = false
  self.skill_set = 0
  self.skill_set_random = 0
  self.atk_count = 0
  self.dive_timer = 0
  self.is_diving = false
  self.diving_out = 0
  self.retreat_shoot_pos = {}
  self.javelin_list = {}
  self.javelin4 = nil
  self.javelin1_pos = {}
  self.javelin1 = nil
  self.javelin2_pos = {}
  self.javelin2 = nil
  self.javelin3_pos = {}
  self.javelin3 = nil
  self.behit_count = 0
  self.atk_count = 0
  self.skill_count = 0
  self.break_time1 = 0
  self.break_time2 = 0
  self.camera_time = 0
  self.retreat_time = 0
  self.ground_missile = nil
  self.stun_type = 0
  self.stun = false
  self.cast_missile_done = false
end

function M:on_start()
  self.birth_time = get_npc_time(self.npc) + 3
  cast_skill(self.npc, self.npc, self.born_skill)
  listen_missile_begin_pos(self.npc, 201026010605, self.on_missile_begin, self)
  listen_missile_begin_pos(self.npc, 201026010607, self.on_missile_begin, self)
  listen_missile_begin_pos(self.npc, 201026010903, self.on_missile_begin, self)
  listen_missile_end_pos(self.npc, 201026010605, self.on_missile_end, self)
end

function M:on_remove()
  unlisten_missile_begin_pos(self.npc, 201026010605, self)
  unlisten_missile_begin_pos(self.npc, 201026010607, self)
  unlisten_missile_begin_pos(self.npc, 201026010903, self)
  unlisten_missile_end_pos(self.npc, 201026010605, self)
end

function M:Relese_Skill(Skill_ID)
  local dis0 = check_npc_distance(self.npc, self.target, Skill_ID[4], true)
  local dis1 = check_npc_distance(self.npc, self.target, Skill_ID[5], true)
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
  if get_npc_time(self.npc) <= self.stun_timer then
    lookat_npc(self.target, self.npc)
    return
  end
  if 1 ~= self.control then
    return
  end
  if get_npc_time(self.npc) >= Skill_ID[3] then
    if not dis1 then
      self:Move_Forward()
    elseif dis1 and not dis0 then
      lookat_npc(self.npc, self.target)
      cast_skill(self.npc, self.target, Skill_ID[1])
      Skill_ID[3] = get_npc_time(self.npc) + Skill_ID[2]
      self.wandering = false
    elseif dis0 then
      self:Move_Bcakward()
    end
  else
    self:Wandering()
  end
end

function M:Move_Forward()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:Wandering()
  if not self.target then
    return
  end
  self.wander_randomseed = math.random()
  if self.wander_randomseed < 0.3 and get_npc_time(self.npc) >= self.wander_time then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 0.6 and get_npc_time(self.npc) >= self.wander_time then
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 1 and get_npc_time(self.npc) >= self.wander_time then
    stop_move(self.npc)
    self.wander_time = get_npc_time(self.npc) + 1
  end
  if not self.wandering then
    self.wandering = true
  end
end

function M:Move_Bcakward()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:Enter_Attack()
  if not self.target then
    return
  end
  if 1 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    self:Wandering()
    return
  end
  if not check_activate(self.target) then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if 1 == self.skill_set then
    self:Relese_Skill(self.nomal_atk)
  elseif 2 == self.skill_set then
    self:Relese_Skill(self.dive)
  elseif 3 == self.skill_set then
    self:Relese_Skill(self.retreat_shoot)
  elseif 4 == self.skill_set then
    self:Relese_Skill(self.roar)
  elseif 5 == self.skill_set then
    self:Relese_Skill(self.stab)
  end
end

function M:on_missile_begin(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 201026010605 then
    self.javelin4 = missile
  end
  if missile_cfg.Id == 201026010607 then
    self.ground_missile = missile
  end
  if missile_cfg.Id == 201026010903 then
    if self.javelin1 == nil then
      self.javelin1_pos.x = pos_x
      self.javelin1_pos.z = pos_z
      self.javelin1 = missile
      return
    elseif self.javelin1 ~= nil and nil == self.javelin2 then
      self.javelin2_pos.x = pos_x
      self.javelin2_pos.z = pos_z
      self.javelin2 = missile
      return
    elseif self.javelin1 ~= nil and nil ~= self.javelin2 and nil == self.javelin3 then
      self.javelin3_pos.x = pos_x
      self.javelin3_pos.z = pos_z
      self.javelin3 = missile
    end
    for i = 1, 10 do
      if nil == self.javelin_list[i] then
        self.javelin_list[i] = missile
        break
      end
    end
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner ~= self.npc and m2_owner ~= self.npc then
    return
  end
  if m1_cfg.Id == 201026010605 and m2_cfg.Id == 201026010607 then
    remove_missile(self.ground_missile)
    remove_missile(self.javelin4, true)
    self.javelin4 = nil
    self.ground_missile = nil
    cast_magic(self.npc, self.npc, 20102601012, 1)
  end
end

function M:on_missile_end(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 201026010605 then
    local pos_x = pos_x
    local pos_z = pos_z
    if not self.cast_missile_done then
      cast_missile(self.npc, nil, pos_x, pos_z, 201026010903, 1, pos_x, pos_z)
      self.cast_missile_done = true
    end
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 1999127 == magic_id then
    cast_magic(self.npc, self.npc, 20102601010, 1)
  end
  if npc == self.npc and 20102601013 == magic_id then
    abort_magic_by_id(self.npc, 201055002, 1)
    abort_magic_by_id(self.npc, 201055003, 1)
    abort_magic_by_id(self.npc, 201055004, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id ~= self.nomal_atk[1] then
    self.atk_count = 0
  end
  if skill_id == self.retreat_shoot[1] then
    self.retreat_shoot_pos = get_npc_pos(self.npc)
    self.retreat_time = self.retreat_time + 1
    change_follow_target(1, self.npc, {
      7,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 3
      },
      1.3,
      0.55
    })
    self.camera_time = get_npc_time(self.npc) + 2
    change_focus_follow_speed(2)
  end
  if skill_id == self.roar[1] then
    self.retreat_time = 0
  end
  if skill_id == self.dive[1] then
    set_can_searched(self.npc, false)
    cast_magic(self.npc, self.npc, 20102601014, 1)
  end
  if skill_id == self.undergrand[1] then
    cast_magic(self.npc, self.npc, 201055002, 1)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if not self.target then
    return
  end
  if hit_target == self.npc and math.random(1, 100) > 50 then
    self.behit_count = self.behit_count + 1
  end
  if hit_target == self.npc and 4 == missile_cfg.MissileTypeTag and check_magic(self.npc, 20102601010) then
    self.control = 2
    change_follow_target(1, self.npc, {
      8,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 2
      },
      1.3,
      0.55
    })
    cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.FX, 1)
    cast_magic(self.npc, self.npc, 20101201014, 1)
    cast_magic(self.npc, self.npc, 20101101026, 1)
    cast_magic(self.npc, self.npc, 20101101027, 1)
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    enter_stun(self.npc, true)
    self.stun_type = 1
    self.break_time1 = get_npc_time(self.npc) + 2.8
    abort_magic_by_id(self.npc, 20102601010, 1)
    self.camera_time = get_npc_time(self.npc) + 0.2
    change_focus_follow_speed(2)
  end
  if false == hit and self.stun == true then
    cast_magic(self.npc, self.npc, 20101101032, 1)
    hit = true
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if skill_id == self.nomal_atk[1] then
    self.stun_timer = now_time + 3
    self.atk_count = self.atk_count + 1
    if self.atk_count >= 2 then
      self.skill_set = 2
    end
  end
  if skill_id == self.dive[1] then
    cast_skill(self.npc, self.target, self.undergrand[1])
    cast_magic(self.npc, self.npc, 20102601001, 1)
    self.diving_out = now_time + 3
    self.is_diving = true
    enable_shadow(self.npc, false)
  end
  if skill_id == self.undershoot[1] then
    self.stun_timer = now_time + 3
    self.skill_set = 1
    set_can_searched(self.npc, true)
    abort_magic_by_id(self.npc, 20102601014, 99)
  end
  if skill_id == self.retreat_shoot[1] then
    if self.retreat_time < 3 and self.target then
      if check_npc_distance(self.npc, self.target, 12, true) and math.random(1, 100) > 50 then
        self.skill_set = 5
      else
        self.skill_set = 2
      end
    end
    self.cast_missile_done = false
  end
  if skill_id == self.roar[1] then
    self.skill_set = 5
  end
  if skill_id == self.stab[1] then
    self.skill_set = 1
  end
  if skill_id == self.break_end[1] or skill_id == self.counter_break_end[1] then
    if check_npc_distance(self.npc, self.target, 2, true) then
      self.control = 1
      lookat_npc(self.npc, self.target)
      self.skill_set = 3
    else
      self.stun_timer = get_npc_time(self.npc) + 3
      if math.random(1, 100) > 40 then
        self.skill_set = 5
      else
        self.skill_set = 2
      end
      self.control = 1
    end
  end
end

function M:Diving_Skill()
  if not self.target then
    return
  end
  local now_time = get_npc_time(self.npc)
  if is_cast_skill_time(self.npc, self.undergrand[1]) and now_time > self.dive_timer and self.is_diving then
    local pos1 = get_npc_offset_position(self.npc, get_npc_pos(self.target), 30, 10)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 20102601002, 1)
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, pos1)
    self.dive_timer = now_time + 0.8
  end
  if is_cast_skill_time(self.npc, self.undergrand[1]) and now_time > self.diving_out then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.is_diving = false
  end
  if is_cast_skill_time(self.npc, self.undergrand[1]) and not self.is_diving then
    if now_time > self.dive_timer then
      cast_magic(self.npc, self.npc, 20102601002, 1)
      self.dive_timer = now_time + 0.8
    end
    if get_npc_distance(self.npc, 1, self.target, true) <= 1.5 then
      abort_skill(self.npc)
      lookat_npc(self.npc, self.target, 1)
      cast_skill(self.npc, self.target, self.undershoot[1])
      abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
      abort_magic_by_id(self.npc, 20102601001, 1)
      enable_shadow(self.npc, true)
    end
  end
end

function M:Control_missile()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc, self.roar[1]) and check_magic(self.npc, 20102601005) then
    cast_missile(self.npc, nil, self.javelin1_pos.x, self.javelin1_pos.z, 201026010901, 1, get_npc_pos(self.target).x, get_npc_pos(self.target).z)
    remove_missile(self.javelin1)
    self.javelin1 = nil
    abort_magic_by_id(self.npc, 20102601005, 1)
  elseif is_cast_skill_time(self.npc, self.roar[1]) and check_magic(self.npc, 20102601006) then
    cast_missile(self.npc, nil, self.javelin2_pos.x, self.javelin2_pos.z, 201026010901, 1, get_npc_pos(self.target).x, get_npc_pos(self.target).z)
    remove_missile(self.javelin2)
    self.javelin2 = nil
    abort_magic_by_id(self.npc, 20102601006, 1)
  elseif is_cast_skill_time(self.npc, self.roar[1]) and check_magic(self.npc, 20102601007) then
    cast_missile(self.npc, nil, self.javelin3_pos.x, self.javelin3_pos.z, 201026010901, 1, get_npc_pos(self.target).x, get_npc_pos(self.target).z)
    remove_missile(self.javelin3)
    self.javelin3 = nil
    abort_magic_by_id(self.npc, 20102601007, 1)
  end
end

function M:Retreat_shoot()
  if not self.target then
    return
  end
  if self.retreat_time >= 3 and not is_cast_skill_time(self.npc) and not check_magic(self.npc, 20102601014) then
    self.skill_set = 4
  end
  if self.behit_count >= 8 then
    if check_npc_distance(self.npc, self.target, 6, true) then
      self.skill_set = 3
      self.behit_count = 0
    elseif math.random(1, 100) > 40 then
      self.skill_set = 5
    else
      self.skill_set = 2
    end
  end
end

function M:on_superarmor_break(npc, camp)
  if self.target then
    lookat_npc(self.npc, self.target)
  end
  if npc == self.npc then
    self.control = 2
    self.stun_type = 2
    stop_move(self.npc)
    change_follow_target(1, self.npc, {
      8,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 2
      },
      1.3,
      0.55
    })
    cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.FX, 1)
    cast_magic(self.npc, self.npc, 20101201014, 1)
    cast_magic(self.npc, self.npc, 20101101026, 1)
    cast_magic(self.npc, self.npc, 20101101027, 1)
    abort_skill(self.npc)
    enter_stun(self.npc, true)
    self.break_time2 = get_npc_time(self.npc) + 5
    self.camera_time = get_npc_time(self.npc) + 0.2
    change_focus_follow_speed(2)
  end
  if self.retreat_time > 0 and npc == self.npc then
    if self.javelin1 then
      remove_missile(self.javelin1)
      self.javelin1 = nil
      if self.javelin2 then
        remove_missile(self.javelin2)
        self.javelin2 = nil
      end
      if self.javelin3 then
        remove_missile(self.javelin3)
        self.javelin3 = nil
      end
    end
    self.retreat_time = 0
  end
end

function M:Break()
  if 2 ~= self.control then
    return
  end
  stop_move(self.npc)
  local now_time = get_npc_time(self.npc)
  abort_magic_by_id(self.npc, 201055002, 99)
  abort_magic_by_id(self.npc, 201055003, 99)
  abort_magic_by_id(self.npc, 201055004, 99)
  if 2 == self.stun_type then
    if now_time > self.break_time2 and is_really_enter_stun(self.npc) then
      exit_stun(self.npc)
      self.stun = true
    end
    if self.target and check_npc_distance(self.npc, self.target, 2, true) and stun_is_end(self.npc) then
      self.control = 1
      lookat_npc(self.npc, self.target)
      self.skill_set = 3
      self.stun_type = 0
      self.stun = false
      hit = false
    elseif stun_is_end(self.npc) then
      self.stun_timer = get_npc_time(self.npc) + 3
      if math.random(1, 100) > 40 then
        self.skill_set = 5
      else
        self.skill_set = 2
      end
      self.control = 1
      self.stun_type = 0
      self.stun = false
      hit = false
    end
  end
  if 1 == self.stun_type then
    if now_time > self.break_time1 and is_really_enter_stun(self.npc) then
      exit_stun(self.npc)
      self.stun = true
    end
    if self.target and check_npc_distance(self.npc, self.target, 2, true) and stun_is_end(self.npc) then
      self.control = 1
      lookat_npc(self.npc, self.target)
      self.skill_set = 3
      self.stun_type = 0
      self.stun = false
      hit = false
    elseif stun_is_end(self.npc) then
      self.stun_timer = get_npc_time(self.npc) + 3
      if math.random(1, 100) > 40 then
        self.skill_set = 5
      else
        self.skill_set = 2
      end
      self.control = 1
      self.stun_type = 0
      self.stun = false
      hit = false
    end
  end
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.die_skill)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if is_cast_skill_time(self.npc, self.dive[1]) or is_cast_skill_time(self.npc, self.undergrand[1]) or is_cast_skill_time(self.npc, self.undershoot[1]) then
    return
  end
  if npc == self.target and 2 ~= self.control then
    abort_skill(self.npc)
    self.control = 0
    self.birth_time = get_npc_time(self.npc) + 2
    self.is_birth = false
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 50, 30)
  CommonMonster.remove_timer(self)
  CommonMonster.block_hit_stun(self)
  local now_time = get_npc_time(self.npc)
  self:Enter_Attack()
  self:Diving_Skill()
  self:Control_missile()
  self:Retreat_shoot()
  self:Break()
  if now_time > self.birth_time and not self.is_birth and self.target and 0 == self.control then
    self.control = 1
    lookat_npc(self.npc, self.target)
    self.skill_set = 2
    self.is_birth = true
  end
  if get_npc_time(self.npc) > self.camera_time then
    change_follow_target(0)
  end
  if check_npc_status(self.npc, 9) then
    cast_magic(self.npc, self.npc, 20102601003, 1)
  else
    abort_magic_by_id(self.npc, 20102601003, 1)
  end
end

return M
