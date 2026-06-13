local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill1_1 = {
    20104301,
    20,
    19,
    0,
    30,
    get_skill_cfg(20104301).CastTime,
    get_skill_cfg(20104301).AfterTime,
    nil,
    true,
    false
  }
  self.skill1_2 = {
    20104302,
    0,
    0,
    0,
    30,
    get_skill_cfg(20104301).CastTime,
    get_skill_cfg(20104301).AfterTime,
    nil,
    true,
    false
  }
  self.skill1_3 = {
    20104303,
    0,
    0,
    0,
    30,
    get_skill_cfg(20104301).CastTime,
    get_skill_cfg(20104301).AfterTime,
    nil,
    true,
    false
  }
  self.skill2_1 = {
    20104316,
    25,
    60,
    0,
    30,
    get_skill_cfg(20104302).CastTime,
    get_skill_cfg(20104302).AfterTime,
    nil,
    false,
    false
  }
  self.skill4_1 = {
    20104304,
    45,
    0,
    0,
    30,
    get_skill_cfg(20104304).CastTime,
    get_skill_cfg(20104304).AfterTime,
    nil,
    false,
    false
  }
  self.skill5_1 = {
    20104305,
    45,
    0,
    0,
    30,
    get_skill_cfg(20104305).CastTime,
    get_skill_cfg(20104305).AfterTime,
    nil,
    false,
    false
  }
  self.skill6_3 = {
    20104308,
    0,
    0,
    0,
    30,
    get_skill_cfg(20104308).CastTime,
    get_skill_cfg(20104308).AfterTime,
    nil,
    true,
    false
  }
  self.skill6_2 = {
    20104307,
    0,
    0,
    0,
    30,
    get_skill_cfg(20104307).CastTime,
    get_skill_cfg(20104307).AfterTime,
    self.skill6_3,
    true,
    true
  }
  self.skill6_1 = {
    20104306,
    120,
    0,
    0,
    30,
    get_skill_cfg(20104306).CastTime,
    get_skill_cfg(20104306).AfterTime,
    self.skill6_2,
    false,
    true
  }
  self.mega_stun_3 = {
    20104311,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104311).CastTime,
    get_skill_cfg(20104311).AfterTime,
    nil,
    true,
    false
  }
  self.mega_stun_2 = {
    20104310,
    0,
    0,
    0,
    15,
    get_skill_cfg(20104310).CastTime,
    get_skill_cfg(20104310).AfterTime,
    self.mega_stun_3,
    true,
    true
  }
  self.mega_stun_1 = {
    20104309,
    0,
    0,
    0,
    15,
    get_skill_cfg(20104309).CastTime,
    get_skill_cfg(20104309).AfterTime,
    self.mega_stun_2,
    true,
    true
  }
  self.l_claw_burst = {
    20104312,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104312).CastTime,
    get_skill_cfg(20104306).AfterTime,
    nil,
    true,
    false
  }
  self.r_claw_burst = {
    20104313,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104313).CastTime,
    get_skill_cfg(20104306).AfterTime,
    nil,
    true,
    false
  }
  self.be_countered = {
    20104314,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104314).CastTime,
    get_skill_cfg(20104314).AfterTime,
    nil,
    true,
    false
  }
  self.skill_born = {
    20104315,
    9999,
    0,
    0,
    0,
    get_skill_cfg(20104315).CastTime,
    get_skill_cfg(20104315).AfterTime,
    nil,
    true,
    false
  }
  self.l_eye_burst = {
    20104319,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104312).CastTime,
    get_skill_cfg(20104306).AfterTime,
    nil,
    true,
    false
  }
  self.r_eye_burst = {
    20104320,
    1,
    0,
    0,
    15,
    get_skill_cfg(20104313).CastTime,
    get_skill_cfg(20104306).AfterTime,
    nil,
    true,
    false
  }
  self.skill_by_distance = {
    20104304,
    0,
    0,
    0,
    30,
    get_skill_cfg(20104304).CastTime,
    get_skill_cfg(20104304).AfterTime,
    nil,
    false,
    false
  }
  self.mega_missile = {
    2010431513,
    2010431514,
    2010431515
  }
  self.laser_avtive_missile = {
    2010431507,
    2010431508,
    2010431509,
    2010431516,
    2010431510,
    2010431511,
    2010431512,
    2010431517
  }
  self.skill_list = {
    self.skill6_1,
    self.skill_by_distance,
    self.skill4_1,
    self.skill5_1,
    self.skill2_1,
    self.skill1_1
  }
  self.target = nil
  self.wander_timer = 5
  self.wander_timer_skill_makeup = 0
  self.control = 3
  self.stun_state = 0
  self.born_state = true
  self.claw_state = 1
  self.eye_state = 1
  self.mega_flash = false
  self.mega_flash_timer = 0
  self.laser_l_active = false
  self.laser_r_active = false
  self.eye_burst = false
  self.claw_burst = false
  self.skill_count = 0
  self.ai_part = 1
end

function M:cast_skill(skill)
  local npc_time = get_npc_time(self.npc)
  if 4 == self.control then
    if 1 == self.stun_state then
      skill = self.mega_stun_1
    elseif 2 == self.stun_state then
      skill = self.l_claw_burst
    elseif 3 == self.stun_state then
      skill = self.r_claw_burst
    elseif 4 == self.stun_state then
      skill = self.l_eye_burst
    elseif 5 == self.stun_state then
      skill = self.r_eye_burst
    elseif 6 == self.stun_state then
      skill = self.be_countered
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, skill[1])
    self:wander_time(skill)
    self.control = 3
  end
  if 2 == self.control and npc_time > self.wander_timer then
    cast_skill(self.npc, self.target, self.skill_next[1])
    self.skill_next[3] = npc_time + self.skill_next[2]
    self:wander_time(self.skill_next)
    self.skill_next = self.skill_next[8]
    if self.skill_next then
      self.control = 2
    else
      self.control = 3
      set_skill_end_to_idle(self.npc, true)
    end
    return true
  end
  if not (1 ~= self.control and check_npc_status(self.npc, 0)) or false == skill[9] then
    return false
  end
  if 3 == self.control and npc_time >= self.wander_timer then
    self.control = 0
  end
  if 0 == self.control then
    if npc_time >= skill[3] and npc_time > self.wander_timer then
      cast_skill(self.npc, self.npc, skill[1])
      skill[3] = npc_time + skill[2]
      self:wander_time(skill)
    else
      return false
    end
    self.skill_next = skill[8]
    if self.skill_next and self.skill_next[9] then
      self.control = 2
      if self.skill_next[10] then
        set_skill_end_to_idle(self.npc, false)
      end
    else
      self.control = 3
    end
    return true
  end
end

function M:skill_main_logic(skill)
  if not self.target then
    return
  end
  if self.skill_count < 3 then
    for i, skill in ipairs(self.skill_list) do
      if self:cast_skill(skill) then
        self.skill_count = self.skill_count + 1
        break
      end
    end
  end
  local angel = get_target_angel(self.npc, self.target, true)
  if angel <= 0 then
    skill = self.skill1_2
  else
    skill = self.skill1_3
  end
  if self:cast_skill(skill) then
    self.skill_count = 0
  end
end

function M:wander_time(skill)
  self.wander_timer_skill_makeup = skill[6] + skill[7]
  self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
end

function M:born()
  if self.born_state == true then
    local x, z = get_scene_map_pos_postion("center")
    if x and z then
      lookat_position(self.npc, x, z, true)
    else
      lookat_position(self.npc, 5, 0, true)
    end
    self.born_state = false
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if self.laser_l_active and (m1_cfg.Id == 2010430102 and m2_cfg.Id == 2010430501 or m2_cfg.Id == 2010431701) then
    self.laser_l_active = false
    for i = 1, 4 do
      cast_missile(self.npc, self.npc, nil, nil, self.laser_avtive_missile[i], 0)
    end
  end
  if self.laser_r_active and (m1_cfg.Id == 2010430111 and m2_cfg.Id == 2010430502 or m2_cfg.Id == 2010431801) then
    self.laser_r_active = false
    for i = 5, 8 do
      cast_missile(self.npc, self.npc, nil, nil, self.laser_avtive_missile[i], 0)
    end
  end
end

function M:on_part_damage(npc, target, part_id, cur_hp, is_crit, damage_val)
end

function M:state_change()
  local now_time = get_time()
  local skill1_1_next
  local rand = math.random()
  if rand < 0.2 then
    rand = true
  end
  if now_time > 15 and now_time <= 60 then
    skill1_1_next = self.skill2_1
  elseif now_time > 60 then
    if rand then
      skill1_1_next = self.skill2_1
    else
      skill1_1_next = self.skill5_1
    end
  elseif now_time > 90 then
    self.skill4_1[9] = true
  end
  if skill1_1_next and false == skill1_1_next[9] then
    skill1_1_next[9] = true
  end
  if self.skill1_1[8] ~= skill1_1_next then
    self.skill1_1[8] = skill1_1_next
  end
  if 2 == self.claw_state then
    self.skill1_1[9] = false
    self.skill1_2[9] = false
  elseif 3 == self.claw_state then
    self.skill1_1[9] = false
    self.skill1_3[9] = false
  elseif 2 == self.eye_state then
    self.skill5_1[1] = 20104318
  elseif 3 == self.eye_state then
    self.skill5_1[1] = 20104317
  end
  local now_hp = get_npc_attr(self.npc, 1)
  local hp_max = get_npc_attr(self.npc, 4)
  local rand = math.random()
  if rand < 0.5 then
    rand = true
  end
  if now_hp <= hp_max * 0.8 and now_hp > hp_max * 0.6 and 1 == self.ai_part then
    if rand then
      self:stun_check(true, 2)
    elseif not rand then
      self:stun_check(true, 3)
    end
    self.ai_part = 2
  elseif now_hp <= hp_max * 0.6 and now_hp > hp_max * 0.4 and 2 == self.ai_part then
    if rand then
      self:stun_check(false, 4)
    elseif not rand then
      self:stun_check(false, 5)
    end
    self.ai_part = 3
  elseif now_hp <= hp_max * 0.4 and 3 == self.ai_part then
    self.skill6_1[9] = true
    self.ai_part = 4
  end
  if self.target and not check_npc_distance(self.npc, self.target, 10, false) then
    self.skill_by_distance[9] = true
  else
    self.skill_by_distance[9] = false
  end
end

function M:stun_check(part, state)
  if part then
    if self.stun_state ~= state then
      self.claw_state = state
      self.stun_state = state
      self.control = 4
    end
  elseif self.stun_state ~= state then
    self.eye_state = state
    self.stun_state = state
    self.control = 4
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.skill6_2[1] then
    self.mega_flash = true
    self.mega_flash_timer = get_npc_time(self.npc)
  end
  if skill_id == self.skill6_3[1] then
    self.mega_flash = false
  end
  if skill_id == self.skill5_1[1] then
    if 1 == self.eye_state then
      self.laser_l_active = true
      self.laser_r_active = true
    elseif 2 == self.eye_state then
      self.laser_r_active = true
    elseif 3 == self.eye_state then
      self.laser_l_active = true
    end
  end
  if skill_id == self.skill_by_distance[1] then
    self.skill_by_distance[9] = false
  end
end

function M:on_skill_end(npc, skill_id)
  if skill_id == self.skill5_1[1] then
    self.laser_l_active = false
    self.laser_r_active = false
  end
end

function M:mega_flash_cast(missile_list)
  if self.mega_flash then
    local flash_now_time = get_npc_time(self.npc)
    local target_pos = get_npc_pos(self.target)
    if flash_now_time > self.mega_flash_timer then
      local scale = 4
      local target_pos_x = {
        target_pos.x
      }
      for i = 2, 8 do
        target_pos_x[i] = target_pos.x + math.random() + math.random(-scale, scale)
      end
      local target_pos_z = {
        target_pos.z
      }
      for i = 2, 8 do
        target_pos_z[i] = target_pos.z + math.random() + math.random(-scale, scale)
      end
      for _, missile_id in ipairs(missile_list) do
        for i = 1, 8 do
          cast_missile(self.npc, nil, target_pos_x[i], target_pos_z[i], missile_id, 0)
        end
      end
      self.mega_flash_timer = flash_now_time + 3
    end
  end
end

function M:on_frame()
  self:born()
  self:skill_main_logic()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:state_change()
  self:mega_flash_cast(self.mega_missile)
end

return M
