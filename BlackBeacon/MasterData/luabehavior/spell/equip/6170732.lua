local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local curr_time = 0
local cd = 0

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if get_npc_time(self.npc) > curr_time + cd and skAct and skAct:deemAtk() then
    local cur_hp = get_npc_attr(self.npc, 1)
    local max_hp = get_npc_attr(self.npc, 4)
    local percent = cur_hp / max_hp
    if percent < 0.4 then
      local level = get_ability_level(40018) or 1
      cast_magic(self.npc, self.npc, 61707321, level)
      curr_time = get_npc_time(self.npc)
      cd = 1
    end
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
