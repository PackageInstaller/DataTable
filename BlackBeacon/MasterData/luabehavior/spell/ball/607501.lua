local M = Util.create_class()

function M:_init()
  self.use = 1
  self.npc1 = nil
  self.npc2 = nil
  self.npc3 = nil
end

function M:on_start()
  if get_come_on_hero() then
    self.npc1 = get_come_on_hero()
  end
  if get_scene_hero_by_poskey(21) then
    self.npc2 = get_scene_hero_by_poskey(21)
  end
  if get_scene_hero_by_poskey(22) then
    self.npc3 = get_scene_hero_by_poskey(22)
  end
end

function M:on_before_npc_hp_zero(npc)
  if 0 == self.use then
    return
  end
  if self.npc1 and npc == self.npc1 then
    cast_magic(self.npc1, self.npc1, 6020017, 1)
    self.use = 0
    return
  end
  if self.npc2 and npc == self.npc2 then
    cast_magic(self.npc1, self.npc1, 6020017, 1)
    self.use = 0
    return
  end
  if self.npc3 and npc == self.npc3 then
    cast_magic(self.npc1, self.npc1, 6020017, 1)
    self.use = 0
    return
  end
end

return M
