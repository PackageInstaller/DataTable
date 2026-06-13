local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.magic_set = 0
  self.timer_set = 0
  self.blooding_set = 0
  self.over_timer = 0
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65003911) then
    cast_magic(self.npc, self.hero_one, 65003911, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65003911) then
    cast_magic(self.npc, self.hero_two, 65003911, 0)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if npc ~= self.npc then
    return
  end
  if get_npc_attr(self.npc, 1) >= get_npc_attr(self.npc, 4) * 0.3 then
    return
  elseif target == self.npc or target == self.hero_one or target == self.hero_two then
    return
  else
    local value = math.abs(damage_val)
    cast_magic(self.npc, self.npc, 65003913, math.max(math.min(value, 300), 1))
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) < get_npc_attr(self.npc, 4) * 0.3 then
    return
  else
    if 0 == self.timer_set then
      self.over_timer = get_npc_time(self.npc) + 1
      self.timer_set = 1
    end
    local now_time = get_npc_time(self.npc)
    if now_time > self.over_timer and 1 == self.timer_set then
      self.over_timer = now_time + 1
      self.blooding_set = self.blooding_set + 1
      cast_magic(self.npc, self.npc, 65003912, 1)
    end
  end
end

return M
