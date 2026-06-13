local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
  cast_magic(self.come_on_hero, self.come_on_hero, 66102201)
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
    cast_magic(self.come_on_hero, self.come_on_hero, 66102201)
  else
    abort_magic_by_id(npc, 66102201, 1)
  end
end

return M
