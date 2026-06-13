local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.last_time = 0
  self.curr_time = get_npc_time(self.npc)
  self.cd = 1
  self:get_level()
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if get_magic_num(self.npc, rogueMgr.fragment_magic) > 0 then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct then
    return
  end
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time <= self.last_time + self.cd then
    return
  end
  local per1, per2 = tool:randByTime(1, self.possibility)
  if per2 then
    rogueMgr.random_cast_fragment(rogueMgr, self.npc, 1, 3)
    self.last_time = self.curr_time
  end
end

function M:on_room_change(npc)
  self:get_level()
end

function M:get_level()
  self.level = get_ability_level(70010)
  if self.level > 1 then
    self.possibility = 0.2
  else
    self.possibility = 0.3
  end
end

return M
