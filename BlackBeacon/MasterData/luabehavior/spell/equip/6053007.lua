local M = Util.create_class()

function M:_init()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if not check_magic(target, 1999030) then
    return
  end
  cast_magic(target, target, 60530071, 1)
  cast_magic(target, target, 60530072, 1)
end

return M
