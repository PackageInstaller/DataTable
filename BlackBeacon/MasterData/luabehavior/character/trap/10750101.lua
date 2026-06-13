local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  cast_magic(npc, npc, 4032905, 1)
  set_npc_floating_text_hud_visible(npc, false)
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  self.skill = 300106303
  self.mark = 3000001
  self.loop = false
end

function M:on_start()
  cast_magic(self.npc, self.npc, 2010050117, 1)
  cast_magic(self.npc, self.npc, 2010050113, 1)
  cast_magic(self.npc, self.npc, 399932, 1)
  cast_magic(self.npc, self.npc, 399931, 1)
  cast_magic(self.npc, self.npc, 30010570102, 1)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  if check_magic(self.npc, self.mark) then
    self.loop = true
  end
end

function M:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile, part_npc)
  if 300106301 ~= skill_id and not check_magic(self.npc, 1075010102) and not check_magic(self.npc, 399933) then
    cast_magic(self.npc, self.npc, 1075010102, 1)
    cast_magic(self.npc, self.npc, 1075010103, 1)
    if get_cur_room_id() == 1070401 and 1 == get_sync_var("music_tips") then
      on_level_counter_add("Music1", 0)
    elseif get_cur_room_id() == 1070401 and 2 == get_sync_var("music_tips") then
      on_level_counter_add("Music2", 0)
    elseif get_cur_room_id() == 1070401 and 3 == get_sync_var("music_tips") then
      on_level_counter_add("Music3", 0)
    end
  end
end

return M
