local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, true)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.hero = get_come_on_hero()
  self.dropcount = 0
  self.maxdropcount = 1
  self.dropdone = false
end

function M:on_frame()
  if get_sync_var("is_save") then
    self.dropdone = true
  end
  if self.dropcount >= self.maxdropcount and self.dropdone == false then
    self.dropcount = 0
    self.dropdone = true
    set_sync_var("drop", true)
    return
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc and get_sync_var("over") == true then
    self.dropcount = self.dropcount + 1
  end
end

return M
