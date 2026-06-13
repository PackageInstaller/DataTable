local M = Util.create_class()
local target_list = {}
local magic_level = 0
local magic = {
  [1] = {
    61701041,
    61701042,
    61701043,
    61701044,
    61701045
  },
  [2] = {
    61701046,
    61701047,
    61701048,
    61701049,
    61701050
  }
}
local ability = 20004
local level = 1
local mastery_check_fuc = {
  [6170101] = function(self)
    magic_level = magic_level + 1
  end,
  [6170102] = function(self)
    magic_level = magic_level + 1
  end,
  [6170103] = function(self)
    magic_level = magic_level + 1
  end,
  [6170104] = function(self)
    magic_level = magic_level + 1
  end,
  [6170105] = function(self)
    magic_level = magic_level + 1
  end,
  [6170106] = function(self)
    magic_level = magic_level + 1
  end,
  [6170107] = function(self)
    magic_level = magic_level + 1
  end,
  [6170108] = function(self)
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
end

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
  self:magic_numbs()
end

function M:on_room_change(npc)
  self:magic_numbs()
end

function M:on_npc_born(npc)
  if 1 ~= get_role_kind(npc) and get_come_on_hero() == self.npc then
    for k, v in pairs(magic[level]) do
      cast_magic(self.npc, npc, v, magic_level)
    end
  end
end

return M
