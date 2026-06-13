local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.nightSwitch = true
  local skills = {
    tripleHit = {
      2030460107,
      5,
      0,
      0,
      1.5,
      -45,
      45
    },
    doubleHit = {
      2030460101,
      6,
      math.random(5, 10),
      0,
      0.5,
      -45,
      45
    },
    dashOut = {
      2030460102,
      16,
      10,
      0,
      1.5,
      -45,
      45,
      -4
    },
    dashIn = {
      2030460103,
      5 + 5 * math.random(),
      3 + 5 * math.random(),
      2,
      6,
      -45,
      45
    },
    skill1 = {
      2030460104,
      0,
      0,
      2,
      4,
      -60,
      60
    },
    skill2 = {
      2030460105,
      0,
      math.random(5, 15),
      0,
      8,
      -60,
      60
    },
    skill3 = {
      2030460106,
      0,
      0,
      0,
      8,
      -60,
      60
    },
    waterball = {
      2030460108,
      20,
      math.random(6, 18),
      3,
      10,
      -60,
      60
    }
  }
  local nodes = {"drink", "specialATK"}
  local actMoves = {
    "moveToWater"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.states.specialATK.timer = math.random(1, 10)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.rangedAtk(_ENV.waterball, _ENV.specialATK)
    _ENV.meleeAtk(_ENV.doubleHit, _ENV.dashIn, _ENV.dashOut, _ENV.tripleHit)
    _ENV.specialATK(_ENV.skill1, _ENV.skill3)
  end
  do
    local waterball = monster.states.waterball
    
    function waterball.start(waterball)
      local self = waterball.monster
      waterball.isCastOver = false
      local skill = waterball.skill
      waterball.curSk = skill
      skill.state = waterball
      abort_skill(self.npc, true)
      waterball.timer = get_npc_time(waterball.monster.npc) + waterball.cd
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      local waterbulletdropplace = get_npc_offset_position(self.npc, nil, 0, 6)
      cast_skill(self.npc, nil, 2030460108, waterbulletdropplace.x, waterbulletdropplace.z)
      set_skill_end_to_idle(monster.npc, true)
    end
  end
  do
    local idle = monster.states.idle
    local active = monster.states.active
    local gotTarget = monster.states.gotTarget
    
    function gotTarget.start(gotTarget)
      gotTarget.base.start(gotTarget)
      monster.idleSwitch = false
      set_can_searched(monster.npc, true)
      set_npc_hp_visible(gotTarget.monster.npc, true)
      gotTarget.monster.search.minDis = 8
      gotTarget.monster.search.maxDis = 30
      gotTarget.monster.nightSwitch = false
      if get_cur_room_id() == 104401 or get_cur_room_id() == 104501 then
        gotTarget.monster.search.minDis = 8
        gotTarget.monster.search.maxDis = 99
        gotTarget.monster.nightSwitch = false
      end
    end
  end
  do
    local doubleHit = states.doubleHit
    
    function doubleHit.finTrans(doubleHit)
      local turn = math.random()
      local npc = doubleHit.monster.npc
      local target = doubleHit.monster.target
      local distance = get_npc_distance(npc, 1, target, true)
      if turn < 0.666 and distance <= 3 then
        doubleHit.monster.skills.dashOut.timer = 0
        return doubleHit.monster.states.dashOut
      elseif turn < 0.666 and distance > 3 then
        doubleHit.monster.skills.dashIn.timer = 0
        return doubleHit.monster.states.dashIn
      elseif turn > 0.666 then
        return doubleHit.monster.states.wander
      end
    end
    
    function monster.states.dashOut.finTrans(dashOut)
      local Trans = math.random()
      if Trans < 0.1 then
        return dashOut.monster.states.wander
      end
      if Trans > 0.1 then
        return dashOut.monster.states.specialATK
      end
    end
    
    function skills.dashOut.onEnd(dashOut)
      local monster = dashOut.monster
      monster.wander = {
        minDis = 0.5,
        maxDis = 10,
        minTime = 1,
        maxTime = 2,
        type = "walk"
      }
      
      local function resetwander(monster)
        monster.wander = {
          minDis = 0.5,
          maxDis = 5,
          minTime = 1,
          maxTime = 2,
          type = "walk"
        }
      end
      
      monster:doAfter(resetwander, 2)
      dashOut.base.onEnd(dashOut)
    end
    
    function monster.states.specialATK.isReady(specialATK)
      if specialATK.timer < get_npc_time(monster.npc) then
        return true
      end
      return false
    end
    
    function monster.states.specialATK.finish(specialATK)
      specialATK.timer = get_npc_time(monster.npc) + 25
    end
  end
  set_hud_config("warning", {
    Prefab = "UI_Hud10",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  set_hud_config("warning2", {
    Prefab = "UI_Hud11",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  do
    local HudSwitch = true
    monster.crystal = monster.crystal or {}
    monster.idleSwitch = true
    local noTarget = monster.states.noTarget
    local idle = monster.states.idle
    local Memory = monster.crystal
    monster.WarningDis = {
      3,
      9,
      1,
      4
    }
    monster.sneak = true == get_sync_var("qian_night") or true == get_sync_var("qian_dark")
    
    function idle.finish()
      if get_sync_var("qian_night") == true and not check_magic(monster.npc, 40104404) then
        active_hud(monster.npc, "warning", "attachpoint", false, nil)
        active_hud(monster.npc, "warning2", "attachpoint", true, nil)
        cast_magic(monster.npc, monster.npc, 2030430115)
        abort_magic_by_id(monster.npc, 2030430114, 99)
        
        local function delay()
          active_hud(monster.npc, "warning2", "attachpoint", false, nil)
        end
        
        monster:doAfter(delay, 1.5)
      end
      if (get_sync_var("qian_night") == true or true == get_sync_var("qian_dark")) and not check_magic(monster.npc, 40104404) then
        cast_missile3(monster.npc, monster.npc, nil, nil, 30010220103, 1)
      end
    end
    
    function idle.start(idle)
      idle.time = 3
      idle.cd = 8
      abort_skill(monster.npc, false)
      stop_move(idle.monster.npc)
    end
    
    function idle.tick(idle)
      if not monster.sneak then
        return
      end
      if not monster.crystal then
        return
      end
      if not monster.idleSwitch then
        return
      end
      if check_magic(monster.npc, 40104404) then
        return
      end
      if get_sync_var("qian_night") == true then
        local distance = get_npc_distance(monster.npc, 1, get_come_on_hero(), false)
        if get_npc_attr(monster.npc, 3) >= 99 then
          monster.search.minDis = 5
          monster.search.maxDis = 12
        end
        if distance <= monster.WarningDis[2] then
          if not check_magic(monster.npc, 2030430114) then
            cast_magic(monster.npc, monster.npc, 2030430114, 1)
          end
        else
          abort_magic_by_id(monster.npc, 2030430114, 1)
        end
        if distance < monster.WarningDis[1] then
          if not check_magic(monster.npc, 2030430112) then
            lookat_npc(monster.npc, get_come_on_hero(), false)
            cast_magic(monster.npc, monster.npc, 2030430112, 1)
          end
        elseif not check_magic(monster.npc, 2030430113) and get_npc_attr(monster.npc, 3) > 1 then
          cast_magic(monster.npc, monster.npc, 2030430113)
        end
        if get_npc_attr(monster.npc, 3) > 1 and true == HudSwitch then
          HudSwitch = false
          active_hud(monster.npc, "warning", "attachpoint", true, nil)
        elseif get_npc_attr(monster.npc, 3) < 1 and false == HudSwitch then
          HudSwitch = true
          active_hud(monster.npc, "warning", "attachpoint", false, nil)
        end
      end
      if Memory ~= monster.crystal and true == monster.crystal.permission then
        Memory = monster.crystal
        local selfpos = get_npc_pos(monster.npc)
        local tar_pos = get_position_offset_position(monster.crystal.Selfpos, selfpos, math.random() * 90 - 45, 1 * math.random())
        monster:idlemove(tar_pos)
      end
    end
  end
  do
    local skill1 = monster.states.skill1
    
    local function randomBaseCheck(actSkill, possibility)
      return monster.tool.randByTime(actSkill.monster, possibility) and actSkill.base.isReady(actSkill)
    end
    
    function skill1.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.5)
    end
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_npc_group_id(monster.npc) == 10410221 then
    monster.search.minDis = 2
    monster.search.maxDis = 5
  end
  if get_sync_var("qian_night") == true then
    set_can_searched(monster.npc, false)
    monster.search.minDis = monster.WarningDis[3]
    monster.search.maxDis = monster.WarningDis[3]
    cast_magic(monster.npc, monster.npc, 2030430111)
  end
  if true == get_sync_var("qian_dark") then
    monster.search.minDis = monster.WarningDis[4]
    monster.search.maxDis = monster.WarningDis[4]
  end
  if true == get_sync_var("nightSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
  if true == get_sync_var("darkSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.attack.interval = 1
  monster.states.dashIn.cd = 4
  monster.wander.minDis = 3
  local _ENV = monster.states
  _ENV.meleeAtk(_ENV.doubleHit, _ENV.dashOut, _ENV.tripleHit)
  _ENV.freeAtk(_ENV.dashIn)
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  local switch = check_npc_distance(monster.npc, get_come_on_hero(), monster.WarningDis[1], true)
  if 2030430112 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) <= 100 and switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
  if 2030430113 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) > 0 and not switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not monster.sneak then
    return
  end
  if monster.state.name == "idle" then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.idlemove(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
  
  local function delay()
    cast_magic(monster.npc, monster.npc, 2010440105, 1)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, pos)
  end
  
  monster:doAfter(delay, 0.5)
end

function monster.idleturn(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010220103 and monster.state.name == "idle" then
    local function delay()
      monster.search.minDis = 8
      
      monster.search.maxDis = 30
    end
    
    monster:doAfter(delay, 0.5)
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    if m2_cfg.Id == 203046010301 then
      monster:try_red_skill_counter(m1, m2)
    end
  end
end

return monster
