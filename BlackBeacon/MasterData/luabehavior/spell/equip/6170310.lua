local M = Util.create_class()
local team_hero_list = {}
local time = 0
local add_time = 0

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if 61703091 == magic_id then
  end
end

return M
