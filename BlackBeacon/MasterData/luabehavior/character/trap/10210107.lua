local M = Util.create_class()

function M:_init(npc)
  self.v_last_be_hit_time = -1
  self.npc = npc
  npc:set_ignore_sync(true)
  self:set_npc_not_beattack_collid_enabled(false)
  self.v_hit_num = 0
  set_npc_floating_text_hud_visible(npc, false)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if target == self.npc and damage_val < 0 and (0 == self.v_hit_num % 2 and 30010630201 == magic_id or 0 ~= self.v_hit_num % 2) then
    local cur_time = get_time()
    if cur_time > self.v_last_be_hit_time + self.npc.v_be_hit_cd or -1 == self.v_last_be_hit_time then
      self.v_last_be_hit_time = cur_time
      self.v_hit_num = self.v_hit_num + 1
      SceneMgr:on_cd_npc_hit(self.npc:get_local_name(), self.v_hit_num)
      self:set_npc_not_beattack_collid_enabled(true)
      Timer:add_timer("set_npc_not_beattack_collid_enabled", self.npc.v_be_hit_cd, function()
        self:set_npc_not_beattack_collid_enabled(false)
      end)
    end
  end
end

function M:set_npc_not_beattack_collid_enabled(is_enable)
  local collider = self.npc:get_collider()
  if collider and not collider:IsNull() then
    collider.enabled = not is_enable
  end
  set_can_searched(self.npc, not is_enable)
  self.npc:set_is_ghost(is_enable)
  self.npc:set_is_air(is_enable)
end

return M
