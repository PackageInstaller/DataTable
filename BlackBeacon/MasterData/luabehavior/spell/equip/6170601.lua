local M = Util.create_class()
local team_hero_list = {}
local time_sphere = get_god_npc()
local time_sphere_skill = 617069101
local time_sphere_missile = 61706910101
local rogueMgr = import("common.rogueManager")
local linkMgr = import("character.base.base_linkManager")
local tool = import("common.tool")
local black_hole = {
  [2] = 61706910501,
  [3] = 61706910502,
  [4] = 61706910503,
  [5] = 61706910504,
  [6] = 61706910505
}
local black_hole_dark_damage = {
  6170691003,
  6170691004,
  6170691005,
  6170691006,
  6170691007
}
local A2_black_hole = {
  [2] = 61706910701,
  [3] = 61706910702,
  [4] = 61706910703,
  [5] = 61706910704,
  [6] = 61706910705
}
local B1_black_hole = {
  [2] = 61706910801,
  [3] = 61706910802,
  [4] = 61706910803,
  [5] = 61706910804,
  [6] = 61706910805
}

function M:_init(npc)
  self.tool = tool
  self.default_init_time = 0
  self.default_cd = 2.5
  self.A2_init_time = 0
  self.A2_cd = 1.5
end

function M:on_magic_begin_default(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if magic_kind and magic_kind[10] and get_npc_time(self.npc) > self.default_init_time + self.default_cd then
    local hero = get_come_on_hero()
    local element = get_active_char_element(hero)
    local black_hole_id = black_hole[element]
    if black_hole_id then
      cast_missile3(hero, target, nil, nil, black_hole_id)
      self.default_init_time = get_npc_time(self.npc)
      self.default_cd = 25
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg)
end

function M:after_damage_A1(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg)
  for _, damage_id in pairs(black_hole_dark_damage) do
    if magic_id == damage_id then
      if check_magic(get_come_on_hero(), rogueMgr.huisu) then
        self.tool:castMagicToTeam(61706012)
        break
      end
      self.tool:castMagicToTeam(61706015)
      break
    end
  end
end

function M:after_damage_A2(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg)
  self.after_damage_A1(self, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg)
end

function M:power_up(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.weilai and get_magic_num(npc, rogueMgr.weilai) > 5 then
    abort_magic_by_id(npc, rogueMgr.weilai, 99)
    self.tool:castMagicToTeam(61706014)
  end
end

function M:on_element_aborn_start_A2(npc, element, skill_id, attacker)
  self.tool:castMagicToTeam(61706013)
end

function M:on_missile_end_pos_B1(owner, pos_x, pos_z, missile_cfg, missile)
  local count = 2
  local hero = get_come_on_hero()
  for _, black_hole_id in pairs(black_hole) do
    if missile_cfg.Id == black_hole_id then
      cast_missile3(hero, hero, pos_x, pos_z, B1_black_hole[count])
      return
    end
    count = count + 1
  end
end

function M:on_element_aborn_start_B1(npc, element, skill_id, attacker)
  if 617069108 == skill_id then
    cast_missile3(attacker, npc, nil, nil, 61709910101)
  end
end

function M:on_element_aborn_start_B2(npc, element, skill_id, attacker)
  self.on_element_aborn_start_B1(npc, element, skill_id, attacker)
  if 1 == element then
    self.default_cd = 0
  end
end

function M:on_magic_begin_B2(npc, target, magic_id, magic_level, magic_kind, magic_type)
  self.on_magic_begin_default(self, npc, target, magic_id, magic_level, magic_kind, magic_type)
  if 6170691019 == magic_id and check_magic(target, 61709221) then
    cast_magic(get_come_on_hero(), target, 6170691020)
  end
end

function M:on_fate_book_battle_start()
  self:update_fangcheng_jindu()
  rogueMgr:add_water_control_magic(self.npc)
end

function M:on_room_change(npc)
  self:update_fangcheng_jindu()
end

function M:on_npc_born(npc)
  rogueMgr:born_add_water_control(self.npc, npc)
end

function M:update_fangcheng_jindu()
  self.on_magic_begin = self.on_magic_begin_default
  local branch_id, branch_level = get_equation_branch_info(11)
  if branch_id and branch_level then
    if 1101 == branch_id and 1 == branch_level then
      self.after_damage = self.after_damage_A1
    elseif 1101 == branch_id and 2 == branch_level then
      local hero1 = get_come_on_hero()
      local hero2 = get_scene_hero_by_poskey(21)
      local hero3 = get_scene_hero_by_poskey(22)
      self.after_damage = self.after_damage_A2
      self.on_element_aborn_start = self.on_element_aborn_start_A2
      local role1 = hero1:get_behavior()
      if role1 then
        tool.insert(role1, "onRampageStart", self.power_up)
      end
      if hero2 then
        local role2 = hero2:get_behavior()
        tool.insert(role2, "onRampageStart", self.power_up)
      end
      if hero3 then
        local role3 = hero3:get_behavior()
        tool.insert(role3, "onRampageStart", self.power_up)
      end
    elseif 1102 == branch_id and 1 == branch_level then
      self.on_missile_end_pos = self.on_missile_end_pos_B1
      self.on_element_aborn_start = self.on_element_aborn_start_B1
    elseif 1102 == branch_id and 2 == branch_level then
      self.on_missile_end_pos = self.on_missile_end_pos_B1
      self.on_element_aborn_start = self.on_element_aborn_start_B2
      self.on_magic_begin = self.on_magic_begin_B2
      black_hole = {
        [2] = 61706910901,
        [3] = 61706910902,
        [4] = 61706910903,
        [5] = 61706910904,
        [6] = 61706910905
      }
    end
  end
end

return M
