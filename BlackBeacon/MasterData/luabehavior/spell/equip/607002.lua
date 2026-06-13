local M = Util.create_class()

function M:_init(npc)
  self.duration = 0
  self.magic_num = 0
end

function M:on_frame()
  self:before_damage()
  self:magic_level()
  self:check()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc and self.magic_num < 10 then
    cast_magic(self.npc, target, 6070020, 1)
    self.magic_num = self.magic_num + 1
  end
end

function M:magic_level()
  if 10 == self.magic_num then
    self.magic_num = 11
  end
end

function M:check()
  if not check_magic(self.npc, 6070020) then
    self.magic_num = 0
  end
end

return M
