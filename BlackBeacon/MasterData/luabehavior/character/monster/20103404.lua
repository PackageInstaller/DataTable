local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local tool = import("common.monster_tool")

function M:_init(npc)
  Base._init(self)
  self.boom = 2010340301
  self.skill1 = {
    2010340302,
    0,
    0,
    0,
    99,
    get_skill_cfg(2010340302).CastTime,
    get_skill_cfg(2010340302).AfterTime,
    0
  }
  self.boom_hit = 2010340302
  self.allow_boom = 0
  self.allow_boom_time = 0
  self.boom_hit_time = 0
  self.control = 0
  self.born_skill = 2010340303
  self.hit = 0
end

function M:on_start()
  enable_shadow(self.npc, false)
  set_npc_hp_visible(self.npc, false)
  cast_magic(self.npc, self.npc, 20103401001, 1)
  cast_magic(self.npc, self.npc, 20103403063, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if 30010390201 == missile then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  local now_time = get_npc_time(self.npc)
  if missile_cfg.Id == 201034011201 and now_time >= self.boom_hit_time then
    self.hit = 1
    cast_skill(self.npc, self.npc, self.skill1[1])
    self.allow_boom = 8
  end
  if missile_cfg.Id == 201034010401 or missile_cfg.Id == 201034011001 then
    cast_skill(self.npc, self.npc, self.skill1[1])
    self.allow_boom = 8
    self.hit = 1
  end
  if missile_cfg.Id == 30010390301 then
    cast_magic(self.npc, self.npc, 20103401034, 1)
    remove_npc(self.npc)
  end
end

function M:on_skill_end(npc, skill_id)
  local now_time = get_npc_time(self.npc)
end

function M:on_frame()
  if 9 == self.allow_boom then
    remove_npc(self.npc)
  end
  if not check_magic(self.npc, 20103403063) then
    cast_magic(self.npc, self.npc, 20103403063, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
