local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.now_energy = get_npc_attr(self.npc, 2)
  self.level = get_develop_level(self.npc, 6, 651110031)
  listen_attr_change_mq(self.npc, 2, self.on_jingli_change, self)
end

function M:on_jingli_change(npc, attr_type, change_value)
  if change_value < 0 then
    cast_magic(self.npc, self.npc, 651110032, self.level)
  end
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 2, self)
end

return M
