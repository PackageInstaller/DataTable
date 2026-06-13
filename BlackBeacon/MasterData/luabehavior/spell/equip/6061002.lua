local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, atk_target)
  if check_magic(atk_target, 1999010) then
    cast_magic(owner, owner, 60610021, 1)
  end
  if check_magic(atk_target, 1999020) then
    cast_magic(owner, owner, 60610021, 1)
  end
  if check_magic(atk_target, 1999030) then
    cast_magic(owner, owner, 60610021, 1)
  end
  if check_magic(atk_target, 1999040) then
    cast_magic(owner, owner, 60610021, 1)
  end
  if check_magic(atk_target, 1999050) then
    cast_magic(owner, owner, 60610021, 1)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc == get_come_on_hero() and get_npc_time(npc) >= self.time then
    self:creat_magic(npc, target)
    self.time = get_npc_time(npc) + 0.25
  end
end

function M:on_frame()
end

return M
