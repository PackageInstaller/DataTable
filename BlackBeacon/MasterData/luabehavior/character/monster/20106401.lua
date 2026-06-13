local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local CDMAX = math.huge

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local t = monster.create_skill_node_cfg
  local skills = {
    atk_1 = t(2010640101, 15, 3, 0, 4, -60, 60),
    atk_2 = t(2010640102, 15, 5, 0, 4, -60, 60),
    atk_3 = t(2010640104, 25, 10, 0, 4, -60, 60),
    exatk_jump = t(2010640103, 20, 2, 5, 20, -60, 60),
    MeleeStrike_1 = t(2010640111),
    MeleeStrike_2 = t(2010640112),
    MeleeStrike_3 = t(2010640113),
    MeleeStrike_4 = t(2010640114),
    Darkstate_throwstaff = t(2010640121, 15),
    Quadruped_stab = t(2010640141, 10, 10, 0, 6, -60, 60),
    Quadruped_stab2 = t(2010640142, 15, 10, 0, 6, -60, 60),
    Leftlegparalysis1 = t(2010640151),
    Righttlegparalysis1 = t(2010640152),
    Righttlegparalysis2 = t(2010640153),
    Leftlegparalysis2 = t(2010640154),
    Leftlegparalysis1_end = t(2010640155),
    Righttlegparalysis1_end = t(2010640156),
    Righttlegparalysis2_end = t(2010640157),
    Leftlegparalysis2_end = t(2010640158),
    Lightstate_reclaimstaff = t(2010640122, 15),
    jumphit_hit = t(2010640123, 14, 0, 0, 6, -60, 60),
    fireball = t(2010640196, 30, 20, 0, 12),
    Chargedbeams = t(2010640197, 25, 2, 0, 25, -60, 60),
    Weakatk_1 = t(2010640181, 2, 2, 0, 8, -60, 60),
    Weakatk_2 = t(2010640182, 2, 2, 0, 8, -60, 60),
    Brokenlimbs_l1 = t(2010640192),
    Brokenlimbs_r1 = t(2010640192),
    Brokenlimbs_l2 = t(2010640192),
    Brokenlimbs_r2 = t(2010640192),
    Limb_l1 = t(2010640171),
    Limb_r1 = t(2010640172),
    Limb_l2 = t(2010640173),
    Limb_r2 = t(2010640174)
  }
  monster.TurnDarktimer = 5
  monster.TurnLighttimer = 9999
  local nodes = {
    "nmatk",
    "Strike",
    "Dark",
    "Light",
    "Weak",
    "LongATK"
  }
  monstBase._init(monster, skills, nil, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Light, _ENV.Darkstate_throwstaff, _ENV.Dark, _ENV.Lightstate_reclaimstaff(_ENV.jumphit_hit))
    _ENV.LongATK(_ENV.Chargedbeams, _ENV.fireball, _ENV.exatk_jump)
    _ENV.Dark(_ENV.Quadruped_stab(_ENV.Leftlegparalysis1(_ENV.Leftlegparalysis1_end)), _ENV.Quadruped_stab2(_ENV.Righttlegparalysis2(_ENV.Righttlegparalysis2_end)))
    _ENV.Light(_ENV.LongATK(_ENV.Chargedbeams, _ENV.fireball, _ENV.exatk_jump), _ENV.nmatk(_ENV.atk_1, _ENV.atk_2, _ENV.Strike(_ENV.MeleeStrike_1(_ENV.MeleeStrike_2(_ENV.MeleeStrike_3(_ENV.MeleeStrike_4)))), _ENV.atk_3))
  end
  do
    local _ENV = monster.states
    _ENV.nmatk.intervalOffset = 2
    _ENV.freeAtk.intervalOffset = 2
  end
  Change = true
  Ballet = {
    0,
    0,
    0,
    0
  }
  do
    local Dark = monster.states.Dark
    TurnDark = monster.states.Darkstate_throwstaff
    local Light = monster.states.Light
    local turnLight = monster.states.Lightstate_reclaimstaff
    DarkReady = false
    LightReady = true
    
    function TurnDark.isReady(TurnDark)
      if get_npc_time(monster.npc) > monster.TurnDarktimer and Change == false then
        LightReady = false
        cast_magic(monster.npc, monster.npc, 201064010101)
        cast_magic(monster.npc, monster.npc, 201064010106)
        return true
      end
    end
    
    function TurnDark.start(TurnDark)
      local positions = {
        {
          x = X1,
          z = Z1
        },
        {
          x = X2,
          z = Z2
        },
        {
          x = X3,
          z = Z3
        },
        {
          x = X4,
          z = Z4
        }
      }
      for i = 1, 4 do
        if 1 == Ballet[i] then
          cast_missile3(monster.npc, nil, positions[i].x, positions[i].z, 201064012106, 0)
        end
      end
      TurnDark.base.start(TurnDark)
    end
    
    function TurnDark.finish(TurnDark)
      monster.TurnDarktimer = get_npc_time(monster.npc) + 999999
      DarkReady = true
      TurnDark.base.finish(TurnDark)
    end
    
    function Dark.isReady(Dark)
      if DarkReady == true then
        return true
      end
      return false
    end
    
    function turnLight.isReady(turnLight)
      if Change == true and get_npc_time(monster.npc) > monster.TurnLighttimer then
        return true
      end
      return false
    end
    
    function turnLight.start(turnLight)
      local monster = turnLight.monster
      cast_magic(monster.npc, monster.npc, 201064010104)
      abort_magic_by_id(monster.npc, 201064010106, 1)
      lookat_position(monster.npc, X, Z, false)
      monster.TurnDarktimer = get_npc_time(monster.npc) + 3
      turnLight.base.start(turnLight)
    end
    
    function turnLight.finish(turnLight)
      abort_magic_by_id(monster.npc, 201064010104, 1)
      monster.TurnLighttimer = get_npc_time(monster.npc) + 999999
      Change = true
      LightReady = true
      turnLight.base.finish(turnLight)
    end
    
    local jumphit_hit = monster.states.jumphit_hit
    
    function jumphit_hit.start(jumphit_hit)
    end
    
    function Light.isReady(Light)
      if LightReady == true then
        return true
      end
      return false
    end
  end
  Paralysis1 = false
  Paralysis2 = false
  do
    local Quadruped_stab2 = monster.states.Quadruped_stab2
    local Quadruped_stab = monster.states.Quadruped_stab
    
    function Quadruped_stab.start(Quadruped_stab)
      cast_magic(monster.npc, monster.npc, 1999241, 1)
      Quadruped_stab.base.start(Quadruped_stab)
    end
    
    function Quadruped_stab.tick(Quadruped_stab)
      if Paralysis1 == true then
        function Quadruped_stab.tickTrans(Quadruped_stab)
          return monster.states.Leftlegparalysis1
        end
        
        return false
      end
    end
    
    function Quadruped_stab2.isReady(Quadruped_stab2)
      return get_npc_time(monster.npc) > Quadruped_stab2.timer
    end
    
    function Quadruped_stab2.start(Quadruped_stab2)
      cast_magic(monster.npc, monster.npc, 1999241, 1)
      Quadruped_stab2.base.start(Quadruped_stab2)
    end
    
    function Quadruped_stab2.tick(Quadruped_stab2)
      if Paralysis2 == true then
        function Quadruped_stab2.tickTrans(Quadruped_stab)
          return monster.states.Righttlegparalysis2
        end
        
        return false
      end
    end
    
    function Quadruped_stab2.finish(Quadruped_stab2)
      Quadruped_stab2.timer = get_npc_time(monster.npc) + Quadruped_stab2.cd
      DarkReady = false
      Change = true
      monster.TurnLighttimer = get_npc_time(monster.npc) + 2
      Quadruped_stab2.base.finish(Quadruped_stab2)
    end
    
    local Leftlegparalysis1 = monster.states.Leftlegparalysis1
    local Leftlegparalysis1_end = monster.states.Leftlegparalysis1_end
    
    function Leftlegparalysis1.isReady(Leftlegparalysis1)
      if Paralysis1 == true then
        Leftlegparalysis1.timer = 0
        return true
      end
      return false
    end
    
    function Leftlegparalysis1_end.finish(Leftlegparalysis1_end)
      Paralysis2 = false
      Leftlegparalysis1_end.base.finish(Leftlegparalysis1_end)
    end
    
    function Leftlegparalysis1_end.finTrans(Leftlegparalysis1_end)
      return monster.states.Quadruped_stab2
    end
    
    local Righttlegparalysis2 = monster.states.Righttlegparalysis2
    local Righttlegparalysis2_end = monster.states.Righttlegparalysis2_end
    
    function Righttlegparalysis2.isReady(Righttlegparalysis2)
      if Paralysis2 == true then
        Righttlegparalysis2.timer = 0
        return true
      end
      return false
    end
    
    function Righttlegparalysis2_end.finish(Righttlegparalysis2_end)
      Paralysis2 = false
      Righttlegparalysis2_end.base.finish(Righttlegparalysis2_end)
    end
    
    function Righttlegparalysis2_end.finTrans(Righttlegparalysis2)
      return monster.states.Quadruped_stab2
    end
  end
  do
    local Atk3 = monster.states.atk_3
    
    function Atk3.finish(Atk3)
      Atk3.timer = get_npc_time(monster.npc) + Atk3.cd
      Atk3.base.finish(Atk3)
    end
    
    function Atk3.finTrans(Atk3)
      return monster.states.wander
    end
  end
  monster.states.Strike.timer = 15
  do
    local Strike = monster.states.Strike
    local MeleeStrike_4 = monster.states.MeleeStrike_4
    monster.states.Strike.cd = 20
    monster.states.Strike.intcd = 10
    
    function Strike.isReady(Strike)
      if get_npc_distance(monster.npc, 1, monster.target, false) < 6 then
        return get_npc_time(monster.npc) > Strike.timer
      end
    end
    
    function Strike.finish(Strike)
      Strike.timer = get_npc_time(monster.npc) + Strike.cd
    end
    
    local strike4 = 0
    
    function MeleeStrike_4.isReady(MeleeStrike_4)
      if math.random() <= 0.4 or strike4 >= 3 then
        strike4 = 0
        return get_npc_time(monster.npc) > MeleeStrike_4.timer
      elseif math.random() > 0.4 then
        strike4 = strike4 + 1
      end
      return false
    end
    
    function MeleeStrike_4.finish(MeleeStrike_4)
      MeleeStrike_4.timer = get_npc_time(monster.npc) + Strike.cd
    end
    
    function monster.states.MeleeStrike_4.finTrans(MeleeStrike_4)
      return monster.states.wander
    end
  end
  local usenumber = 0
  do
    local nmatk = monster.states.nmatk
    local atk_3
    
    function nmatk.isReady()
      if usenumber < 6 then
        return true
      end
      return false
    end
    
    function nmatk.finish(nmatk)
      usenumber = usenumber + 1
      print(usenumber)
      nmatk.base.finish(nmatk)
    end
  end
  do
    local LongATK = monster.states.LongATK
    local Chargedbeams = monster.states.Chargedbeams
    local fireball = monster.states.fireball
    
    function LongATK.isReady(LongATK)
      if get_npc_distance(monster.npc, 1, monster.target, false) > 5 or usenumber >= 6 then
        return true
      end
      return false
    end
    
    function Chargedbeams.isReady(Chargedbeams)
      if (get_npc_distance(monster.npc, 1, monster.target, false) > 10 or usenumber >= 6) and math.random() < 0.5 then
        return get_npc_time(monster.npc) > Chargedbeams.timer
      end
      return false
    end
    
    function Chargedbeams.finish(Chargedbeams)
      usenumber = 0
      Chargedbeams.timer = get_npc_time(monster.npc) + Chargedbeams.cd
      Chargedbeams.base.finish(Chargedbeams)
    end
    
    function fireball.isReady(fireball)
      if (get_npc_distance(monster.npc, 1, monster.target, false) > 10 or usenumber >= 6) and math.random() > 0.5 then
        return get_npc_time(monster.npc) > fireball.timer
      end
      return false
    end
    
    function fireball.finish(fireball)
      usenumber = 0
      fireball.timer = get_npc_time(monster.npc) + fireball.cd
      fireball.base.finish(fireball)
    end
  end
  do
    local exatk_jump = monster.states.exatk_jump
    
    function exatk_jump.start(exatk_jump)
      local monster = exatk_jump.monster
      if monster.target then
        lookat_npc(monster.npc, monster.target, false)
      end
      exatk_jump.base.start(exatk_jump)
    end
  end
  local Ready = true
  local D_atk_Ready = false
  Rebound = 0
  Reboundbool = false
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc then
    if m2_cfg.Id == 201064014101 and 3 ~= m1_cfg.MissileTypeTag then
      abort_magic_by_id(monster.npc, 1999241, 1)
      play_effect(monster.npc, "Fx_common_RedSkill1", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill2", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill4", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill5", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkillCounter", "HitCase", false)
      Paralysis1 = true
    end
    if m2_cfg.Id == 201064014201 and 3 ~= m1_cfg.MissileTypeTag then
      abort_magic_by_id(monster.npc, 1999241, 1)
      play_effect(monster.npc, "Fx_common_RedSkill1", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill2", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill4", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkill5", "HitCase", false)
      play_effect(monster.npc, "Fx_common_RedSkillCounter", "HitCase", false)
      Paralysis2 = true
    end
    if m2_cfg.Id == 201064016201 and 3 ~= m1_cfg.MissileTypeTag then
      Rebound = Rebound + 1
      remove_missile_by_id(201064016201, monster.npc, true)
      print(Rebound)
      if Rebound < 3 then
        set_npc_pretend_visible(monster.npc, false)
        flash_to_pos(monster.npc, 0, 222, 0)
        set_can_searched(monster.npc, true)
        abort_magic_by_id(monster.npc, 1999241, 1)
        monster:try_red_skill_counter(m1, m2)
      end
      if Rebound >= 3 then
        Reboundbool = true
        set_npc_pretend_visible(monster.npc, false)
        flash_to_pos(monster.npc, 0, 222, 0)
        set_can_searched(monster.npc, true)
        abort_magic_by_id(monster.npc, 1999241, 1)
        play_effect(monster.npc, "Fx_common_RedSkill1", "HitCase", false)
        play_effect(monster.npc, "Fx_common_RedSkill2", "HitCase", false)
        play_effect(monster.npc, "Fx_common_RedSkill4", "HitCase", false)
        play_effect(monster.npc, "Fx_common_RedSkill5", "HitCase", false)
        play_effect(monster.npc, "Fx_common_RedSkillCounter", "HitCase", false)
      end
    end
    if m2_cfg.Id == 201064019101 and 3 ~= m1_cfg.MissileTypeTag then
      Fire_pos = get_missile_pos(m2)
      remove_missile_by_id(201064019101, monster.npc, true)
      if Fire_pos ~= nil then
        local positions = {
          {
            x = X1,
            z = Z1
          },
          {
            x = X2,
            z = Z2
          },
          {
            x = X3,
            z = Z3
          },
          {
            x = X4,
            z = Z4
          }
        }
        local targetPos = positions[math.random(1, 4)]
        cast_missile3(player, nil, Fire_pos.x, Fire_pos.z, 201064019102, 0, targetPos.x, targetPos.z)
      end
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missle_cfg, missle)
  if missle_cfg.Id == 201064010201 then
    monster.states.Strike.timer = monster.states.Strike.timer + 8
    monster.states.atk_3.timer = 0
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  change_follow_target_new(3, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
  X1, Y1, Z1 = get_area_pos("LT")
  X2, Y2, Z2 = get_area_pos("RT")
  X3, Y3, Z3 = get_area_pos("LB")
  X4, Y4, Z4 = get_area_pos("RB")
  cast_missile3(monster.npc, nil, X1, Z1, 201064019801, 0)
  cast_missile3(monster.npc, nil, X2, Z2, 201064019802, 0)
  cast_missile3(monster.npc, nil, X3, Z3, 201064019803, 0)
  cast_missile3(monster.npc, nil, X4, Z4, 201064019804, 0)
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201064012105 then
    X = pos_x
    Z = pos_z
  end
end

return monster
