local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local time = 0
local interval_time = 0
local magic_level = 0
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
  if magic_level >= 8 and get_come_on_hero() == self.npc then
    cast_magic(self.npc, get_god_npc(), 61701103, 1)
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
  if 607000012 == skill_id and self.npc == get_come_on_hero() then
    if check_magic(self.npc, 6170108) then
      cast_missile(self.npc, self.npc, nil, nil, 60700001103, 1, nil, nil)
      cast_magic(self.npc, self.npc, 61701081, 1)
    else
      local x, z = get_indicator_pos(60)
      cast_missile(self.npc, nil, x, z, 60700001101, 1, nil, nil)
      cast_missile(self.npc, nil, x, z, 60700001102, 1, nil, nil)
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and (missile_cfg.Id == 60700001103 or missile_cfg.Id == 60700001102) and magic_level >= 4 then
    cast_magic(self.npc, hit_target, 6170110, 1)
  end
end

function M:on_frame()
end

return M
