local M = Util.create_class()

function M:_init()
end

function M:on_skill_begin(npc, skill_id)
  if 2 == get_skill_cfg(skill_id).SkillType then
    cast_magic(self.npc, self.npc, 6021010, 1)
    cast_magic(self.npc, self.npc, 6021011, 1)
  end
end

return M
