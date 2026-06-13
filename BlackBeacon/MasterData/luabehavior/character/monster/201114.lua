local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  set_npc_ignore_sync_area(npc, false)
  Base._init(self)
  self.target = nil
  self.stun_timer = 0
  self.control = 0
  self.wander = {
    4,
    8,
    1
  }
  self.wander_timer = 2
  self.monster_type = 1
  self.camp_skill_list = {
    self.skill01,
    self.skill02
  }
  self.npc_time = 0
  self.inBattle = 0
  self.xulistart = false
  self.hud_start = 0
  cast_magic(npc, npc, 201010305, 0)
  cast_magic(npc, npc, 201010304, 0)
  set_sync_var("201114_xuli", false)
  set_hud_config("xulibar", {
    Prefab = "UI_Hud6",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
  self.targetPos = {
    x = 0,
    y = 0,
    z = 0
  }
  set_sync_var("201114_gateTwoSwitch", false)
  self.targetPos = {
    x = self.targetPosX,
    y = self.targetPosY,
    z = self.targetPosZ
  }
  self.skill01 = {
    20111401,
    2,
    1,
    0,
    9,
    get_skill_cfg(20111401).CastTime,
    get_skill_cfg(20111401).AfterTime,
    0
  }
  self.skill02 = {
    20111402,
    10,
    10,
    0,
    5,
    get_skill_cfg(20111402).CastTime,
    get_skill_cfg(20111402).AfterTime,
    0
  }
end

function M:cast_skill(skill_instant_ID)
  local ran_interval = math.random() * 1.5 + 2
  local now_time = get_npc_time(self.npc)
  if CommonMonster.skill_cast_condition(self, skill_instant_ID, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
  else
    return
  end
  if get_target_angel(self.npc, self.target, true) <= -30 or get_target_angel(self.npc, self.target, true) >= 30 then
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
  end
end

function M:skill_main_logic()
  if 0 ~= self.control then
    return
  end
  if get_sync_var("201114_xuli") == true then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if true == get_sync_var("201114_gateTwoSwitch") then
    self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("S1")
    self.TargetPos1 = {
      x = self.TargetPos1X,
      y = self.TargetPos1Y,
      z = self.TargetPos1Z
    }
    if check_npc_distance_to_pos(self.npc, self.TargetPos1X, self.TargetPos1Z, 1.5, false) == false then
      switch_move_type(self.npc, 1)
      move_to_pos(self.npc, self.TargetPos1)
    elseif true == check_npc_distance_to_pos(self.npc, self.TargetPos1X, self.TargetPos1Z, 1.5, false) then
      self.skill02[3] = 0
      cast_skill(self.npc, nil, 20111402)
      return
    end
  end
  if self.target ~= nil and check_npc_distance(self.npc, self.target, 4, true) and not self:cast_skill(self.skill02) then
    if not self:cast_skill(self.skill01) then
      return
    end
    return
  end
end

function M:look_at()
  set_npc_hp_visible(self.npc, false)
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 11) then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not is_cast_skill_time(self.npc) then
    lookat_npc(self.npc, self.target, false)
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
  if self.wander_randomseed >= 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:move_away_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if get_sync_var("201114_TargetPosX") == nil then
    self.targetPos = {
      x = 0,
      y = 0,
      z = 0
    }
  else
    self.targetPosX = get_sync_var("201114_TargetPosX")
    self.targetPosY = get_sync_var("201114_TargetPosY")
    self.targetPosZ = get_sync_var("201114_TargetPosZ")
    self.targetPos = {
      x = self.targetPosX,
      y = self.targetPosY,
      z = self.targetPosZ
    }
  end
  if get_sync_var("201114_ArriveDestination") == true then
    return
  end
  if nil == self.target then
    self.inBattle = 0
    self.npc_time = get_npc_time(self.npc)
    if self.npc_time < self.wander_timer then
      return
    end
    if 9 == self.control then
      return
    end
    if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 0.6, false) == false then
      switch_move_type(self.npc, 1)
      move_to_pos(self.npc, self.targetPos)
    else
      stop_move(self.npc)
    end
  elseif check_magic(self.target, 201114014) then
    self.inBattle = 0
    self.npc_time = get_npc_time(self.npc)
    if self.npc_time < self.wander_timer then
      return
    end
    if 9 == self.control then
      return
    end
    if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 0.6, false) == false then
      switch_move_type(self.npc, 1)
      move_to_pos(self.npc, self.targetPos)
    else
      stop_move(self.npc)
    end
  elseif check_npc_distance(self.npc, self.target, 6, true) then
    self.inBattle = 1
    if not self.target then
      return
    end
    if not check_activate(self.target) then
      return
    end
    self.npc_time = get_npc_time(self.npc)
    if self.npc_time < self.wander_timer then
      return
    end
    if is_cast_skill_time(self.npc) then
      return
    end
    if check_npc_status(self.npc, 2) then
      return
    end
    if 9 == self.control then
      return
    end
    local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
    local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
    if distance_max and not distance_min then
      self:move_approch_wander()
    elseif not distance_max then
      self:move_approch_wander()
    elseif distance_min and not check_npc_distance(self.npc, self.target, 2, true) then
      self:move_normal_wander()
    elseif check_npc_distance(self.npc, self.target, 2, true) then
      self:move_away_wander()
    end
  else
    self.inBattle = 0
    self.npc_time = get_npc_time(self.npc)
    if self.npc_time < self.wander_timer then
      return
    end
    if 9 == self.control then
      return
    end
    if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 0.6, false) == false then
      switch_move_type(self.npc, 1)
      move_to_pos(self.npc, self.targetPos)
    else
      stop_move(self.npc)
    end
  end
  self.wander_timer = self.npc_time + self.wander[3]
end

function M:on_enter_area(npc, area)
  if npc ~= self.npc then
    return
  end
  if area.Key == "gate2" then
    set_sync_var("201114_gateTwoSwitch", true)
    self.inBattle = 1
  end
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  if self.xulistart == false then
    CommonMonster.search_target(self, 30, 15)
  end
  CommonMonster.monster_on_frame(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
  if get_sync_var("201114_ArriveDestination") == true and false == get_sync_var("201114_gateTwoSwitch") and true == get_sync_var("201114_xuli") then
    self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("CD1")
    self.TargetPos2 = {
      x = self.TargetPos2X,
      y = self.TargetPos2Y,
      z = self.TargetPos2Z
    }
    set_sync_var("201114_xuli", false)
    cast_magic(self.npc, self.npc, 201010304, 0)
    active_hud(self.npc, "xulibar", "attachpoint", true)
    self.hud_start = get_npc_time(self.npc) + 0.1
    self.xulistart = true
    self.control = 0
    self.target = nil
    set_npc_target(self.npc, nil)
    lookat_position(self.npc, self.TargetPos2.x, self.TargetPos2.z, false)
  end
  if self.hud_start and get_npc_time(self.npc) > self.hud_start and get_npc_attr(self.npc, 3) < get_npc_attr(self.npc, 6) then
    cast_magic(self.npc, self.npc, 201010303, 0)
    self.hud_start = get_npc_time(self.npc) + 0.1
  end
  if get_npc_attr(self.npc, 3) == get_npc_attr(self.npc, 6) and get_sync_var("201114_ArriveDestination") == true and false == get_sync_var("201114_gateTwoSwitch") and self.hud_start > 0 then
    cast_magic(self.npc, self.npc, 201010304, 0)
    active_hud(self.npc, "xulibar", "attachpoint", false)
    self.hud_start = nil
    set_sync_var("201114_gateTwoSwitch", true)
    set_sync_var("201114_ArriveDestination", false)
    set_sync_var("201114_TargetPosX", 245)
    set_sync_var("201114_TargetPosY", -10)
    set_sync_var("201114_TargetPosZ", 0)
    set_sync_var("DOOROPEN", true)
    cast_skill(self.npc, nil, 20111402)
  end
  self:wander_main_logic()
  self:look_at()
  self:skill_main_logic()
end

function M:after_damage(npc, target, magic_id, damage_saign, damage_type, is_crit, damage_val)
  if target == self.npc and damage_val < 0 and get_sync_var("201114_ArriveDestination") == true and get_sync_var("201114_gateTwoSwitch") == false then
    self.hud_start = 0
    self.control = 0
    set_sync_var("201114_xuli", true)
  end
end

return M
