local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    300200201,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200201).CastTime,
    get_skill_cfg(300200201).AfterTime
  }
  self.skill_missile_id = 30020020201
  self.control = 0
  self.hit_fly_npc = nil
  self.hit_tag = false
  self.charge_time = 0
  set_hud_config("3002002_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
end

function M:on_skill_end(npc, skill_id)
end

function M:cast_skill(skill_instant_ID)
  if 0 == self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.control = 1
  end
end

function M:on_frame()
  self:cast_skill(self.skill01)
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  if 2 == self.control then
    active_hud(self.npc, "3002002_bar", "attachpoint", true, "区域时停")
    self.control = 3
  end
  if 3 == self.control then
    local npc_time = get_npc_time(self.npc)
    local energy_now = get_npc_attr(self.npc, 3)
    local energy_max = get_npc_attr(self.npc, 6)
    if energy_now < energy_max and npc_time > self.charge_time then
      cast_magic(self.npc, self.npc, 3002002005, 0)
      self.charge_time = npc_time + 0.1
    end
  end
  CommonMonster.search_target(self, 50, 8)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc or self.hit_tag == true then
    return
  end
  if missile_cfg.Id == 30020030101 then
    abort_skill(self.npc)
    set_can_searched(self.npc, false)
    cast_skill(self.npc, nil, 300200202, nil, nil)
    self.hit_tag = true
    cast_magic(self.npc, self.npc, 3002002005, 0)
    self.control = 2
  elseif missile_cfg.Id == 30020030201 then
    abort_skill(self.npc)
    set_can_searched(self.npc, false)
    cast_skill(self.npc, nil, 300200211, nil, nil)
    self.hit_tag = true
    cast_magic(self.npc, self.npc, 3002002005, 0)
    self.control = 2
  elseif hit_type > 0 then
    cast_magic(self.npc, self.npc, 3002002003, 1)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300200202 == skill_id then
    cast_skill(self.npc, nil, 300200203, nil, nil)
  elseif 300200203 == skill_id then
    cast_skill(self.npc, nil, 300200204, nil, nil)
  elseif 300200204 == skill_id then
    cast_skill(self.npc, nil, 300200205, nil, nil)
  elseif 300200205 == skill_id then
    cast_skill(self.npc, nil, 300200206, nil, nil)
  elseif 300200206 == skill_id then
    create_scene_effect("Fx_T3001010_05", npc:get_pos_vec3(), 0)
    self.npc:on_dead(nil, true)
    remove_npc(npc)
  elseif 300200211 == skill_id then
    cast_skill(self.npc, nil, 300200212, nil, nil)
  elseif 300200212 == skill_id then
    cast_skill(self.npc, nil, 300200213, nil, nil)
  elseif 300200213 == skill_id then
    cast_skill(self.npc, nil, 300200214, nil, nil)
  elseif 300200214 == skill_id then
    cast_skill(self.npc, nil, 300200215, nil, nil)
  elseif 300200215 == skill_id then
    create_scene_effect("Fx_T3001010_05", npc:get_pos_vec3(), 0)
    self.npc:on_dead(nil, true)
    remove_npc(npc)
  end
end

function M:on_missile_begin(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.npc and missile_cfg.Id == self.skill_missile_id then
    self.skill_missile = missile
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc ~= self.npc then
    return
  end
  create_scene_effect("Fx_T3001010_05", npc:get_pos_vec3(), 0)
  self.npc:on_dead(nil, true)
  remove_npc(npc)
end

return M
