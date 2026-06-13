local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill02 = {
    2010150102,
    7,
    3,
    0,
    4,
    get_skill_cfg(20100902).CastTime,
    get_skill_cfg(20100902).AfterTime,
    0
  }
  self.skill01 = {
    2010150101,
    10,
    1.5,
    0,
    2,
    get_skill_cfg(20100901).CastTime,
    get_skill_cfg(20100901).AfterTime,
    0
  }
  self.camp_skill_list = {
    self.skill01,
    self.skill02
  }
  self.counter_reatk_skill = "反击技能ID"
  self.monster_type = 1
  self.born_skill = "出生技能ID"
  self.stun_info = {set = false, time = 0}
  self.die_skill = "死亡技能ID"
end

function M:on_skill_begin(npc, skill_id)
  Base.on_skill_start(self, npc, skill_id)
end

function M:on_skill_hit(npc, skill_id)
  Base.on_skill_hit(self, npc, skill_id)
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
end

function M:skill_cast(skill_instant)
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 1.5 + 2
  if CommonMonster.skill_cast_condition(self, skill_instant, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
  return true
end

function M:skill_main_logic()
  if CommonMonster.skill_main_condition(self) then
    return
  end
  if get_target_angel(self.npc, self.target, true) <= -60 and get_target_angel(self.npc, self.target, true) >= 60 then
    return
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 4)
  CommonMonster.monster_on_frame(self)
  CommonMonster.wander_main_logic(self, 1.5, 3.5, 1)
  self:skill_main_logic()
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
