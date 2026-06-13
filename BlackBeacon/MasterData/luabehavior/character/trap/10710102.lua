local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  self.timecount = 0
  self.timegap = 3
  self.skill = 1071010201
end

function M:on_start()
  cast_magic(self.npc, self.npc, 2010050117, 1)
  cast_magic(self.npc, self.npc, 2010050113, 1)
  cast_magic(self.npc, self.npc, 399932, 1)
  cast_magic(self.npc, self.npc, 399931, 1)
  cast_magic(self.npc, self.npc, 30010570102, 1)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  if check_magic(self.npc, 10710101021) then
    self.timegap = 1
  end
  if check_magic(self.npc, 10710101023) then
    self.timegap = 3
  end
  if check_magic(self.npc, 10710101025) then
    self.timegap = 5
  end
end

function M:on_frame()
  if get_npc_time(self.npc) - self.timecount >= tonumber(self.timegap) then
    self.timecount = self.timecount + tonumber(self.timegap)
    cast_skill(self.npc, self.npc, self.skill)
  end
  if check_magic(self.npc, 3010101011) then
  end
end

return M
