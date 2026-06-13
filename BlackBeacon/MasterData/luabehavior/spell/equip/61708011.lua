local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local fangcheng_jindu = 22
local aoe_damage = 61708920305

function M:_init(npc)
  self.shield_missile = 61708910101
end

function M:on_start()
  self:update_fangcheng_jindu()
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.shield_missile, self.on_shield_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.shield_missile, self.on_shield_release_npc, self)
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.shield_missile, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.shield_missile, self)
end

function M:on_shield_catch_npc(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    if self.npc == get_come_on_hero() then
      tool:castMagicToTeam(61708012)
    end
    self.in_shield = true
  end
end

function M:on_shield_release_npc(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_shield = false
  end
end

function M:on_shield_catch_npc_A1(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    if self.npc == get_come_on_hero() then
      tool:castMagicToTeam(61708012)
    end
    self.in_shield = true
    cast_magic(self.npc, self.npc, 61708013)
    cast_magic(self.npc, self.npc, 61708014)
    if 5 == get_role_kind(self.npc) then
      cast_magic(self.npc, self.npc, 61708015)
      cast_magic(self.npc, self.npc, 61708016)
    end
  end
end

function M:on_shield_release_npc_A1(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_shield = false
    abort_magic_by_id(self.npc, 61708012, 99)
    abort_magic_by_id(self.npc, 61708013, 99)
    abort_magic_by_id(self.npc, 61708014, 99)
    abort_magic_by_id(self.npc, 61708015, 99)
    abort_magic_by_id(self.npc, 61708016, 99)
  end
end

function M:on_shield_catch_npc_A2(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_shield = true
    tool:castMagicToTeam(61708012)
    cast_magic(self.npc, self.npc, 61708013)
    cast_magic(self.npc, self.npc, 61708014)
    if 5 == get_role_kind(self.npc) then
      cast_magic(self.npc, self.npc, 61708015)
      cast_magic(self.npc, self.npc, 61708016)
      cast_magic(self.npc, self.npc, 617080110)
    end
  end
end

function M:on_shield_release_npc_A2(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_shield = false
    abort_magic_by_id(self.npc, 61708012, 99)
    abort_magic_by_id(self.npc, 61708013, 99)
    abort_magic_by_id(self.npc, 61708014, 99)
    abort_magic_by_id(self.npc, 61708015, 99)
    abort_magic_by_id(self.npc, 61708016, 99)
    abort_magic_by_id(self.npc, 617080110, 99)
  end
end

function M:on_room_change(npc)
  self:update_fangcheng_jindu()
end

function M:after_damage_target_B1(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not self.in_shield then
    return
  end
  if magic_id == rogueMgr.fanji then
    if check_magic(target, rogueMgr.baojin) then
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen50)
    else
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen10)
    end
  end
end

function M:after_damage_target_B2(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not self.in_shield then
    return
  end
  if magic_id == rogueMgr.fanji then
    if check_magic(target, rogueMgr.baojin) then
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen50)
    else
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen10)
    end
    if not rogueMgr.fanji_time then
      rogueMgr.fanji_time = 0
    end
    rogueMgr.fanji_time = rogueMgr.fanji_time + 1
    print(rogueMgr.fanji_time)
    if rogueMgr.fanji_time >= 10 and self.npc == get_come_on_hero() then
      local level = self:calculate_Value(get_fate_book_coin_count())
      cast_missile3(self.npc, self.npc, nil, nil, aoe_damage, level)
      rogueMgr.fanji_time = 0
    end
  end
end

function M:calculate_Value(num)
  if num <= 100 then
    return 1
  elseif num >= 500 then
    return 6
  else
    local diff = num
    local increment = math.ceil(diff / 100)
    return 1 + increment
  end
end

function M:update_fangcheng_jindu()
  local branch_id, branch_level = get_equation_branch_info(14)
  if not branch_id then
    return
  end
  if 1401 == branch_id and 1 == branch_level then
    self.on_shield_release_npc = self.on_shield_release_npc_A1
    self.on_shield_catch_npc = self.on_shield_catch_npc_A1
  elseif 1401 == branch_id and 2 == branch_level then
    self.on_shield_release_npc = self.on_shield_release_npc_A2
    self.on_shield_catch_npc = self.on_shield_catch_npc_A2
  elseif 1402 == branch_id and 1 == branch_level then
    self.after_damage_target = self.after_damage_target_B1
  elseif 1402 == branch_id and 2 == branch_level then
    self.after_damage_target = self.after_damage_target_B2
  end
end

function M:on_hero_showup_or_back(behavior, npc, is_showup, by_ult_change)
  if npc == self.npc and not is_showup then
    self:on_shield_release_npc(nil, self.npc)
  end
end

return M
