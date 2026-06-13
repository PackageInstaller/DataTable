local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.god = get_god_npc()
end

function M:on_frame()
  if 0 == self.magic_set then
    start_texture_guide(1211001)
    self.magic_set = 1
  end
  if 99 == self.magic_set then
  end
  if get_sync_var("attr100num") then
  end
end

function M:on_texture_guide_finish(group_id)
  if 1 == self.magic_set and 1211001 == group_id then
    set_sync_var("texture_guide", 1211001)
    self.magic_set = 99
  end
end

return M
