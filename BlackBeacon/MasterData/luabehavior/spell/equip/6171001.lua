local M = Util.create_class()
local tool = import("common.tool")
local hero = get_come_on_hero()
local level = get_god_skill_level() or 1

function M:_init(npc)
  self.Golden18_per_up = 0
  self.is_6171091 = false
end

function M:on_start()
  self:get_level()
  if check_magic(self.npc, 6171018) then
    self.level = get_ability_level(60011) or 1
    if 1 == self.level then
      self.Golden18_per_up = 0.05
    elseif self.level > 1 then
      self.Golden18_per_up = 0.1
    end
  end
end

function M:on_room_change(npc)
  self:get_level()
  if check_magic(self.npc, 6171018) then
    self.level = get_ability_level(60011) or 1
    if 1 == self.level then
      self.Golden18_per_up = 0.05
    elseif self.level > 1 then
      self.Golden18_per_up = 0.1
    end
  end
end

function M:on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if 61710011 == magic_id and self.npc == get_come_on_hero() then
    local num = get_magic_num(hero, 61710011)
    if 5 == num and not check_magic(self.npc, 61710012) then
      cast_magic(self.npc, self.npc, 61710012, 0)
    end
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  local kind_num = get_magic_kind_num(self.npc, 61710)
  local num = get_magic_num(hero, 61710011)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if not skAct then
    return
  end
  if skAct:deemAtk() then
    if kind_num > 0 then
      local per1, per2 = tool:randByTime(0.1, 0.15 + self.Golden18_per_up)
      if check_magic(self.npc, 6171017) then
        per1, per2 = tool:randByTime(0.1, 0.3 + self.Golden18_per_up)
      end
      if per2 then
        cast_magic(self.npc, hero, 61710011, 0)
      end
    end
    if 5 == num then
      if check_magic(self.npc, 6171013) then
        return
      end
      local self_pos = get_npc_pos(self.npc)
      local base_pos1 = get_npc_offset_position(self.npc, nil, 90, 2)
      local base_pos2 = get_npc_offset_position(self.npc, nil, -90, 2)
      local target_pos = get_npc_offset_position(self.npc, nil, 0, 3.5)
      local p1 = get_position_offset_position(self_pos, target_pos, 0, 0)
      local p2 = get_position_offset_position(base_pos1, target_pos, 0, 0.5)
      local p3 = get_position_offset_position(base_pos2, target_pos, 0, 0.5)
      if not check_magic(self.npc, 6171018) then
        abort_magic_by_id(hero, 61710011)
        abort_magic_by_id(hero, 61710012)
        cast_missile3(hero, nil, p1.x, p1.z, 61710910401, 1)
        cast_missile3(hero, nil, p1.x, p1.z, 61710910402, 1)
      else
        abort_magic_by_id(hero, 61710011)
        abort_magic_by_id(hero, 61710012)
        cast_missile3(hero, hero, nil, nil, 61710910405, 1)
        cast_missile3(hero, hero, nil, nil, 61710910406, 1)
        cast_missile3(hero, hero, nil, nil, 61710910407, 1)
        cast_missile3(hero, hero, nil, nil, 61710910408, 1)
        cast_missile3(hero, hero, nil, nil, 61710910420, 1)
        cast_missile3(hero, hero, nil, nil, 61710910421, 1)
      end
    end
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if not (owner == get_come_on_hero() and check_magic(self.npc, 6171018)) or self.npc ~= get_come_on_hero() then
    return
  end
  if missile_cfg.Id == 61710910405 and self.is_6171091 then
    if 1 == level then
      cast_missile3(hero, hero, nil, nil, 61710910101, 1)
      cast_missile3(hero, hero, nil, nil, 61710910102, 1)
      cast_missile3(hero, hero, nil, nil, 61710910103, 1)
    elseif 2 == level then
      cast_missile3(hero, hero, nil, nil, 61710910201, 1)
      cast_missile3(hero, hero, nil, nil, 61710910202, 1)
      cast_missile3(hero, hero, nil, nil, 61710910203, 1)
    elseif 3 == level then
      cast_missile3(hero, hero, nil, nil, 61710910301, 1)
      cast_missile3(hero, hero, nil, nil, 61710910302, 1)
      cast_missile3(hero, hero, nil, nil, 61710910303, 1)
    end
  end
end

function M:get_level()
  level = get_god_skill_level() or 1
  local id = get_npc_id(get_god_npc())
  if 6171091 == id then
    self.is_6171091 = true
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc ~= self.npc then
    return
  end
  if true == is_showup then
    hero = get_come_on_hero()
  end
end

return M
