local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:after_damage_self_default(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time <= self.last_time + self.cd then
    return
  end
  local layer = get_magic_num(self.npc, rogueMgr.fragment_magic)
  if layer < 1 then
    return
  end
  local value = self:get_value(layer)
  self.last_time = self.curr_time
  for i, missile_id in ipairs(self.missile_list) do
    if i > value then
      break
    end
    cast_missile3(self.npc, nil, nil, nil, missile_id)
  end
end

function M:on_start()
  self.last_time = 0
  self.cd = 6
  self:update_fangcheng_jindu()
  tool:castMagicToTeam(rogueMgr.fragment_control)
end

function M:on_target_self_magic_begin_B1(npc, magic_id, magic_level, magic_kind, magic_type)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if self.have_shot then
    return
  end
  if magic_id == rogueMgr.fragment_effect_magic then
    local layer = rogueMgr.fragment_effect_magic_num
    local value = self:get_value(layer)
    self.have_shot = true
    for i, missile_id in ipairs(self.missile_list) do
      if i > value then
        break
      end
      cast_missile3(self.npc, nil, nil, nil, missile_id, rogueMgr.fragment_level)
    end
  end
end

function M:after_damage_target_B1(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not self.have_shot then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct then
    return
  end
  remove_missile_by_id(61712910509, npc, true)
end

function M:on_self_missile_end_pos_B1(pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == 61712910509 then
    local hero = get_come_on_hero()
    local role = hero:get_behavior()
    if role.target then
      cast_missile3(owner, role.target, pos_x, pos_z, 61712910510, rogueMgr.fragment_level)
      self.have_shot = false
    else
      cast_missile3(owner, hero, pos_x, pos_z, 61712910510, rogueMgr.fragment_level)
      if self.have_shot == true then
        cast_missile3(owner, hero, pos_x, pos_z, 61712910513)
        self.have_shot = false
      end
    end
  end
end

function M:on_missile_collide_B1(m2_owner, m1_owner, m2, m1, m2_cfg, m1_cfg)
  if get_come_on_hero() ~= self.npc then
    return
  end
  if m1.missile_id == 61712910510 and m2.missile_id == 61712910513 or m1.missile_id == 61712910513 and m2.missile_id == 61712910510 then
    if m1.missile_id == 61712910510 then
      remove_missile(m1, true)
    else
      remove_missile(m2, true)
    end
  end
end

function M:after_damage_target_B2(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:after_damage_target_B1(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if 61712023 == magic_id then
    local per = math.random()
    if per > 0.5 then
      rogueMgr:random_cast_fragment(self.npc, 1, 3, target)
    end
  end
end

function M:on_npc_hp_zero_A1(npc, attacker, magic_id, missile_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(npc)
  if kind <= 4 and kind >= 2 and check_magic(npc, 61712025) then
    cast_magic(self.npc, self.npc, 61712026)
  end
end

function M:after_damage_self_A2(npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  self.curr_time = get_npc_time(self.npc)
  if self.curr_time <= self.last_time + self.cd then
    return
  end
  local layer = get_magic_num(self.npc, rogueMgr.fragment_magic)
  if layer < 1 then
    return
  end
  local value = 4
  self.last_time = self.curr_time
  for i, missile_id in ipairs(self.missile_list) do
    if i > value then
      break
    end
    cast_missile3(self.npc, nil, nil, nil, missile_id)
  end
end

function M:before_damage_target_A2(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if magic_id == rogueMgr.fanji then
    cast_magic(self.npc, self.npc, 61712027)
  end
end

function M:update_fangcheng_jindu()
  self.after_damage_self = self.after_damage_self_default
  self.missile_list = {
    61712910601,
    61712910602,
    61712910603,
    61712910604,
    61712910605,
    61712910606,
    61712910607,
    61712910608
  }
  local branch_id, branch_level = get_equation_branch_info(17)
  if branch_id and branch_level then
    if 1701 == branch_id then
      self.missile_list = {
        61712910701,
        61712910702,
        61712910703,
        61712910704,
        61712910705,
        61712910706,
        61712910707,
        61712910708
      }
      if 1 == branch_level then
        self.on_npc_hp_zero = self.on_npc_hp_zero_A1
      elseif 2 == branch_level then
        self.on_npc_hp_zero = self.on_npc_hp_zero_A1
        self.after_damage_self = self.after_damage_self_A2
        self.before_damage_target_ = self.before_damage_target_A2
      end
    elseif 1702 == branch_id then
      self.missile_list = {
        61712910501,
        61712910502,
        61712910503,
        61712910504,
        61712910505,
        61712910506,
        61712910507,
        61712910508
      }
      if 1 == branch_level then
        self.on_missile_collide = self.on_missile_collide_B1
        self.on_target_self_magic_begin = self.on_target_self_magic_begin_B1
        self.on_self_missile_end_pos = self.on_self_missile_end_pos_B1
        self.after_damage_target = self.after_damage_target_B1
      elseif 2 == branch_level then
        self.on_missile_collide = self.on_missile_collide_B1
        self.on_target_self_magic_begin = self.on_target_self_magic_begin_B1
        self.on_self_missile_end_pos = self.on_self_missile_end_pos_B1
        self.after_damage_target = self.after_damage_target_B2
      end
    end
  end
end

function M:get_value(input)
  if input >= 1 and input <= 3 then
    return 1
  elseif input >= 4 and input <= 6 then
    return 2
  elseif input >= 7 and input <= 9 then
    return 4
  elseif 10 == input then
    return 8
  else
    return nil
  end
end

return M
