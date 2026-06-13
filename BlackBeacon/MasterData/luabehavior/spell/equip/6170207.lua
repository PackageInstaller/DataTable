local M = Util.create_class()
local time = 0
local interval_time = 0
local ability = 30007
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:after_heal(npc, target, magic_id, heal_val)
  if target == self.npc and self.npc == get_come_on_hero() then
    time = get_time()
    if time >= interval_time then
      interval_time = time + 5
      cast_magic(self.npc, self.npc, 61702071, level)
    end
  end
end

return M
