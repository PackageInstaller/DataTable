local M = Util.create_class()
local tool = import("common.tool")
local rolebase = import("character.base.role_base")
local skillAction = import("character.base.base_role_skillAction")
local hero = get_come_on_hero()
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}
local per1, per2 = tool:randByTime(0.1, 0.05)

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(60009) or 1
  if self.level > 1 then
    per1, per2 = tool:randByTime(0.1, 0.1)
  end
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(60009) or 1
  if self.level > 1 then
    per1, per2 = tool:randByTime(0.1, 0.1)
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct then
    return
  end
  if skAct:deemSkill() and get_magic_num(hero, 61710011) < 5 then
    local num = 5 - get_magic_num(hero, 61710011)
    if per2 then
      if 0 == num then
        cast_magic(self.npc, hero, 61710011, 0)
      elseif num >= 1 then
        for i = 1, num do
          cast_magic(self.npc, hero, 61710011, 0)
        end
      end
    else
      cast_magic(self.npc, hero, 61710011, 0)
    end
  end
end

return M
