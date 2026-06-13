local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if check_magic(npc, 6040003) then
    enable_shadow(self.npc, true)
    cast_skill(self.npc, npc, 20102201, nil, nil)
  end
end

return M
