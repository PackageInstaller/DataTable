local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  self.level = get_ability_level(10014) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10014) or 1
end

function M:after_shield_target(npc, magic_id, shield_value)
  if get_npc_time(self.npc) > self.cast_time + self.cast_cd then
    cast_magic(self.npc, self.npc, 61711231, self.level)
    self.cast_time = get_npc_time(self.npc)
    self.cast_cd = 1
  end
end

function M:_init(npc)
  self.cast_cd = 0
  self.cast_time = 0
end

return M
