local M = Util.create_class()
CD = 0

function M:_init(npc)
end

function M:on_frame()
  self:change_cd()
end

function M:change_cd()
  if 1 == CD then
    return
  end
  local hero_one = get_scene_hero_by_poskey(21)
  local hero_two = get_scene_hero_by_poskey(22)
  change_skill_cd(self.npc, 18, 2, 6070010)
  change_skill_cd(self.npc, 18, 2, 6070011)
  if hero_one then
    change_skill_cd(hero_one, 18, 2, 6070010)
    change_skill_cd(hero_one, 18, 2, 6070011)
  end
  if hero_two then
    change_skill_cd(hero_two, 18, 2, 6070010)
    change_skill_cd(hero_two, 18, 2, 6070011)
  end
  CD = 1
end

return M
