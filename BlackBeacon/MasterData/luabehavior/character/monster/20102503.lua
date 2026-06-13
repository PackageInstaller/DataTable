local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.Skill01 = {
    2010250301,
    12,
    0,
    0,
    1.5,
    get_skill_cfg(2010250301).CastTime,
    get_skill_cfg(2010250301).AfterTime
  }
  self.Skill02 = {
    2010250302,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250302).CastTime,
    get_skill_cfg(2010250302).AfterTime
  }
  self.Skill03 = {
    2010250303,
    17,
    0,
    0,
    1.5,
    get_skill_cfg(2010250303).CastTime,
    get_skill_cfg(2010250303).AfterTime
  }
  self.Skill04 = {
    2010250304,
    19,
    0,
    0,
    1.5,
    get_skill_cfg(2010250304).CastTime,
    get_skill_cfg(2010250304).AfterTime
  }
  self.Skill05 = {
    2010250305,
    23,
    0,
    0,
    1.5,
    get_skill_cfg(2010250305).CastTime,
    get_skill_cfg(2010250305).AfterTime
  }
  self.Skill06 = {
    2010250306,
    5,
    0,
    0,
    1.5,
    get_skill_cfg(2010250306).CastTime,
    get_skill_cfg(2010250306).AfterTime
  }
  self.Skill07 = {
    2010250307,
    30,
    0,
    0,
    1.5,
    get_skill_cfg(2010250307).CastTime,
    get_skill_cfg(2010250307).AfterTime
  }
  self.Skill08 = {
    2010250308,
    0,
    0,
    0,
    1.5,
    get_skill_cfg(2010250308).CastTime,
    get_skill_cfg(2010250308).AfterTime
  }
  self.Skill09 = {
    2010250309,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250309).CastTime,
    get_skill_cfg(2010250309).AfterTime
  }
  self.Skill10 = {
    2010250310,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250310).CastTime,
    get_skill_cfg(2010250310).AfterTime
  }
  self.Skill11 = {
    2010250311,
    25,
    0,
    0,
    1.5,
    get_skill_cfg(2010250311).CastTime,
    get_skill_cfg(2010250311).AfterTime
  }
  self.Skill12 = {
    2010250312,
    0,
    0,
    0,
    1.5,
    get_skill_cfg(2010250312).CastTime,
    get_skill_cfg(2010250312).AfterTime
  }
  self.Skill13 = {
    2010250321,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250321).CastTime,
    get_skill_cfg(2010250321).AfterTime
  }
  self.Skill14 = {
    2010250323,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250323).CastTime,
    get_skill_cfg(2010250323).AfterTime
  }
  self.Skill15 = {
    2010250324,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250324).CastTime,
    get_skill_cfg(2010250324).AfterTime
  }
  self.Skill16 = {
    2010250325,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250325).CastTime,
    get_skill_cfg(2010250325).AfterTime
  }
  self.Skill17 = {
    2010250326,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250326).CastTime,
    get_skill_cfg(2010250326).AfterTime
  }
  self.Skill18 = {
    2010250327,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250327).CastTime,
    get_skill_cfg(2010250327).AfterTime
  }
  self.Skill19 = {
    2010250334,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250334).CastTime,
    get_skill_cfg(2010250334).AfterTime
  }
  self.Skill20 = {
    2010250328,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250328).CastTime,
    get_skill_cfg(2010250328).AfterTime
  }
  self.Skill21 = {
    2010250329,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250329).CastTime,
    get_skill_cfg(2010250329).AfterTime
  }
  self.Skill22 = {
    2010250330,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250330).CastTime,
    get_skill_cfg(2010250330).AfterTime
  }
  self.Skill23 = {
    2010250322,
    10,
    0,
    0,
    1.5,
    get_skill_cfg(2010250322).CastTime,
    get_skill_cfg(2010250322).AfterTime
  }
  self.stunSkill = 2010250335
  self.stunrecoverSkill = 2010250336
  self.BeHitCounter = 2010250333
  self.target = nil
  self.wander_timer = 0
  self.attackcount = 0
  self.wanderlasttime = 4
  self.wanderteleportbool = false
  self.wander_interval = 4
  self.status = 0
  self.Skill01CDbool = false
  self.Skill02CDbool = false
  self.Skill03CDbool = false
  self.Skill04CDbool = false
  self.Skill05CDbool = false
  self.Skill06CDbool = false
  self.Skill07CDbool = false
  self.Skill08CDbool = false
  self.Skill09CDbool = false
  self.Skill10CDbool = false
  self.Skill11CDbool = false
  self.Skill12CDbool = false
  self.Skill13CDbool = false
  self.Skill14CDbool = false
  self.Skill15CDbool = false
  self.Skill16CDbool = false
  self.Skill17CDbool = false
  self.Skill18CDbool = false
  self.Skill19CDbool = false
  self.Skill20CDbool = false
  self.Skill21CDbool = false
  self.Skill22CDbool = false
  self.Skill23CDbool = false
  self.teletportposx = 0
  self.teletportposz = 0
  self.Skill01teleportSkill = false
  self.Skill06teleportSkill = false
  self.Skill09teleportSkill = false
  self.Skill10teleportSkill = false
  self.Skill20teleportSkill = false
  self.Skill21teleportSkill = false
  self.isteleporting = false
  self.AtSkillEndBool = false
  self.AllowCastSkill = true
  self.iscombo = false
  self.phase1 = true
  self.phase2 = false
  self.StunBool = false
  self.StunTimer = 0
  self.StunLastTime = 10
  self.StunBoolForEnter = false
  self.BehitTimerbool = false
  self.BehitTimer = 0
  self.BehitTimerInterval = 5
  self.FirstTimeInPhase2 = true
  self.UltSkillTimerInterval = 30
  self.UltTimer = 0
  self.IsUltStatus = false
  self.UltSkill1Hit = true
  self.UltSkill2Hit = true
  self.UltSkill3Hit = true
  self.UltSkill4Hit = true
  self.UltSkill5Hit = true
  self.UltSkill1ID = 2010250316
  self.UltSkill2ID = 2010250317
  self.UltSkill3ID = 2010250318
  self.UltSkill4ID = 2010250319
  self.UltSkill5ID = 2010250320
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if npc ~= self.target then
    return
  end
  if target ~= self.npc then
    return
  end
  if 3 ~= damage_sign then
    return
  end
  if check_magic(self.npc, 201025030803) == true then
    abort_skill(self.npc, false)
    if check_npc_status(self.npc, 2) then
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.target, 2010250333)
    end
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if npc ~= self.target then
    return
  end
  if target ~= self.npc then
    return
  end
  if 0 == change_level then
    self.StunBool = true
    self.StunTimer = get_npc_time(self.npc)
  end
end

function M:skill_main_logic2()
  self:CheckCD()
  local SkillCasttime = get_npc_time(self.npc)
  local DistanceToPlayer = get_npc_distance(self.npc, 1, self.target, true)
  if self.FirstTimeInPhase2 == true then
    self.AllowCastSkill = false
    self.UltTimer = SkillCasttime
    self.FirstTimeInPhase2 = false
    cast_skill(self.npc, self.npc, 2010250314)
  end
  if SkillCasttime >= self.UltTimer + self.UltSkillTimerInterval then
    self.UltTimer = SkillCasttime
    self.IsUltStatus = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.npc, 2010250315)
  end
  if true == self.IsUltStatus and true == self.AllowCastSkill then
    self.iscombo = true
    cast_skill(self.npc, self.target, self.UltSkill1ID)
  end
end

function M:CheckCD()
  local Currenttime = get_npc_time(self.npc)
  if Currenttime >= self.Skill01[3] then
    self.Skill01CDbool = true
  end
  if Currenttime >= self.Skill02[3] then
    self.Skill02CDbool = true
  end
  if Currenttime >= self.Skill03[3] then
    self.Skill03CDbool = true
  end
  if Currenttime >= self.Skill04[3] then
    self.Skill04CDbool = true
  end
  if Currenttime >= self.Skill05[3] then
    self.Skill05CDbool = true
  end
  if Currenttime >= self.Skill06[3] then
    self.Skill06CDbool = true
  end
  if Currenttime >= self.Skill07[3] then
    self.Skill07CDbool = true
  end
  if Currenttime >= self.Skill08[3] then
    self.Skill08CDbool = true
  end
  if Currenttime >= self.Skill09[3] then
    self.Skill09CDbool = true
  end
  if Currenttime >= self.Skill10[3] then
    self.Skill10CDbool = true
  end
  if Currenttime >= self.Skill11[3] then
    self.Skill11CDbool = true
  end
  if Currenttime >= self.Skill12[3] then
    self.Skill12CDbool = true
  end
  if Currenttime >= self.Skill13[3] then
    self.Skill13CDbool = true
  end
  if Currenttime >= self.Skill14[3] then
    self.Skill14CDbool = true
  end
  if Currenttime >= self.Skill15[3] then
    self.Skill15CDbool = true
  end
  if Currenttime >= self.Skill16[3] then
    self.Skill16CDbool = true
  end
  if Currenttime >= self.Skill17[3] then
    self.Skill17CDbool = true
  end
  if Currenttime >= self.Skill18[3] then
    self.Skill18CDbool = true
  end
  if Currenttime >= self.Skill19[3] then
    self.Skill19CDbool = true
  end
  if Currenttime >= self.Skill20[3] then
    self.Skill20CDbool = true
  end
  if Currenttime >= self.Skill21[3] then
    self.Skill21CDbool = true
  end
  if Currenttime >= self.Skill22[3] then
    self.Skill22CDbool = true
  end
  if Currenttime >= self.Skill23[3] then
    self.Skill23CDbool = true
  end
end

function M:skill_main_logic1()
  self:CheckCD()
  local SkillCasttime1 = get_npc_time(self.npc)
  local SkillCasttime = get_npc_time(self.npc)
  local DistanceToPlayer = get_npc_distance(self.npc, 1, self.target, false)
  if check_npc_status(self.npc, 2) then
    return
  end
  if self.target == nil then
    return
  end
  if self.Skill06CDbool == true and true == self.AllowCastSkill and self.isteleporting == false then
    self.isteleporting = true
    self.AllowCastSkill = false
    self.Skill06[3] = SkillCasttime1 + self.Skill06[2]
    self:teleport(2)
    self.Skill06CDbool = false
    self.Skill06teleportSkill = true
  end
  if self.isteleporting == false and false == self.iscombo then
    self.AllowCastSkill = true
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 201025030801 == magic_id then
    flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
  end
  if 201025030804 == magic_id then
    abort_magic_by_id(self.npc, 201025030803, 1)
  end
end

function M:teleport(r)
  self.AllowCastSkill = false
  self.isteleporting = true
  local randompoint = math.random(0, 360)
  local target_pos = get_npc_pos(self.target)
  self.teletportposx = target_pos.x + r * math.cos(randompoint)
  self.teletportposz = target_pos.z + r * math.sin(randompoint)
  cast_skill(self.npc, self.target, self.Skill08[1])
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if 2010250313 == skill_id then
    self.BehitTimer = 0
  end
end

function M:on_skill_end(npc, skill_id)
  local SkillCasttime1 = get_npc_time(self.npc)
  if npc ~= self.npc then
    return
  end
  if self.target == nil then
    return
  end
  if skill_id == self.Skill12[1] then
    return
  end
  if skill_id == self.UltSkill1ID then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, self.UltSkill2ID)
  end
  if skill_id == self.UltSkill2ID then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, self.UltSkill3ID)
  end
  if skill_id == self.UltSkill3ID then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, self.UltSkill4ID)
  end
  if skill_id == self.UltSkill4ID then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, self.UltSkill5ID)
  end
  if skill_id == self.UltSkill5ID then
    self.UltSkill4Hit = false
    self.iscombo = false
    self.IsUltStatus = false
  end
  if skill_id == self.BeHitCounter then
    abort_skill(self.npc, true)
    if self.UltSkill4Hit == true then
      cast_skill(self.npc, self.target, self.UltSkill5ID)
      self.UltSkill4Hit = false
      self.UltSkill3Hit = false
    end
    if true == self.UltSkill3Hit then
      cast_skill(self.npc, self.target, self.UltSkill4ID)
      self.UltSkill3Hit = false
      self.UltSkill2Hit = false
    end
    if true == self.UltSkill2Hit then
      cast_skill(self.npc, self.target, self.UltSkill3ID)
      self.UltSkill2Hit = false
      self.UltSkill1Hit = false
    end
    if true == self.UltSkill1Hit then
      cast_skill(self.npc, self.target, self.UltSkill2ID)
      self.UltSkill1Hit = false
    end
  end
  if skill_id == self.Skill07[1] then
    self.AllowCastSkill = false
    abort_skill(self.npc, false)
    self:teleport(2)
    self.Skill09teleportSkill = true
  end
  if skill_id == self.Skill09[1] then
    self.AllowCastSkill = false
    abort_skill(self.npc, false)
    self:teleport(2)
    self.Skill10teleportSkill = true
  end
  if skill_id == self.Skill20[1] then
    self.AllowCastSkill = false
    abort_skill(self.npc, false)
    self:teleport(5)
    self.Skill20teleportSkill = true
  end
  if skill_id == self.Skill21[1] then
    self.AllowCastSkill = false
    abort_skill(self.npc, false)
    self:teleport(2)
    self.Skill21teleportSkill = true
  end
  if skill_id == self.Skill14[1] and false == self.AtSkillEndBool then
    self.AllowCastSkill = false
    self.AtSkillEndBool = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.target, self.Skill15[1])
  end
  if skill_id == self.Skill15[1] and false == self.AtSkillEndBool then
    self.AllowCastSkill = false
    self.AtSkillEndBool = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.target, self.Skill16[1])
  end
  if skill_id == self.Skill16[1] and false == self.AtSkillEndBool then
    self.AllowCastSkill = false
    self.AtSkillEndBool = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.target, self.Skill17[1])
  end
  if skill_id == self.Skill17[1] and false == self.AtSkillEndBool then
    self.AllowCastSkill = false
    self.AtSkillEndBool = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.target, self.Skill18[1])
  end
  if skill_id == self.Skill18[1] then
    self.iscombo = false
  end
  if skill_id == self.Skill01[1] then
    self.AllowCastSkill = false
    self.AtSkillEndBool = true
    abort_skill(self.npc, false)
    cast_skill(self.npc, self.target, self.Skill02[1])
  end
  if skill_id == self.Skill02[1] then
    self.isteleporting = false
  end
  if skill_id == self.Skill06[1] then
    self.isteleporting = false
  end
  if skill_id == self.Skill21[1] then
    self:teleport(3)
  end
  if skill_id == self.Skill08[1] then
    self.AllowCastSkill = false
    if true == self.Skill01teleportSkill and false == self.AtSkillEndBool then
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill01[1])
      self.Skill01teleportSkill = false
    end
    if true == self.Skill06teleportSkill and false == self.AtSkillEndBool then
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill06[1])
      self.Skill06teleportSkill = false
    end
    if true == self.Skill09teleportSkill and false == self.AtSkillEndBool then
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill09[1])
      self.Skill09teleportSkill = false
    end
    if true == self.Skill10teleportSkill and false == self.AtSkillEndBool then
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill10[1])
      self.Skill10teleportSkill = false
    end
    if true == self.Skill20teleportSkill and false == self.AtSkillEndBool then
      self.Skill20teleportSkill = false
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill21[1])
      self.Skill21teleportSkill = true
    end
    if true == self.Skill21teleportSkill and false == self.AtSkillEndBool then
      self.AllowCastSkill = false
      self.AtSkillEndBool = true
      abort_skill(self.npc, false)
      cast_skill(self.npc, self.target, self.Skill22[1])
      self.Skill21teleportSkill = false
    end
  end
  if skill_id == self.Skill10[1] then
    self.iscombo = false
    self.isteleporting = false
  end
  self.AtSkillEndBool = false
  if self.iscombo ~= true then
    self.AllowCastSkill = true
  end
end

function M:Wander()
  local nowtime = get_npc_time(self.npc)
  if nowtime < self.wander_timer then
    return
  end
  if self.attackcount >= 3 then
    self.control = 1
  end
  if self.target == nil then
    return
  end
  if self.wanderteleportbool == false then
    self.wanderteleportbool = true
    self:wanderteleport(5)
  end
  local RandomLeftOrRight = math.random(0, 100)
  if RandomLeftOrRight <= 50 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
  self.wander_timer = nowtime + self.wander_interval
  self.wanderteleportbool = false
end

function M:wanderteleport(r)
  if nil == r then
    r = 10
  end
  local randompoint = math.random(0, 360)
  local target_pos = get_npc_pos(self.target)
  self.teletportposx = target_pos.x + r * math.cos(randompoint)
  self.teletportposz = target_pos.z + r * math.sin(randompoint)
  cast_skill(self.npc, self.target, self.Skill12[1])
end

function M:CheckSelfStatus()
  local current_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  if check_npc_status(self.npc, 1) == true then
    self.AllowCastSkill = false
  else
    self.AllowCastSkill = true
  end
  if true == self.StunBool then
    if false == self.StunBoolForEnter then
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.target, 2010250335)
    end
    if get_npc_time(self.npc) >= self.StunTimer + self.StunLastTime then
      self.StunBool = false
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.target, 2010250336)
    end
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 1) then
    self.BehitTimerbool = false
  end
end

function M:on_frame()
  if self.phase2 == true then
    self:skill_main_logic2()
  end
  if true == self.phase1 and self.phase2 == false then
    self:skill_main_logic1()
  end
  self:Wander()
  self:CheckSelfStatus()
  local npc_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) or is_cast_skill_time(self.npc, 2010250313, 1) then
    local npc_now_time = get_npc_time(self.npc)
    if false == self.BehitTimerbool and false == self.StunBool then
      self.BehitTimerbool = true
      self.BehitTimer = npc_now_time
    end
    if npc_now_time >= self.BehitTimer + self.BehitTimerInterval then
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.target, 2010250313)
    end
  end
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
