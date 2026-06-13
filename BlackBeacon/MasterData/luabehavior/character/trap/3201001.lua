local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    320100101,
    0,
    0,
    0,
    0,
    get_skill_cfg(320100101).CastTime,
    get_skill_cfg(320100101).AfterTime
  }
  self.skill03 = {
    320100103,
    0,
    0,
    0,
    0,
    get_skill_cfg(320100103).CastTime,
    get_skill_cfg(320100103).AfterTime
  }
  self.skill04 = {
    320100104,
    0,
    0,
    0,
    0,
    get_skill_cfg(320100104).CastTime,
    get_skill_cfg(320100104).AfterTime
  }
  self.control = 0
  self.hit_fly_npc = nil
  set_can_searched(npc, false)
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
  if self.hit_fly_npc and check_npc_status(self.hit_fly_npc, 10) and not check_magic(self.hit_fly_npc, 320101) then
    cast_magic(self.hit_fly_npc, self.hit_fly_npc, 320101, 0)
    self.hit_fly_npc = nil
  end
  CommonMonster.search_target(self, 50, 8)
  if self.target and check_magic(self.target, 320102) and is_cast_skill_time(self.npc, 320100101) then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, 320100103, nil, nil)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and (320100101 == skill_id or 320100103 == skill_id or 320100104 == skill_id) and (check_npc_status(hit_target, 2) or check_npc_status(hit_target, 11)) then
    cast_missile(self.npc, hit_target, nil, nil, 32010010201, 0)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc == self.npc and 100403 == magic_id then
    self.hit_fly_npc = target
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == self.npc and m1_cfg.Id == 32010010101 and (m2_cfg.Id == 10010044401 or m2_cfg.Id == 10010044403) then
    local hit_npc = search_npc(self.npc, 2, 10, 1004067, 1)
    if hit_npc then
      abort_magic_by_id(hit_npc, 1004067, 1)
    end
  end
end

return M
