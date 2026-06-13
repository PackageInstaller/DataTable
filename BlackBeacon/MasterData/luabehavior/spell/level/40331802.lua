local M = Util.create_class()
local nowTime, intervalTime

function M:_init()
  intervalTime = 2
end

function M:on_start()
end

function M:on_frame()
  nowTime = get_npc_time(self.npc)
  if nowTime >= intervalTime then
    cast_missile(self.npc, nil, nil, nil, 30020200102, 1)
    intervalTime = nowTime + 1
  end
end

return M
