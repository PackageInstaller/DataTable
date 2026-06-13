local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
M.cd = 1
M.next_time = -1

function M:on_start()
  self.level = get_ability_level(10019) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10019) or 1
end

function M:after_heal_self(npc, magic_id, heal_val)
  if get_come_on_hero() ~= self.npc then
    return
  end
  local godNpc = get_god_npc()
  local current_time = get_npc_time(godNpc)
  if current_time > M.next_time then
    local hero1 = get_scene_hero_by_poskey(21)
    local hero2 = get_scene_hero_by_poskey(22)
    if hero1 and not check_npc_die(hero1) then
      if self.level > 1 and not check_magic(hero1, 61711331) then
        cast_magic(hero1, hero1, 61711331)
      end
      cast_magic(hero1, hero1, magic_id)
    end
    if hero2 and not check_npc_die(hero2) then
      if self.level > 1 and not check_magic(hero2, 61711331) then
        cast_magic(hero2, hero2, 61711331)
      end
      cast_magic(hero2, hero2, magic_id)
    end
    M.next_time = current_time + M.cd
  end
end

function M:_init(npc)
end

return M
