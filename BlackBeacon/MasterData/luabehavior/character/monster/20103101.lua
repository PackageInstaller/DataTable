local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 3.5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 100, maxDis = 100}
  local skills = {
    Gape_Atk = {
      2010310101,
      10,
      2,
      0,
      4,
      -45,
      45
    },
    Gape_turn180 = {
      2010310102,
      10,
      2,
      0,
      4,
      -10,
      180
    },
    Top_beforSkill = {
      2010310101,
      0,
      0,
      0,
      99
    },
    Top_start = {
      2010310103,
      25,
      15,
      0,
      99
    },
    Top_loop = {
      2010310104,
      0,
      0,
      0,
      99
    },
    Top_end = {
      2010310105,
      0,
      0,
      0,
      99
    },
    RedSkill_Spitting = {
      2010310106,
      16,
      8,
      0,
      15
    },
    Spitting = {
      2010310125,
      12,
      2,
      0,
      15
    },
    Thunder2 = {
      2010310115,
      5,
      2,
      0,
      20
    },
    Iaser_start = {
      2010310116,
      30,
      0,
      0,
      99
    },
    Iaser_loop = {
      2010310119,
      0,
      0,
      0,
      99
    },
    Iaser_end = {
      2010310120,
      0,
      0,
      0,
      99
    },
    Left90 = {
      2010310109,
      0,
      0,
      0,
      5
    },
    Right90 = {
      2010310110,
      0,
      0,
      0,
      5
    }
  }
  local nodes = {
    "Top",
    "Turn",
    "ATK",
    "moveStateA",
    "ATK_stateA",
    "ATK_stateB",
    "Iaser"
  }
  local actMoves = {
    "Stand",
    "Henshin",
    "moveStateB"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.time = 0
  monster.droptime = 0
  monster.ai_state = 1
  monster.check_room_id = 101401
  monster.drop_time = 0
  monster.allow_attack = 0
  monster.allow_warning = 0
  monster.next_attack = 0
  monster.next_warning = 0
  monster.obstacle_missile = 201031010808
  monster.obstacle_missile_self = 201031010810
  monster.obstacle_missile_collide = 201031010809
  monster.stateB_obstacle = 0
  monster.Thunder2_time = 0
  monster.Gear_missile = 201031010804
  monster.Gear_num = 0
  monster.overload_nums = 0
  monster.HenshinSwitch = false
  monster.check_story_stat2 = 0
  monster.check_story_stun = 0
  monster.change_stage_time = 0
  monster.storycheck = true
  monster.obstacle_count_info = {
    timer = 12,
    nums = 0,
    pos = {}
  }
  monster.stun_missile_list = {
    [201031010305] = true,
    [201031010306] = true,
    [201031010307] = true,
    [201031010308] = true,
    [201031010403] = true,
    [201031010404] = true,
    [201031010405] = true,
    [201031010406] = true,
    [201031010503] = true,
    [201031010504] = true,
    [201031010505] = true,
    [201031010506] = true,
    [201031010507] = true,
    [201031010508] = true,
    [201031010509] = true,
    [201031010510] = true
  }
  monster.drop_missile_list = {}
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.Henshin, _ENV.noTarget)
    _ENV.freeAtk(_ENV.ATK_stateA, _ENV.ATK_stateB)
    _ENV.ATK_stateA(_ENV.Top, _ENV.RedSkill_Spitting, _ENV.Spitting, _ENV.ATK)
    _ENV.ATK_stateB(_ENV.Iaser, _ENV.Thunder2)
    _ENV.ATK(_ENV.Gape_Atk(_ENV.Gape_turn180))
    _ENV.Top(_ENV.Top_beforSkill(_ENV.Top_start(_ENV.Top_loop(_ENV.Top_loop))), _ENV.Top_end)
    _ENV.Iaser(_ENV.Iaser_start(_ENV.Iaser_loop(_ENV.Iaser_end)))
    _ENV.wander(_ENV.moveStateA, _ENV.moveStateB)
    _ENV.moveStateA(_ENV.Turn, _ENV.forward, _ENV.Stand)
    _ENV.Turn(_ENV.Left90, _ENV.Right90)
  end
  if get_tower_id() == 220103 or get_tower_id() == 220104 or get_tower_id() == 220105 then
    set_keyframe_enable(monster.npc, 201031011606, true, true)
    set_keyframe_enable(monster.npc, 201031011902, true, true)
    monster.hard = true
  else
    set_keyframe_enable(monster.npc, 201031011606, false, true)
    set_keyframe_enable(monster.npc, 201031011902, false, true)
    monster.states.attack.interval = 3
    monster.hard = false
    monster.obstacle_missile_self = 201031010824
  end
  
  function monster.states.root.tick(root)
    if check_magic(root.monster.npc, 20103101072) then
      exit_stun(root.monster.npc)
    end
  end
  
  do
    local active = monster.states.active
    local ATK_stateA = monster.states.ATK_stateA
    local ATK_stateB = monster.states.ATK_stateB
    monster.states.faint.switch = false
    
    function active.start()
      active.base.start(active)
      active.monster:xRay()
    end
    
    function active.tick(active)
      active.monster.drop_down_count(monster)
      active.monster.RedSkill_Gear(monster)
      active.monster.Gear(monster)
      active.monster.Thunder(monster)
    end
    
    function ATK_stateA.isReady(ATK_stateA)
      if 1 == ATK_stateA.monster.ai_state then
        return true
      end
    end
    
    function ATK_stateB.isReady(ATK_stateB)
      if 2 == ATK_stateB.monster.ai_state then
        return true
      end
    end
  end
  do
    local ATK = monster.states.ATK
    local Gape_Atk = monster.states.Gape_Atk
    local Gape_turn180 = monster.states.Gape_turn180
    
    function ATK.isReady(ATK)
      if Gape_turn180.base.isReady(Gape_turn180) then
        return true
      end
    end
    
    function Gape_Atk.start(Gape_Atk)
      Gape_turn180.backup = Gape_turn180.isReady
      
      function Gape_turn180.isReady()
        return true
      end
      
      set_skill_end_to_idle(Gape_Atk.monster.npc, false)
      Gape_Atk.base.start(Gape_Atk)
    end
    
    function Gape_turn180.start(Gape_turn180)
      Gape_turn180.isReady = Gape_turn180.backup
      Gape_turn180.base.start(Gape_turn180)
    end
  end
  do
    local Top = monster.states.Top
    local Top_beforSkill = monster.states.Top_beforSkill
    local Top_loop = monster.states.Top_loop
    local Top_end = monster.states.Top_end
    local Top_start = monster.states.Top_start
    Top_loop.spin_timer = 0
    
    function Top.isReady(Top)
      if 0 == monster.obstacle_count_info.nums then
        return false
      end
      local Top_start = Top.monster.states.Top_start
      return Top_start.base.isReady(Top_start)
    end
    
    function Top.finish(Top)
      abort_magic_by_id(monster.npc, 20103101076)
      cast_magic(monster.npc, monster.npc, 1999219, 1)
      Top.base.finish(Top)
    end
    
    function Top_beforSkill.start(Top_beforSkill)
      set_skill_end_to_idle(Top_beforSkill.monster.npc, false)
      Top_beforSkill.base.start(Top_beforSkill)
    end
    
    function Top_start.start(Top_start)
      Top_start.monster.states.Top_loop.spin_timer = get_npc_time(Top_start.monster.npc) + 4 + 2 * math.random()
      play_DBM_ani(7)
      if Top_start.monster.storycheck == true then
        start_stroy(201402)
        Top_start.monster.storycheck = false
      end
      Top_start.base.start(Top_start)
    end
    
    function Top_loop.isReady(Top_loop)
      if get_npc_time(Top_loop.monster.npc) < Top_loop.spin_timer then
        return true
      end
    end
    
    function Top_loop.start(Top_loop)
      Top_loop.base.start(Top_loop)
    end
    
    function Top_loop.finTrans(Top_loop)
      return Top_loop.monster.states.Top_end
    end
    
    function Top_end.isReady(Top_end)
      if get_npc_time(Top_end.monster.npc) > Top_loop.spin_timer then
        return true
      end
    end
    
    function Top_end.start(Top_end)
      disable_DBM(7, 1)
      abort_magic_by_id(Top_end.monster.npc, 20103101017)
      Top_end.base.start(Top_end)
    end
  end
  do
    local Spitting = monster.states.Spitting
    local RedSkill_Spitting = monster.states.RedSkill_Spitting
    
    function Spitting.isReady(Spitting)
      if Spitting.monster.Gear_num >= 6 then
        return false
      end
      return Spitting.base.isReady(Spitting)
    end
    
    function RedSkill_Spitting.isReady(RedSkill_Spitting)
      if RedSkill_Spitting.monster.Gear_num >= 6 then
        return false
      end
      return RedSkill_Spitting.base.isReady(RedSkill_Spitting)
    end
  end
  do
    local wander = monster.states.wander
    local moveStateA = monster.states.moveStateA
    local moveStateB = monster.states.moveStateB
    
    function wander.tickTrans(wander)
      if is_cast_skill_time(monster.npc, nil, true) then
        return
      end
      local monster = wander.monster
      local states = monster.states
      if not monster.target then
        return states.noTarget
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
    
    function moveStateA.isReady(moveStateA)
      if 1 ~= moveStateA.monster.ai_state then
        return false
      end
      return true
    end
    
    function moveStateB.isReady(moveStateB)
      if 2 == moveStateB.monster.ai_state then
        return true
      end
    end
    
    function moveStateB.tick(moveStateB)
      stop_move(moveStateB.monster.npc)
      lookat_npc(moveStateB.monster.npc, moveStateB.monster.target, false)
    end
  end
  do
    local Henshin = monster.states.Henshin
    local gotTarget = monster.states.gotTarget
    local faint = monster.states.faint
    faint.time = 0
    Henshin.turn = false
    
    function gotTarget.tickTrans(gotTarget)
      if gotTarget.monster.HenshinSwitch == true then
        abort_skill(gotTarget.monster.npc, true)
        Henshin.turn = true
        return Henshin
      end
    end
    
    function faint.start(faint)
      local monster = faint.monster
      if 1 == monster.ai_state then
        abort_magic_by_id(monster.npc, 20103101017, 99)
        remove_missile_by_id(201031011703, nil, false)
        disable_DBM(7, 1)
      end
      if 2 == monster.ai_state then
        remove_missile_by_id(201031011601, monster.npc, true)
        remove_missile_by_id(201031011606, monster.npc, true)
        abort_magic_by_id(monster.npc, 20103101063, 99)
        abort_magic_by_id(monster.npc, 20103101062, 99)
      end
    end
    
    function faint.tickTrans(faint)
      if faint.monster.HenshinSwitch == true then
        abort_skill(gotTarget.monster.npc, true)
        Henshin.turn = true
        return Henshin
      end
    end
    
    function Henshin.isReady(Henshin)
      return Henshin.turn and Henshin.monster.HenshinSwitch
    end
    
    function Henshin.start(Henshin)
      local monster = Henshin.monster
      Henshin.turn = false
      monster.HenshinSwitch = false
      abort_magic_by_id(monster.npc, 20103101017)
      flash_to_pos(monster.npc, monster.born_pos.x, monster.born_pos.z)
      set_npc_controller(monster.npc, 1)
      stop_move(monster.npc)
      lookat_npc(monster.npc, monster.target, false)
      cast_magic(monster.npc, monster.npc, 1999224, 1)
      cast_magic(monster.npc, monster.npc, 1999225, 1)
      cast_magic(monster.npc, monster.npc, 1999330, 1)
      cast_magic(monster.npc, monster.npc, 1999331, 1)
      
      local function magic()
        abort_magic_by_id(monster.npc, 20103101004)
        abort_magic_by_id(monster.npc, 20103101005)
        abort_magic_by_id(monster.npc, 20103101059)
        abort_magic_by_id(monster.target, 20103101059)
        remove_missile_by_id(201031010805, monster.npc, true)
        remove_missile_by_id(201031010808, monster.npc, true)
        remove_missile_by_id(201031010809, monster.npc, true)
        remove_missile_by_id(monster.obstacle_missile_self, monster.npc, true)
        remove_missile_by_id(201031010810, monster.npc, true)
      end
      
      local function STUN()
        abort_skill(monster.npc, true)
        exit_stun(monster.npc)
        monster.ai_state = 2
        monster:transState(monster.states.Iaser)
      end
      
      monster:doAfter(magic, 1)
      monster:doAfter(STUN, 0.6)
    end
    
    function Henshin.tickTrans(Henshin)
      if 2 == Henshin.monster.ai_state then
        return Henshin.monster.states.Iaser
      end
    end
  end
  do
    local Iaser_end = monster.states.Iaser_end
    
    function Iaser_end.start(Iaser_end)
      local monster = Iaser_end.monster
      remove_missile_by_id(201031011601, monster.npc, true)
      remove_missile_by_id(201031011606, monster.npc, true)
      abort_magic_by_id(monster.npc, 20103101062, 1)
      abort_magic_by_id(monster.npc, 20103101063, 1)
      Iaser_end.base.start(Iaser_end)
    end
  end
  do
    local Thunder2 = monster.states.Thunder2
    Thunder2.trans = false
    
    function Thunder2.start(Thunder2)
      local function delay()
        play_DBM_ani(26)
      end
      
      monster:doAfter(delay, 0.5)
      Thunder2.monster.Thunder2_time = get_npc_time(Thunder2.monster.npc) + 1
      Thunder2.base.start(Thunder2)
      
      function Thunder2.finish(Thunder2)
        Thunder2.base.finish(Thunder2)
        disable_DBM(26, 1)
      end
    end
  end
  do
    local Turn = monster.states.Turn
    local Left90 = monster.states.Left90
    local Right90 = monster.states.Right90
    local Stand = monster.states.Stand
    
    function Turn.isReady(Turn)
      local AngleToPlayer = get_target_angel(Turn.monster.npc, Turn.monster.target, true)
      if AngleToPlayer > 45 or AngleToPlayer < -45 then
        return true
      else
        return false
      end
    end
    
    function Turn.finTrans(True)
      return True.monster.states.Stand
    end
    
    function Left90.isReady(Left90)
      local angle = get_target_angel(Left90.monster.npc, Left90.monster.target, true)
      if angle <= -45 and angle >= -180 then
        return true
      end
    end
    
    function Right90.isReady(Right90)
      local angle = get_target_angel(Right90.monster.npc, Right90.monster.target, true)
      if angle >= 45 and angle <= 180 then
        return true
      end
    end
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
    end
    
    function Stand.tickTrans(Stand)
      local Turn = Stand.monster.states.Turn
      if Turn.base.isReady(Turn) then
        return Turn
      end
    end
  end
  do
    local dead = monster.states.dead
    dead.delay = {fx = 2.2, remove = 3.2}
  end
end

function monster.on_start(monster)
  set_npc_phase_number(monster.npc, 2)
  monster:xRay()
  play_effect(monster.npc, "Fx_M201031_crack", "Bone052", false)
  change_follow_target(3, monster.npc, {
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
  monster.born_pos = get_npc_pos(monster.npc)
  if get_cur_room_id() == monster.check_room_id then
    start_stroy(201401)
  end
  monster:xRay()
end

function monster.drop_down_count(monster)
  if not monster.target then
    return
  end
  if 1 == monster.ai_state then
    if not monster.hard then
      if get_npc_time(monster.npc) > monster.obstacle_count_info.timer and 0 == monster.obstacle_count_info.nums then
        local drop_positions = {
          "drop_1",
          "drop_2",
          "drop_3",
          "drop_4"
        }
        local missile_id = 201031010823
        for _, drop in ipairs(drop_positions) do
          local drop_x, drop_y, drop_z = get_area_pos(drop)
          cast_missile(monster.npc, nil, drop_x, drop_z, missile_id, 1)
          cast_missile(monster.npc, nil, drop_x, drop_z, monster.obstacle_missile_self, 1)
        end
        monster.droptime = get_npc_time(monster.npc) + 2
        monster.obstacle_count_info.timer = get_npc_time(monster.npc) + 7
        monster.obstacle_count_info.nums = 4
      end
    elseif get_npc_time(monster.npc) > monster.obstacle_count_info.timer and 0 == monster.obstacle_count_info.nums then
      local random = math.random(1, 4)
      local drop_positions_list = {
        "drop_1",
        "drop_2",
        "drop_3",
        "drop_4"
      }
      local missile_id = 201031010823
      local drop_x, drop_y, drop_z = get_area_pos(drop_positions_list[random])
      cast_missile(monster.npc, nil, drop_x, drop_z, missile_id, 1)
      cast_missile(monster.npc, nil, drop_x, drop_z, monster.obstacle_missile_self, 1)
      monster.droptime = get_npc_time(monster.npc) + 2
      monster.obstacle_count_info.timer = get_npc_time(monster.npc) + 7
      monster.obstacle_count_info.nums = 1
    end
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  local now_time = get_npc_time(monster.npc)
  if 1 ~= monster.ai_state then
    return
  end
  if missile_cfg.Id == monster.obstacle_missile_collide then
    cast_magic(monster.npc, monster.npc, 20103101018, 1)
  end
  if missile_cfg.Id == 201031010802 then
    cast_magic(monster.npc, monster.npc, 20103101002, 1)
  end
  if missile_cfg.Id == monster.obstacle_missile_self then
    table.insert(monster.drop_missile_list, missile)
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  local m1_cfg = other_missile_cfg
  local m2_cfg = self_missile_cfg
  local m1 = other_missile
  local m2 = self_missile
  if 1 ~= monster.ai_state then
    return
  end
  if m1_cfg.Id == monster.obstacle_missile_self then
    for i, _ in pairs(monster.stun_missile_list) do
      if m2_cfg.Id == i then
        cast_magic(monster.npc, monster.npc, 1999242, 1)
        cast_magic(monster.npc, monster.npc, 1999261, 1)
        cast_magic(monster.npc, monster.npc, 20103101068, 1)
        abort_skill(monster.npc)
        remove_missile_by_id(201031011703, nil, false)
        remove_missile(m1, false)
        local pos_save = {}
        local mons_pos = get_npc_pos(monster.npc)
        cast_missile(monster.npc, nil, pos_save.x, pos_save.z, 201031010815, 1)
        cast_missile(monster.npc, nil, pos_save.x, pos_save.z, 201031010816, 1)
        remove_missile(m1, false)
        abort_magic_by_id(monster.npc, 20103101017, 99)
        cast_magic(monster.npc, monster.npc, 20103101014, 1)
        cast_magic(monster.npc, monster.npc, 20103101015, 1)
        cast_magic(monster.npc, monster.npc, 20103101016, 1)
        monster.obstacle_count_info.nums = monster.obstacle_count_info.nums - 1
        monster.obstacle_count_info.timer = get_npc_time(monster.npc) + 7
        monster.allow_attack = 0
        monster.allow_warning = 0
        monster.allow_x = 0
        set_sync_var("M201031_stunset", true)
        if 0 == monster.check_story_stun and get_cur_room_id() == monster.check_room_id then
          start_stroy(201403)
          monster.check_story_stun = 1
        end
        disable_DBM(7, 1)
      end
    end
  end
end

function monster.RedSkill_Gear(monster)
  if 1 ~= monster.ai_state then
    return
  end
  if not monster.target then
    return
  end
  if check_magic(monster.npc, 20103101003) and is_cast_skill_time(monster.npc, 2010310106) then
    local ran_far = 1
    local ran_near = 1
    if get_target_angel(monster.npc, monster.target, true) <= -45 and get_target_angel(monster.npc, monster.target, true) >= 45 then
      cast_missile(monster.npc, monster.target, nil, nil, monster.Gear_missile, 1)
      local dis = get_npc_distance(monster.npc, 1, monster.target, true)
      local now_pos = get_npc_pos(monster.npc)
      local tar_pos = get_npc_pos(monster.target)
      local dir_pos = tar_pos - now_pos
      local curb_lengeth = dis / 8
      if dis <= 8 then
        for _ = 1, ran_far do
          local len = 8 + curb_lengeth * math.random() * 2
          local ran_deg = math.random() * 30
          local ran_half = math.random() * 10
          if ran_half >= 5 then
            ran_deg = 0 - ran_deg
          end
          local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, len)
          local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
          if wp_judge then
            cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
          else
            cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
          end
        end
      elseif dis > 8 then
        for _ = 1, ran_far do
          local len = 8 - curb_lengeth * math.random() * 2
          local ran_deg = 180 - math.random() * 30
          local ran_half = math.random() * 10
          if ran_half >= 5 then
            ran_deg = 0 - ran_deg
          end
          local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, len)
          local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
          if wp_judge then
            cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
          else
            cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
          end
        end
      end
      for _ = 1, ran_near do
        local ran_len = math.random() * 1 + 1.5
        local ran_deg = math.random() * 360
        local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, ran_len)
        local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
        if wp_judge then
          cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
        else
          cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
        end
      end
      monster.Gear_num = monster.Gear_num + ran_far + ran_near + 1
    else
      local ran_nums = math.random(1, 2)
      for _ = 1, ran_nums do
        local ran_deg = math.random() * 30
        local ran_half = math.random() * 10
        local ran_len = math.random() * 3
        if ran_half >= 5 then
          ran_deg = 0 - ran_deg
        end
        local ran_pos = get_npc_offset_position(monster.npc, nil, ran_deg, ran_len + 5)
        local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), ran_pos, 4)
        if wp_judge then
          cast_missile(monster.npc, nil, ran_pos.x, ran_pos.z, monster.Gear_missile, 1)
        else
          cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
        end
      end
      monster.Gear_num = monster.Gear_num + ran_nums
    end
    abort_magic_by_id(monster.npc, 20103101003)
  end
end

function monster.Gear(monster)
  if 1 ~= monster.ai_state then
    return
  end
  if not monster.target then
    return
  end
  if check_magic(monster.npc, 20103101003) and is_cast_skill_time(monster.npc, 2010310125) then
    local ran_far = 1
    local ran_near = 1
    if get_target_angel(monster.npc, monster.target, true) <= -45 and get_target_angel(monster.npc, monster.target, true) >= 45 then
      cast_missile(monster.npc, monster.target, nil, nil, monster.Gear_missile, 1)
      local dis = get_npc_distance(monster.npc, 1, monster.target, true)
      local now_pos = get_npc_pos(monster.npc)
      local tar_pos = get_npc_pos(monster.target)
      local dir_pos = tar_pos - now_pos
      local curb_lengeth = dis / 8
      if dis <= 8 then
        for _ = 1, ran_far do
          local len = 8 + curb_lengeth * math.random() * 2
          local ran_deg = math.random() * 30
          local ran_half = math.random() * 10
          if ran_half >= 5 then
            ran_deg = 0 - ran_deg
          end
          local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, len)
          local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
          if wp_judge then
            cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
          else
            cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
          end
        end
      elseif dis > 8 then
        for _ = 1, ran_far do
          local len = 8 - curb_lengeth * math.random() * 2
          local ran_deg = 180 - math.random() * 30
          local ran_half = math.random() * 10
          if ran_half >= 5 then
            ran_deg = 0 - ran_deg
          end
          local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, len)
          local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
          if wp_judge then
            cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
          else
            cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
          end
        end
      end
      for _ = 1, ran_near do
        local ran_len = math.random() * 1 + 1.5
        local ran_deg = math.random() * 360
        local far_pos1 = get_npc_offset_position(monster.target, dir_pos, ran_deg, ran_len)
        local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), far_pos1, 4)
        if wp_judge then
          cast_missile(monster.npc, nil, far_pos1.x, far_pos1.z, monster.Gear_missile, 1)
        else
          cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
        end
      end
      monster.Gear_num = monster.Gear_num + ran_far + ran_near + 1
    else
      local ran_nums = math.random(1, 2)
      for _ = 1, ran_nums do
        local ran_deg = math.random() * 30
        local ran_half = math.random() * 10
        local ran_len = math.random() * 3
        if ran_half >= 5 then
          ran_deg = 0 - ran_deg
        end
        local ran_pos = get_npc_offset_position(monster.npc, nil, ran_deg, ran_len + 5)
        local wp_judge, wp_pos = get_nearest_walkable_pos(get_npc_pos(monster.target), ran_pos, 4)
        if wp_judge then
          cast_missile(monster.npc, nil, ran_pos.x, ran_pos.z, monster.Gear_missile, 1)
        else
          cast_missile(monster.npc, nil, wp_pos.x, wp_pos.z, monster.Gear_missile, 1)
        end
      end
      monster.Gear_num = monster.Gear_num + ran_nums
    end
    abort_magic_by_id(monster.npc, 20103101003)
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if 1 ~= monster.ai_state then
    return
  end
  if missile_cfg.Id == 201031010805 then
    monster.Gear_num = monster.Gear_num - 1
  end
end

function monster.on_self_npc_hp_zero(monster)
  disable_DBM(7, 1)
  if 1 == monster.ai_state then
    cast_magic(monster.npc, monster.npc, 1999242, 1)
    cast_magic(monster.npc, monster.npc, 1999261, 1)
    change_npc_phase_state(monster.npc, 2, false)
    clear_input(nil)
    cast_magic(monster.npc, monster.npc, 20103101005, 1)
    stop_move(monster.npc)
    cast_magic(monster.npc, monster.npc, 20103101059, 1)
    switch_bgm_block("bgm_modern_boss", 2)
    monster.HenshinSwitch = true
    
    local function TurnState()
      cast_magic(monster.npc, monster.npc, 20103101004, 1)
      if 0 == monster.check_story_stat2 and get_cur_room_id() == monster.check_room_id then
        start_stroy(201404)
        monster.check_story_stat2 = 1
      end
    end
    
    monster:doAfter(TurnState, 0)
    return
  end
  if 2 == monster.ai_state then
    monster.ai_state = 0
    change_npc_phase_state(monster.npc, 1, false)
    monster.base.on_self_npc_hp_zero(monster)
  end
end

function monster.Thunder(monster)
  if 2 ~= monster.ai_state then
    return
  end
  if not monster.target then
    return
  end
  if not is_cast_skill_time(monster.npc, 2010310115) then
    return
  end
  local now_time = get_npc_time(monster.npc)
  local now_pos = get_npc_pos(monster.npc)
  local pos
  if now_time > monster.Thunder2_time then
    monster.Thunder2_time = now_time + 1
    if monster.hard then
      local ran_deg = math.random() * 360
      local ran_len = math.random() * 3 + 1.5
      pos = get_npc_offset_position(monster.target, nil, ran_deg, ran_len)
    else
      local targetDis = get_npc_distance(monster.npc, 1, monster.target, false)
      if targetDis > 1 then
        local ran_deg = math.random() * 360
        local ran_len = math.random() * 3 + 1.5
        pos = get_npc_offset_position(monster.target, nil, ran_deg, ran_len)
      else
        pos = get_npc_pos(monster.npc)
      end
    end
    cast_missile(monster.npc, nil, pos.x, pos.z, 201031010801, 1)
    if math.abs(pos.x - now_pos.x) <= 2.5 and math.abs(pos.z - now_pos.z) <= 2.5 then
      local function stun()
        if monster.hard then
          cast_magic(monster.npc, monster.npc, 20103101077)
        else
          cast_magic(monster.npc, monster.npc, 20103101069)
        end
      end
      
      monster:doAfter(stun, 1.1)
    end
  end
end

function monster.on_npc_removed(monster, npc)
  local kind = get_role_kind(npc)
  if 1 ~= kind and npc == monster.target then
    monster:searchTarget()
  end
end

return monster
