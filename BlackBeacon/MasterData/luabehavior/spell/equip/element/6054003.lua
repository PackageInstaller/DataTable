local M = Util.create_class()

function M:_init()
  self.init_sheild_set = false
  self.now_sheild = nil
  self.sheild_set = false
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  local max_hp = get_npc_attr(self.npc, 4)
  if not self.now_sheild then
    if check_magic(npc, 1999040) then
      cast_magic(self.npc, self.npc, 60540031, 1)
      cast_magic(self.npc, self.npc, 60540032, 1)
      self.sheild_set = true
      self.now_sheild = get_npc_shield(self.npc)
    end
  elseif self.now_sheild / max_hp <= 0.2 and check_magic(npc, 1999040) then
    cast_magic(self.npc, self.npc, 60540031, 1)
    cast_magic(self.npc, self.npc, 60540032, 1)
    self.sheild_set = true
    self.now_sheild = get_npc_shield(self.npc)
  end
end

function M:on_frame()
  if not self.npc then
    return
  end
  if self.init_sheild_set == false then
    self.now_sheild = get_npc_shield(self.npc)
    self.init_sheild_set = true
  end
  if check_magic(self.npc, 60540031) and self.now_sheild > 0 and not check_magic(self.npc, 60540033) then
    cast_magic(self.npc, self.npc, 60540033, 1)
  elseif self.now_sheild <= 0 and true == self.sheild_set and check_magic(self.npc, 60540033) then
    self.sheild_set = false
    abort_magic_by_id(self.npc, 60540033)
  elseif not check_magic(self.npc, 60540031) and check_magic(self.npc, 60540033) then
    self.sheild_set = false
    abort_magic_by_id(self.npc, 60540033)
  end
end

return M
