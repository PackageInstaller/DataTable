local M = Util.create_class()

function M:_init()
  self.time = 0
  self.control = 0
end

function M:creat_magic(owner, atk_target)
  if check_magic(atk_target, 1999030) then
    cast_magic(owner, owner, 60530021, 1)
    cast_magic(owner, atk_target, 60530022, 1)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc and check_magic(npc, 1999030) and math.random(1, 9) <= 9 then
    self:creat_magic(target, npc)
    self.control = 1
  end
end

function M:on_frame()
end

return M
