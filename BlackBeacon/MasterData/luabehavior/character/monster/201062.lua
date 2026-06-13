local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    2010150101,
    1,
    0,
    0,
    10,
    get_skill_cfg(2010150101).CastTime,
    get_skill_cfg(2010150101).AfterTime,
    0
  }
  self.monster_type = 1
  self.control = 0
  self.born_skill = 2010150103
  self.move_timer = 0
  self.wander = {1.7, 0.5}
  self.wander_backrange = (math.random() + math.random(10, 30)) / 10
  self.wander_backtimer = 0
  self.wander_timer = 3
  self.wander_state = 0
  self.target = nil
  self.stun_timer = 0
  self.hurt_reatk_skill = self.skill01
  self.hurt_check = 0
  self.hurt_check_timer = 0
  self.hurt_cnt_timer = 0
end

function M:on_start()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if hit_type <= 4 then
    CommonMonster.counterattack_value(self)
  end
  CommonMonster.counteratk(self)
end

function M:cast_skill(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.control = 0
    return
  end
  if 0 == self.control then
  else
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
  if now_time < skill_instant_id[3] then
    self.skill_set_time = skill_instant_id[3] - self.now_time + math.random(0, 2)
    self.skill_set = 0
    return
  end
  lookat_npc(self.npc, self.target)
  if check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    cast_skill(self.npc, self.target, skill_instant_id[1])
    skill_instant_id[3] = now_time + skill_instant_id[2] + math.random(10, 30) / 10
    self.skill_set_time = self.now_time + math.random(50, 90) / 10
    self.skill_set = 0
  elseif check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    if now_time > self.move_timer then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
      self.move_timer = now_time + 1
    end
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and check_npc_distance(self.npc, self.target, skill_instant_id[5] + 2, false) then
    if now_time > self.move_timer then
      switch_move_type(self.npc, 1)
      moveto_npc(self.npc, self.target)
      self.move_timer = now_time + 1
    end
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5] + 2, false) and check_npc_distance(self.npc, self.target, skill_instant_id[5] + 3, false) then
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.skill02[1])
    skill_instant_id[3] = self.now_time + skill_instant_id[2]
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5] + 3, false) and now_time > self.move_timer then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.move_timer = now_time + 1
  end
end

function M:skill_main_logic()
  self:cast_skill(self.skill01)
end

function M:on_frame()
  self:skill_main_logic()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
  end
end

return M
