local M = Util.create_class()
local tool = import("common.tool")
local hero = get_come_on_hero()
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}

function M:_init(npc)
  self.cast_cd = 1
  self.cast_time = 0
end

function M:on_start()
  self.level = get_ability_level(60014) or 1
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(60014) or 1
end

function M:on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if magic_kind and magic_kind[61710] and get_npc_time(self.npc) > self.cast_time + self.cast_cd and self.npc == get_come_on_hero() then
    if 1 == self.level then
      cast_magic(self.npc, self.npc, 61710152, 0)
      self.cast_time = get_npc_time(self.npc)
    elseif self.level > 1 then
      cast_magic(self.npc, self.npc, 617101521, 0)
      self.cast_time = get_npc_time(self.npc)
    end
  end
end

function M:on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if magic_kind and magic_kind[61710] and get_magic_kind_num(self.npc, 61710) < 1 then
    local hp_cur = get_npc_attr(self.npc, 1)
    local hp_max = get_npc_attr(self.npc, 4)
    local hp_per = math.ceil(hp_cur / hp_max * 100)
    if hp_per < 30 then
      if nil ~= team_hero_list[1] then
        cast_magic(team_hero_list[1], team_hero_list[1], 61710151, self.level)
      end
      if nil ~= team_hero_list[2] then
        cast_magic(team_hero_list[2], team_hero_list[2], 61710151, self.level)
      end
    end
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc ~= self.npc then
    return
  end
  if true == is_showup then
    team_hero_list = {
      get_scene_hero_by_poskey(21),
      get_scene_hero_by_poskey(22),
      get_come_on_hero()
    }
    hero = get_come_on_hero()
  end
end

return M
