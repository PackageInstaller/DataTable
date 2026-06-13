local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fangcheng_jindu = "B1"
rogueMgr.atkAct = tool:dummySkAct(rogueMgr)

function rogueMgr.atkAct.isAtk()
  return true
end

local Default_missile = 61707910401
local A_missile = 61707910403
local B_missile = 61707910405

function M:on_start()
  self.Default_timer = 0
  self.Default_CD = 6
  self.A1_timer = 0
  self.A1_CD = 3
  self.A2_timer = 0
  self.A2_CD = 1
  self.B1_timer = 0
  self.B1_CD = 6
  self.B2_timer = 0
  self.B2_CD = 6
  self.Greatsword = 0.05
  self.Greatsword_timer = 0
  self:update_fangcheng_jindu()
end

function M:on_room_change()
  self:update_fangcheng_jindu()
end

function M:after_damage_target_default(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isSkill() and not rogueMgr.Default_missile_time and self.Default_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, Default_missile, 1)
    self.Default_timer = get_npc_time(self.npc) + self.Default_CD
    rogueMgr.Default_missile_time = true
  end
end

function M:after_damage_target_A1(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isAtk() and not rogueMgr.A_missile_time and self.A1_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, A_missile, 1, nil, nil, nil, nil, nil, nil, nil, rogueMgr.atkAct:skInfo())
    if check_magic(self.npc, rogueMgr.kuangnu) then
      self.A1_CD = 1.5
    else
      self.A1_CD = 3
    end
    self.A1_timer = get_npc_time(self.npc) + self.A1_CD
    rogueMgr.A_missile_time = true
  end
  if skAct and skAct:isSkill() and not rogueMgr.Default_missile_time and self.Default_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, Default_missile, 1, nil, nil, nil, nil, nil, nil, nil, rogueMgr.atkAct:skInfo())
    self.Default_timer = get_npc_time(self.npc) + self.Default_CD
    rogueMgr.Default_missile_time = true
  end
end

function M:after_damage_target_A2(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isAtk() and not rogueMgr.A_missile_time and self.A2_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, A_missile, 1, nil, nil, nil, nil, nil, nil, nil, rogueMgr.atkAct:skInfo())
    self.A2_timer = get_npc_time(self.npc) + self.A2_CD
    rogueMgr.A_missile_time = true
  end
  if skAct and skAct:isSkill() and not rogueMgr.Default_missile_time and self.Default_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, Default_missile, 1, nil, nil, nil, nil, nil, nil, nil, rogueMgr.atkAct:skInfo())
    self.Default_timer = get_npc_time(self.npc) + self.Default_CD
    rogueMgr.Default_missile_time = true
  end
end

function M:on_missile_begin_pos_A2(owner, pos_x, pos_z, missile_cfg, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if missile_cfg.Id == 61707910404 and check_magic(self.npc, rogueMgr.kuangnu) then
    change_missile_config(missile_cfg.Id, "magic", {617079141, 617079143}, 0)
  end
end

function M:after_damage_target_B1(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isSkill() and not rogueMgr.B_missile_time and self.B1_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, B_missile, 1)
    self.B1_timer = get_npc_time(self.npc) + self.B1_CD
    rogueMgr.B_missile_time = true
  end
  if missile and missile.missile_cfg.Id == 61707910406 then
    local nowHP = get_npc_attr(target, 1)
    local maxHP = get_npc_attr(target, 4)
    if check_magic(self.npc, rogueMgr.baojun) then
      self.B1_execute = 0.1
    else
      self.B1_execute = 0.05
    end
    if nowHP / maxHP < self.B1_execute then
      cast_magic(self.npc, target, 61707032, 1)
      cast_magic(self.npc, self.npc, 61707031, 1)
    end
  end
end

function M:after_damage_target_B2(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and skAct:isSkill() and not rogueMgr.B_missile_time and self.B1_timer < get_npc_time(self.npc) then
    cast_missile(self.npc, target, nil, nil, 61707910405, 1)
    self.B1_timer = get_npc_time(self.npc) + self.B1_CD
    rogueMgr.B_missile_time = true
  end
  if missile then
    if missile.missile_cfg.Id == 61707910406 then
      local nowHP = get_npc_attr(target, 1)
      local maxHP = get_npc_attr(target, 4)
      if check_magic(self.npc, rogueMgr.baojun) then
        self.B1_execute = 0.1
      else
        self.B1_execute = 0.05
      end
      if nowHP / maxHP < self.B1_execute then
        cast_magic(self.npc, target, 61707032, 1)
        cast_magic(self.npc, self.npc, 61707031, 1)
      end
      if get_magic_num(self.npc, rogueMgr.weilai) >= 9 then
        self.Greatsword = 0.1
      else
        self.Greatsword = 0.05
      end
      local per1, per2 = tool:randByTime(1, self.Greatsword)
      if per2 and self.Greatsword_timer < get_npc_time(self.npc) then
        cast_missile(self.npc, target, nil, nil, 61707910407, 1)
        self.Greatsword_timer = get_npc_time(self.npc) + 2
      end
    end
    if missile.missile_cfg.Id == 61707910407 then
      local nowHP = get_npc_attr(target, 1)
      local maxHP = get_npc_attr(target, 4)
      if get_magic_num(self.npc, rogueMgr.weilai) >= 9 then
        self.B2_execute = 0.3
      else
        self.B2_execute = 0.25
      end
      if nowHP / maxHP < self.B1_execute then
        cast_magic(self.npc, target, 61707032, 1)
        cast_magic(self.npc, self.npc, 61707031, 1)
      end
    end
  end
end

function M:on_fate_book_battle_start_B1()
  abort_magic_by_id(self.npc, 61707031, 99)
end

function M:update_fangcheng_jindu()
  local branch_id, branch_level = get_equation_branch_info(12)
  if 0 == branch_id then
    self.after_damage_target = self.after_damage_target_default
  end
  if 1201 == branch_id and 1 == branch_level then
    self.after_damage_target = self.after_damage_target_A1
  elseif 1201 == branch_id and 2 == branch_level then
    self.after_damage_target = self.after_damage_target_A2
    self.on_missile_begin_pos = self.on_missile_begin_pos_A2
  elseif 1202 == branch_id and 1 == branch_level then
    self.after_damage_target = self.after_damage_target_B1
    self.on_fate_book_battle_start = self.on_fate_book_battle_start_B1
  elseif 1202 == branch_id and 2 == branch_level then
    self.after_damage_target = self.after_damage_target_B2
    self.on_fate_book_battle_start = self.on_fate_book_battle_start_B1
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == A_missile then
    rogueMgr.A_missile_time = false
  elseif missile_cfg.Id == B_missile then
    rogueMgr.B_missile_time = false
  elseif missile_cfg.Id == Default_missile then
    rogueMgr.Default_missile_time = false
  end
end

function M:_init(npc)
end

return M
