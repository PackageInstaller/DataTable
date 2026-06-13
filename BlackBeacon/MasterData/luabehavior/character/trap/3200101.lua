local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  self.total_num = get_sync_var("total_num")
  self.over = false
end

function M:on_frame()
  if self.over then
    return
  end
  for i = 1, self.total_num do
    self.temp_lamp = get_sync_var("lamp" .. tostring(i))
    if not self.temp_lamp then
      return
    end
  end
  set_sync_var("over", true)
  self.over = true
end

return M
