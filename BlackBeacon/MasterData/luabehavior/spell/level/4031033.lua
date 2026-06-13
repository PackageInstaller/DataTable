local M = Util.create_class()

function M:_init()
  self.magic_set = nil
end

function M:on_start()
  self.plat1_pos = add_npc_by_pos_key(1, 3001024, "anchor1", 0, 0, "tp3", 0, 0, 2, 1)
  self.plat2_pos = add_npc_by_pos_key(1, 3001024, "anchor2", 0, 0, "tp3", 0, 0, 2, 1)
  self.plat3_pos = add_npc_by_pos_key(1, 3001024, "anchor3", 0, 0, "tp3", 0, 0, 2, 1)
  for index = 1, 6 do
    for index2 = 1, 6 do
      self.point[index .. index2].x, self.point[index .. index2].z = get_scene_map_pos_postion(tostring(index .. index2))
    end
  end
end

function M:on_frame()
  if not get_sync_var("move_plat") or 0 == get_sync_var("move_plat") then
    return
  end
end

return M
