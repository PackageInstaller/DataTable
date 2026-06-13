local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, true)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("N1")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("N2")
  self.TargetPos3X, self.TargetPos3Y, self.TargetPos3Z = get_area_pos("N3")
  self.TargetPos4X, self.TargetPos4Y, self.TargetPos4Z = get_area_pos("N4")
  local N1 = {
    x = self.TargetPos1X,
    y = self.TargetPos1Y,
    z = self.TargetPos1Z
  }
  local N2 = {
    x = self.TargetPos2X,
    y = self.TargetPos2Y,
    z = self.TargetPos2Z
  }
  local N3 = {
    x = self.TargetPos3X,
    y = self.TargetPos3Y,
    z = self.TargetPos3Z
  }
  local N4 = {
    x = self.TargetPos4X,
    y = self.TargetPos4Y,
    z = self.TargetPos4Z
  }
  self.TargetPosMX, self.TargetPosMY, self.TargetPosMZ = get_area_pos("M1")
  self.M1 = {
    x = self.TargetPosMX,
    y = self.TargetPosMY,
    z = self.TargetPosMZ
  }
  self.step = 1
  self.goal = {
    N1,
    N2,
    N3,
    N4
  }
  self.goalname = {
    "T1",
    "T2",
    "T3",
    "T4"
  }
  self.stepmode = true
  self.startMove = false
  self.iswatching = false
  self.herohiding = false
  self.timecount = 0
  self.timegap = 1
  self.hidepointposX = 0
  self.hidepointposY = 0
  self.hidepointposZ = 0
  self.hidepointpos = {
    self.hidepointposX,
    self.hidepointposY,
    self.hidepointposZ
  }
  self.hidearea = nil
  self.juqing = {
    2210201,
    2210202,
    2210203
  }
  self.randomjuqing = math.random(1, 3)
  self.endstoryid = 3210202
  self.hero = get_come_on_hero()
  self.warming = 0
  self.warmingtip = 1
  self.maxwarming = 20
  self.minwarming = 0
  self.warmdistance = 7
  self.outdistance = 20
  self.outtipsdistance = 15
  self.outtipson = false
  self.tipon = false
  self.warmingtipsid = 310020101
  self.distancetipsid = 310020102
  self.warmskill = 301010501
  self.exposedistance = 1
end

local function isSamePos(pos1, pos2, tollerance)
  return tollerance >= (pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.z - pos2.z) * (pos1.z - pos2.z)
end

function M:on_start()
  cast_magic(self.npc, self.hero, self.HeroSlowDebuff)
end

function M:on_frame()
  if check_magic(self.npc, 3010101021) then
    if self.goal[self.step] == nil then
      start_stroy(self.endstoryid)
      abort_magic_by_id(self.hero, self.HeroSlowDebuff)
      return
    end
    local pos
    if isSamePos(get_npc_pos(self.npc), self.goal[self.step], 0.5) and self.startMove and self.goal[self.step] then
      self.step = self.step + 1
      pos = self.goal[self.step]
      if self.goal[self.step] ~= nil then
        cast_skill(self.npc, self.hero, self.warmskill, nil, nil)
      end
    end
    if nil ~= pos then
      move_to_pos(self.npc, pos)
    end
  end
  if check_magic(self.npc, 3010101022) then
    if self.goal[self.step] == nil then
      if self.stepmode then
        self.stepmode = false
        self.step = self.step - 2
        move_to_pos(self.npc, self.goal[self.step])
      else
        self.stepmode = true
        self.step = self.step + 2
        move_to_pos(self.npc, self.goal[self.step])
      end
    end
    local pos
    if isSamePos(get_npc_pos(self.npc), self.goal[self.step], 0.5) and self.startMove and self.goal[self.step] then
      if self.stepmode then
        self.step = self.step + 1
        pos = self.goal[self.step]
      else
        self.step = self.step - 1
        pos = self.goal[self.step]
      end
      cast_skill(self.npc, self.hero, self.warmskill, nil, nil)
    end
    if nil ~= pos then
      move_to_pos(self.npc, pos)
    end
  end
  if check_magic(self.npc, 3010101023) then
    if self.goal[self.step] == nil then
      self.step = 1
      cast_skill(self.npc, self.hero, self.warmskill, nil, nil)
      move_to_pos(self.npc, self.goal[self.step])
    end
    local pos
    if isSamePos(get_npc_pos(self.npc), self.goal[self.step], 0.5) and self.startMove and self.goal[self.step] then
      self.step = self.step + 1
      pos = self.goal[self.step]
      if self.goal[self.step] ~= nil then
        cast_skill(self.npc, self.hero, self.warmskill, nil, nil)
      end
    end
    if nil ~= pos then
      move_to_pos(self.npc, pos)
    end
  end
  if get_npc_time(self.npc) - self.timecount >= tonumber(self.timegap) then
    self.timecount = self.timecount + tonumber(self.timegap)
    if self.iswatching and not self.herohiding then
      self.warming = self.warming + 1
    end
    if get_npc_distance(self.npc, 1, self.hero, true) <= self.warmdistance and not self.herohiding then
      self.warming = self.warming + 1
    end
    if not self.iswatching and get_npc_distance(self.npc, 1, self.hero, true) > self.warmdistance or true == self.herohiding then
      self.warming = self.warming - 1
    end
    if get_npc_distance(self.npc, 1, self.hero, true) <= self.exposedistance then
      self.warming = self.maxwarming
    end
    if get_npc_distance(self.npc, 1, self.hero, true) > self.outdistance then
      set_npc_pos(self.hero, "T0")
      change_follow_target(0)
      start_stroy(2210204)
    end
    if self.warming >= self.warmingtip and false == self.tipon or get_npc_distance(self.npc, 1, self.hero, true) <= self.warmdistance and false == self.tipon then
      set_scene_tips(self.warmingtipsid, true)
      self.tipon = true
    end
    if self.warming < self.warmingtip or true == self.herohiding then
      set_scene_tips(self.warmingtipsid, false)
      self.tipon = false
    end
    if self.warming >= self.maxwarming then
      start_stroy(self.juqing[self.randomjuqing])
      self.warming = 0
      if nil ~= self.goalname[self.step - 1] then
        set_npc_pos(self.hero, self.goalname[self.step - 1])
      else
        set_npc_pos(self.hero, "M1")
      end
    end
    if self.warming <= self.minwarming then
      self.warming = self.minwarming
    end
  end
  if check_magic(self.npc, 3010101011) then
  end
  if get_npc_distance(self.npc, 1, self.hero, true) >= self.outtipsdistance and false == self.outtipson then
    set_scene_tips(310020102, true)
    self.outtipson = true
  end
  if get_npc_distance(self.npc, 1, self.hero, true) < self.outtipsdistance and true == self.outtipson then
    set_scene_tips(310020102, false)
    self.outtipson = false
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and skill_id == self.warmskill then
    self.startMove = false
    self.iswatching = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and skill_id == self.warmskill and is_time_out then
    self.startMove = true
    self.iswatching = false
  end
end

function M:on_enter_area(npc, area)
  local areaName = area.Tag
  local areaactor = area.Key
  if npc == self.hero then
    if "begin" == areaName then
      move_to_pos(self.npc, self.goal[1])
      self.startMove = true
      if check_magic(self.npc, 3010101021) then
        change_follow_target(1, self.npc, {
          6,
          12,
          {
            x = 0,
            y = -5,
            z = -1.8
          },
          1,
          0.6
        })
      end
    elseif "hide" == areaName then
      self.hidearea = areaactor
      self.hidepointposX, self.hidepointposY, self.hidepointposZ = get_area_pos(self.hidearea)
      if get_npc_distance(self.npc, 1, self.hero, true) > get_npc_distance(self.npc, 2, self.hidepointposX, self.hidepointposZ, true) then
        self.herohiding = true
      end
    elseif "destroy" == areaName then
      abort_magic_by_id(self.hero, self.HeroSlowDebuff)
    end
  end
end

function M:on_leave_area(npc, area)
  local areaName = area.Tag
  local areaactor = area.Key
  if npc == self.hero and "hide" == areaName then
    self.herohiding = false
    self.hidepointposX = 0
    self.hidepointposY = 0
    self.hidepointposZ = 0
  end
end

return M
