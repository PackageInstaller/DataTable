local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, true)
  set_npc_floating_text_hud_visible(npc, false)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and missile_cfg.Id == 30010390201 then
    set_sceneobj_visible_save_state("scene_timeline_damen3", true, true)
    set_sceneobj_visible_save_state("/Root/Change_/Change_dusk/Level3/Cube (6)", true, true)
    set_sceneobj_visible_save_state("Change_/Change_dusk/Level3/Damen/sc01_bld_06a1_pre/sc01_bld_06a1_02_mod(MISSILE_AND_CHAR_BLOCK)", true, true)
    set_sync_var("damen3", true)
    set_scene_tips(100185, false, {})
    remove_npc(self.npc)
  end
end

function M:on_frame()
  if check_magic(self.npc, Const.LOCK_ON_TAG) and get_god_skill_level() >= 2 and not self.tips then
    set_scene_tips(100185, true, {})
    self.tips = true
  elseif not check_magic(self.npc, Const.LOCK_ON_TAG) and self.tips then
    set_scene_tips(100185, false, {})
    self.tips = false
  end
end

return M
