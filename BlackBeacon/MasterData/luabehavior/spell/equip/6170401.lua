local M = Util.create_class()
local team_hero_list = {}
local ability = 50001
local level = 1
local ultTime = false

function M:_init(npc)
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 5 == skill_type then
    cast_magic(self.npc, self.npc, 61704011, level)
    ultTime = true
  end
end

function M:on_skill_end(npc, skill_id, skill_type)
  if npc == self.npc and ultTime then
    ultTime = false
    abort_magic_by_id(self.npc, 61704011)
  end
end

return M
