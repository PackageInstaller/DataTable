local M = Util.create_class()
local time = 0
local interval_time = 0
local ability = 30005
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:after_heal(npc, target, magic_id, heal_val)
  if target == self.npc and 61702051 ~= magic_id then
    time = get_time()
    if time >= interval_time then
      interval_time = time + 3
      cast_magic(self.npc, self.npc, 61702051, level)
    end
  end
end

return M
