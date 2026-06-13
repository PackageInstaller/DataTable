local M = Util.create_class()

function M:_init()
  self.cd_timer = 0
  self.iscast = false
  self.time = 0
  self.control = 0
  self.nums = 1
end

function M:on_magic_begin(npc, target, magic_id)
  if 1999050 ~= magic_id then
    return
  end
  if get_npc_time(self.npc) >= self.cd_timer then
    cast_magic(self.npc, self.npc, 60550071, 1)
    cast_magic(self.npc, self.npc, 60550072, 1)
    cast_magic(self.npc, self.npc, 60540022, 1)
    cast_magic(self.npc, self.npc, 60550073, 1)
    self.iscast = true
    self.control = 0
    self.cd_timer = get_npc_time(self.npc) + 20
  end
end

function M:sleep_time()
  if get_npc_time(self.npc) >= self.time and self.nums <= 8 then
    self.time = get_npc_time(self.npc) + 1
    self.control = 0
    self.nums = self.nums + 1
  else
    self.control = 1
  end
end

function M:creat_magic()
  if 0 == self.control then
    cast_magic(self.npc, self.npc, 1999051, 1)
  end
end

function M:on_frame()
  if self.iscast then
    self:sleep_time()
    self:creat_magic()
  end
  if self.nums > 8 then
    self.iscast = false
    self.control = 2
    self.nums = 0
  end
end

return M
