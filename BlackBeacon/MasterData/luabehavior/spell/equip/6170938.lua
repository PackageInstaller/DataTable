local M = Util.create_class()
local tool = import("common.tool")
local is_niubi = false

function M:on_start()
end

function M:after_damage_self(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if (2 == get_role_kind(npc) or 3 == get_role_kind(npc) or 4 == get_role_kind(npc)) and not check_magic(npc, 61709381) then
    local level = get_ability_level(30024) or 1
    if 1 == level then
      change_abnormal_flag_count(npc, 2, 1)
    else
      change_abnormal_flag_count(npc, 2, 2)
      cast_magic(self.npc, npc, 61709381)
    end
  end
end

function M:_init(npc)
end

return M
