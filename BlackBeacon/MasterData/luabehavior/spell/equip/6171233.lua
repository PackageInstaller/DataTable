local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_start()
  tool:castMagicToTeam(rogueMgr.fragment_control)
  self:get_level()
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if target ~= self.npc or self.npc ~= get_come_on_hero() then
    return
  end
  if magic_id ~= rogueMgr.fragment_magic then
    return
  end
  local hero1 = get_scene_hero_by_poskey(21)
  local hero2 = get_scene_hero_by_poskey(22)
  if 1 == self.level then
    local per1, per2 = tool:randByTime(0.05, 0.5)
    print(per1, per2)
    if per2 then
      cast_magic(hero1, hero1, magic_id)
    else
      cast_magic(hero2, hero2, magic_id)
    end
  else
    cast_magic(hero1, hero1, magic_id)
    cast_magic(hero2, hero2, magic_id)
  end
end

function M:on_room_change(npc)
  self:get_level()
end

function M:get_level()
  self.level = get_ability_level(70011)
end

return M
