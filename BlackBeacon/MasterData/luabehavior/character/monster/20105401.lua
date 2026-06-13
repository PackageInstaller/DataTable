local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 999,
    minTime = 1.5,
    maxTime = 1.5,
    type = "run"
  }
  monster.search = {minDis = 100, maxDis = 100}
  local actskills = {
    parryA_start = {
      2010540101,
      0,
      0
    },
    parryA_loop = {
      2010540102,
      0,
      0
    },
    parryA_end = {
      2010540103,
      0,
      0
    },
    parryB_start = {
      2010540104,
      0,
      0
    },
    parryB_loop = {
      2010540105,
      0,
      0
    },
    parryB_end = {
      2010540106,
      0,
      0
    },
    parryC_start = {
      2010540107,
      0,
      0
    },
    parryC_loop = {
      2010540108,
      0,
      0
    },
    parryC_end = {
      2010540109,
      0,
      0
    },
    Triple_start = {
      2010540110,
      0,
      2
    },
    Triple_loop = {
      2010540111,
      0,
      0
    },
    Triple_end = {
      2010540112,
      0,
      0
    },
    quadruple_start = {
      2010540113,
      0,
      2
    },
    quadruple_loop = {
      2010540114,
      0,
      0
    },
    quadruple_end = {
      2010540115,
      0,
      0
    },
    hide_clawA = {
      2010540116,
      50,
      25
    },
    idleA = {
      2010540117,
      0,
      0
    },
    hide = {
      2010540119,
      45,
      9999
    },
    hit1_1 = {
      2010540120,
      0,
      0
    },
    hit1_2 = {
      2010540121,
      0,
      0
    },
    hit1_3 = {
      2010540122,
      0,
      0
    },
    hide_clawB = {
      2010540123,
      0,
      9999
    },
    idleB = {
      2010540124,
      0,
      0
    },
    dragonball_start = {
      2010540125,
      70,
      10
    },
    dragonball_end = {
      2010540126,
      0,
      0
    },
    fire_wall = {
      2010540127,
      120,
      10
    },
    fire_wall_end = {2010540135},
    hit2_1 = {
      2010540136,
      0,
      0
    },
    hit2_2 = {
      2010540137,
      0,
      0
    },
    hit2_3 = {
      2010540138,
      0,
      0
    },
    stab = {
      2010540128,
      0,
      0
    },
    phase1_1 = {
      2010540129,
      0,
      0
    },
    phase1_2 = {
      2010540130,
      0,
      0
    },
    phase1_3 = {
      2010540131,
      0,
      0
    },
    phase1_4 = {
      2010540132,
      0,
      0
    },
    phase1_5 = {
      2010540133,
      0,
      0
    }
  }
  local nodes = {
    "ComboA",
    "ComboB",
    "ComboC",
    "ChangeState",
    "StabCombo",
    "Dragonball",
    "FireWall",
    "Ult",
    "TurnTo",
    "GP"
  }
  monstBase._init(monster, actskills, nil, nodes)
  monster.Gpskill = {}
  monster.stone_now_time = 0
  monster.ai_state = 1
  monster.crash = 1
  monster.coordinates = 1
  monster.cam = 0
  monster.Stone_timeA = 0
  monster.Stone_timeB = 0
  monster.FireWall_stoneC = 0
  monster.FireWall_stoneF = 0
  monster.FollowNPC = {}
  monster.states.attack.interval = 0
  monster.partNPC = {}
  monster.FocusMIsA = nil
  monster.FocusMIsB = nil
  monster.FocusMIsC = nil
  monster.FocusMIsD = nil
  monster.Gpmissile = {
    201054010112,
    201054010417,
    201054010418,
    201054010712,
    201054011027,
    201054011028,
    201054011029,
    201054011334,
    201054011335,
    201054011336,
    201054011337
  }
  do
    local base_pos = {
      x = 0,
      y = 173.27,
      z = 336.5
    }
    local face_to_positions = {
      [201054013403] = {x = 30.72, z = 328.2},
      [201054013404] = {x = -11.8, z = 365.9},
      [201054013405] = {x = -24.3, z = 316.0}
    }
    monster.Follow_NPC_pos = {
      [201054013403] = get_position_offset_position(base_pos, face_to_positions[201054013403], 0, 8),
      [201054013404] = get_position_offset_position(base_pos, face_to_positions[201054013404], 0, 3),
      [201054013405] = get_position_offset_position(base_pos, face_to_positions[201054013405], 0, 8)
    }
  end
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ChangeState, _ENV.Ult, _ENV.TurnTo, _ENV.GP)
    _ENV.Ult(_ENV.FireWall, _ENV.Dragonball)
    _ENV.TurnTo(_ENV.ComboC, _ENV.ComboA)
    _ENV.GP(_ENV.Triple_start, _ENV.quadruple_start)
    _ENV.wander(_ENV.idle)
    _ENV.ComboA(_ENV.hide_clawA(_ENV.idleA))
    _ENV.ComboC(_ENV.hide_clawB(_ENV.idleB))
    _ENV.Dragonball(_ENV.dragonball_start(_ENV.parryB_start))
    _ENV.ChangeState(_ENV.phase1_1(_ENV.phase1_2(_ENV.phase1_3(_ENV.phase1_4(_ENV.phase1_5)))))
    _ENV.FireWall(_ENV.fire_wall(_ENV.fire_wall_end(_ENV.hit2_1(_ENV.hit2_2(_ENV.hit2_3(_ENV.parryA_start))))))
  end
  do
    local parryA_start = monster.skills.parryA_start
    local parryA_loop = monster.skills.parryA_loop
    local parryA_end = monster.skills.parryA_end
    local parryB_start = monster.skills.parryB_start
    local parryB_loop = monster.skills.parryB_loop
    local parryB_end = monster.skills.parryB_end
    local parryC_start = monster.skills.parryC_start
    local parryC_loop = monster.skills.parryC_loop
    local parryC_end = monster.skills.parryC_end
    local idleA = monster.skills.idleA
    local hit1_3 = monster.skills.hit1_3
    local idleB = monster.skills.idleB
    local dragonball_start = monster.skills.dragonball_start
    local dragonball_end = monster.skills.dragonball_end
    local Triple_start = monster.skills.Triple_start
    local Triple_loop = monster.skills.Triple_loop
    local Triple_end = monster.skills.Triple_end
    local quadruple_start = monster.skills.quadruple_start
    local quadruple_loop = monster.skills.quadruple_loop
    local quadruple_end = monster.skills.quadruple_end
    parryA_start(parryA_loop(parryA_end))
    parryB_start(parryB_loop(parryB_end))
    parryC_start(parryC_loop(parryC_end))
    Triple_start(Triple_loop(Triple_end))
    quadruple_start(quadruple_loop(quadruple_end))
    hit1_3(parryA_start)
    idleA(parryC_start)
    idleB(parryA_start)
    dragonball_start(dragonball_end)
  end
  do
    local active = monster.states.active
    local attack = monster.states.attack
    attack.random = math.random()
    
    function attack.finish(attack)
      attack.base.finish(attack)
      attack.random = math.random()
    end
    
    function active.start(active)
      active.base.start(active)
    end
    
    do
      local ComboA = monster.states.ComboA
      local ComboB = monster.states.ComboB
      local ComboC = monster.states.ComboC
      local TurnTo = monster.states.TurnTo
      TurnTo.timer = 0
      
      function TurnTo.isReady()
        return TurnTo.timer < get_npc_time(monster.npc)
      end
      
      function TurnTo.start(TurnTo)
        remove_missile_by_id(201054012508, monster.npc)
      end
      
      function TurnTo.finish(TurnTo)
        cast_missile3(monster.npc, nil, nil, nil, 201054012508)
      end
      
      function ComboA.isReady(ComboA)
        return 1 == monster.coordinates
      end
      
      function ComboB.isReady()
        if 2 ~= monster.coordinates then
          return false
        end
        if 1 == monster.ai_state then
          return attack.random < 0.3
        else
          return attack.random >= 0.3
        end
      end
      
      function ComboC.isReady()
        return 2 == monster.coordinates
      end
      
      function ComboA.finish()
        TurnTo.timer = get_npc_time(monster.npc) + 45
      end
      
      function ComboB.finish()
        TurnTo.timer = get_npc_time(monster.npc) + 40
      end
      
      function ComboC.finish()
        TurnTo.timer = get_npc_time(monster.npc) + 80
      end
    end
    do
      local Ult = monster.states.Ult
      local FireWall = monster.states.FireWall
      local Dragonball = monster.states.Dragonball
      Ult.timer = 0
      
      function Ult.isReady()
        if Ult.timer < get_npc_time(monster.npc) then
          return true
        end
        return false
      end
      
      function Ult.finish()
        Ult.timer = get_npc_time(monster.npc) + 15
      end
      
      function FireWall.isReady()
        if 1 ~= monster.coordinates then
          return false
        end
        if 1 == monster.ai_state then
          return attack.random < 0.3
        else
          return attack.random >= 0.3
        end
      end
      
      function FireWall.start(FireWall)
        remove_missile_by_id(201054012508, monster.npc)
      end
      
      function FireWall.finish(FireWall)
        cast_missile3(monster.npc, nil, nil, nil, 201054012508)
      end
      
      function Dragonball.isReady()
        if 2 == monster.coordinates then
          return true
        end
        if 1 == monster.ai_state then
          return attack.random >= 0.3
        else
          return attack.random < 0.3
        end
      end
    end
    do
      local GP = monster.states.GP
      local Triple_start = monster.states.Triple_start
      local quadruple_start = monster.states.quadruple_start
      
      function GP.isReady()
        return true
      end
      
      function Triple_start.isReady(Triple_start)
        if attack.random <= 0.5 then
          return Triple_start.base.isReady(Triple_start)
        end
        return false
      end
      
      function quadruple_start.isReady(quadruple_start)
        if attack.random > 0.5 then
          return quadruple_start.base.isReady(quadruple_start)
        end
        return false
      end
    end
  end
  do
    local parryA_start = monster.skills.parryA_start
    local parryA_loop = monster.skills.parryA_loop
    local parryB_start = monster.skills.parryB_start
    local parryB_loop = monster.skills.parryB_loop
    local parryC_start = monster.skills.parryC_start
    local parryC_loop = monster.skills.parryC_loop
    
    function parryA_start.onBegin(parryA_start)
      parryA_start.base.onBegin(parryA_start)
      local Q1_pos = {x = 0, z = 345}
      local Q2_pos = {x = 5, z = 330}
      for k, v in pairs(monster.FollowNPC) do
        remove_npc(v)
      end
      cast_magic(monster.npc, monster.npc, 2010540743, 1)
      if 1 == monster.coordinates then
        set_camera(2010540102, true, true)
        flash_to_pos(monster.npc, Q1_pos.x, Q1_pos.z)
      else
        set_camera(2010540104, true, true)
        flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      end
      lookat_position(monster.npc, 20, 300, false)
    end
    
    function parryA_loop.onBegin(parryA_loop)
      if 1 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010201, true, true)
        set_keyframe_enable(monster.npc, 201054010202, false, true)
      elseif 2 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010201, false, true)
        set_keyframe_enable(monster.npc, 201054010202, true, true)
      end
    end
    
    function parryB_start.onBegin(parryB_start)
      parryB_start.base.onBegin(parryB_start)
      cast_magic(monster.npc, monster.npc, 2010540743, 1)
      if 1 == monster.coordinates then
        local Q1_pos = {x = 0, z = 345}
        set_camera(2010540102, true, true)
        flash_to_pos(monster.npc, Q1_pos.x, Q1_pos.z)
        lookat_position(monster.npc, 20, 300, false)
      elseif 2 == monster.coordinates then
        local Q2_pos = {x = 5, z = 330}
        set_camera(2010540104, true, true)
        flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
        lookat_position(monster.npc, 0, 336, false)
      end
    end
    
    function parryB_loop.onBegin(parryB_loop)
      if 1 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010501, true, true)
        set_keyframe_enable(monster.npc, 201054010502, false, true)
        set_keyframe_enable(monster.npc, 201054010503, false, true)
      elseif 2 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010501, false, true)
        set_keyframe_enable(monster.npc, 201054010502, true, true)
        set_keyframe_enable(monster.npc, 201054010503, false, true)
      elseif 3 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010501, false, true)
        set_keyframe_enable(monster.npc, 201054010502, false, true)
        set_keyframe_enable(monster.npc, 201054010503, true, true)
      end
    end
    
    function parryC_start.onBegin(parryC_start)
      parryC_start.base.onBegin(parryC_start)
      local Q2_pos = {x = 5, z = 330}
      set_camera(2010540104, true, true)
      lookat_position(monster.npc, 0, 336, false)
    end
    
    function parryC_loop.onBegin(parryC_loop)
      if 1 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010801, true, true)
        set_keyframe_enable(monster.npc, 201054010802, false, true)
      elseif 2 == monster.crash then
        set_keyframe_enable(monster.npc, 201054010801, false, true)
        set_keyframe_enable(monster.npc, 201054010802, true, true)
      end
    end
  end
  do
    local ComboA = monster.states.ComboA
    
    function ComboA.finish(ComboA)
      monster.states.hide.timer = get_npc_time(monster.npc) + 25
      monster.states.hide_clawB.timer = get_npc_time(monster.npc) + 25
    end
  end
  do
    local hide_clawA = monster.skills.hide_clawA
    
    function hide_clawA.onBegin(hide_clawA)
      hide_clawA.base.onBegin(hide_clawA)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011807, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011808, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011809, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011854, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011855, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011856, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011857, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011858, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011859, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011860, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011861, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011862, 1, 0, 335.25, 184)
    end
    
    function hide_clawA.onEnd(hide_clawA)
      hide_clawA.base.onEnd(hide_clawA)
      local Q2_pos = {x = 5, z = 330}
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      monster.coordinates = 2
      set_camera(2010540103, true, true)
    end
  end
  do
    local hide = monster.skills.hide
    local hit1_1 = monster.states.hit1_1
    local hit1_2 = monster.states.hit1_2
    local hit1_3 = monster.states.hit1_3
    local ComboB = monster.states.ComboB
    
    function hide.onBegin(hide)
      hide.base.onBegin(hide)
      monster.coordinates = 1
      cast_magic(monster.npc, monster.npc, 2010540743, 1)
    end
    
    function hit1_1.start(hit1_1)
      hit1_1.base.start(hit1_1)
      local Q2_pos = {x = 2.2, z = 333.7}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012001, false, true)
        set_keyframe_enable(monster.npc, 201054012007, false, true)
        set_keyframe_enable(monster.npc, 201054012008, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012002, false, true)
        set_keyframe_enable(monster.npc, 201054012003, false, true)
        set_keyframe_enable(monster.npc, 201054012006, false, true)
        set_keyframe_enable(monster.npc, 201054012001, true, true)
        set_keyframe_enable(monster.npc, 201054012007, true, true)
        set_keyframe_enable(monster.npc, 201054012008, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, 0, 330, false)
      set_camera(2010540105, true, true)
    end
    
    function hit1_2.start(hit1_2)
      hit1_2.base.start(hit1_2)
      local Q2_pos = {x = -1.2, z = 333}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012101, false, true)
        set_keyframe_enable(monster.npc, 201054012107, false, true)
        set_keyframe_enable(monster.npc, 201054012108, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012102, false, true)
        set_keyframe_enable(monster.npc, 201054012103, false, true)
        set_keyframe_enable(monster.npc, 201054012106, false, true)
        set_keyframe_enable(monster.npc, 201054012101, true, true)
        set_keyframe_enable(monster.npc, 201054012107, true, true)
        set_keyframe_enable(monster.npc, 201054012108, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, 20, 300, false)
      set_camera(2010540106, true, true)
    end
    
    function hit1_3.start(hit1_3)
      hit1_3.base.start(hit1_3)
      local Q2_pos = {x = -1.51, z = 330.5}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012201, false, true)
        set_keyframe_enable(monster.npc, 201054012207, false, true)
        set_keyframe_enable(monster.npc, 201054012208, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054012202, false, true)
        set_keyframe_enable(monster.npc, 201054012203, false, true)
        set_keyframe_enable(monster.npc, 201054012206, false, true)
        set_keyframe_enable(monster.npc, 201054012201, true, true)
        set_keyframe_enable(monster.npc, 201054012207, true, true)
        set_keyframe_enable(monster.npc, 201054012208, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, 0, 330, false)
      set_camera(2010540107, true, true)
    end
  end
  do
    local hide_clawB = monster.skills.hide_clawB
    
    function hide_clawB.onEnd(hide_clawB)
      hide_clawB.base.onEnd(hide_clawB)
      monster.coordinates = 1
      set_camera(2010540103, true, true)
      cast_magic(monster.npc, monster.npc, 2010540744, 1)
    end
    
    function hide_clawB.onBegin(hide_clawB)
      hide_clawB.base.onBegin(hide_clawB)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011807, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011808, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011809, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011854, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011855, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011856, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011857, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011858, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, 3.5, 330, 201054011859, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011860, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011861, 1, 0, 335.25, 184)
      cast_missile_new(monster.npc, nil, -8, 345, 201054011862, 1, 0, 335.25, 184)
    end
  end
  do
    local Triple_loop = monster.skills.Triple_loop
    local quadruple_loop = monster.skills.quadruple_loop
    
    function Triple_loop.onBegin(Triple_loop)
      if 1 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011101, true, true)
        set_keyframe_enable(monster.npc, 201054011102, false, true)
        set_keyframe_enable(monster.npc, 201054011103, false, true)
        set_keyframe_enable(monster.npc, 201054011104, false, true)
      elseif 2 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011101, false, true)
        set_keyframe_enable(monster.npc, 201054011102, true, true)
        set_keyframe_enable(monster.npc, 201054011103, false, true)
        set_keyframe_enable(monster.npc, 201054011104, false, true)
      elseif 3 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011101, false, true)
        set_keyframe_enable(monster.npc, 201054011102, false, true)
        set_keyframe_enable(monster.npc, 201054011103, true, true)
        set_keyframe_enable(monster.npc, 201054011104, false, true)
      elseif 4 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011101, false, true)
        set_keyframe_enable(monster.npc, 201054011102, false, true)
        set_keyframe_enable(monster.npc, 201054011103, false, true)
        set_keyframe_enable(monster.npc, 201054011104, true, true)
      end
    end
    
    function quadruple_loop.onBegin(quadruple_loop)
      if 1 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011401, true, true)
        set_keyframe_enable(monster.npc, 201054011402, false, true)
        set_keyframe_enable(monster.npc, 201054011403, false, true)
        set_keyframe_enable(monster.npc, 201054011404, false, true)
        set_keyframe_enable(monster.npc, 201054011405, false, true)
      elseif 2 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011401, false, true)
        set_keyframe_enable(monster.npc, 201054011402, true, true)
        set_keyframe_enable(monster.npc, 201054011403, false, true)
        set_keyframe_enable(monster.npc, 201054011404, false, true)
        set_keyframe_enable(monster.npc, 201054011405, false, true)
      elseif 3 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011401, false, true)
        set_keyframe_enable(monster.npc, 201054011402, false, true)
        set_keyframe_enable(monster.npc, 201054011403, true, true)
        set_keyframe_enable(monster.npc, 201054011404, false, true)
        set_keyframe_enable(monster.npc, 201054011405, false, true)
      elseif 4 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011401, false, true)
        set_keyframe_enable(monster.npc, 201054011402, false, true)
        set_keyframe_enable(monster.npc, 201054011403, false, true)
        set_keyframe_enable(monster.npc, 201054011404, true, true)
        set_keyframe_enable(monster.npc, 201054011405, false, true)
      elseif 5 == monster.crash then
        set_keyframe_enable(monster.npc, 201054011401, false, true)
        set_keyframe_enable(monster.npc, 201054011402, false, true)
        set_keyframe_enable(monster.npc, 201054011403, false, true)
        set_keyframe_enable(monster.npc, 201054011404, false, true)
        set_keyframe_enable(monster.npc, 201054011405, true, true)
      end
    end
  end
  do
    local stab = monster.skills.stab
    local StabCombo = monster.states.StabCombo
    
    function stab.onBegin(stab)
      stab.base.onBegin(stab)
      if 1 == monster.coordinates then
        set_keyframe_enable(monster.npc, 201054012801, true, true)
        set_keyframe_enable(monster.npc, 201054012802, true, true)
        set_keyframe_enable(monster.npc, 201054012803, true, true)
        set_keyframe_enable(monster.npc, 201054012816, false, true)
        set_keyframe_enable(monster.npc, 201054012817, false, true)
        set_keyframe_enable(monster.npc, 201054012818, false, true)
      end
      if 1 ~= monster.coordinates then
        set_keyframe_enable(monster.npc, 201054012816, true, true)
        set_keyframe_enable(monster.npc, 201054012817, true, true)
        set_keyframe_enable(monster.npc, 201054012818, true, true)
        set_keyframe_enable(monster.npc, 201054012801, false, true)
        set_keyframe_enable(monster.npc, 201054012802, false, true)
        set_keyframe_enable(monster.npc, 201054012803, false, true)
      end
    end
    
    function stab.tick(stab)
      if check_magic(monster.npc, 2010540623) then
        set_scene_camera(2010540104)
      end
      if check_magic(monster.npc, 2010540647) then
        set_scene_camera(2010540106)
      end
      if check_magic(monster.npc, 2010540636) then
        set_lock_velocity(monster.npc, 0.5)
      end
      if check_magic(monster.npc, 2010540664) then
        set_scene_camera(2010540124)
      end
      if check_magic(monster.npc, 2010540666) then
        set_scene_camera(2010540127)
      end
      if check_magic(monster.npc, 2010540665) then
        set_scene_camera(2010540121)
      end
    end
    
    function StabCombo.tick()
      if check_magic(monster.npc, 2010540641) then
        local missile_list1 = {
          201054011811,
          201054011812,
          201054011813
        }
        local player = get_come_on_hero()
        local playerpos = get_npc_pos(player)
        local nowtime = get_npc_time(monster.npc)
        if nowtime > monster.stone_now_time then
          local scale = 6
          local target_pos_x = {
            playerpos.x
          }
          target_pos_x = playerpos.x + math.random() + math.random(-scale, scale)
          local target_pos_z = {
            playerpos.z
          }
          target_pos_z = playerpos.z + math.random() + math.random(-scale, scale)
          for _, missile_id in ipairs(missile_list1) do
            cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_id, 0)
          end
          monster.stone_now_time = nowtime + 0.5
        end
      end
    end
  end
  do
    local Dragonball = monster.states.Dragonball
    local dragonball_start = monster.skills.dragonball_start
    
    function Dragonball.tick(Dragonball)
      local id = get_cur_camera_id()
      if 2010540117 == id or check_magic(monster.npc, 2010540758) then
        monster.Stone(monster, 1.2, 0.6)
      end
    end
    
    function dragonball_start.onBegin(dragonball_start)
      dragonball_start.base.onBegin(dragonball_start)
      set_ui_object_visible("fight", "Right", false)
      set_ui_object_visible("fight", "TeamHeads", false)
      set_ui_object_visible("fight", "UltInfo", false)
      joystick_end()
      if 1 == monster.coordinates then
        cast_missile_new(monster.npc, nil, -15.9, 336.6, 201054013417, 1, -15.9, 336.6, 100, 200)
        cast_missile_new(monster.npc, nil, -25.3, 360.2, 201054013418, 1, -25.3, 360.2, 100, 200)
        cast_missile_new(monster.npc, nil, 0.47, 354.7, 201054013419, 1, 0.47, 354.7, 100, 200)
        cast_missile_new(monster.npc, nil, -9.8, 381.2, 201054013419, 1, -9.8, 381.2, 100, 200)
        cast_missile_new(monster.npc, nil, -39.9, 343.5, 201054013420, 1, -39.9, 343.5, 100, 200)
        cast_missile_new(monster.npc, nil, -36.8, 384.1, 201054013419, 1, -36.8, 384.1, 100, 200)
        cast_missile_new(monster.npc, nil, 12.9, 378.4, 201054013418, 1, 12.9, 378.4, 100, 200)
        cast_missile_new(monster.npc, nil, -49.9, 364.6, 201054013417, 1, -49.9, 364.6, 100, 200)
        cast_missile_new(monster.npc, nil, -20.0, 406.7, 201054013418, 1, -20.0, 406.7, 100, 200)
        cast_missile_new(monster.npc, nil, 5.96, 402.9, 201054013420, 1, 5.96, 402.9, 100, 200)
        cast_missile_new(monster.npc, nil, -62.5, 385.9, 201054013420, 1, -62.5, 385.9, 100, 200)
      else
        cast_missile_new(monster.npc, nil, 14, 302.8, 201054013417, 1, 10, 348.8, 100, 200)
        cast_missile_new(monster.npc, nil, 0.2, 325.4, 201054013418, 1, 0.2, 325.4, 100, 200)
        cast_missile_new(monster.npc, nil, 17.0, 348, 201054013419, 1, 17.0, 348, 100, 200)
        cast_missile_new(monster.npc, nil, -2.9, 284.8, 201054013419, 1, -2.9, 284.8, 100, 200)
        cast_missile_new(monster.npc, nil, 27.2, 322.5, 201054013420, 1, 27.2, 322.5, 100, 200)
        cast_missile_new(monster.npc, nil, 27.2, 322.5, 201054013419, 1, 27.2, 322.5, 100, 200)
        cast_missile_new(monster.npc, nil, 49.9, 319.7, 201054013418, 1, 49.9, 319.7, 100, 200)
        cast_missile_new(monster.npc, nil, 37.4, 296, 201054013417, 1, 37.4, 296, 100, 200)
        cast_missile_new(monster.npc, nil, 21.1, 277.9, 201054013418, 1, 21.1, 277.9, 100, 200)
        cast_missile_new(monster.npc, nil, -12.9, 305.9, 201054013420, 1, -12.9, 305.9, 100, 200)
        cast_missile_new(monster.npc, nil, 42.9, 344.2, 201054013420, 1, 42.9, 344.2, 100, 200)
      end
    end
    
    function dragonball_start.onEnd(dragonball_start)
      dragonball_start.base.onEnd(dragonball_start)
      
      local function delay()
        set_ui_object_visible("fight", "Right", true)
        set_ui_object_visible("fight", "TeamHeads", true)
        set_ui_object_visible("fight", "UltInfo", true)
      end
      
      monster:doAfter(delay, 1)
    end
  end
  do
    local FireWall = monster.states.FireWall
    local fire_wall = monster.skills.fire_wall
    
    function fire_wall.onBegin(fire_wall)
      fire_wall.base.onBegin(fire_wall)
      set_keyframe_enable(monster.npc, 201054012711, true, true)
      set_keyframe_enable(monster.npc, 201054012712, true, true)
      set_keyframe_enable(monster.npc, 201054012709, false, true)
      set_keyframe_enable(monster.npc, 201054012710, false, true)
      cast_missile_new(monster.npc, nil, 0, 337, 201054013401, 1, nil, nil, 175)
      cast_missile_new(monster.npc, nil, 30.72, 328.2, 201054013403, 1, nil, nil, nil, 173.5)
      cast_missile_new(monster.npc, nil, -11.82, 365.94, 201054013404, 1, nil, nil, nil, 173.5)
      cast_missile_new(monster.npc, nil, -24.33, 316.04, 201054013405, 1, nil, nil, nil, 173.5)
      
      local function delay()
        if 1 == monster.coordinates then
          set_camera(2010540115, true, true)
        else
          set_camera(2010540120, true, true)
        end
      end
      
      monster:doAfter(delay, 2)
    end
    
    local hit2_1 = monster.states.hit2_1
    local hit2_2 = monster.states.hit2_2
    local hit2_3 = monster.states.hit2_3
    
    function hit2_1.start(hit2_1)
      hit2_1.base.start(hit2_1)
      local Q2_pos = {x = -2.02, z = 337.81}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013601, false, true)
        set_keyframe_enable(monster.npc, 201054013607, false, true)
        set_keyframe_enable(monster.npc, 201054013608, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013602, false, true)
        set_keyframe_enable(monster.npc, 201054013603, false, true)
        set_keyframe_enable(monster.npc, 201054013606, false, true)
        set_keyframe_enable(monster.npc, 201054013601, true, true)
        set_keyframe_enable(monster.npc, 201054013607, true, true)
        set_keyframe_enable(monster.npc, 201054013608, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, -46, 331.5, false)
    end
    
    function hit2_2.start(hit2_2)
      hit2_2.base.start(hit2_2)
      local Q2_pos = {x = -4.1, z = 332.2}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013701, false, true)
        set_keyframe_enable(monster.npc, 201054013707, false, true)
        set_keyframe_enable(monster.npc, 201054013708, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013702, false, true)
        set_keyframe_enable(monster.npc, 201054013703, false, true)
        set_keyframe_enable(monster.npc, 201054013706, false, true)
        set_keyframe_enable(monster.npc, 201054013701, true, true)
        set_keyframe_enable(monster.npc, 201054013707, true, true)
        set_keyframe_enable(monster.npc, 201054013708, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, 19.4, 295.9, false)
    end
    
    function hit2_3.start(hit2_3)
      hit2_3.base.start(hit2_3)
      local Q2_pos = {x = -1.2, z = 342.1}
      if 1 == monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013801, false, true)
        set_keyframe_enable(monster.npc, 201054013807, false, true)
        set_keyframe_enable(monster.npc, 201054013808, false, true)
      end
      if 1 ~= monster.ai_state then
        set_keyframe_enable(monster.npc, 201054013802, false, true)
        set_keyframe_enable(monster.npc, 201054013803, false, true)
        set_keyframe_enable(monster.npc, 201054013806, false, true)
        set_keyframe_enable(monster.npc, 201054013801, true, true)
        set_keyframe_enable(monster.npc, 201054013807, true, true)
        set_keyframe_enable(monster.npc, 201054013808, true, true)
      end
      flash_to_pos(monster.npc, Q2_pos.x, Q2_pos.z)
      lookat_position(monster.npc, 8.4, 376.4, false)
    end
  end
  do
    local ChangeState = monster.states.ChangeState
    local phase1_1 = monster.skills.phase1_1
    local phase1_2 = monster.skills.phase1_2
    local phase1_4 = monster.skills.phase1_4
    local phase1_5 = monster.skills.phase1_5
    
    function ChangeState.isReady()
      return false
    end
    
    function ChangeState.finTrans()
      return monster.states.wander
    end
    
    function ChangeState.tick(ChangeState)
      if check_magic(monster.npc, 2010540641) then
        local missile_list1 = {
          201054011811,
          201054011812,
          201054011813
        }
        local player = get_come_on_hero()
        local playerpos = get_npc_pos(player)
        local nowtime = get_npc_time(monster.npc)
        if nowtime > monster.stone_now_time then
          local scale = 6
          local target_pos_x = {
            playerpos.x
          }
          target_pos_x = playerpos.x + math.random() + math.random(-scale, scale)
          local target_pos_z = {
            playerpos.z
          }
          target_pos_z = playerpos.z + math.random() + math.random(-scale, scale)
          for _, missile_id in ipairs(missile_list1) do
            cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_id, 0)
          end
          monster.stone_now_time = nowtime + 0.5
        end
      end
    end
    
    function phase1_1.onBegin(phase1_1)
      phase1_1.base.onBegin(phase1_1)
      if 1 == monster.coordinates then
        set_camera(2010540109, true, true)
        set_keyframe_enable(monster.npc, 201054012909, true, true)
        set_keyframe_enable(monster.npc, 201054012910, true, true)
        set_keyframe_enable(monster.npc, 201054012911, false, true)
        set_keyframe_enable(monster.npc, 201054012912, false, true)
      end
      if 1 ~= monster.coordinates then
        set_camera(2010540112, true, true)
        set_keyframe_enable(monster.npc, 201054012912, true, true)
        set_keyframe_enable(monster.npc, 201054012911, true, true)
        set_keyframe_enable(monster.npc, 201054012910, false, true)
        set_keyframe_enable(monster.npc, 201054012909, false, true)
      end
    end
    
    function phase1_2.onBegin(phase1_2)
      phase1_2.base.onBegin(phase1_2)
      monster.ai_state = 2
      if 1 == monster.coordinates then
        set_camera(2010540110, true, true)
      end
      if 1 ~= monster.coordinates then
        set_camera(2010540113, true, true)
      end
    end
    
    function phase1_4.onBegin(phase1_4)
      phase1_4.base.onBegin(phase1_4)
      if 1 == monster.coordinates then
        set_camera(2010540111, true, true)
      end
      if 1 ~= monster.coordinates then
        set_camera(2010540114, true, true)
      end
    end
    
    function phase1_4.tick(phase1_4)
      if 1 == monster.coordinates then
        set_keyframe_enable(monster.npc, 201054013204, true, true)
        set_keyframe_enable(monster.npc, 201054013205, false, true)
        if check_magic(monster.npc, 2010540684) then
          cast_missile_new(monster.npc, nil, 0, 325, 201054011894, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 325, 201054011896, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 325, 201054011897, 1, 16, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540685) then
          cast_missile_new(monster.npc, nil, 5, 345.25, 201054011890, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 345.25, 201054011892, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 335.25, 201054011893, 1, 0, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540686) then
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011894, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011896, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011897, 1, 16, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540687) then
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011890, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011892, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011893, 1, 0, 335.25, 184)
        end
      end
      if 1 ~= monster.coordinates then
        set_keyframe_enable(monster.npc, 201054013205, true, true)
        set_keyframe_enable(monster.npc, 201054013204, false, true)
        if check_magic(monster.npc, 2010540684) then
          cast_missile_new(monster.npc, nil, 0, 325, 201054011894, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 325, 201054011895, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 325, 201054011896, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 325, 201054011897, 1, 16, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540685) then
          cast_missile_new(monster.npc, nil, 5, 345.25, 201054011890, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 345.25, 201054011891, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 345.25, 201054011892, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 335.25, 201054011893, 1, 0, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540686) then
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011894, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011895, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011896, 1, 16, 335.25, 184)
          cast_missile_new(monster.npc, nil, 0, 345.25, 201054011897, 1, 16, 335.25, 184)
        end
        if check_magic(monster.npc, 2010540687) then
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011890, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011891, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011892, 1, 0, 335.25, 184)
          cast_missile_new(monster.npc, nil, 5, 325.25, 201054011893, 1, 0, 335.25, 184)
        end
      end
    end
    
    function phase1_5.onBegin(phase1_5)
      if 1 == monster.coordinates then
        set_camera(2010540102, true, true)
      end
      if 1 ~= monster.coordinates then
        set_camera(2010540104, true, true)
      end
      abort_magic_by_id(monster.npc, 2010540753, 1)
    end
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  local playerpos1 = get_npc_pos(player)
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    local magicId = magics and magics[1]
    for key, value in pairs(monster.Gpmissile) do
      if value == m2_cfg.Id then
        monster:try_red_skill_counter(m1)
      end
    end
  end
end

function monster.on_start(monster)
  monster:xRay()
  set_sceneobj_visible_save_state("/Root/Scene/sc06_area_02a/FX/FX_Sc06_05_fog", true)
  set_npc_phase_number(monster.npc, 2)
  enable_shadow(monster.npc, false)
  for key, value in pairs(tool.team.npc) do
    if key then
      set_show_betargeted_arrow(value, false)
    end
  end
  cast_magic(monster.npc, monster.npc, 2010480115, 1)
  set_camera(2010540101, true, true)
  cast_missile_new(monster.npc, nil, 17.72, 298.06, 201054013450, nil, nil, nil, nil, 180)
  cast_missile_new(monster.npc, nil, -25.55, 368.41, 201054013451, nil, nil, nil, nil, 180)
  cast_missile_new(monster.npc, nil, 5.46, 325.25, 201054013452, nil, nil, nil, nil, 180)
  cast_missile_new(monster.npc, nil, -10.1, 351.38, 201054013453, nil, nil, nil, nil, 180)
end

function monster.on_self_npc_hp_zero(monster)
  if 2 == monster.ai_state then
    monster.base.on_self_npc_hp_zero(monster)
  end
  if 1 == monster.ai_state then
    switch_bgm_block("bgm_chapter7_Boss", 2)
    change_npc_phase_state(monster.npc, 2, false)
    cast_magic(monster.npc, monster.npc, 1999224, 1)
    cast_magic(monster.npc, monster.npc, 1999225, 1)
    cast_magic(monster.npc, monster.npc, 2010540753, 1)
    start_stroy(5072203)
    cast_magic(monster.npc, monster.npc, 2010540822, 1)
    monster:transState(monster.states.ChangeState, true)
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  monster.Gp = true
  monster.Gpskill.mis = missile
  monster.Gpskill.id = missile.v_skill_id
  monster.Gpskill.cfg = missile.missile_cfg
  monster.Gpskill.type = missile.missile_cfg.Type
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  local player = get_come_on_hero()
  local playerpos1 = get_npc_pos(player)
  if 2010540617 == magic_id then
    cast_magic(monster.npc, player, 2010540616, 1)
  end
  if 2010540750 == magic_id then
    cast_magic(monster.npc, player, 2010540751, 1)
  end
  if 2010540720 == magic_id and monster.state.curSk then
    monster.crash = 1
    monster.state.curSk:deriveAuto()
  end
  if 1999219 == magic_id then
    for key, value in pairs(monster.Gpmissile) do
      if key then
        remove_missile_by_id(value, monster.npc, false)
      end
    end
    if monster.Gp == true then
      monster.crash = monster.crash + 1
      cast_magic(monster.npc, player, 2010540742, 1)
      cast_magic(monster.npc, monster.npc, 2010540745, 1)
      cast_magic(monster.npc, monster.npc, 2010540603, 1)
      cast_magic(monster.npc, player, 2010540604, 1)
      cast_magic(monster.npc, player, 2010540605, 1)
      cast_magic(monster.npc, player, 2010540608, 1)
      cast_magic(monster.npc, monster.npc, 2010540606, 1)
      cast_magic(monster.npc, monster.npc, 2010540607, 1)
      cast_magic(monster.npc, monster.npc, 2010540620, 1)
      cast_magic(monster.npc, monster.npc, 2010540748, 1)
      cast_magic(monster.npc, monster.npc, 1999220, 1)
      cast_magic(monster.npc, monster.npc, 2010540764)
      local roleNpc = get_come_on_hero()
      local role = roleNpc and roleNpc:get_behavior()
      local on_skill_hit = role and role.on_skill_hit
      local on_self_skill_hit = role and role.on_self_skill_hit
      if on_skill_hit then
        role:on_skill_hit(roleNpc, monster.Gpskill.id, monster.npc, monster.Gpskill.type, monster.Gpskill.cfg, monster.Gpskill.mis)
      end
      if on_self_skill_hit then
        role:on_self_skill_hit(monster.Gpskill.id, monster.npc, monster.Gpskill.type, monster.Gpskill.cfg, monster.Gpskill.mis)
      end
      if playerpos1 then
        cast_missile_new(monster.npc, player, playerpos1.x, playerpos1.z + 2, 201054011804, 1, playerpos1.x, playerpos1.z + 2, playerpos1.y, playerpos1.y, playerpos1.x, playerpos1.z)
      end
    end
    monster.Gp = false
  end
  if 2010540754 == magic_id then
    monster.crash = 1
  end
  if 2010540756 == magic_id then
    if 1 == monster.coordinates then
      set_camera(2010540116, true, true)
    else
      set_camera(2010540118, true, true)
    end
  end
  if 2010540757 == magic_id then
    if 1 == monster.coordinates then
      set_camera(2010540117, true, true)
    else
      set_camera(2010540119, true, true)
    end
  end
  if 2010540818 == magic_id then
    if 2 == monster.ai_state then
      cast_missile_new(monster.npc, nil, 0, 336.5, 201054013435, 1, nil, nil, nil, 175.25)
      cast_missile_new(monster.npc, nil, 30.72, 328.2, 201054013438, 1, nil, nil, nil, 173.5)
    end
    cast_missile3(monster.npc, nil, 30.72, 328.2, 201054013602, 1, nil, nil, nil, 173.5)
  end
  if 2010540819 == magic_id then
    if 2 == monster.ai_state then
      cast_missile_new(monster.npc, nil, 0, 336.5, 201054013436, 1, nil, nil, nil, 175.25)
      cast_missile_new(monster.npc, nil, -11.82, 365.94, 201054013439, 1, nil, nil, nil, 173.5)
    end
    cast_missile3(monster.npc, nil, -11.82, 365.94, 201054013702, 1, nil, nil, nil, 173.5)
  end
  if 2010540820 == magic_id then
    if 2 == monster.ai_state then
      cast_missile_new(monster.npc, nil, 0, 336.5, 201054013437, 1, nil, nil, nil, 175.25)
      cast_missile_new(monster.npc, nil, -24.33, 316.04, 201054013440, 1, nil, nil, nil, 173.5)
    end
    cast_missile3(monster.npc, nil, -24.33, 316.04, 201054013802, 1, nil, nil, nil, 173.5)
  end
  if 2010540823 == magic_id then
    monster:Focus(true, false)
  elseif 2010540824 == magic_id then
    monster:Focus(true, true)
  elseif 2010540822 == magic_id then
    cast_magic(monster.npc, monster.npc, 2010540826)
    monster:Focus(false)
  end
  if 2010540761 == magic_id then
    monster.partNPC = get_part_npc(monster.npc, nil) or Const.NIL_TABLE
    cast_magic(monster.npc, monster.npc, 2010540763)
    for key, value in pairs(monster.partNPC) do
      if value:get_behavior() then
        cast_magic(value, value, 2010540761)
      end
    end
  elseif 2010540762 == magic_id then
    monster.partNPC = get_part_npc(monster.npc, nil) or Const.NIL_TABLE
    abort_magic_by_id(monster.npc, 2010540826, 99)
    for key, value in pairs(monster.partNPC) do
      if value:get_behavior() then
        cast_magic(value, value, 2010540762)
      end
    end
  end
  if 2010540698 == magic_id and 2 == monster.ai_state then
    cast_magic(monster.npc, monster.npc, 2010540828)
  elseif 2010540699 == magic_id and 2 == monster.ai_state then
    cast_magic(monster.npc, monster.npc, 2010540827)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, magic_level, magic_kind, magic_type)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if get_cur_camera_id() ~= monster.cam then
    print(monster.cam .. "镜头切换" .. get_cur_camera_id())
    monster.cam = get_cur_camera_id()
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  monster.base.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  local missile_list = {201054013417, 201054013419}
  for k, v in pairs(missile_list) do
    if missile_cfg.Id == v then
      cast_missile_new(monster.npc, nil, pos_x, pos_z, 201054013421, 1, pos_x, pos_z, 100, 228)
    end
  end
  if monster.Follow_NPC_pos[missile_cfg.Id] then
    local Tarpos = monster.Follow_NPC_pos[missile_cfg.Id]
    monster.FollowNPC[missile_cfg.Id] = add_npc2(2, 20105404, Tarpos.x, Tarpos.z, Tarpos.x, Tarpos.z, 2, 1)
  end
  local idMap = {
    [201054013450] = "A",
    [201054013451] = "B",
    [201054013452] = "C",
    [201054013453] = "D"
  }
  local suffix = idMap[missile_cfg.Id]
  if suffix then
    monster["FocusMIs" .. suffix] = missile
  end
end

function monster.Stone(monster, StoneA_cd, StoneB_cd)
  local missile_list = {
    201054013416,
    201054013413,
    201054013423
  }
  local Hero_pos = get_npc_pos(get_come_on_hero())
  local nowTime = get_npc_time(monster.npc)
  if nowTime > monster.Stone_timeA then
    local center_x, center_z = 0, 336.5
    local scale = 4
    local target_pos_x = Hero_pos.x
    local target_pos_z = Hero_pos.z
    local born_pos_x = Hero_pos.x + math.random() + math.random(-3, 3)
    local born_pos_z = Hero_pos.z + math.random() + math.random(-3, 3)
    local born_pos_y = Hero_pos.y + 20
    repeat
      local angle = math.random() * 2 * math.pi
      target_pos_x = Hero_pos.x + math.random(-scale, scale) * math.cos(angle)
      target_pos_z = Hero_pos.z + math.random(-scale, scale) * math.sin(angle)
      local Distance_to_center = math.sqrt((target_pos_x - center_x) ^ 2 + (target_pos_z - center_z) ^ 2)
    until Distance_to_center < 25
    cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_list[1], 0)
    cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_list[math.random(2, 3)], 0, nil, nil, nil, nil, born_pos_x, born_pos_z, born_pos_y)
    monster.Stone_timeA = nowTime + StoneA_cd
  end
  if nowTime > monster.Stone_timeB then
    local target_pos_x = 0
    local target_pos_z = 336
    local born_pos_y = Hero_pos.y + 20
    local angle = math.random() * 2 * math.pi
    local radius = math.random(10, 23)
    target_pos_x = target_pos_x + radius * math.cos(angle)
    target_pos_z = target_pos_z + radius * math.sin(angle)
    local born_pos_x = Hero_pos.x + math.random() + math.random(-3, 3)
    local born_pos_z = Hero_pos.z + math.random() + math.random(-3, 3)
    cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_list[1], 0)
    cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_list[2], 0, nil, nil, nil, nil, born_pos_x, born_pos_z, born_pos_y)
    monster.Stone_timeB = nowTime + StoneB_cd
  end
end

function monster.FireWall_stone(monster, Close_cd, Far_cd)
  local missile_list = {201054013416, 201054013413}
  local missile_list1 = {
    201054011811,
    201054011812,
    201054011813
  }
  local Hero_pos = get_npc_pos(get_come_on_hero())
  local nowTime = get_npc_time(monster.npc)
  if nowTime > monster.FireWall_stoneC then
    local target_pos_x = 0
    local target_pos_z = 336
    local born_pos_y = Hero_pos.y + 20
    local angle = math.random() * 2 * math.pi
    local radius = math.random(2, 11)
    target_pos_x = Hero_pos.x + radius * math.cos(angle)
    target_pos_z = Hero_pos.z + radius * math.sin(angle)
    local born_pos_x = Hero_pos.x + math.random() + math.random(-3, 3)
    local born_pos_z = Hero_pos.z + math.random() + math.random(-3, 3)
    for _, missile_id in ipairs(missile_list1) do
      cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_id, 1)
    end
    monster.FireWall_stoneC = nowTime + Close_cd
  end
  if nowTime > monster.FireWall_stoneF + math.random() then
    local target_pos_x = 0
    local target_pos_z = 336
    local born_pos_y = Hero_pos.y + 20
    local angle = math.random() * 2 * math.pi
    local radius = math.random(11, 30)
    target_pos_x = Hero_pos.x + radius * math.cos(angle)
    target_pos_z = Hero_pos.z + radius * math.sin(angle)
    local born_pos_x = Hero_pos.x + math.random() + math.random(-3, 3)
    local born_pos_z = Hero_pos.z + math.random() + math.random(-3, 3)
    for _, missile_id in ipairs(missile_list1) do
      cast_missile_new(monster.npc, nil, target_pos_x, target_pos_z, missile_id, 0)
    end
    monster.FireWall_stoneF = nowTime + Far_cd
  end
end

function monster.Focus(monster, focus, state)
  local params = {
    12,
    0,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6,
    0.02
  }
  if focus then
    local suffixMap = {
      [false] = {
        [1] = "A",
        [2] = "B"
      },
      [true] = {
        [1] = "C",
        [2] = "D"
      }
    }
    local suffix = suffixMap[state][monster.coordinates]
    change_follow_target_new(3, monster["FocusMIs" .. suffix], params)
  else
    change_follow_target_new(3, get_come_on_hero(), params)
    change_follow_target_new(0)
  end
end

return monster
