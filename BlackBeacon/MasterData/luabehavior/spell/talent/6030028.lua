local M = Util.create_class()

function M:_init()
  self.before_sharft = 0
  self.after_sharft = 0
end

function M:on_frame()
  local now_battleval_1 = 0
end

function M:after_heal(npc, target, magic_id, heal_val)
  if target ~= self.npc then
    return
  end
  if 5001001 == magic_id or 5001002 == magic_id or 5001003 == magic_id or 5001004 == magic_id then
    local now_hp = get_npc_attr(self.npc, 1)
    local now_max_hp = get_npc_attr(self.npc, 4)
    self.after_sharft = now_hp / now_max_hp
  end
  local final = math.ceil(self.before_sharft - self.after_sharft)
  cast_magic(self.npc, self.npc, 6031061, final)
  cast_magic(self.npc, self.npc, 6031062, final)
  cast_magic(self.npc, self.npc, 6031063, final)
end

return M
