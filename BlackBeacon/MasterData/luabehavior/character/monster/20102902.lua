local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    2010290101,
    7,
    1,
    0,
    3.5,
    get_skill_cfg(2010290101).CastTime,
    get_skill_cfg(2010290101).AfterTime,
    0
  }
  self.skill02 = {
    2010290102,
    7,
    1,
    0,
    3.5,
    get_skill_cfg(2010290102).CastTime,
    get_skill_cfg(2010290102).AfterTime,
    0
  }
  self.skill03 = {
    2010290103,
    10,
    1,
    3.5,
    7,
    get_skill_cfg(2010290103).CastTime,
    get_skill_cfg(2010290103).AfterTime,
    0
  }
  self.skill04 = {
    2010290104,
    10,
    1,
    0,
    7,
    get_skill_cfg(2010290104).CastTime,
    get_skill_cfg(2010290104).AfterTime,
    0
  }
  self.skill05 = {
    2010290105,
    10,
    1,
    0,
    7,
    get_skill_cfg(2010290105).CastTime,
    get_skill_cfg(2010290105).AfterTime,
    0
  }
  self.skill06 = {
    2010290106,
    20,
    5,
    0,
    7,
    get_skill_cfg(2010290106).CastTime,
    get_skill_cfg(2010290106).AfterTime,
    0
  }
  self.camp_skill_list = {
    self.skill01,
    self.skill02,
    self.skill03
  }
  self.counter_reatk_skill = self.skill01
  self.monster_type = 1
  self.wander = {
    1.5,
    3.5,
    1
  }
  self.wander_timer = 2
  self.control = 0
  self.target = nil
  self.stun_timer = 0
  self.move_timer = 0
  self.countinue = 0
  self.hit_random = 0
  self.jink_random = 0
  self.skill_set_time = 0
  self.strike_back = 0
  self.isHavingShield = false
  self.shieldCD = 30
  self.ShieldTimer = 0
  self.shieldType = 0
  self.shieldTypeforBreak = 0
  self.natralDisappearTimer = 0
end

function M:skill_main_logic()
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 1.5 + 2
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if CommonMonster.skill_cast_condition(self, nil, now_time, get_npc_group_id(self.npc), self.monster_type, 2, ran_interval) then
    return false
  end
  if not check_npc_distance(self.npc, self.target, self.skill01[4], false) and check_npc_distance(self.npc, self.target, self.skill01[5], false) and now_time >= self.skill01[3] then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.skill03[1])
    self.control = 99
    self.skill_set_time = now_time + 2
    self.skill01[3] = now_time + self.skill01[2]
  elseif now_time < self.skill01[3] and now_time >= self.skill06[3] then
    cast_skill(self.npc, self.target, self.skill06[1])
    self.control = 99
    self.skill_set_time = now_time + 2
    self.skill06[3] = now_time + self.skill06[2]
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  local now_time = get_npc_time(self.npc)
  if npc == self.npc and 2010290101 == skill_id then
    self.hit_random = math.random() * 10
    if self.hit_random >= 0 then
      CommonMonster.tiktok_timer_func(self, 0.7, function()
        abort_skill(self.npc)
        cast_skill(self.npc, self.target, self.skill02[1])
        self.skill02[3] = now_time + self.skill02[2]
      end)
    end
  end
  if self.counter_atk_val < 100 then
    return
  end
  if self.counter_atk_val >= 100 then
    self.jink_random = math.random(1, 2)
    if 1 == self.jink_random and now_time >= self.skill04[3] then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.skill04[1])
      self.skill04[3] = now_time + self.skill04[2]
      self.counter_atk_val = 80
    end
    if 2 == self.jink_random and now_time >= self.skill05[3] then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.skill05[1])
      self.skill05[3] = now_time + self.skill05[2]
      self.counter_atk_val = 80
    end
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  local now_time = get_npc_time(self.npc)
  if npc ~= self.npc then
    return
  end
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
  end
  if skill_id == self.skill04[1] or skill_id == self.skill05[1] and now_time >= self.skill03[3] then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.skill03[1])
    self.skill03[3] = now_time + self.skill03[2]
    self.skill_set_time = now_time + 2
    self.control = 99
  else
    return
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  local now_time = get_npc_time(self.npc)
  if npc ~= self.npc then
    return
  end
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
  end
  if npc == self.npc and self.target and skill_id == self.skill06[1] then
    cast_magic(self.npc, self.npc, 201180048, 0)
    self.shieldType = 5
    self.shieldTypeforBreak = 5
    cast_magic(self.npc, self.npc, 201180052, 0)
    cast_magic(self.npc, self.npc, 201180053, 0)
    cast_magic(self.npc, self.npc, 201180050, 0)
    self.isHavingShield = true
    self.natralDisappearTimer = now_time + 10
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc == get_come_on_hero() and target == self.npc then
    local now_time = get_npc_time(self.npc)
    if self.isHavingShield == false then
    else
      print("有盾消耗盾")
      if 2 == damage_type then
        if 2 == self.shieldType then
          cast_magic(target, target, 201180052, 0)
        elseif 3 == self.shieldType then
          cast_magic(npc, npc, 201180051, 0)
        end
      elseif 3 == damage_type then
        if 3 == self.shieldType then
          cast_magic(target, target, 201180052, 0)
        elseif 4 == self.shieldType then
          cast_magic(npc, npc, 201180051, 0)
        end
      elseif 4 == damage_type then
        if 4 == self.shieldType then
          cast_magic(target, target, 201180052, 0)
        elseif 2 == self.shieldType then
          cast_magic(npc, npc, 201180051, 0)
        end
      elseif 5 == damage_type then
        if 5 == self.shieldType then
          cast_magic(target, target, 201180052, 0)
        elseif 6 == self.shieldType then
          cast_magic(npc, npc, 201180051, 0)
        end
      elseif 6 == damage_type then
        if 6 == self.shieldType then
          cast_magic(target, target, 201180052, 0)
        else
          if 5 == self.shieldType then
            cast_magic(npc, npc, 201180051, 0)
          else
          end
        end
      end
      cast_magic(target, target, 201180050, 0)
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if npc == get_come_on_hero() and target == self.npc then
    local now_time = get_npc_time(self.npc)
    if get_npc_shield(target) <= 0 and now_time <= self.natralDisappearTimer then
      if 5 == self.shieldTypeforBreak then
        cast_magic(target, target, 201180049, 0)
      elseif 2 == self.shieldTypeforBreak then
        cast_magic(target, target, 201180045, 0)
      elseif 3 == self.shieldTypeforBreak then
        cast_magic(target, target, 201180041, 0)
      elseif 4 == self.shieldTypeforBreak then
        cast_magic(target, target, 201180047, 0)
      elseif 6 == self.shieldTypeforBreak then
        cast_magic(target, target, 201180043, 0)
      end
      self.shieldTypeforBreak = 0
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
  Base.on_magic_end(self, npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 201180040 == magic_id or 201180042 == magic_id or 201180044 == magic_id or 201180046 == magic_id or 201180048 == magic_id then
    self.isHavingShield = false
    local now_time = get_npc_time(self.npc)
    self.ShieldTimer = now_time + self.shieldCD
    self.shieldType = 0
    abort_magic_by_id(self.npc, 201180053, 1)
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

function M:move_leave_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
  self.wander_timer = get_npc_time(self.npc) + 1
end

function M:move_approch_wander()
  if 1 == self.run then
    return
  end
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:run_approch_wander()
  switch_move_type(self.npc, 0)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
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
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  local distance_maxx = check_npc_distance(self.npc, self.target, self.wander[2] + 3, true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif distance_min then
    self:move_leave_wander()
  elseif not distance_max and distance_maxx then
    self:move_approch_wander()
  elseif not distance_maxx then
    self:run_approch_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:attack_done_bonus()
  if is_cast_skill_time(self.npc) then
    return
  end
  if 99 == self.control then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.skill_set_time then
      self.control = 0
    end
  end
end

function M:on_frame()
  self:wander_main_logic()
  self:skill_main_logic()
  self:attack_done_bonus()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
