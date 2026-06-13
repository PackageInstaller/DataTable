local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  self.check_counting = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 10, nil, false, true)
  if not self.target then
    return
  elseif self.target then
    for k, v in pairs(self.target) do
      self.check_counting = k
    end
  end
end

function M:battle_solo()
  if 1 == self.check_counting then
    cast_magic(self.npc, self.npc, 650018021, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650018021, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650018021, 0)
    end
  else
    abort_magic_by_id(self.npc, 650018021)
    if self.hero_one then
      abort_magic_by_id(self.hero_one, 650018021)
    end
    if self.hero_two then
      abort_magic_by_id(self.hero_two, 650018021)
    end
  end
end

function M:on_frame()
  self:battle_solo()
  self:search_target()
end

return M
