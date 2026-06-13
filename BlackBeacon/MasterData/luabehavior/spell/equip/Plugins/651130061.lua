local M = Util.create_class()
local tool = import("common.tool")
local team = tool.team.npc

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651130061)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and (4 == skill_type or 5 == skill_type) then
    cast_magic(self.npc, self.npc, 651130062, self.level)
    if get_magic_num(self.npc, 651130062) >= 4 then
      cast_magic(self.npc, self.npc, 651130063, self.level)
    end
  end
end

return M
