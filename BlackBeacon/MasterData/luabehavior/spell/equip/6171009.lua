local M = Util.create_class()
local tool = import("common.tool")
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}
local hero = get_come_on_hero()
local per1, per2 = tool:randByTime(0.1, 0.15)

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(60019) or 1
  if self.level > 1 then
    per1, per2 = tool:randByTime(0.1, 0.3)
  end
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(60019) or 1
  if self.level > 1 then
    per1, per2 = tool:randByTime(0.1, 0.3)
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skact = info and info.skAct
  if skact and skact:deemSkill() and is_crit then
    local num = get_magic_kind_num(self.npc, 61710)
    if 0 == num and per2 then
      cast_magic(self.npc, self.npc, 61710021, 0)
    end
  end
end

return M
