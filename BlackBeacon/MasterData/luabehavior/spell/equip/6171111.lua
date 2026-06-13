local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fanji_times = 0
local damage_missile = 61711910101

function M:on_start()
  self.level = get_ability_level(10009) or 1
  local god = get_god_npc()
  rogueMgr.lasttime_6171111 = get_npc_time(god)
  if self.level > 1 then
    rogueMgr.cd_6171111 = 20
  else
    rogueMgr.cd_6171111 = 25
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(10009) or 1
  local god = get_god_npc()
  rogueMgr.lasttime_6171111 = get_npc_time(god)
  if self.level > 1 then
    rogueMgr.cd_6171111 = 20
  else
    rogueMgr.cd_6171111 = 25
  end
end

function M:after_shield_target(npc, magic_id, shield_value)
  local god = get_god_npc()
  rogueMgr.currtime_6171111 = get_npc_time(god)
  if rogueMgr.currtime_6171111 > rogueMgr.lasttime_6171111 + rogueMgr.cd_6171111 and self.npc == get_come_on_hero() then
    local bool, num = tool:checkMagicToTeam(rogueMgr.shengguang)
    if 0 == num then
      cast_magic(self.npc, self.npc, rogueMgr.shengguang)
      cast_missile3(self.npc, self.npc, nil, nil, damage_missile)
      rogueMgr.lasttime_6171111 = rogueMgr.currtime_6171111
    end
  end
end

function M:on_target_self_magic_end(npc, magic_id, magic_kind, magic_type, is_break)
  if magic_id == rogueMgr.shengguang then
    remove_missile_by_id(damage_missile)
  end
end

function M:_init(npc)
end

return M
