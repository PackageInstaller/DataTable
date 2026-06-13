local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Attack360 = {
      2020430101,
      9,
      math.random(1, 4),
      1,
      2.3,
      -45,
      45
    },
    jumpattack = {
      2020430102,
      15,
      math.random(1, 4),
      0,
      4,
      -45,
      45
    },
    tailattack = {
      2020430116,
      5,
      1,
      0,
      2,
      -45,
      45
    },
    tailattack2 = {
      2020430103,
      12,
      1,
      0,
      2.3,
      -45,
      45
    },
    tailattack3 = {
      2020430104,
      0,
      1,
      0,
      9999
    },
    drink_Start = {
      2020430105,
      0,
      15,
      0,
      999
    },
    drink_Loop = {
      2020430106,
      0,
      0,
      0,
      999
    },
    drink_End = {
      2020430107,
      0,
      0,
      0,
      999
    },
    Henshin = {
      2020430118,
      0,
      0,
      0,
      999
    }
  }
  local nodes = {"drink", "ATK"}
  local actMoves = {
    "moveToWater"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.crystal = true
  monster.nightSwitch = true
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.ATK, _ENV.Attack360, _ENV.jumpattack, _ENV.tailattack)
    _ENV.ATK(_ENV.tailattack2(_ENV.tailattack3))
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
    local tailattack3 = monster.states.tailattack3
    
    function tailattack3.start(tailattack3)
      local npc = tailattack3.monster.npc
      if check_magic(npc, 2020430199) then
        cast_magic(npc, npc, 2020430115, 1)
      else
        cast_magic(npc, npc, 2020430112, 1)
      end
      tailattack3.base.start(tailattack3)
    end
  end
  do
    local ATK = monster.states.ATK
    
    function ATK.isReady(attack)
      local npc = attack.monster.npc
      local hpmax = get_npc_attr(npc, 4)
      local hpnow = get_npc_attr(npc, 1)
      if hpnow / hpmax <= 0.8 then
        return true
      end
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

return monster
