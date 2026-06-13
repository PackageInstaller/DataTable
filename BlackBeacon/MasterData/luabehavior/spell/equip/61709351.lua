local M = Util.create_class()
local tool = import("common.tool")
local CD = 3
local current_time = 0

function M:after_heal(npc, target, magic_id, heal_val)
  if target ~= get_come_on_hero() then
    return
  end
  if get_npc_time(get_come_on_hero()) > current_time + CD then
    local hero = get_come_on_hero()
    cast_missile3(hero, hero, nil, nil, 61709910102)
    current_time = get_npc_time(hero)
  end
end

function M:on_start()
end

function M:_init(npc)
end

return M
