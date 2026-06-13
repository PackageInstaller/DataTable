local M = Util.create_class()
local check_magic_id = {
  [1] = 399964,
  [2] = 399965,
  [3] = 399966,
  [4] = 399967,
  [5] = 399968,
  [6] = 399983,
  [7] = 399984,
  [8] = 399985,
  [9] = 399986,
  [10] = 399987,
  [11] = 399988,
  [12] = 399987,
  [13] = 399988
}
local trap_magic_id = {
  [1] = 399970,
  [2] = 399971,
  [3] = 399972,
  [4] = 399973,
  [5] = 399974,
  [6] = 399975,
  [7] = 399976,
  [8] = 399977,
  [9] = 399978,
  [10] = 399979,
  [11] = 399980,
  [12] = 399931,
  [13] = 399933
}

function M:_init()
  self.control = nil
  self.trapid = nil
  self.target = nil
  self.splash_timer = nil
  self.walk_set = nil
  self.TEMP_POS = {}
  self.skill01 = {
    300102701,
    5,
    0,
    0,
    0,
    get_skill_cfg(300102701).CastTime,
    get_skill_cfg(300102701).AfterTime
  }
end

function M:cast_skill(skill_instant_ID)
  if 300102701 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 2, 10, nil, 1)
end

function M:control_set()
  self:cast_skill(self.skill01)
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  self:dir_change()
  self:wander_main_logic()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
    self:control_set()
  end
  if 0 == self.control then
    for index = 1, 5 do
      if check_magic(self.npc, check_magic_id[index]) then
        self.trapid = index
      end
    end
    if check_magic(self.npc, check_magic_id[6]) then
      self.walk_set = 0
    elseif check_magic(self.npc, check_magic_id[7]) then
      self.walk_set = 2
    elseif check_magic(self.npc, check_magic_id[8]) then
      self.walk_set = 4
    elseif check_magic(self.npc, check_magic_id[9]) then
      self.walk_set = 6
    elseif check_magic(self.npc, check_magic_id[10]) then
      self.walk_set = 4
    elseif check_magic(self.npc, check_magic_id[11]) then
      self.walk_set = 0
    elseif check_magic(self.npc, check_magic_id[12]) then
      self.walk_set = 6
    elseif check_magic(self.npc, check_magic_id[13]) then
      self.walk_set = 2
    end
    self.control = 1
  end
end

function M:dir_change()
  local now_time = get_npc_time(self.npc)
  if 1 == self.walk_set and now_time >= self.walk_timer then
    if check_magic(self.npc, check_magic_id[10]) or check_magic(self.npc, check_magic_id[11]) then
      self.walk_set = 4
    else
      self.walk_set = 2
    end
  elseif 3 == self.walk_set and now_time >= self.walk_timer then
    if check_magic(self.npc, check_magic_id[12]) or check_magic(self.npc, check_magic_id[13]) then
      self.walk_set = 6
    else
      self.walk_set = 4
    end
  elseif 5 == self.walk_set and now_time >= self.walk_timer then
    if check_magic(self.npc, check_magic_id[10]) or check_magic(self.npc, check_magic_id[11]) then
      self.walk_set = 0
    else
      self.walk_set = 6
    end
  elseif 7 == self.walk_set and now_time >= self.walk_timer then
    if check_magic(self.npc, check_magic_id[12]) or check_magic(self.npc, check_magic_id[13]) then
      self.walk_set = 2
    else
      self.walk_set = 0
    end
  end
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_x = now_pos.x + 8
    self.TEMP_POS.x = aim_pos_x
    self.TEMP_POS.z = now_pos.z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 1
  elseif 2 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_z = now_pos.z + 8
    self.TEMP_POS.x = now_pos.x
    self.TEMP_POS.z = aim_pos_z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 3
  elseif 4 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_x = now_pos.x - 8
    self.TEMP_POS.x = aim_pos_x
    self.TEMP_POS.z = now_pos.z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 5
  elseif 6 == self.walk_set then
    local now_time = get_npc_time(self.npc)
    local now_pos = get_npc_pos(self.npc)
    local aim_pos_z = now_pos.z - 8
    self.TEMP_POS.x = now_pos.x
    self.TEMP_POS.z = aim_pos_z
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.walk_timer = now_time + 3
    self.walk_set = 7
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

return M
