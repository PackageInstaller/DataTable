local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if math.random(1, 100) <= 10 then
  else
    return
  end
  if check_magic(target, 1999020) and self.cast_set == false and 1 ~= damage_sign then
    self.target = target
    self.cast_set = true
    cast_magic(self.npc, self.npc, 60520051, 1)
    cast_magic(self.npc, self.target, 60520052, 1)
  end
end

function M:on_frame()
  if not check_magic(self.npc, 60520051) and self.cast_set == true then
    self.cast_set = false
  end
end

return M
