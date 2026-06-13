local M = Util.create_class()
local team_hero_list = {}
local level = 1
local revive = true
local rebornMgrBase = import("character.base.base_rebornManager")
M.ability = 30006

function M:getLevel()
  return get_ability_level(M.ability) or 0
end

function M:_init(npc)
end

function M:on_start(npc)
  rebornMgrBase:add_shared_chance(61702061, nil, self, self.getLevel)
end

function M:on_room_change(npc)
  rebornMgrBase:add_shared_chance(61702061, nil, self, self.getLevel)
end

return M
