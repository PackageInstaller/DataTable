local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    20102602,
    2.1,
    0,
    0,
    99,
    get_skill_cfg(20102602).CastTime,
    get_skill_cfg(20102602).AfterTime,
    0
  }
  self.skill01 = {
    20102601,
    2,
    1,
    1,
    99,
    get_skill_cfg(20102601).CastTime,
    get_skill_cfg(20102601).AfterTime,
    self.skill02
  }
  self.used_enemy_pos = nil
  self.wander = {
    6,
    9,
    0.5
  }
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.npc_now_time = 0
  self.side_choice = 0
  self.stun_timer = 0
  self.timer_set = 0
  self.born_skill = 20102603
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 3
    self.stun_timer = get_npc_time(self.npc) + 1
    return
  end
end

function M:cast_skill(skill_instant_ID)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if now_time < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not self.target then
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
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if now_time >= skill_instant_ID[3] then
    if 20102601 == skill_instant_ID[1] then
      abort_skill(self.npc)
      local random_pos_x = math.random(4, 5)
      local random_pos_z = math.random(4, 5)
      local now_enemy_pos = get_npc_pos(self.target)
      self.used_enemy_pos = get_npc_pos(self.target)
      if math.random(1, 11) > 6 then
        xpos_to_go = now_enemy_pos.x + random_pos_x
      else
        xpos_to_go = now_enemy_pos.x - random_pos_x
      end
      if math.random(1, 11) > 8 then
        zpos_to_go = now_enemy_pos.z + random_pos_z
      else
        zpos_to_go = now_enemy_pos.z - random_pos_z
      end
      cast_skill(self.npc, nil, self.skill01[1], xpos_to_go, zpos_to_go)
      skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
      if 0 == self.timer_set then
        self.npc_now_time = now_time
        self.timer_set = 1
      end
      if now_time >= self.npc_now_time + 5 then
        self.npc_now_time = now_time
        self.control = 2
      end
    end
  else
    return
  end
end

function M:next_skill()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if 2 == self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill02[1])
    self.wander_timer_skill_makeup = self.skill02[6] + self.skill02[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.control = 0
  end
end

function M:be_attacked_bonus()
  local now_time = get_npc_time(self.npc)
  if now_time >= self.stun_timer and 3 == self.control then
    self.control = 0
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if not self:cast_skill(self.skill01) and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    return
  end
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  if check_magic(self.npc, 100174) then
    return
  end
  self:skill_main_logic()
  self:next_skill()
  self:be_attacked_bonus()
  CommonMonster.remove_timer(self)
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:hurt()
  if not check_npc_status(self.npc, 0) then
    stop_move(self.npc)
    return
  end
end

return M
