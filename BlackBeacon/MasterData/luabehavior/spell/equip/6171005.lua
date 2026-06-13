local M = Util.create_class()
local hero = get_come_on_hero()
local lazer_mis = {
  61710910101,
  61710910201,
  61710910301,
  61710910401,
  61710910403
}
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}

function M:_init(npc)
  self.cast_cd = 5
  self.cast_time = 0
end

function M:on_start()
  self.level = get_ability_level(60023) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(60023) or 1
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg)
  if owner ~= self.npc or self.npc ~= get_come_on_hero() then
    return
  end
  if (missile_cfg.Id == lazer_mis[1] or missile_cfg.Id == lazer_mis[2] or missile_cfg.Id == lazer_mis[3] or missile_cfg.Id == lazer_mis[4]) and get_npc_time(self.npc) > self.cast_time + self.cast_cd then
    for k, v in pairs(team_hero_list) do
      cast_magic(owner, v, 61710051, self.level)
    end
    self.cast_time = get_npc_time(self.npc)
  end
end

return M
