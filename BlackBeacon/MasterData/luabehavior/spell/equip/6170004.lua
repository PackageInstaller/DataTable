local M = Util.create_class()
local target_list = {}
local magic_level = 0
local magic = {61700041, 61700042}
local ability = 10004
local level = 1
local mastery_check_fuc = {
  [6170001] = function(self)
    magic_level = magic_level + 1
  end,
  [6170002] = function(self)
    magic_level = magic_level + 1
  end,
  [6170003] = function(self)
    magic_level = magic_level + 1
  end,
  [6170004] = function(self)
    magic_level = magic_level + 1
  end,
  [6170005] = function(self)
    magic_level = magic_level + 1
  end,
  [6170006] = function(self)
    magic_level = magic_level + 1
  end,
  [6170007] = function(self)
    magic_level = magic_level + 1
  end,
  [6170008] = function(self)
    magic_level = magic_level + 1
  end
}

function M:magic_numbs()
  magic_level = 0
  for key, value in pairs(mastery_check_fuc) do
    if check_magic(self.npc, key) then
      value(self)
    end
  end
  cast_magic(self.npc, self.npc, magic[level], magic_level)
end

function M:_init(npc)
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:on_start()
  level = get_ability_level(ability)
  self:magic_numbs()
end

function M:on_room_change(npc)
  self:magic_numbs()
end

return M
