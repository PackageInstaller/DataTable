local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.god = get_god_npc()
  self.attr99num = 0
  self.attr100num = 0
  self.attr101num = 0
end

function M:on_frame()
  if 0 == self.magic_set and self.god then
    local npc_list = {
      get_come_on_hero(),
      get_scene_hero_by_poskey(21),
      get_scene_hero_by_poskey(22)
    }
    for i, npc in ipairs(npc_list) do
      if npc then
        self.attr99num = self.attr99num + get_npc_attr(npc, 99)
        self.attr100num = self.attr100num + get_npc_attr(npc, 100)
        self.attr101num = self.attr101num + get_npc_attr(npc, 101)
      end
    end
    self.magic_set = 1
  end
  if 1 == self.magic_set then
    self.magic_set = 2
    self.attr99num = self.attr99num + get_npc_attr(self.god, 99)
    self.attr100num = self.attr100num + get_npc_attr(self.god, 100)
    self.attr101num = self.attr101num + get_npc_attr(self.god, 101)
    set_sync_var("attr99num", self.attr99num)
    set_sync_var("attr100num", self.attr100num)
    set_sync_var("attr101num", self.attr101num)
  end
  if 2 == self.magic_set then
    self.magic_set = 3
    abort_magic_by_id(self.npc, 4031024, 1)
  end
end

return M
