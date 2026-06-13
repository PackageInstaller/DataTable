local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 100, maxDis = 100}
  monster.born = 2010340121
  monster.challenge_normal = false
  monster.challenge_hard = false
  monster.TowerId = get_tower_id()
  print("难度，塔号", monster.TowerId)
  monster.normalTower = {220201, 220202}
  monster.hardTower = {
    220203,
    220204,
    60024,
    60025,
    220205,
    2312,
    2212,
    2211,
    50212,
    2221
  }
  for key, value in pairs(monster.normalTower) do
    if value == monster.TowerId then
      print("难度，简单")
      monster.challenge_normal = true
      break
    end
  end
  for key, value in pairs(monster.hardTower) do
    if value == monster.TowerId then
      monster.challenge_hard = true
      print("难度，困难")
      break
    end
  end
  local skills = {
    slap_r = {
      2010340101,
      10,
      3,
      0,
      120,
      120,
      -90
    },
    claw_l = {
      2010340102,
      14,
      10,
      0,
      6,
      -45,
      45
    },
    claw_back = {
      2010340118,
      10,
      2,
      0,
      120,
      120,
      -90
    },
    ground_blast = {
      2010340107,
      15,
      10,
      1,
      15,
      -60,
      60
    },
    hugeSmash = {
      2010340103,
      30,
      10,
      0,
      16,
      -90,
      90
    },
    moveTripleHit = {
      2010340109,
      5,
      0,
      0,
      18,
      -120,
      120
    },
    Redskill = {
      2010340133,
      18,
      8,
      0,
      18,
      -120,
      120
    },
    biggesHit = {
      2010340110,
      50,
      0,
      0,
      16
    },
    changeStateA = {2010340116},
    henshin_start = {2010340104},
    henshin_loop = {2010340105},
    henshin_end = {2010340106},
    Transport = {2010340127},
    roar = {2010340112},
    jumpHit = {
      2010340111,
      2,
      2,
      8,
      120
    },
    Iaser_start = {2010340113, 50},
    Iaser_loop = {2010340114},
    Iaser_end = {2010340115},
    Bomb = {2010340126, 20},
    stagger = {2010340134},
    HS_roar = {2010340122},
    jump_loopA = {
      2010340119,
      40,
      0
    },
    jump_loopB = {2010340119},
    jump_loopC = {2010340119},
    flash = {2010340120}
  }
  local nodes = {
    "TurnAtk",
    "Henshin",
    "Iaser",
    "FlashBack",
    "Triple_Jump"
  }
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.states.attack.interval = 0.5
  monster.ai_state = 1
  monster.flash_switch = false
  monster.level = monster.npc:get_level()
  tool.BOSS_Dead = false
  if not monster.challenge_normal and not monster.challenge_hard then
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Henshin, _ENV.FlashBack, _ENV.TurnAtk, _ENV.attack, _ENV.wander)
    _ENV.Henshin(_ENV.changeStateA(_ENV.henshin_start(_ENV.henshin_loop(_ENV.henshin_end), _ENV.roar)))
    _ENV.TurnAtk(_ENV.jumpHit, _ENV.claw_back, _ENV.slap_r)
    _ENV.freeAtk(_ENV.Iaser, _ENV.biggesHit, _ENV.claw_l, _ENV.ground_blast, _ENV.hugeSmash, _ENV.Redskill, _ENV.moveTripleHit)
    _ENV.Iaser(_ENV.Iaser_start(_ENV.Iaser_loop(_ENV.Iaser_end)))
    _ENV.FlashBack(_ENV.flash(_ENV.Bomb))
    _ENV.wander(_ENV.stand)
  elseif monster.challenge_normal then
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Henshin, _ENV.FlashBack, _ENV.TurnAtk, _ENV.attack, _ENV.wander)
    _ENV.Henshin(_ENV.stagger(_ENV.HS_roar))
    _ENV.TurnAtk(_ENV.jumpHit, _ENV.claw_back, _ENV.slap_r)
    _ENV.freeAtk(_ENV.Iaser, _ENV.Triple_Jump, _ENV.claw_l, _ENV.ground_blast, _ENV.Redskill, _ENV.moveTripleHit)
    _ENV.Iaser(_ENV.Iaser_start(_ENV.Iaser_loop(_ENV.Iaser_end)))
    _ENV.Triple_Jump(_ENV.jump_loopA(_ENV.jump_loopB(_ENV.jump_loopC)))
    _ENV.FlashBack(_ENV.flash(_ENV.Bomb))
    _ENV.wander(_ENV.stand)
  elseif monster.challenge_hard then
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.Henshin, _ENV.FlashBack, _ENV.TurnAtk, _ENV.attack, _ENV.wander)
    _ENV.Henshin(_ENV.stagger(_ENV.HS_roar))
    _ENV.TurnAtk(_ENV.jumpHit, _ENV.claw_back, _ENV.slap_r)
    _ENV.freeAtk(_ENV.Iaser, _ENV.biggesHit, _ENV.Triple_Jump, _ENV.claw_l, _ENV.ground_blast, _ENV.hugeSmash, _ENV.Redskill, _ENV.moveTripleHit)
    _ENV.Iaser(_ENV.Iaser_start(_ENV.Iaser_loop(_ENV.Iaser_end)))
    _ENV.Triple_Jump(_ENV.jump_loopA(_ENV.jump_loopB(_ENV.jump_loopC)))
    _ENV.FlashBack(_ENV.flash(_ENV.Bomb))
    _ENV.wander(_ENV.stand)
  end
  do
    local TurnAtk = monster.states.TurnAtk
    local wander = monster.states.wander
    local stand = monster.states.stand
    local FlashBack = monster.states.FlashBack
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      local tree = monster.tree
      if not monster.target then
        return states.noTarget
      end
      if FlashBack.base.isReady(FlashBack) then
        return FlashBack
      end
      if TurnAtk.base.isReady(TurnAtk) then
        return TurnAtk
      end
      if states.attack then
        return tree:chooseChildAction(states.attack)
      end
    end
    
    function stand.start(stand)
      lookat_npc(stand.monster.npc, stand.monster.target)
      stop_move(stand.monster.npc)
    end
  end
  do
    local claw_back = monster.states.claw_back
    local TurnAtk = monster.states.TurnAtk
    local jumpHit = monster.states.jumpHit
    local slap_r = monster.states.slap_r
    
    function jumpHit.start(jumpHit)
      local monster = jumpHit.monster
      set_lock_velocity(monster.npc, 0.3)
      if monster.target then
        lookat_npc(monster.npc, monster.target, false)
      end
      jumpHit.base.start(jumpHit)
    end
    
    function jumpHit.finish(jumpHit)
      local monster = jumpHit.monster
      abort_magic_by_id(monster.npc, 20103401027, 1)
      set_lock_velocity(monster.npc, 0.1)
    end
    
    function TurnAtk.isReady(TurnAtk)
      if 2 == TurnAtk.monster.ai_state then
        return false
      end
      return jumpHit.base.isReady(jumpHit) or claw_back.base.isReady(claw_back) or slap_r.base.isReady(slap_r)
    end
    
    function TurnAtk.finTrans(TurnAtk)
      return TurnAtk.monster.states.wander
    end
  end
  do
    local biggesHit = monster.states.biggesHit
    local hugeSmash = monster.states.hugeSmash
    
    function hugeSmash.start(hugeSmash)
      local self = hugeSmash.monster
      
      local function Stone1()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 25, 10)
        local pos2 = get_npc_offset_position(self.npc, nil, 115, 10)
        local pos3 = get_npc_offset_position(self.npc, nil, 205, 10)
        local pos4 = get_npc_offset_position(self.npc, nil, 295, 10)
        if is_cast_skill_time(self.npc, 2010340103, 1) then
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone2()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 1, 6)
        local pos2 = get_npc_offset_position(self.npc, nil, 90, 6)
        local pos3 = get_npc_offset_position(self.npc, nil, 180, 6)
        local pos4 = get_npc_offset_position(self.npc, nil, 270, 6)
        if is_cast_skill_time(self.npc, 2010340103, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      monster:doAfter(Stone1, 3)
      monster:doAfter(Stone2, 3.3)
      hugeSmash.base.start(hugeSmash)
    end
    
    function biggesHit.start(biggesHit)
      local self = biggesHit.monster
      
      local function Stone1()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 45, 5)
        local pos2 = get_npc_offset_position(self.npc, nil, 135, 5)
        local pos4 = get_npc_offset_position(self.npc, nil, 315, 5)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone2()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 1, 10)
        local pos4 = get_npc_offset_position(self.npc, nil, 270, 10)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone3()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 45, 15)
        local pos4 = get_npc_offset_position(self.npc, nil, 315, 15)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      monster:doAfter(Stone1, 1.5)
      monster:doAfter(Stone2, 3.5)
      monster:doAfter(Stone3, 6.3)
      biggesHit.base.start(biggesHit)
    end
  end
  if not monster.challenge_normal and not monster.challenge_hard then
    local roar = monster.states.roar
    local Henshin = monster.states.Henshin
    local changeStateA = monster.states.changeStateA
    local root = monster.states.root
    local henshin_loop = monster.states.henshin_loop
    local henshin_start = monster.states.henshin_start
    local henshin_end = monster.states.henshin_end
    henshin_loop.cd = 0
    henshin_loop.timer = 0
    
    function roar.isReady()
      return false
    end
    
    function Henshin.isReady()
      return false
    end
    
    function changeStateA.isReady()
      return false
    end
    
    function henshin_start.isReady()
      return false
    end
    
    changeStateA.trans = false
    
    function changeStateA.start(changeStateA)
      if not monster.target then
        monster:searchTarget()
      end
      
      function changeStateA.isReady()
        return false
      end
      
      abort_magic_by_id(monster.npc, 20103401068, 1)
      enable_shadow(monster.npc, false)
      cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
      changeStateA.base.start(changeStateA)
    end
    
    function henshin_start.start(henshin_start)
      local monster = henshin_start.monster
      local Q1_pos = {
        x = 189.0939,
        y = -954.3987,
        z = 204.883
      }
      changeStateA.trans = false
      
      function henshin_start.isReady()
        return false
      end
      
      cast_magic(npc, npc, 20103401067, 1)
      cast_magic(monster.npc, monster.npc, 20103401056, 1)
      cast_magic(monster.npc, monster.npc, 20103401057, 1)
      cast_magic(monster.npc, monster.npc, 20104101017, 1)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      cast_missile_new(monster.npc, nil, monster.born_pos.x, monster.born_pos.z, 201034013104, 1)
      henshin_start.base.start(henshin_start)
    end
    
    function henshin_loop.start(henshin_loop)
      local monster = henshin_loop.monster
      local npc = monster.npc
      tool.BOSS_Dead = false
      henshin_loop.end_time = get_npc_time(npc) + 60
      henshin_loop.warning = get_npc_time(monster.npc)
      henshin_loop.timer = get_npc_time(monster.npc)
      if get_cur_room_id() == 1241 then
        set_scene_tips(1023006, true, {})
      end
      start_stroy(202011)
      add_npc_by_pos_key(1, 20203501, "tp1", -4, -5, "tp3", 0, 0, 4, monster.level)
      add_npc_by_pos_key(1, 20203502, "tp1", 4, -5, "tp3", 0, 0, 4, monster.level)
      add_npc_by_pos_key(1, 20203503, "tp1", 0, -5, "tp3", 0, 0, 4, monster.level)
      henshin_loop.base.start(henshin_loop)
    end
    
    function henshin_loop.tick(henshin_loop)
      local monster = henshin_loop.monster
      local switch = true
      local roleNpc = get_come_on_hero()
      local role = roleNpc and roleNpc:get_behavior()
      monster.ai_state = 3
      henshin_loop.cd = 0.3 * get_npc_attr(npc, 4) / (get_npc_attr(npc, 4) - get_npc_attr(npc, 1))
      if get_npc_attr(npc, 1) / get_npc_attr(npc, 4) > 0.5 and true == switch then
        switch = false
        henshin_loop.cd = (henshin_loop.end_time - get_npc_time(npc)) * 0.01 * get_npc_attr(npc, 4) / (get_npc_attr(npc, 4) - get_npc_attr(npc, 1))
      end
      if get_npc_time(monster.npc) > henshin_loop.timer then
        cast_magic(monster.npc, monster.npc, 20103401064, 1)
        henshin_loop.timer = henshin_loop.timer + henshin_loop.cd
      end
      if tool.NPC_3 == false and not role:isInUlt() then
        monster.states.FlashBack.timer = math.huge
        set_lock_velocity(monster.npc, 0.1)
        set_scene_tips(1023006, false, {})
        set_scene_camera(2010340101)
        cast_magic(monster.npc, monster.npc, 20103401059, 1)
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
        play_effect_anim(monster.npc, "Fx_M201034_skill6_2_6", "Break")
        play_effect_anim(monster.npc, "Fx_M201034_skill6_2_5_1", "End")
        remove_missile_by_id(201034012003, monster.npc, false)
        remove_missile_by_id(201034013104, monster.npc, false)
        remove_missile_by_id(201034010501, monster.npc, false)
        remove_missile_by_id(201034010402, monster.npc, false)
        remove_missile_by_id(201034010403, monster.npc, false)
        abort_magic_by_id(monster.npc, 20103401056, 1)
        abort_magic_by_id(monster.npc, 20103401057, 1)
        abort_magic_by_id(monster.npc, 20103401069, 1)
        abort_magic_by_id(monster.npc, 20104101017, 1)
        abort_magic_by_id(monster.npc, 20103401065, 1)
        abort_magic_by_id(monster.npc, 20103401067, 5)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
        enter_stun(monster.npc, false, 5)
        
        local function Exit()
          exit_stun(npc)
          monster.tree:transState(monster.states.Iaser)
        end
        
        monster:doAfter(Exit, 4)
      end
      if true == henshin_loop.isCastOver and henshin_end.isReady() and tool.NPC_3 ~= false then
        henshin_loop:derive()
      end
    end
    
    function henshin_end.isReady()
      local roleNpc = get_come_on_hero()
      local role = roleNpc and roleNpc:get_behavior()
      if role and role:isInUlt() then
        return false
      end
      return true
    end
    
    function henshin_end.start(henshin_end)
      cast_magic(monster.npc, monster.target, 20103401070, 1)
      monster.tool.roleFaint(monster.target, 8, 8)
      tool.NPC_1 = 114
      tool.NPC_2 = 114
      tool.NPC_3 = 114
      henshin_end.monster.ai_state = 3
      henshin_end.trans = false
      local monster = henshin_end.monster
      roar.Trans = false
      cast_magic(npc, npc, 20103401069, 1)
      set_lock_velocity(monster.npc, 0.1)
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
      play_effect_anim(monster.npc, "Fx_M201034_skill6_2_6", "Break")
      play_effect_anim(monster.npc, "Fx_M201034_skill6_2_5_1", "End")
      set_scene_camera(2010340101)
      remove_missile_by_id(201034013104, monster.npc, false)
      remove_missile_by_id(201034010501, monster.npc, false)
      remove_missile_by_id(201034010402, monster.npc, false)
      remove_missile_by_id(201034010403, monster.npc, false)
      abort_magic_by_id(monster.npc, 20103401056, 1)
      abort_magic_by_id(monster.npc, 20103401057, 1)
      abort_magic_by_id(monster.npc, 20103401069, 1)
      abort_magic_by_id(monster.npc, 20104101017, 1)
      abort_magic_by_id(monster.npc, 20103401065, 1)
      abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
      henshin_end.base.start(henshin_end)
      
      local function invisible()
        cast_magic(monster.npc, monster.npc, 20103401068, 1)
      end
      
      local function flash()
        local Q1_pos = {
          x = 189.0939,
          y = -954.3987,
          z = 204.883
        }
        local look_pos = {
          x = 189.0939,
          y = -954.3987,
          z = 196.021
        }
        flash_to_pos(monster.npc, Q1_pos.x, Q1_pos.z)
        lookat_position(monster.npc, look_pos.x, look_pos.z, false)
        
        function roar.isReady()
          return true
        end
        
        henshin_end.trans = true
      end
      
      monster:doAfter(invisible, 1.7)
      monster:doAfter(flash, 2.5)
    end
    
    function henshin_end.tickTrans(henshin_end)
      if henshin_end.trans == true and roar.base.isReady(roar) then
        return roar
      end
    end
    
    function roar.start(roar)
      monster.states.FlashBack.timer = 0
      start_stroy(202012)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      
      local function die()
        local roleNpc = get_come_on_hero()
        local role = roleNpc and roleNpc:get_behavior()
        abort_magic_by_id(monster.npc, 20103401067, 1)
        abort_magic_by_id(monster.npc, 20103401069, 1)
        if not role:isInUlt() then
          cast_magic(monster.npc, monster.target, 20103401034, 1)
        end
      end
      
      monster:doAfter(die, 2.9)
      roar.base.start(roar)
    end
    
    function roar.finTrans(roar)
      return roar.monster.states.wander
    end
  end
  if monster.challenge_normal or monster.challenge_hard then
    local stagger = monster.states.stagger
    local Henshin = monster.states.Henshin
    local HS_roar = monster.states.HS_roar
    
    function Henshin.isReady()
      return false
    end
    
    function stagger.finish(stagger)
      exit_stun(monster.npc)
      cast_magic(monster.npc, monster.npc, 1999224, 1)
      cast_magic(monster.npc, monster.npc, 1999225, 1)
      cast_magic(monster.npc, monster.npc, 1999226, 1)
      cast_magic(monster.npc, monster.npc, 1999227, 1)
      cast_magic(monster.npc, monster.npc, 1999228, 1)
      cast_magic(monster.npc, monster.npc, 1999229, 1)
      cast_magic(monster.npc, monster.npc, 1999230, 1)
      monster.ai_state = 3
      stagger.base.finish(stagger)
    end
    
    function HS_roar.start(start)
      HS_roar.base.start(start)
      monster.ai_state = 3
      monster.states.FlashBack.timer = get_npc_time(monster.npc) + 10
    end
    
    function HS_roar.finTrans(HS_roar)
      monster.states.Iaser_start.timer = get_npc_time(monster.npc) + 15
      return monster.states.wander
    end
  end
  do
    local biggesHit = monster.states.biggesHit
    local Iaser = monster.states.Iaser
    local Iaser_start = monster.states.Iaser_start
    local Iaser_loop = monster.states.Iaser_loop
    local Iaser_end = monster.states.Iaser_end
    
    function biggesHit.isReady(biggesHit)
      if not biggesHit.base.isReady(biggesHit) then
        return false
      end
      if 3 ~= biggesHit.monster.ai_state then
        return false
      end
      return true
    end
    
    function Iaser.isReady(Iaser)
      if 3 == Iaser.monster.ai_state then
        return true
      end
      return false
    end
    
    function Iaser_start.start(Iaser_start)
      if monster.challenge_normal or monster.challenge_hard then
        cast_magic(npc, npc, 20103401068, 1)
        
        local function delay()
          flash_to_pos(monster.npc, 189, 218, 45.76)
          abort_magic_by_id(monster.npc, 20103401068, 99)
          lookat_position(monster.npc, 189.0939, 205, true)
        end
        
        monster:doAfter(delay, 0.7)
      end
      monster.states.FlashBack.timer = 0
      Iaser_start.base.start(Iaser_start)
    end
    
    function Iaser_loop.start(Iaser_loop)
      Iaser_loop.base.start(Iaser_loop)
      set_lock_velocity(monster.npc, 0.1)
    end
    
    function Iaser_loop.finish(Iaser_loop)
      monster.states.Bomb.timer = get_npc_time(monster.npc) + monster.states.Bomb.cd
      local npc = Iaser_loop.monster.npc
      abort_magic_by_id(npc, 20103401025, 1)
      abort_magic_by_id(npc, 20103401030, 1)
      abort_magic_by_id(npc, 20103401031, 1)
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      abort_magic_by_id(monster.npc, 20103401066, 1)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      abort_magic_by_id(monster.npc, 20103401069, 1)
      if 3 == faint.monster.ai_state then
        set_scene_camera(2010340101)
        abort_magic_by_id(faint.monster.npc, 20103401025, 1)
        abort_magic_by_id(faint.monster.npc, 20103401030, 1)
        abort_magic_by_id(faint.monster.npc, 20103401031, 1)
      end
    end
  end
  do
    local dead = monster.states.dead
    dead.delay = {fx = 4, remove = 5}
  end
  do
    local FlashBack = monster.states.FlashBack
    local Bomb = monster.states.Bomb
    local flash = monster.states.flash
    local Q1_pos = {
      x = 189,
      y = -954.3987,
      z = 204
    }
    FlashBack.timer = 20
    
    function FlashBack.isReady(FlashBack)
      if not check_npc_distance_to_pos(monster.npc, Q1_pos.x, Q1_pos.z, 12, false) and FlashBack.timer < get_npc_time(monster.npc) then
        return Bomb.base.isReady(Bomb)
      end
      return false
    end
    
    function Bomb.start(Bomb)
      local Q1_pos = {
        x = 189.0939,
        y = -954.3987,
        z = 204.883
      }
      local look_pos = {
        x = 189.0939,
        y = -954.3987,
        z = 196.021
      }
      FlashBack.timer = get_npc_time(monster.npc) + 35
      flash_to_pos(monster.npc, Q1_pos.x, Q1_pos.z)
      set_lock_velocity(monster.npc, 25)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      lookat_position(monster.npc, look_pos.x, look_pos.z, false)
      abort_magic_by_id(monster.npc, 20103401066, 1)
      abort_magic_by_id(monster.npc, 20103401067, 1)
      Bomb.base.start(Bomb)
    end
    
    function Bomb.finTrans(Bomb)
      set_lock_velocity(monster.npc, 0.1)
      return monster.states.wander
    end
  end
  do
    local moveTripleHit = monster.states.moveTripleHit
    local Redskill = monster.states.Redskill
    
    function moveTripleHit.finish(moveTripleHit)
      moveTripleHit.base.finish(moveTripleHit)
      Redskill.timer = get_npc_time(monster.npc) + 10
    end
    
    function Redskill.finish(Redskill)
      Redskill.base.finish(Redskill)
      moveTripleHit.timer = get_npc_time(monster.npc) + 10
    end
  end
  do
    local Triple_Jump = monster.states.Triple_Jump
    
    function Triple_Jump.isReady(Triple_Jump)
      return 3 == monster.ai_state
    end
    
    function Triple_Jump.finish(Triple_Jump)
      monster.states.jumpHit.timer = get_npc_time(monster.npc) + 8
    end
  end
end

function monster.on_start(monster)
  set_npc_phase_number(monster.npc, 2)
  monster.born_pos = get_npc_pos(monster.npc)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  monster:xRay()
  set_lock_velocity(monster.npc, 0.1)
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
end

function monster.on_self_npc_hp_zero(monster)
  if 1 == monster.ai_state then
    change_npc_phase_state(monster.npc, 2, false)
    abort_skill(monster.npc, true)
    switch_bgm_block("bgm_ancient_boss", 2)
    start_stroy(202010)
    monster.ai_state = 2
    if not monster.challenge_normal and not monster.challenge_hard then
      cast_magic(monster.npc, monster.npc, 20103401067, 1)
      cast_magic(monster.npc, monster.npc, 20103401071, 1)
      cast_magic(monster.npc, monster.npc, 1999330, 1)
      cast_magic(monster.npc, monster.npc, 1999331, 1)
      
      function monster.states.changeStateA.isReady()
        return true
      end
      
      tool.BOSS_Dead = true
      monster:transState(monster.states.changeStateA, true)
    end
    if monster.challenge_normal or monster.challenge_hard then
      abort_magic_by_id(monster.npc, 20103401067, 99)
      monster:transState(monster.states.stagger, true)
    end
  end
  if 3 == monster.ai_state then
    change_npc_phase_state(monster.npc, 1, false)
    switch_bgm_block("bgm_ancient_boss", 3)
    monster.tree:transState(monster.states.dead)
    
    local function hp()
      set_npc_hp_visible(monster.npc, false)
    end
    
    monster:doAfter(hp, 3)
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  monster.base.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 20103401068 == magic_id then
    cast_magic(monster.npc, monster.npc, 20103401069, 1)
  end
  if 20103401047 == magic_id then
    local look_pos = {
      x = 189.0939,
      y = -954.4951,
      z = 204.44
    }
    exit_stun(monster.npc)
    set_npc_pos(monster.npc, "T1")
    set_lock_velocity(monster.npc, 25)
    lookat_position(monster.npc, look_pos.x, look_pos.z, false)
    set_scene_camera(2010340103)
    if get_tough_record_state(monster.npc) then
      cast_magic(monster.npc, monster.npc, 1999225, 1)
    end
    cast_magic(monster.npc, monster.npc, 20103401065, 1)
    
    function monster.states.henshin_start.isReady()
      return true
    end
    
    monster.states.changeStateA.trans = true
    monster.states.changeStateA:derive(monster.states.henshin_start)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 20103401068 == magic_id then
    abort_magic_by_id(monster.npc, 20103401069, 1)
    abort_magic_by_id(monster.npc, 20103401067, 1)
  end
  if 20103401067 == magic_id then
    abort_magic_by_id(monster.npc, 20103401071, 1)
    abort_magic_by_id(monster.npc, 20103401072, 1)
    abort_magic_by_id(monster.npc, 20103401073, 1)
  end
end

function monster.on_keyframe_action(monster, kfId, npcTag, comnTag)
  if 201034010406 == kfId then
    cast_missile3(monster.npc, nil, 189, 221.3, 201034010401, 1)
  end
end

return monster
