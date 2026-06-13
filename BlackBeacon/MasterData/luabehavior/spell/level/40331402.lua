local M = Util.create_class()

function M:_init()
  self.nowTime = 0
  self.intervalTime = 0
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
  if not check_magic(self.npc, 4033140201) and self.nowTime >= self.intervalTime then
    self.intervalTime = self.nowTime + 1
    local monster, numb = search_npc(self.npc, 2, 4, nil, true, true)
    if numb >= 1 then
      cast_magic(self.npc, self.npc, 4033140201, numb)
    end
  end
end

return M
