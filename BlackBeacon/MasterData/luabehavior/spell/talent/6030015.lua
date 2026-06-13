local M = Util.create_class()

function M:_init()
  self.buff_layer = 0
  self.used_id = 0
  self.buff_timer = 0
  self.buff_set = 0
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc == self.npc then
    cast_magic(self.npc, self.npc, 6031023, 1)
  end
end

return M
