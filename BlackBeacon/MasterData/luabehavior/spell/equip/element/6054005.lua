local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.cd_timer = 0
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if not check_magic(target, 1999040) then
    return
  end
  if 1 ~= damage_sign then
    self.cast_set = true
    self.cd_timer = get_npc_time(self.npc) + 3
    cast_magic(npc, npc, 60540052, 1)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if self.cast_set and 1 == damage_sign and get_npc_time(self.npc) <= self.cd_timer then
    cast_magic(npc, npc, 60540051, 1)
  end
end

function M:on_frame()
  if get_npc_time(self.npc) > self.cd_timer then
    self.cast_set = false
  end
end

return M
