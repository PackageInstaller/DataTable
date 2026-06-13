local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, target)
  cast_missile(self.npc, target, nil, nil, 10019012001, 1, nil, nil, nil)
end

function M:on_npc_hp_zero(npc)
  if check_magic(npc, 1999030) then
    self:creat_magic(npc, npc)
  end
end

function M:on_frame()
end

return M
