local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_start()
end

function M:on_frame()
  if 0 == self.magic_set then
    start_texture_guide(1002)
    self.magic_set = 1
  end
end

function M:on_texture_guide_finish(group_id)
  if 1002 == group_id then
    set_scene_camera(9901)
    abort_magic_by_id(self.npc, 4031009, 1)
  end
end

return M
