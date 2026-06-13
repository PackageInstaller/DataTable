local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, true)
  set_npc_floating_text_hud_visible(npc, false)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    set_sceneobj_visible_save_state("Statemesh/home10/bridge_1/bridge_1_on", true, true)
    remove_npc(self.npc)
  end
end

return M
