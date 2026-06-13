local M = Util.create_class()
local team_hero_list = {}
local time = 0
local interval_time = 0
local magic_level = 0
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
  if magic_level >= 8 and get_come_on_hero() == self.npc then
    cast_magic(self.npc, get_god_npc(), 61700093, 1)
  end
end

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
  self:magic_numbs()
end

function M:on_room_change(npc)
  self:magic_numbs()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 607000002 == skill_id and get_come_on_hero() == self.npc then
    cast_missile(self.npc, self.npc, nil, nil, 60700000101, 1, nil, nil)
    cast_missile(self.npc, self.npc, nil, nil, 60700000102, 1, nil, nil)
    if magic_level >= 4 then
      cast_magic(self.npc, self.npc, 61700092, 1)
    end
  end
end

function M:on_frame()
end

return M
