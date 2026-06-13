local M = Util.create_class()
local tool = import("common.tool")

function M:on_start()
  self.curr_time = 0
  self.cd = 0.5
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isSkill() and get_magic_kind_num(target, 10) >= 1 and get_npc_time(self.npc) > self.curr_time + self.cd then
    local level = get_ability_level(20014) or 1
    cast_magic(self.npc, self.npc, 61706231, level)
    self.curr_time = get_npc_time(self.npc)
  end
end

function M:_init(npc)
end

return M
