local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
end

function M:before_damage(npc, target, magic_id, damage_sign)
  if npc ~= self.npc then
    return
  end
  if get_npc_attr(self.npc, 71) > 0 then
    cast_magic(self.npc, self.npc, 61711381)
  end
end

function M:_init(npc)
end

return M
