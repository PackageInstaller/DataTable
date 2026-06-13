local M = Util.create_class()
local is_recover = true
local ability = 30003
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 2 == get_skill_cfg(skill_id).SkillType then
    is_recover = true
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if is_recover and npc == self.npc and 2 == get_skill_cfg(skill_id).SkillType then
    is_recover = false
    cast_magic(self.npc, self.npc, 61702031, level)
  end
end

return M
