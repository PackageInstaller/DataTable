local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(50014) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(50014) or 1
end

function M:on_before_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 5 == get_role_kind(npc) then
    local pos = {}
    pos = get_npc_pos(npc)
    cast_missile3(npc, self.npc, nil, nil, 61708920201, self.level)
  end
end

return M
