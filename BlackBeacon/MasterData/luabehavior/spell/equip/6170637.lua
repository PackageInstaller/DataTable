local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if 6170691009 ~= magic_id and self.cast_count > 0 and (1 == get_role_kind(npc) or 5 == get_role_kind(npc)) and check_magic(target, 6170691001) then
    self.count = self.count + 1
    if self.count >= 10 then
      local level = get_ability_level(20023) or 1
      cast_missile3(get_come_on_hero(), get_come_on_hero(), nil, nil, 61706910601, level)
      self.count = 0
      self.cast_count = 0
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 617069101 == skill_id or 617069102 == skill_id or 617069103 == skill_id then
    self.cast_count = 1
  end
end

function M:_init(npc)
  self.cast_count = 0
  self.count = 0
end

return M
