local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:team_add_magic(magic_id)
  if magic_id then
    for key, value in pairs(self.team_hero_list) do
      if value then
        cast_magic(self.npc, value, magic_id)
      end
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  team_add_magic(1012020801)
end

return M
