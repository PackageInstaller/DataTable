local M = Util.create_class()
local tool = import("common.tool")

function M:on_start()
  cast_magic(self.npc, self.npc, 6170911)
  cast_magic(self.npc, self.npc, 6170912)
  cast_magic(self.npc, self.npc, 6170913)
  cast_magic(self.npc, self.npc, 6170921)
  cast_magic(self.npc, self.npc, 6170922)
  cast_magic(self.npc, self.npc, 6170923)
  cast_magic(self.npc, self.npc, 6170931)
  cast_magic(self.npc, self.npc, 6170932)
  cast_magic(self.npc, self.npc, 6170933)
  cast_magic(self.npc, self.npc, 6170935)
end

function M:_init(npc)
end

return M
