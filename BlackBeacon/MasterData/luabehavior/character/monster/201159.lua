local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    2010340101,
    3,
    3,
    0,
    120,
    get_skill_cfg(2010340101).CastTime,
    get_skill_cfg(2010340101).AfterTime,
    nil
  }
  self.skill02 = {
    2010340102,
    6,
    8,
    0,
    6,
    get_skill_cfg(2010340102).CastTime,
    get_skill_cfg(2010340102).AfterTime,
    nil
  }
  self.skill03 = {
    2010340103,
    18,
    21,
    0,
    16,
    get_skill_cfg(2010340103).CastTime,
    get_skill_cfg(2010340103).AfterTime,
    nil
  }
  self.skill05 = {
    2010340107,
    8,
    9,
    1,
    15,
    get_skill_cfg(2010340107).CastTime,
    get_skill_cfg(2010340107).AfterTime,
    nil
  }
  self.skill06 = {
    2010340108,
    10,
    5,
    0,
    10,
    get_skill_cfg(2010340108).CastTime,
    get_skill_cfg(2010340108).AfterTime,
    nil
  }
  self.skill07 = {
    2010340109,
    8,
    5,
    0,
    16,
    get_skill_cfg(2010340109).CastTime,
    get_skill_cfg(2010340109).AfterTime,
    nil
  }
  self.skill08 = {
    2010340110,
    30,
    31,
    0,
    16,
    get_skill_cfg(2010340110).CastTime,
    get_skill_cfg(2010340110).AfterTime,
    nil
  }
  self.skill09 = {
    2010340111,
    2,
    2,
    13,
    120,
    get_skill_cfg(2010340111).CastTime,
    get_skill_cfg(2010340111).AfterTime,
    nil
  }
  self.skill10 = {
    2010340112,
    25,
    31,
    0,
    18,
    get_skill_cfg(2010340112).CastTime,
    get_skill_cfg(2010340112).AfterTime,
    nil
  }
  self.skill14 = {
    2010340116,
    99,
    3,
    0,
    12,
    get_skill_cfg(2010340116).CastTime,
    get_skill_cfg(2010340116).AfterTime,
    nil
  }
  self.skill15 = {
    2010340117,
    99,
    3,
    0,
    12,
    get_skill_cfg(2010340117).CastTime,
    get_skill_cfg(2010340117).AfterTime,
    nil
  }
  self.skill16 = {
    2010340118,
    2,
    2,
    0,
    120,
    get_skill_cfg(2010340118).CastTime,
    get_skill_cfg(2010340118).AfterTime,
    nil
  }
  self.skill17 = {
    2010340119,
    2,
    2,
    0,
    120,
    get_skill_cfg(2010340119).CastTime,
    get_skill_cfg(2010340119).AfterTime,
    nil
  }
  self.skill13 = {
    2010340115,
    5,
    5,
    0,
    99,
    get_skill_cfg(2010340115).CastTime,
    get_skill_cfg(2010340115).AfterTime,
    nil
  }
  self.skill12 = {
    2010340114,
    5,
    5,
    0,
    99,
    get_skill_cfg(2010340114).CastTime,
    get_skill_cfg(2010340114).AfterTime,
    self.skill13
  }
  self.skill11 = {
    2010340113,
    30,
    15,
    0,
    99,
    get_skill_cfg(2010340113).CastTime,
    get_skill_cfg(2010340113).AfterTime,
    self.skill12
  }
  self.death_skill1 = {
    2010340128,
    0,
    0,
    0,
    99,
    get_skill_cfg(2010340128).CastTime,
    get_skill_cfg(2010340128).AfterTime,
    nil
  }
  self.skill19 = 2010340115
  self.skill18 = 2010340114
  self.skill20 = 2010340113
  self.mega_stone = false
  self.mega_stone_timer = 0
  self.die = 2010340128
  self.mega_missile_1 = {
    201034013101,
    201034013102,
    201034013103
  }
  self.die_skill = self.death_skill1[1]
  self.dizziness1 = 2010340128
  self.dizziness2 = 2010340129
  self.dizziness3 = 2010340130
  self.s07 = 0
  self.power555 = 0
  self.AOE = 2010340126
  self.stele = 0
  self.stele1 = 0
  self.skill03_set = 0
  self.get_power = 0
  self.get_power1 = 2010340104
  self.get_power2 = 2010340105
  self.get_power3 = 2010340106
  self.get_power_time = 0
  self.allow_get_power = 0
  self.control = 0
  self.state = 0
  self.wander = {
    1,
    3,
    2
  }
  self.wander_timer = 1
  self.level = nil
  self.circle = 0
  self.hp_time = 0
  self.add_monster = 0
  self.abort_level = 0
  self.walk = false
  self.born_skill = 2010340121
  self.skill_control = 0
  self.allow_flash = 0
  self.flash_time = 0
  self.skill08_set = 0
  self.stun_timer = 0
  self.magic_missile1 = false
  self.magic_missile2 = false
  self.magic_missile3 = false
  self.TP2 = false
  self.TP1 = false
  self.skill08_set_time = 0
  self.combo_skill_cfg = nil
  CommonMonster.set_value("三个全部死亡", 1, 0)
end

function M:on_start()
  self.born_pos = get_npc_pos(self.npc)
  cast_magic(self.npc, self.npc, 20103401001, 1)
  set_lock_velocity(self.npc, 0.1)
  change_follow_target(1, self.npc, {
    16,
    26,
    {
      x = 0,
      y = -10,
      z = -1
    },
    1,
    0.9
  })
  self.level = self.npc:get_level()
end

function M:skill_cast(skill_instant)
  local now_time = get_npc_time(self.npc)
  if not self.target or not self.npc then
    return false
  end
  if now_time <= skill_instant[3] then
    return false
  end
  if check_npc_distance(self.npc, self.target, skill_instant[5], false) and not check_npc_distance(self.npc, self.target, skill_instant[4], false) then
  else
    return false
  end
  abort_skill(self.npc)
  skill_instant[3] = now_time + skill_instant[2]
  cast_skill(self.npc, self.target, skill_instant[1])
  if skill_instant[8] then
    set_skill_end_to_idle(self.npc, false)
    self.combo_skill_cfg = skill_instant[8]
  elseif self.combo_skill_cfg ~= nil then
    set_skill_end_to_idle(self.npc, true)
    self.combo_skill_cfg = nil
  end
  self.control = 1
  return true
end

function M:skill_cast(skill_instant)
  local now_time = get_npc_time(self.npc)
  if check_npc_distance(self.npc, self.target, skill_instant[5], false) and not check_npc_distance(self.npc, self.target, skill_instant[4], false) then
  else
    return true
  end
  if CommonMonster.skill_cast_condition(self, skill_instant, now_time) then
    return false
  end
  if skill_instant == self.skill01 then
    cast_skill(self.npc, self.target, self.skill01[1])
    self.skill01[3] = now_time + self.skill01[2]
    return true
  end
  if skill_instant == self.skill02 then
    cast_skill(self.npc, self.target, skill_instant[1])
    self.skill02[3] = now_time + self.skill02[2]
    return true
  end
  if skill_instant == self.skill03 then
    self.skill03_set = 1
    self.stele = 1
    cast_skill(self.npc, self.target, self.skill03[1])
    self.skill10[3] = now_time + self.skill10[2]
    self.skill03[3] = now_time + self.skill03[2]
    return true
  end
  if skill_instant == self.skill05 then
    cast_skill(self.npc, self.target, skill_instant[1])
    self.skill05[3] = now_time + self.skill05[2]
    return true
  end
  if skill_instant == self.skill06 and 0 == self.skill06_set then
    cast_skill(self.npc, self.npc, self.skill06[1])
    self.skill06_set = 1
    self.skill06[3] = now_time + self.skill06[2]
    return true
  end
  if skill_instant == self.skill07 then
    cast_skill(self.npc, self.target, skill_instant[1])
    self.skill07[3] = now_time + self.skill07[2]
    self.abort_level = 0
    return true
  end
  if skill_instant == self.skill09 then
    cast_skill(self.npc, self.target, self.skill09[1])
    self.skill09[3] = now_time + self.skill09[2]
    return true
  end
  if skill_instant == self.skill08 then
    self.skill08_set = 1
    self.stele1 = 1
    self.stone6 = 1
    cast_skill(self.npc, self.target, self.skill08[1])
    self.skill08[3] = now_time + self.skill08[2]
    return true
  end
  if skill_instant == self.skill10 then
    self.stele = 0
    self.stele1 = 0
    cast_skill(self.npc, self.target, self.skill10[1])
    self.skill10[3] = now_time + self.skill10[2]
    return true
  end
  if skill_instant == self.skill14 then
    abort_skill(self.npc)
    self.skill14_set = 1
    cast_skill(self.npc, self.target, self.skill14[1])
    self.skill14[3] = now_time + self.skill14[2]
    return true
  end
  if skill_instant == self.skill15 then
    cast_skill(self.npc, self.target, self.skill15[1])
    self.skill15[3] = now_time + self.skill15[2]
    return true
  end
  if skill_instant == self.skill16 then
    cast_skill(self.npc, self.target, self.skill16[1])
    self.skill16[3] = now_time + self.skill16[2]
    return true
  end
  if skill_instant[8] then
    set_skill_end_to_idle(self.npc, false)
    self.combo_skill_cfg = skill_instant[8]
  elseif self.combo_skill_cfg ~= nil then
    set_skill_end_to_idle(self.npc, true)
    self.combo_skill_cfg = nil
  end
  if self.mega_stone == false and check_magic(self.npc, 20103401044) then
    self.mega_stone = true
    self.mega_stone_timer = get_time()
  elseif self.mega_stone == true and not check_magic(self.npc, 20103401044) then
    self.mega_stone = false
  end
end

function M:mega_stone_cast1(missile_list, posx, posz)
  if self.mega_stone then
    local stone_now_time = get_time() + 6
    local now_pos = get_npc_pos(self.npc)
    if stone_now_time > self.mega_stone_timer then
      local scale = 3
      now_pos1.x = now_pos.x + math.random() + math.random(-scale, scale)
      now_pos1.z = now_pos.z + math.random() + math.random(-scale, scale)
      for _, missile_id in ipairs(missile_list) do
        cast_missile(self.npc, nil, now_pos1.x, now_pos1.z, missile_id, 0)
      end
      self.mega_stone_timer = stone_now_time + 0.5
    end
  end
end

function M:state0_skill_cast()
  local now_time = get_npc_time(self.npc)
  local now_pos = get_npc_pos(self.npc)
  if 0 ~= self.control then
    return
  end
  if 0 ~= self.state then
    return
  end
  if 1 ~= self.skill_control then
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if 2 == self.s07 then
    self:skill_cast(self.skill07, 0)
    self.s07 = 0
  end
  if now_time >= self.skill03[3] then
    self:skill_cast(self.skill03, 0)
  end
  if now_time >= self.skill05[3] then
    self:skill_cast(self.skill05, 0)
  end
  if now_time >= self.skill07[3] then
    self:skill_cast(self.skill07, 0)
    self.s07 = 0
  end
end

function M:state1_skill_cast()
  local now_time = get_npc_time(self.npc)
  local now_pos = get_npc_pos(self.npc)
  if 0 ~= self.control then
    return
  end
  if 3 ~= self.state then
    return
  end
  if self.walk == true then
    return
  end
  if not self.target then
    return
  end
  if 1 ~= self.skill_control then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_magic(self.npc, 20103401044) and 1 == self.stone6 then
    self:mega_stone_cast1(self.mega_missile_1)
  end
  if 2 == self.s07 then
    self:skill_cast(self.skill07, 0)
    self.s07 = 0
  end
  if 1 == self.laser1 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill18)
  end
  if now_time >= self.skill08[3] then
    self:skill_cast(self.skill08, 0)
  end
  if now_time >= self.skill07[3] then
    self:skill_cast(self.skill07, 0)
  end
  if now_time >= self.skill05[3] then
    self:skill_cast(self.skill05, 0)
  end
  if now_time >= self.skill03[3] then
    self:skill_cast(self.skill03, 0)
  end
end

function M:skill03_cast()
  local now_time = get_npc_time(self.npc)
  if not is_cast_skill_time(self.npc, self.skill03[1]) then
    return
  end
  if is_cast_skill_time(self.npc, self.skill03[1]) and 1 == self.skill03_set then
    self.skill03_set = 2
    self.skill03_set_time = now_time + 3
  end
  if 2 == self.skill03_set and now_time >= self.skill03_set_time then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.npc, nil, 25, 10)
    local pos2 = get_npc_offset_position(self.npc, nil, 115, 10)
    local pos3 = get_npc_offset_position(self.npc, nil, 205, 10)
    local pos4 = get_npc_offset_position(self.npc, nil, 295, 10)
    add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
    self.skill03_set_time = now_time + 0.3
    self.skill03_set = 3
  end
  if 3 == self.skill03_set and now_time >= self.skill03_set_time then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.npc, nil, 1, 6)
    local pos2 = get_npc_offset_position(self.npc, nil, 90, 6)
    local pos3 = get_npc_offset_position(self.npc, nil, 180, 6)
    local pos4 = get_npc_offset_position(self.npc, nil, 270, 6)
    add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
    self.skill03_set_time = now_time + 0.3
    self.skill03_set = 0
  end
end

function M:skill14_cast()
  if 1 == self.skill14_set and check_magic(self.npc, 20103401047) then
    self.allow_flash = 1
    self.state = 1
    self.get_power = 1
    self.skill14_set = 0
  end
end

function M:skill08_cast()
  local now_time = get_npc_time(self.npc)
  local now_pos = get_npc_pos(self.npc)
  if is_cast_skill_time(self.npc, self.skill08[1]) and 1 == self.skill08_set then
    self.skill08_set = 3
    self.skill08_set_time = now_time + 1.5
  end
  if 3 == self.skill08_set and now_time >= self.skill08_set_time then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.npc, nil, 45, 5)
    local pos2 = get_npc_offset_position(self.npc, nil, 135, 5)
    local pos3 = get_npc_offset_position(self.npc, nil, 225, 5)
    local pos4 = get_npc_offset_position(self.npc, nil, 315, 5)
    add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
    self.skill08_set_time = now_time + 2
    self.skill08_set = 4
  end
  if 4 == self.skill08_set and now_time >= self.skill08_set_time then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.npc, nil, 1, 10)
    local pos2 = get_npc_offset_position(self.npc, nil, 90, 10)
    local pos3 = get_npc_offset_position(self.npc, nil, 180, 10)
    local pos4 = get_npc_offset_position(self.npc, nil, 270, 10)
    add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
    self.skill08_set_time = now_time + 2.8
    self.skill08_set = 5
  end
  if 5 == self.skill08_set and now_time >= self.skill08_set_time then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.npc, nil, 45, 15)
    local pos2 = get_npc_offset_position(self.npc, nil, 135, 15)
    local pos3 = get_npc_offset_position(self.npc, nil, 225, 15)
    local pos4 = get_npc_offset_position(self.npc, nil, 315, 15)
    add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
    add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
    self.skill08_set_time = now_time + 3.5
    self.skill08_set = 0
    self.abort_level = 0
  end
end

function M:on_skill_end(npc, skill_id)
  local now_time = get_npc_time(self.npc)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.skill18 then
    clear_focal()
    self.laser2 = 1
    self.laser1 = 0
    abort_magic_by_id(self.npc, 20103401025, 1)
    abort_magic_by_id(self.npc, 20103401030, 1)
    abort_magic_by_id(self.npc, 20103401031, 1)
    change_follow_target(1, self.npc, {
      16,
      26,
      {
        x = 0,
        y = -10,
        z = -1
      },
      1,
      0.9
    })
  end
  if skill_id == self.skill18 and 1 == self.laser2 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.skill19)
    abort_magic_by_id(self.npc, 20103401025, 1)
    abort_magic_by_id(self.npc, 20103401030, 1)
    abort_magic_by_id(self.npc, 20103401031, 1)
    change_follow_target(1, self.npc, {
      16,
      26,
      {
        x = 0,
        y = -10,
        z = -1
      },
      1,
      0.9
    })
  end
  if skill_id == self.skill09[1] then
    abort_magic_by_id(self.npc, 20103401027, 1)
    set_lock_velocity(self.npc, 0.6)
  end
  if skill_id == self.skill16[1] then
    set_lock_velocity(self.npc, 0.6)
  end
  if skill_id == self.skill13 then
    abort_magic_by_id(self.npc, 20103401030, 1)
    abort_magic_by_id(self.npc, 20103401031, 1)
  end
  if skill_id == self.skill12 then
    abort_magic_by_id(self.npc, 20103401030, 1)
    abort_magic_by_id(self.npc, 20103401031, 1)
  end
  if skill_id == self.get_power3 then
    self.allow_get_power = 10
    cast_magic(self.npc, self.npc, 20103401026, 1)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    set_lock_velocity(self.npc, 0.6)
  end
  if skill_id == self.skill10[1] then
    remove_missile_by_id(201034012002, nil, true)
    remove_missile_by_id(201034012003, nil, true)
    remove_missile_by_id(201034012004, nil, true)
  end
  if skill_id == self.skill17[1] then
    self.allow_get_power = 11
  end
end

function M:stage(npc)
  local now_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  if now_hp / max_hp <= 0.5 and 0 == self.power555 and 0 == self.state then
    self:skill_cast(self.skill14, 0)
    self.power555 = 1
  end
end

function M:now_give_me_the_power1()
  local now_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  local now_pos = get_npc_pos(self.npc)
  local now_time = get_npc_time(self.npc)
  local pos_zero = {
    x = 189.0939,
    y = -954.4951,
    z = 218
  }
  local look_pos = {
    x = 189.0939,
    y = -954.4951,
    z = 204.44
  }
  if 1 == self.allow_flash and now_time >= self.flash_time and 1 == self.power555 then
    cast_magic(self.npc, self.npc, 20103401051, 1)
    enable_shadow(self.npc, false)
    set_npc_hp_visible(self.npc, false)
    cast_magic(self.npc, self.npc, 20102701007, 1)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 100104, 1)
    self.flash_time = now_time + 99
    self.allow_flash = 2
    if 2 == self.allow_flash then
      CommonMonster.tiktok_timer_func(self, 0.6, function()
        lookat_position(self.npc, look_pos.x, look_pos.z, false)
        set_npc_pos(self.npc, "T1")
        set_lock_velocity(self.npc, 15)
        if get_cur_room_id() == 1241 then
          play_timeline("timeline_boss2_camera", 1, 1.2, nil, false, true)
        else
        end
        self.allow_flash = 0
        cast_magic(self.npc, self.npc, 20103401050, 1)
      end)
      self.power555 = 2
      self.allow_get_power = 6
      set_npc_hp_visible(self.npc, true)
    end
  end
  if 2 == self.power555 and 6 == self.allow_get_power and check_magic(self.npc, 20103401049) then
    start_stroy(202012)
    abort_magic_by_id(self.npc, Const.LOCK_MASK)
    abort_magic_by_id(self.npc, 20102701007)
    abort_skill(self.npc)
    cast_magic(self.npc, self.npc, 20103401007, 0)
    cast_skill(self.npc, self.target, self.skill20)
    change_follow_target(1, self.target, {
      16,
      26,
      {
        x = 0,
        y = -10,
        z = -1
      },
      1,
      0.9
    })
    self.power555 = 3
    self.state = 3
    self.allow_get_power = 9
    self.laser1 = 1
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201034012002 then
    self.circle = self.circle + 1
    self.hp_time = 1
  end
  if missile_cfg.Id == 201034012003 then
    self.circle = self.circle + 1
    self.hp_time = 1
  end
  if missile_cfg.Id == 201034012004 then
    self.hp_time = 1
    self.circle = self.circle + 1
  end
end

function M:missile_circle()
  local Q1_pos = {
    x = 193.11,
    y = -954.4951,
    z = 209.0774
  }
  local Q2_pos = {
    x = 182.65,
    y = -954.4951,
    z = 207.5
  }
  local Q3_pos = {
    x = 188.8689,
    y = -954.4951,
    z = 199.7994
  }
  if not self.magic_missile1 and 1 == CommonMonster.get_value("三个全部死亡", 1) then
    cast_missile(self.npc, nil, Q1_pos.x, Q1_pos.z, 201034012002, 0)
    self.magic_missile1 = true
  elseif not self.magic_missile2 and 2 == CommonMonster.get_value("三个全部死亡", 1) then
    cast_missile(self.npc, nil, Q2_pos.x, Q2_pos.z, 201034012003, 0)
    self.magic_missile2 = true
  elseif not self.magic_missile3 and 3 == CommonMonster.get_value("三个全部死亡", 1) then
    cast_missile(self.npc, nil, Q3_pos.x, Q3_pos.z, 201034012004, 0)
    self.magic_missile3 = true
  end
end

function M:change_state()
  local now_time = get_npc_time(self.npc)
  if 10 ~= self.allow_get_power then
    return
  end
  if 0 == self.circle and self.hp_time >= 1 then
    cast_magic(self.npc, self.npc, 20103401005, 0)
    self.hp_time = 0
  end
  if 1 == self.circle and self.hp_time >= 1 then
    cast_magic(self.npc, self.npc, 20103401005, 0)
    self.hp_time = 0
  end
  if 2 == self.circle and self.hp_time >= 1 then
    cast_magic(self.npc, self.npc, 20103401006, 0)
    self.hp_time = 0
  end
  if 3 == self.circle and self.hp_time >= 1 then
    cast_magic(self.npc, self.npc, 20103401007, 0)
    self.hp_time = 0
  end
end

function M:change_state_skill()
  local now_time = get_npc_time(self.npc)
  local now_pos = get_npc_pos(self.npc)
  local Q4_pos = {
    x = 189.162,
    y = -954.4951,
    z = 205.1954
  }
  if now_time >= self.skill17[3] and 10 == self.allow_get_power then
    lookat_npc(self.npc, self.target, true)
    cast_skill(self.npc, self.target, self.skill17[1], Q4_pos.x, Q4_pos.z)
    self.skill17[3] = self.skill17[3] + self.skill17[2]
  end
  if self.circle >= 1 and now_time >= self.skill10[3] and 11 == self.allow_get_power then
    cast_skill(self.npc, self.target, self.skill10[1])
    self.circle = 9
    self.allow_get_power = 99
    self.get_power = 0
  end
end

function M:add_npc1()
  local now_time = get_npc_time(self.npc)
  if not is_cast_skill_time(self.npc, self.get_power2) then
    return
  end
  if is_cast_skill_time(self.npc, self.get_power2) and 0 == self.add_monster then
    local now_pos = get_npc_pos(self.npc)
    local pos1 = get_npc_offset_position(self.target, nil, 0, 10)
    add_npc_by_pos_key(1, 20203501, "tp1", -4, -6, "tp3", 0, 0, 4, 99)
    add_npc_by_pos_key(1, 20203502, "tp1", 4, -6, "tp3", 0, 0, 4, 99)
    add_npc_by_pos_key(1, 20203503, "tp1", 0, -6, "tp3", 0, 0, 4, 99)
    self.add_monster = 1
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.get_power2 then
    cast_missile(self.npc, nil, self.born_pos.x, self.born_pos.z, 201034012001, 1)
  end
  if skill_id == self.skill13 then
    abort_magic_by_id(self.npc, 20103401025, 1)
  end
  if skill_id == self.skill19 then
    self.laser2 = 0
  end
  if skill_id == self.skill05[1] then
    CommonMonster.tiktok_timer_func(self, 1.5, function()
      abort_magic_by_id(self.npc, 20103401027, 1)
    end)
  end
end

function M:before_skill08_cast()
  local now_time = get_npc_time(self.npc)
  local now_pos = get_npc_pos(self.npc)
  if is_cast_skill_time(self.npc) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if 3 ~= self.state then
    return
  end
  if not self.target then
    return
  end
  if 1 ~= self.skill_control then
    return
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
end

function M:wander_main_logic()
  local now_time = get_npc_time(self.npc)
  if now_time < self.wander_timer then
    return
  end
  if check_npc_status(self.npc, 5) then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 9) then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if not self.target then
    return
  end
  if 9 == self.control then
    return
  end
  if 1 == self.state then
    return
  end
  if 2 == self.state then
    return
  end
  if 0 ~= self.get_power then
    return
  end
  if self.walk == true then
    return
  end
  if 0 ~= self.allow_flash then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], false)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], false)
  local distance_maxx = check_npc_distance(self.npc, self.target, self.wander[2] + 6, false)
  local angle = get_target_angel(self.npc, self.target, true)
  if distance_max then
    stop_move(self.npc)
  elseif not distance_max and distance_maxx and angle >= 0 and angle <= 30 then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  elseif not distance_max and distance_maxx and angle <= 0 and angle >= -30 then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
  if angle >= 90 and angle <= 180 and now_time >= self.skill01[3] then
    self:skill_cast(self.skill01, 0)
    self.s07 = self.s07 + 1
  elseif angle <= -130 and angle >= -220 and now_time >= self.skill16[3] then
    self:skill_cast(self.skill16, 0)
    self.s07 = self.s07 + 1
  elseif angle <= -90 and angle >= -129 and now_time >= self.skill01[3] then
    self:skill_cast(self.skill01, 0)
    self.s07 = self.s07 + 1
  end
  if not distance_maxx and now_time >= self.skill09[3] and angle >= 0 and angle <= 120 then
    local now_target = get_npc_pos(self.target)
    set_lock_velocity(self.npc, 1)
    lookat_npc(self.npc, self.target, false)
    cast_skill_to_position(self.npc, self.skill09[1], now_target.x, now_target.z)
    self.skill09[3] = now_time + self.skill09[2]
  elseif not distance_maxx and now_time >= self.skill09[3] and angle <= 0 and angle >= -120 then
    local now_target = get_npc_pos(self.target)
    set_lock_velocity(self.npc, 1)
    lookat_npc(self.npc, self.target, false)
    cast_skill_to_position(self.npc, self.skill09[1], now_target.x, now_target.z)
    self.skill09[3] = now_time + self.skill09[2]
  end
  self.wander_timer = now_time + self.wander[1]
end

function M:skill_cast_control()
  local angle = get_target_angel(self.npc, self.target, true)
  if is_cast_skill_time(self.npc) then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if not self.target then
    return
  end
  if angle >= 0 and angle <= 80 then
    self.skill_control = 1
  elseif angle <= 0 and angle >= -80 then
    self.skill_control = 1
  end
  if angle >= 80 or angle <= -80 then
    self.skill_control = 0
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc, 2, 2.5)
  if npc ~= self.npc then
    return
  end
end

function M:on_frame()
  self:skill14_cast()
  self:stage()
  self:now_give_me_the_power1()
  self:missile_circle()
  self:wander_main_logic()
  self:state0_skill_cast()
  self:skill03_cast()
  self:state1_skill_cast()
  self:before_skill08_cast()
  self:skill08_cast()
  self:add_npc1()
  self:change_state()
  self:change_state_skill()
  self:skill_cast_control()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 250, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
