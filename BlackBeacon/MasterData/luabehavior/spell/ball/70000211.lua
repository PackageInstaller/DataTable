local M = Util.create_class()

function M:_init()
  self.nowTime = 0
  self.magicTime = 0
end

function M:on_start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and false == is_showup then
    abort_magic_by_id(self.npc, 7000021101, 99)
    self.magicTime = get_npc_time(self.npc) + 5
  elseif npc == self.npc and true == is_showup and check_magic(npc, 7000021101) then
    cast_magic(self.npc, self.npc, 7000021101, 1)
  end
end

function M:on_frame_background(npc)
  self.nowTime = get_npc_time(self.npc)
  if self.nowTime >= self.magicTime then
    self.magicTime = self.nowTime + 5
    cast_magic(self.npc, self.npc, 7000021101, 1)
  end
end

function M:on_frame(npc)
  self.nowTime = get_npc_time(self.npc)
end

return M
