local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")
local cd = 5

function M:_init(npc)
end

function M:on_start()
  local hero = get_come_on_hero()
  self.last_pos = {}
  self.last_pos = get_npc_pos(hero)
  self.last_time = get_npc_time(self.npc)
  self.is_battle = true
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70001) or 1
end

function M:on_fate_book_battle_start()
  local hero = get_come_on_hero()
  self.last_pos = get_npc_pos(hero)
  self.last_time = get_npc_time(self.npc)
  self.is_battle = true
end

function M:on_room_change(npc)
  local hero = get_come_on_hero()
  self.last_pos = get_npc_pos(hero)
  self.is_battle = false
  self.level = get_ability_level(70001) or 1
end

function M:on_frame()
  if not self.is_battle then
    return
  end
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time > self.last_time + cd then
    local hero = get_come_on_hero()
    self.curr_pos = {}
    self.curr_pos = get_npc_pos(hero)
    local vector = self.curr_pos - self.last_pos
    local norm = vector:Magnitude()
    if norm >= 1 then
      local amount = self:calculate_Value(norm)
      rogueMgr.random_cast_fragment(rogueMgr, hero, amount, 4)
    end
    self.last_pos = self.curr_pos
    self.last_time = self.curr_time
  end
end

function M:calculate_Value(num)
  if num > 6 then
    return 3
  else
    local diff = num
    local increment = math.ceil(diff / 3)
    return increment
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == rogueMgr.fragment_missile_judge then
    local hero = get_come_on_hero()
    local magic_num = get_magic_num(hero, rogueMgr.fragment_magic)
    local level = math.ceil(magic_num / 10)
    cast_missile3(hero, nil, pos_x, pos_z, 61712910403, level)
  end
end

return M
