local M = Util.create_class()
local team_hero_list = {}
local ability = 10005
local level = 1
local now_time = 0
local interval_Time = 0

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == team_hero_list[1] or hit_target == team_hero_list[2] or hit_target == team_hero_list[3] then
    for k, v in pairs(team_hero_list) do
      if npc == v then
        return
      end
    end
    local shield_hp1 = get_npc_shield(hit_target)
    local now_time = get_time()
    if shield_hp1 > 0 and now_time >= interval_Time then
      interval_Time = now_time + 1
      cast_magic(hit_target, npc, 61700051, level)
    end
  end
end

return M
