local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    20105002,
    3,
    1,
    1,
    99,
    get_skill_cfg(20105002).CastTime,
    get_skill_cfg(20105002).AfterTime,
    0
  }
  self.skill01 = {
    20105001,
    2,
    1,
    1,
    99,
    get_skill_cfg(20105001).CastTime,
    get_skill_cfg(20105001).AfterTime,
    0
  }
  self.hit_timer = 0
  self.target = nil
  self.control = 0
  self.now_hp = 0
  self.hurt_by_hp = 0
  self.used_enemy_pos = nil
  self.test_set = 0
  self.TEMP_POS = {}
  self.roll_set = false
end

function M:on_start()
  self.now_hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
end

function M:walk_skill()
  if check_npc_status(self.npc, 2) then
    self.control = 0
    return
  end
  local xpos_to_go = 0
  local zpos_to_go = 0
  if self.target and 0 == self.control then
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
    self.TEMP_POS.x = xpos_to_go
    self.TEMP_POS.z = zpos_to_go
    self.used_enemy_pos = now_enemy_pos
    switch_move_type(self.npc, 1)
    lookat_position(self.npc, self.TEMP_POS.x, self.TEMP_POS.z, true)
    move_to_pos(self.npc, self.TEMP_POS)
    self.control = 1
  elseif not self.target and self.used_enemy_pos then
    self.TEMP_POS.x = xpos_to_go
    self.TEMP_POS.z = zpos_to_go
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.control = 1
  end
end

function M:rolling()
  if self.roll_set == true then
    local xpos_to_go = 0
    local zpos_to_go = 0
    local random_pos_x = math.random(5, 7)
    local random_pos_z = math.random(5, 7)
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
    cast_skill(self.npc, nil, self.skill02[1], xpos_to_go, zpos_to_go)
    self.roll_set = false
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    return
  end
  if hit_target == self.npc then
    self.hurt_by_hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
    if self.now_hp - self.hurt_by_hp >= 0.3 then
      self.roll_set = true
      self.now_hp = self.hurt_by_hp
    end
  end
end

function M:on_frame()
  self:walk_skill()
  self:rolling()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 0) and 1 == self.control then
    self.control = 2
  elseif check_npc_status(self.npc, 0) and 2 == self.control then
    self.control = 0
  end
end

return M
