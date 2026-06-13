local M = Util.create_class()
local team_hero_list = {}
local target_list = {}
local magic_level = 0
local magic = {61704041, 61704042}
local ability = 50004
local level = 1
local mastery_check_fuc = {
  [6170401] = function(self)
    magic_level = magic_level + 1
  end,
  [6170402] = function(self)
    magic_level = magic_level + 1
  end,
  [6170403] = function(self)
    magic_level = magic_level + 1
  end,
  [6170404] = function(self)
    magic_level = magic_level + 1
  end,
  [6170405] = function(self)
    magic_level = magic_level + 1
  end,
  [6170406] = function(self)
    magic_level = magic_level + 1
  end,
  [6170407] = function(self)
    magic_level = magic_level + 1
  end,
  [6170408] = function(self)
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
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
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
