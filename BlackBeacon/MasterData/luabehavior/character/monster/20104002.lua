local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.target = nil
  self.stun_timer = 0
  self.monster_type = 1
  self.control = 0
  self.wander = {
    3,
    8,
    1
  }
  self.wander_timer = 2
  self.allow_flash = 0
  self.flash_time = 0
  self.flash_CD = 3
  self.skill01 = {
    2010400101,
    12,
    3,
    0,
    8,
    get_skill_cfg(2010360101).CastTime,
    get_skill_cfg(2010360101).AfterTime,
    0
  }
  self.skill02 = {
    2010400102,
    20,
    3,
    0,
    8,
    get_skill_cfg(2010300102).CastTime,
    get_skill_cfg(2010300102).AfterTime,
    0
  }
  self.skill03 = {
    2010400103,
    3,
    3,
    0,
    8,
    get_skill_cfg(2010300102).CastTime,
    get_skill_cfg(2010300102).AfterTime,
    0
  }
  self.camp_skill_list = {
    self.skill01,
    self.skill02,
    self.skill03
  }
  self.isFlashing = 0
  self.getHitFlash = 0
  self.counter_reatk_skill = self.skill03
  self.die_skill = 20100905
end

function M:cast_skill(skill_instant_ID)
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 1.5 + 2
  if CommonMonster.skill_cast_condition(self, skill_instant_ID, now_time, get_npc_group_id(self.npc), self.monster_type, 2, ran_interval) then
    return false
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
  else
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if 0 ~= self.control then
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_magic(self.npc, 20102701006) then
    return
  end
  if 1 == self.isFlashing then
    return
  end
  if check_npc_distance(self.npc, self.target, 3, true) then
    self:cast_skill(self.skill03)
    return
  elseif not self:cast_skill(self.skill01) then
    return
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if npc == self.npc then
    abort_magic_by_id(self.npc, 20104001010)
    stop_move(self.npc)
    abort_skill(self.npc)
  end
end

function M:flash_to()
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if 1 == self.allow_flash and now_time >= self.flash_time then
    local angle = math.random() * 360
    local distance = 6
    local pos = get_npc_offset_position(self.target, nil, angle, distance)
    cast_magic(self.npc, self.npc, 20102701009, 1)
    enable_shadow(self.npc, false)
    set_npc_hp_visible(self.npc, false)
    cast_magic(self.npc, self.npc, 20102701005, 1)
    cast_magic(self.npc, self.npc, 20102701006, 1)
    cast_magic(self.npc, self.npc, 20102701006, 1)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 100104, 1)
    self.flash_time = now_time + self.flash_CD
    self.isFlashing = 1
    self.allow_flash = 2
    if 2 == self.allow_flash then
      CommonMonster.tiktok_timer_func(self, 0.9, function()
        if is_cast_skill_time(self.npc) then
          return
        end
        if 1 ~= self.getHitFlash then
          flash_to_pos(self.npc, pos.x, pos.z)
          cast_magic(self.npc, self.npc, 20102701008, 1)
          self.isFlashing = 0
          self.allow_flash = 0
        end
        self.getHitFlash = 0
      end)
    end
  end
  if check_npc_distance(self.npc, self.target, 3, false) then
    self.allow_flash = 1
  end
end

function M:on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 20102701009 == magic_id then
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 100104, 1)
    abort_magic_by_id(self.npc, 20102701007, 1)
    abort_magic_by_id(self.npc, 20102701006, 1)
    abort_magic_by_id(self.npc, 20102701005, 1)
  end
  if 20102701008 == magic_id then
    enable_shadow(self.npc, true)
    set_npc_hp_visible(self.npc, true)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target == self.npc and 1 == self.isFlashing then
    self.getHitFlash = 1
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 100104, 1)
    abort_magic_by_id(self.npc, 20102701007, 1)
    abort_magic_by_id(self.npc, 20102701006, 1)
    abort_magic_by_id(self.npc, 20102701005, 1)
    abort_magic_by_id(self.npc, 20102701009, 1)
    cast_magic(self.npc, self.npc, 20102701008, 1)
    self.allow_flash = 0
    self.isFlashing = 0
  end
end

function M:look_at()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 11) then
    return
  end
  if not is_cast_skill_time(self.npc) then
    lookat_npc(self.npc, self.target, false)
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
  if self.wander_randomseed >= 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if not check_activate(self.target) then
    return
  end
  if npc_time < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if 9 == self.control then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif not distance_max then
    self:move_approch_wander()
  elseif distance_min then
    self:move_normal_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner ~= self.npc then
    return
  end
  if m2_owner == self.npc then
    return
  end
  if m2_cfg.InteracteType == "Light" and m1_cfg.Id == 201040010102 then
    remove_missile(m1)
  end
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
  if check_magic(self.npc, 20104001010) then
    cast_missile(self.npc, nil, get_npc_pos(get_come_on_hero()).x, get_npc_pos(get_come_on_hero()).z, 201040010408, 0)
    cast_missile(self.npc, self.npc, nil, nil, 201040010407, 0)
    abort_magic_by_id(self.npc, 20104001010)
  end
  if check_magic(self.npc, 20104001011) then
    cast_missile(self.npc, nil, get_npc_pos(get_come_on_hero()).x, get_npc_pos(get_come_on_hero()).z, 201040010401, 0)
    cast_missile(self.npc, self.npc, nil, nil, 201040010404, 0)
    abort_magic_by_id(self.npc, 20104001011)
  end
  if check_magic(self.npc, 20104001012) then
    local pos = get_npc_offset_position(get_come_on_hero(), get_npc_pos(self.npc), math.random(60, 300), 2)
    cast_missile(self.npc, nil, pos.x, pos.z, 201040010402, 0)
    cast_missile(self.npc, self.npc, nil, nil, 201040010405, 0)
    abort_magic_by_id(self.npc, 20104001012)
  end
  if check_magic(self.npc, 20104001013) then
    pos = get_npc_offset_position(get_come_on_hero(), get_npc_pos(self.npc), math.random(60, 300), 2)
    cast_missile(self.npc, nil, pos.x, pos.z, 201040010403, 0)
    cast_missile(self.npc, self.npc, nil, nil, 201040010406, 0)
    abort_magic_by_id(self.npc, 20104001013)
  end
  self:wander_main_logic()
  self:look_at()
  self:flash_to()
  self:skill_main_logic()
end

return M
