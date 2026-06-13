local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    300200601,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200601).CastTime,
    get_skill_cfg(300200601).AfterTime
  }
  self.skill_missile_id = 30020060201
  self.control = 0
  self.hit_fly_npc = nil
  self.hit_tag = 0
  self.charge_time = 0
  set_hud_config("3002006_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  self.element_set = nil
end

function M:on_start()
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
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
    active_hud(self.npc, "3002006_bar", "attachpoint", true, "聚怪")
    self.control = 3
  end
  if 3 == self.control then
    local npc_time = get_npc_time(self.npc)
    local energy_now = get_npc_attr(self.npc, 3)
    local energy_max = get_npc_attr(self.npc, 6)
    if energy_now < energy_max and npc_time > self.charge_time then
      cast_magic(self.npc, self.npc, 3002006003, 0)
      self.charge_time = npc_time + 0.1
    end
  end
end

function M:on_skill_begin(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300200603 == skill_id then
  elseif 300200604 == skill_id then
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc or self.hit_tag > 0 then
    return
  end
  cast_magic(self.npc, self.npc, 3002002003, 1)
  if missile_cfg.InteracteType == "Light" then
    self.element_set = 2
  else
    self.element_set = 1
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300200602 == skill_id then
    cast_magic(self.npc, self.npc, 399931, 1)
    cast_magic(self.npc, self.npc, 399932, 1)
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 3001022003, 1)
    self.control = 2
    if 1 == self.element_set then
      cast_skill(self.npc, nil, 300200603, nil, nil)
    elseif 2 == self.element_set then
      cast_skill(self.npc, nil, 300200604, nil, nil)
    end
  elseif 300200603 == skill_id or 300200604 == skill_id then
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
  if npc ~= self.npc then
    return
  end
  abort_skill(self.npc)
  set_can_searched(self.npc, false)
  cast_magic(self.npc, self.npc, 3002006003, 0)
  cast_skill(self.npc, nil, 300200602, nil, nil)
end

return M
