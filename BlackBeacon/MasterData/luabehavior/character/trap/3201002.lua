local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    320100201,
    0,
    0,
    0,
    0,
    get_skill_cfg(320100201).CastTime,
    get_skill_cfg(320100201).AfterTime
  }
  self.control = 0
  self.hit_fly_npc = nil
  self.hit_tag = false
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc then
    if 320100103 == skill_id then
      cast_skill(self.npc, nil, 320100104, nil, nil)
    end
    if 320100104 == skill_id then
      cast_skill(self.npc, nil, 320100103, nil, nil)
    end
  end
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
  CommonMonster.search_target(self, 50, 8)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and (1 == missile_cfg.MissileTypeTag or 2 == missile_cfg.MissileTypeTag) and self.hit_tag == false then
    abort_skill(self.npc)
    set_can_searched(self.npc, false)
    cast_skill(self.npc, nil, 320100202, nil, nil)
    self.hit_tag = true
    cast_magic(self.npc, self.target, 320104, 0)
  end
end

function M:on_skill_end(npc, skill_id)
  if 320100202 == skill_id then
    create_scene_effect("Fx_T3001010_05", npc:get_pos_vec3(), 0)
    self.npc:on_dead(nil, true)
    remove_npc(npc)
  end
end

return M
