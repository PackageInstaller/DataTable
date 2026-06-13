local M = Util.create_class()
local tool = import("common.tool")
local current_time = 0
local CD = 2

function M:on_start()
  local level = get_ability_level(30014) or 1
  if level > 1 then
    CD = 1
  end
end

function M:on_room_change(npc)
  local level = get_ability_level(30014) or 1
  if level > 1 then
    CD = 1
  end
end

function M:_init(npc)
end

function M:on_frame()
  if get_npc_attr(self.npc, 24) <= 10000 then
    return
  end
  if not check_npc_status(self.npc, 9) then
    return
  end
  if get_npc_time(self.npc) > current_time + CD then
    local hero1 = self.npc
    local hero2 = get_scene_hero_by_poskey(21)
    local hero3 = get_scene_hero_by_poskey(22)
    local heal_magic = 61709231
    if hero1 then
      cast_magic(hero1, hero1, heal_magic)
    end
    if hero2 and get_npc_attr(hero2, 4) - get_npc_attr(hero2, 1) > 1 then
      cast_magic(hero2, hero2, heal_magic)
    end
    if hero3 and get_npc_attr(hero3, 4) - get_npc_attr(hero3, 1) > 1 then
      cast_magic(hero3, hero3, heal_magic)
    end
    current_time = get_npc_time(self.npc)
  end
end

return M
