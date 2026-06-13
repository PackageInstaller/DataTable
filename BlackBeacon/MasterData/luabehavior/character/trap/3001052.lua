local Base = import("character.base.base_monster")
local M = Util.create_class()
local CommonMonster = import("common.monster")

function M:_init(npc)
  self.appending_target = npc
  self.monster = 20100901
  self.control = 0
  self.add_npc2_timer = 0
  set_hud_config("3001052_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
end

function M:cast_skill(skill)
  active_hud(self.npc, "3001052_bar", "attachpoint", true)
  local nowtime = get_time()
  local target_pos = get_npc_offset_position(self.appending_target, nil, 0, 5)
  if 0 == self.control then
    cast_magic(self.npc, self.npc, 3001036002, 1)
    local npc_time = get_npc_time(self.npc)
    local energy_now = get_npc_attr(self.npc, 3)
    local energy_max = get_npc_attr(self.npc, 6)
    if energy_now >= energy_max and npc_time > self.add_npc2_timer then
      add_npc2(2, self.monster, target_pos.x, target_pos.z - 0.5, 0, 0, 2, 0)
      self.add_npc2_timer = npc_time + 30
      cast_magic(self.npc, self.npc, 3001052001, 1)
      self.control = 99
    end
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  self:cast_skill()
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  self:skill_main_logic()
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
