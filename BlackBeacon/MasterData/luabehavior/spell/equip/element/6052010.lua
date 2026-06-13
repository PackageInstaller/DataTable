local M = Util.create_class()

function M:_init()
  self.magic_count = 0
  self.trigger_time = get_time()
  self.magic_added = false
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc == self.npc and is_showup then
    self.trigger_time = get_time()
    self.magic_added = false
  elseif npc == self.npc and not is_showup then
    abort_magic_by_id(self.npc, 60520101, 1)
    self.magic_added = false
  end
end

function M:on_frame()
  if not self.magic_added and get_time() >= self.trigger_time + 2 then
    self.trigger_time = get_time()
    self.magic_count = self.magic_count + 1
    cast_magic(self.npc, self.npc, 60520101, 0)
    if 3 == self.magic_count then
      self.magic_added = true
    end
  end
end

return M
