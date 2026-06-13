local M = Util.create_class()

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  set_sync_var("statue_count", 0)
  set_hud_config("3001071_bar", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 1, 4)
  self.skill1 = 300107002
end

function M:on_npc_born(npc)
  change_missile_config(30010700202, "OffsetY", 0.75, 0)
  change_missile_config(30010700202, "EffectScale", 0.75, 0)
  cast_skill(self.npc, nil, self.skill1)
  active_hud(self.npc, "3001071_bar", "T1", true, "完整度")
end

function M:on_self_before_npc_hp_zero()
  local facePos = get_npc_offset_position(self.npc, nil, 0, 3)
  create_scene_effect("Fx_Common_Death", self.npc:get_pos_vec3(), 2, nil, facePos)
  remove_npc(self.npc)
  set_sync_var("statue_count", get_sync_var("statue_count") + 1)
  if 2 == get_sync_var("statue_count") then
    set_sync_var("statue_break", true)
  end
end

return M
