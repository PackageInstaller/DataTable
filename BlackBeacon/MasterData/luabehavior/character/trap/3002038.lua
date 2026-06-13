local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  local can_searched = true
  can_searched = get_sync_var("set_can_searched")
  set_can_searched(npc, can_searched)
  self.skill_born = 300203801
  self.skill_die = 300203802
  self.skill_normal_die = 300203803
  self.stop = false
  self.retreat_time = 6
  self.retreat_time = get_sync_var("retreat_time")
  self.start_time = get_npc_time(npc)
  cast_skill(npc, nil, self.skill_born)
end

function M:on_frame()
  if get_npc_time(self.npc) >= self.start_time + self.retreat_time and not self.stop then
    self.stop = true
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill_normal_die)
  end
end

function M:after_damage_self(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self.stop = true
  self.die = true
  abort_skill(self.npc)
  cast_skill(self.npc, nil, self.skill_die)
  cast_magic(self.npc, self.npc, 10001001, 1)
  set_npc_dead(self.npc, nil, false)
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == self.skill_die then
    remove_npc(self.npc)
  elseif skill_id == self.skill_normal_die and not self.die then
    remove_npc(self.npc)
  end
end

return M
