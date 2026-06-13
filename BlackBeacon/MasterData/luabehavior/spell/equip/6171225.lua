local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  rogueMgr.magic_6171225 = true
  self.last_time = 0
  self.curr_time = get_npc_time(self.npc)
  self.cd = 1
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self.level = get_ability_level(70008)
  if self.level > 1 then
    self.after_damage = self.after_damage_A
  end
end

function M:after_damage_target_A(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time > self.last_time + self.cd then
    local info = missile and get_missile_skill_action_info(missile)
    local skAct = info and info.skAct
    if not skAct or not skAct:isAtk() then
      return
    end
    local per1, per2 = tool:randByTime(1, 0.2)
    if per2 then
      rogueMgr.random_cast_fragment(rogueMgr, self.npc, 1, 3)
      self.last_time = self.curr_time
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(70008)
  if self.level > 1 then
    self.after_damage_target = self.after_damage_target_A
    print(114514)
  end
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6171225)
  if 0 == num then
    rogueMgr.magic_6171225 = false
  end
end

return M
