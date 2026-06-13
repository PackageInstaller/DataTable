local M = Util.create_class()

function M:_init()
  self.hp_set = 0
end

function M:on_frame()
  local now_hp = get_npc_attr(self.npc, 1)
  if is_pass_room() and not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = 9
  end
  if 0 == self.hp_set then
    cast_magic(self.npc, self.npc, 399944, 1)
    cast_magic(self.npc, self.npc, 399945, 1)
    self.hp_set = 1
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc == self.npc then
    return
  end
  if target == self.npc then
    cast_magic(self.npc, npc, 399943, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    remove_npc(self.npc)
  end
end

return M
