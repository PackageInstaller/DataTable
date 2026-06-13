local M = Util.create_class()

function M:_init()
  self.MagicStaty = true
  self.ShieldStaty = false
  self.nowTime = 0
  self.intervalTime = 0
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    local hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
    if hp <= 0.3 and self.MagicStaty then
      self.MagicStaty = false
      cast_magic(self.npc, self.npc, 4033120201, 1)
      self.ShieldStaty = true
      self.intervalTime = self.nowTime + 0.5
    end
  end
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
  if self.ShieldStaty and self.nowTime >= self.intervalTime then
    cast_magic(self.npc, self.npc, 4033120202, 1)
    self.intervalTime = self.nowTime + 0.5
    print("有进吗")
    if get_npc_shield(self.npc) <= 0 then
      self.ShieldStaty = false
    end
  end
end

return M
