local M = Util.create_class()

function M:_init()
  self.over = false
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 3001064005 == magic_id and target == get_come_on_hero() and self.over == false then
    enter_guide(106004)
    self.over = true
  end
end

return M
