local M = Util.create_class()
local tool = import("common.tool")
local rebornMgr = import("character.base.base_rebornManager")

function M:_init(npc)
  rebornMgr:add_shared_chance(61707341)
  self.times = 0
end

function M:on_magic_begin(npc, target, magicId)
  if target ~= get_come_on_hero() then
    return
  end
  if 61707341 == magicId then
    local level = get_ability_level(40020) or 1
    cast_magic(target, target, 61707342, level)
    cast_magic(target, target, 61707343)
    self.times = self.times + 1
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 61707343 ~= magic_id then
    return
  end
  if self.times < 3 then
    local level = get_ability_level(40020) or 1
    cast_magic(target, target, 61707342, level)
    cast_magic(target, target, 61707343)
    self.times = self.times + 1
  end
end

function M:on_fate_book_battle_start()
  rebornMgr:add_shared_chance(61707341)
  self.times = 0
end

return M
