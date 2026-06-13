local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local time = 0
local interval_time = 0
local magic_level = 0
local mastery_check_fuc = {
  [6170301] = function(self)
    magic_level = magic_level + 1
  end,
  [6170302] = function(self)
    magic_level = magic_level + 1
  end,
  [6170303] = function(self)
    magic_level = magic_level + 1
  end,
  [6170304] = function(self)
    magic_level = magic_level + 1
  end,
  [6170305] = function(self)
    magic_level = magic_level + 1
  end,
  [6170306] = function(self)
    magic_level = magic_level + 1
  end,
  [6170307] = function(self)
    magic_level = magic_level + 1
  end,
  [6170308] = function(self)
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
    cast_magic(self.npc, get_god_npc(), 61703093, 1)
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
  if 607000032 == skill_id and get_come_on_hero() == self.npc then
    cast_missile(self.npc, self.npc, nil, nil, 60700003101, 1, nil, nil)
    cast_missile(self.npc, self.npc, nil, nil, 60700003102, 1, nil, nil)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level)
  if magic_level >= 4 and npc == self.npc and 61703091 == magic_id then
    local hp = get_npc_attr(target, 1) / get_npc_attr(target, 4)
    if hp < 0.5 then
      cast_magic(self.npc, self.npc, 61703101, 1)
    end
  end
end

function M:on_frame()
end

return M
