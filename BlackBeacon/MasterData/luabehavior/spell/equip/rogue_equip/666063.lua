local M = Util.create_class()

function M:_init()
  self.timer = 0
  self.timer_start = false
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  self.come_on_hero = get_come_on_hero()
  cast_magic(self.come_on_hero, self.come_on_hero, 2010480152)
  self.timer = get_npc_time(self.npc) + 3
  self.timer_start = true
end

function M:on_frame()
  if self.timer_start == true and get_npc_time(self.npc) > self.timer then
    abort_magic_by_id(self.come_on_hero, 2010480152, 1)
    self.timer_start = false
  end
end

return M
