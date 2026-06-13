local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651230031)
  if check_magic(self.npc, 65113) then
    cast_magic(self.npc, self.npc, 651230032, self.level)
  end
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 65113 == magic_id then
    cast_magic(self.npc, self.npc, 651230032, self.level)
  end
end

return M
