local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    2010250211,
    0,
    0,
    0,
    3,
    get_skill_cfg(2010250211).CastTime,
    get_skill_cfg(2010250211).AfterTime,
    0
  }
  self.skill02_1 = {
    2010250221,
    0,
    0,
    0,
    3,
    get_skill_cfg(2010250221).CastTime,
    get_skill_cfg(2010250221).AfterTime,
    0
  }
  self.skill02_2 = {
    2010250222,
    0,
    0,
    0,
    20,
    get_skill_cfg(2010250222).CastTime,
    get_skill_cfg(2010250222).AfterTime,
    0
  }
  self.skill03_1 = {
    2010250231,
    0,
    0,
    0,
    3,
    get_skill_cfg(2010250231).CastTime,
    get_skill_cfg(2010250231).AfterTime,
    0
  }
  self.skill03_2 = {
    2010250232,
    0,
    0,
    0,
    20,
    get_skill_cfg(2010250232).CastTime,
    get_skill_cfg(2010250232).AfterTime,
    0
  }
  self.skill03_3 = {
    2010250233,
    0,
    0,
    0,
    20,
    get_skill_cfg(2010250233).CastTime,
    get_skill_cfg(2010250233).AfterTime,
    0
  }
  self.skill_list = {
    [1] = {
      self.skill01
    },
    [2] = {
      self.skill02_1,
      self.skill02_2
    },
    [3] = {
      self.skill03_1,
      self.skill03_2,
      self.skill03_3
    }
  }
  self.monster_type = 1
  self.control = 0
  self.born_skill = 2010150103
  self.target = nil
  self.stun_info = {set = false, time = 0}
  self.skill_state = 0
  self.skill_combo = 1
  self.skill_set_time = 0
  self.now_time = 0
end

function M:skill_cast(skill_instant)
  if 0 == self.control then
  else
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < 3 then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 1) then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant[5], false) and not check_npc_distance(self.npc, self.target, skill_instant[4], false) then
    if self.target then
      lookat_npc(self.npc, self.target)
    end
    cast_skill(self.npc, self.target, skill_instant[1])
  elseif not check_npc_distance(self.npc, self.target, skill_instant[5], false) then
    self.camp_distance_random[4] = self.camp_distance_random[4] + 1
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
  return true
end

function M:skill_main_logic()
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if get_target_angel(self.npc, self.target, true) <= 0 and get_target_angel(self.npc, self.target, true) >= 0 then
    return
  end
  self.now_time = get_npc_time(self.npc)
  if 0 == self.skill_state and self.now_time > self.skill_set_time then
    self.skill_state = math.random(2, 3)
    self.skill_combo = 1
    self.skill_set_time = self.now_time + 4
  end
  if not is_cast_skill_time(self.npc) and self.skill_list[self.skill_state] then
    self:skill_cast(self.skill_list[self.skill_state][1])
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.skill01[1] or skill_id == self.skill02_1[1] or skill_id == self.skill03_1[1] then
    self.skill_state = 0
  end
end

function M:on_skill_end(npc, skill_id, skill_type)
  Base.on_skill_end(self, npc, skill_id)
  if npc ~= self.npc or skill_id ~= self.born_skill then
  end
  if skill_id == self.skill01[1] then
    self.skill_state = 0
    self.skill_set_time = self.now_time + 0.5
  end
  if skill_id == self.skill02_1[1] then
    if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      self.skill_state = 0
      self.skill_set_time = self.now_time + 1.5
    else
      if self.target then
        lookat_npc(self.npc, self.target)
      end
      cast_skill(self.npc, self.target, self.skill_list[2][2][1])
    end
  end
  if skill_id == self.skill02_2[1] then
    self.skill_state = 0
    self.skill_set_time = self.now_time + 0.5
  end
  if skill_id == self.skill03_1[1] then
    if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      self.skill_state = 0
      self.skill_set_time = self.now_time + 1.5
    elseif self.target then
      lookat_npc(self.npc, self.target)
      cast_skill(self.npc, self.target, self.skill_list[3][2][1])
    end
  end
  if skill_id == self.skill03_2[1] then
    if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      self.skill_state = 0
      self.skill_set_time = self.now_time + 1.5
    else
      cast_skill(self.npc, self.target, self.skill_list[3][3][1])
    end
  end
  if skill_id == self.skill03_3[1] then
    self.skill_state = 0
    self.skill_set_time = self.now_time + 1
  end
end

function M:on_frame()
  if get_sync_var("fadai") then
    return
  end
  CommonMonster.search_target(self, 30, 4)
  CommonMonster.monster_on_frame(self)
  self:skill_main_logic()
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
