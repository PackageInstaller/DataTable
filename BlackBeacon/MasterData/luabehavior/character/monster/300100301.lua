local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.Skill01 = {
    20120301,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(20120301).CastTime,
    get_skill_cfg(20120301).AfterTime
  }
  self.AllowCastSkill = true
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  set_npc_hp_visible(self.npc, false)
end

function M:skill_main_logic()
  if self.AllowCastSkill == true then
    self.AllowCastSkill = false
    cast_skill(self.npc, self.target, 20120301)
  end
end

function M:on_frame()
  self:skill_main_logic()
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

return M
