local M = Util.create_class()
local team_hero_list = {}
local target_list = {}
local magic_level = 0
local magic = {61702041, 61702042}
local ability = 30004
local level = 1
local mastery_check_fuc = {
  [6170201] = function(self)
    magic_level = magic_level + 1
  end,
  [6170202] = function(self)
    magic_level = magic_level + 1
  end,
  [6170203] = function(self)
    magic_level = magic_level + 1
  end,
  [6170204] = function(self)
    magic_level = magic_level + 1
  end,
  [6170205] = function(self)
    magic_level = magic_level + 1
  end,
  [6170206] = function(self)
    magic_level = magic_level + 1
  end,
  [6170207] = function(self)
    magic_level = magic_level + 1
  end,
  [6170208] = function(self)
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
