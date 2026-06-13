local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    20100902,
    5.5,
    0,
    0,
    3.5,
    get_skill_cfg(20100902).CastTime,
    get_skill_cfg(20100902).AfterTime,
    0
  }
  self.skill01 = {
    20100901,
    4.5,
    1,
    0,
    2,
    get_skill_cfg(20100901).CastTime,
    get_skill_cfg(20100901).AfterTime,
    0
  }
  self.monster_type = 1
  self.wander = {1.7, 0.5}
  self.wander_backrange = (math.random() + math.random(30, 40)) / 10
  self.wander_backtimer = 0
  self.wander_timer = 3
  self.wander_state = 0
  self.target = nil
  self.control = 0
  self.stun_timer = 0
  self.born_skill = 20100903
  self.hurt_reatk_skill = self.skill01
  self.hurt_check = 0
  self.hurt_check_timer = 0
  self.hurt_cnt_timer = 0
end

function M:on_start()
end

function M:cast_skill(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
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
  if check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    if get_npc_time(self.npc) >= skill_instant_id[3] then
      cast_skill(self.npc, self.target, skill_instant_id[1])
      skill_instant_id[3] = now_time + skill_instant_id[2] + math.random(10, 30) / 10
      self.skill_set_time = self.now_time + math.random() + math.random(30, 50) / 10
      self.skill_set = 0
    end
  elseif check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    switch_move_type(self.npc, 2)
    moveto_npc(self.npc, self.target)
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 0 ~= self.skill_set then
    self.skill_set = 0
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 0 ~= self.skill_set then
    self.skill_set = 0
  end
end

function M:attack_done_bonus()
  if get_npc_time(self.npc) >= self.wander_backtimer and 99 == self.control then
    self.control = 0
    self.wander_state = 0
    self.wander_backrange = (math.random() + math.random(30, 50)) / 10
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  local now_time = get_npc_time(self.npc)
  if 0 == self.skill_set and 0 == self.control then
    local skill_set_random = math.random() + math.random(10, 20)
    if skill_set_random >= 14 then
      self.skill_set = 1
    else
      self.skill_set = 2
    end
  elseif 1 == self.skill_set and check_npc_distance(self.npc, self.target, self.skill01[5], false) and now_time >= self.skill01[3] then
    self:cast_skill(self.skill01)
    self.skill_set = 99
  elseif 2 == self.skill_set and check_npc_distance(self.npc, self.target, self.skill02[5], false) and now_time >= self.skill02[3] then
    self:cast_skill(self.skill02)
    self.skill_set = 99
  end
end

function M:on_frame()
  if 1 == self.skill_set and self.now_time >= self.skill01[3] then
    self:cast_skill(self.skill01)
  elseif 2 == self.skill_set and self.now_time >= self.skill02[3] then
    self:cast_skill(self.skill02)
  end
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.skill_change_logic(self)
  CommonMonster.Hit_wall(self)
  if get_sync_var("Dafu_teach", true) and (is_cast_skill_time(self.npc, 20100903) or not is_cast_skill_time(self.npc)) then
    abort_skill(self.npc, true)
    lookat_npc(self.npc, self.target, 1)
    cast_skill(self.npc, self.target, self.skill01[1])
    set_sync_var("Dafu_teach", false)
  end
end

return M
