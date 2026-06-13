local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if self.npc == get_come_on_hero() and npc ~= self.npc then
    cast_magic(self.npc, self.npc, rogueMgr.baojun)
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:deemAtk() and check_magic(self.npc, rogueMgr.baojun) and check_magic(self.npc, rogueMgr.kuangnu) and not check_magic(self.npc, 61707231) then
    local level = get_ability_level(40014) or 1
    cast_magic(self.npc, self.npc, 61707231, level)
  end
end

return M
