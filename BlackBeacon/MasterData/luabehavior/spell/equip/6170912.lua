local M = Util.create_class()
local tool = import("common.tool")
local is_niubi = false
local element_aborn_magic = {
  [2] = 61706251,
  [3] = 61706252,
  [4] = 61706253,
  [5] = 61706254,
  [6] = 61706255
}
local cd_magic = 61709121

function M:on_room_change(npc)
  self.level = get_ability_level(30010) or 1
  if self.level > 1 then
    cd_magic = 61709122
  end
end

function M:on_start()
  self.level = get_ability_level(30010) or 1
  if self.level > 1 then
    cd_magic = 61709122
  end
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if magic_kind and (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) and magic_kind[61709] and not check_magic(target, cd_magic) then
    cast_magic(self.npc, target, cd_magic)
    local numbers = {}
    for i = 2, 6 do
      table.insert(numbers, i)
    end
    for i = #numbers, 2, -1 do
      local j = math.random(i)
      numbers[i], numbers[j] = numbers[j], numbers[i]
    end
    local chosen = {}
    for i = 1, 3 do
      table.insert(chosen, numbers[i])
    end
    for i = 1, 3 do
      change_abnormal_flag_count(target, chosen[i], 1)
    end
  end
end

function M:_init(npc)
end

return M
