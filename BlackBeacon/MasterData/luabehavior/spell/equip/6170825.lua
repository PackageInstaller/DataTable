local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local last_coin = get_fate_book_coin_count()

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(50016) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(50016) or 1
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and not check_magic(self.npc, 61708251) then
    local curr_coin = get_fate_book_coin_count()
    local earn_coin = curr_coin - last_coin
    local level = 0
    if earn_coin >= 1 then
      if self.level and self.level > 1 then
        level = 6
      else
        level = self:calculate_Value(earn_coin)
      end
      cast_magic(self.npc, self.npc, 61708251, level)
      last_coin = curr_coin
    end
  end
end

function M:on_fate_book_battle_start()
  last_coin = get_fate_book_coin_count()
end

function M:calculate_Value(num)
  if num <= 10 then
    return 1
  elseif num >= 50 then
    return 6
  else
    local diff = num - 10
    local increment = math.ceil(diff / 10)
    return 1 + increment
  end
end

return M
