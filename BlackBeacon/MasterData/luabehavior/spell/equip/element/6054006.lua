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
  cast_magic(npc, target, 60540062, 1)
end

return M
