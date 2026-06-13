local M = Util.create_class()

function M:_init()
  self.intervalTime = 0
  self.nowTime = 0
  self.addMagic = false
end

function M:on_start()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if npc == self.npc and self.addMagic and 4 == damage_sign then
    self.addMagic = false
    self.intervalTime = get_npc_time(self.npc) + 2.5
    cast_magic(self.npc, self.npc, 4033520101, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    self.addMagic = false
    self.intervalTime = get_npc_time(self.npc) + 2.5
  end
end

function M:on_frame()
  if not self.addMagic then
    self.nowTime = get_npc_time(self.npc)
    if self.nowTime >= self.intervalTime then
      self.addMagic = true
    end
  end
end

return M
