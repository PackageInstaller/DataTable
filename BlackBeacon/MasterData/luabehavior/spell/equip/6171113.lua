local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fanji_times = 0

function M:on_start()
  self.curr_time = 0
  self.cd = 0.5
  self.level = get_ability_level(10011) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10011) or 1
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if kind < 2 or kind > 4 then
    return
  end
  if get_npc_time(self.npc) > self.curr_time + self.cd and magic_id == rogueMgr.fanji then
    if math.random() < 0.5 then
      if check_element_ab_state(target, 5) then
        cast_magic(self.npc, target, 61711131, self.level)
      end
    elseif check_element_ab_state(target, 6) then
      cast_magic(self.npc, target, 61711132, self.level)
    end
    self.curr_time = get_npc_time(self.npc)
  end
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 6 == element then
    cast_missile_new(self.npc, self.npc, nil, nil, 61711910401)
    cast_missile_new(self.npc, self.npc, nil, nil, 61711910402)
    if get_magic_num(self.npc, 61711222) < 5 then
      tool:castMagicToTeam(61711222)
    end
  elseif 5 == element then
    cast_missile_new(self.npc, self.npc, nil, nil, 61711910403)
    cast_missile_new(self.npc, self.npc, nil, nil, 61711910404)
    if get_magic_num(self.npc, 61711212) < 5 then
      tool:castMagicToTeam(61711212)
    end
  end
end

function M:on_room_pass(room_id)
  tool:abortMagicToTeam(61711212)
  tool:abortMagicToTeam(61711222)
end

function M:_init(npc)
end

return M
