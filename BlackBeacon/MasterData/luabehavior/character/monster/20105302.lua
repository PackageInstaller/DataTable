local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 3,
    type = "Sprint_B3"
  }
  monster.search = {minDis = 100, maxDis = 100}
  monster.born = 2010530210
  local skills = {
    Starfall_A1 = {2010530201},
    Starfall_A2 = {2010530202},
    Starfall_B1 = {2010530201},
    Starfall_B2 = {2010530202},
    Starfall_loop = {2010530203},
    Sprint_start = {2010530204},
    Sprint_move = {2010530205},
    Sprint_atk = {2010530206},
    Sprint_B1 = {2010530204},
    Sprint_B2 = {2010530205},
    Sprint_B3 = {2010530209},
    Sprint_atkB = {2010530206},
    Combo = {2010530208},
    ComboB = {2010530208},
    Execution_hit = {2010530207},
    Hit = {2010530212},
    jumpHit = {2010530213},
    Turnhit = {2010530214}
  }
  set_stun_animation_group_id(monster.npc, 1)
  local nodes = {
    "StartfallA",
    "Sprint",
    "stateA",
    "StartfallB",
    "SprintB"
  }
  local actMoves = {"MoveTo", "Stop"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.stateA, _ENV.wander)
    _ENV.stateA(_ENV.Sprint, _ENV.Execution_hit, _ENV.StartfallB, _ENV.SprintB, _ENV.Hit, _ENV.ComboB, _ENV.jumpHit)
    _ENV.StartfallB(_ENV.Starfall_B1(_ENV.Starfall_B2))
    _ENV.Sprint(_ENV.Sprint_start(_ENV.Sprint_move), _ENV.Sprint_atk)
    _ENV.SprintB(_ENV.Sprint_B1(_ENV.Sprint_B3(_ENV.Sprint_B2(_ENV.Sprint_atkB))))
    _ENV.jumpHit(_ENV.Turnhit)
    _ENV.wander(_ENV.Stop)
  end
  monster.states.dead.delay = {fx = 2.5, remove = 2.9}
  monster.defaultcam = get_cur_camera_id()
  monster.states.attack.interval = 1
  char_visible(false)
  set_can_searched(monster.npc, false)
  monster:xRay()
  monster.HitTrans = true
  do
    local born = monster.states.born
    local ComboB = monster.states.ComboB
    if monster.tool.reborn then
      lookat_npc(get_come_on_hero(), monster.npc, true)
      
      function monster.states.bornSkill.startFrame()
        return 50
      end
    end
    
    function born.start(born)
      monster:searchTarget()
      if not monster.tool.reborn then
        change_follow_target_new(1, monster.npc, {
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
      else
        change_follow_target_new(0)
      end
      local posX, posY, posZ = get_area_pos("A5")
      set_npc_pos(monster.npc, "M0")
      lookat_position(monster.npc, posX, posZ, true)
      cast_missile(monster.npc, nil, posX, posZ, 201053021101, 1)
      born.base.start(born)
    end
    
    function born.finTrans(born)
      local distance = check_npc_distance(monster.npc, get_come_on_hero(), 7, true)
      if distance then
        return monster.states.ComboB
      end
      monster.target = get_come_on_hero()
      return monster.states.Sprint
    end
    
    function ComboB.moveScaleZ()
      return 2
    end
    
    function ComboB.start(ComboB)
      set_keyframe_enable(monster.npc, 201053020806, false, true)
      ComboB.base.start(ComboB)
    end
    
    function ComboB.finish(ComboB)
      ComboB.base.finish(ComboB)
      set_keyframe_enable(monster.npc, 201053020806, true, true)
    end
  end
  set_keyframe_enable(monster.npc, 201053020707, false, true)
  set_keyframe_enable(monster.npc, 201053020708, false, true)
  set_keyframe_enable(monster.npc, 201053020709, false, true)
  do
    local Execution_hit = monster.states.Execution_hit
    
    function Execution_hit.start(Execution_hit)
      monster.tool.reborn = true
      cast_magic(monster.npc, get_come_on_hero(), 201053012125)
      Execution_hit.base.start(Execution_hit)
      char_visible(true)
      start_stroy(5071509)
      set_ui_object_visible("fight", "Main", false)
    end
    
    function Execution_hit.finTrans()
      set_ui_object_visible("fight", "Main", true)
      return monster.states.Stop
    end
  end
  do
    local Sprint = monster.states.Sprint
    local Sprint_move = monster.states.Sprint_move
    
    function monster.skills.Execution_hit.startFrame()
      return 15
    end
    
    function Sprint_move.tick()
      local posx, posy, posz = get_area_pos("A3")
      if get_npc_distance(monster.npc, 1, get_come_on_hero(), false) < 5 then
        monster:transState(monster.states.Sprint_atk, true)
      end
    end
  end
  do
    local Sprint_B3 = monster.states.Sprint_B3
    local Sprint_move = monster.skills.Sprint_move
    local Sprint_B2 = monster.states.Sprint_B2
    
    function Sprint_B3.tick()
      if get_npc_distance(monster.npc, 1, get_come_on_hero(), false) < 8 then
        print(114514)
        Sprint_B3:derive()
      end
    end
    
    function Sprint_B2.tick()
      if get_npc_distance(monster.npc, 1, get_come_on_hero(), false) < 4 then
        Sprint_B2:derive()
      end
    end
  end
  do
    local jumpHit = monster.states.jumpHit
    local Turnhit = monster.states.Turnhit
    local Sprint_B1 = monster.states.Sprint_B1
    
    function jumpHit.target()
      return nil
    end
    
    function jumpHit.tarPos()
      local pos = {
        x = -137.92,
        y = -50.00005,
        z = 143.75
      }
      return pos
    end
    
    function Turnhit.finTrans(Turnhit)
      local distance = check_npc_distance(monster.npc, get_come_on_hero(), 9, true)
      if get_sync_var("up") ~= true then
        return monster.states.ComboB
      else
        return monster.states.SprintB
      end
    end
    
    function Sprint_B1.start(Sprint_B1)
      Sprint_B1.base.start(Sprint_B1)
      local posx, posy, posz = -137.92, -50.00005, 143.75
      if not check_npc_distance_to_pos(monster.npc, posx, posz, 3, false) then
        flash_to_pos(monster.npc, posx, posz)
      end
    end
  end
  do
    local Stop = monster.states.Stop
    
    function Stop.isReady()
      return true
    end
    
    function Stop.start(Stop)
      stop_move(monster.npc)
    end
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  if self_missile.missile_id == 201053021101 and other_missile.missile_id == 201053020503 then
    remove_missile_by_id(201053021101)
    monster.HitTrans = false
    if get_cur_camera_id() ~= 107090301 then
      set_camera(107090301, true)
    end
    monster:transState(monster.states.jumpHit, true)
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 201053011601 == magic_id then
    cast_magic(monster.npc, get_come_on_hero(), 201053012102, 1)
  end
  if 201053012104 == magic_id then
    remove_missile_by_id(201053021101)
    set_sync_var("Execution_hit", true)
  end
  if 201053012105 == magic_id then
    function monster.skills.Execution_hit.startFrame()
      return 15
    end
    
    monster:transState(monster.states.Execution_hit, true)
  end
  if 201053012118 == magic_id then
    local function Cam()
      change_follow_target_new(0)
      
      set_camera(107090202, true)
    end
    
    monster:doAfter(Cam, 1.4)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 2010530202 == skill_id and missile_cfg.Id == 201053020205 then
    function monster.states.Starfall_B2.finish()
      return
    end
    
    function monster.skills.Execution_hit.startFrame()
      return 15
    end
    
    monster:transState(monster.states.Execution_hit, true)
  end
  if 2010530214 == skill_id and missile_cfg.Id == 201053021402 then
    function monster.skills.Execution_hit.startFrame()
      return 15
    end
    
    monster:transState(monster.states.Execution_hit, true)
  end
end

function monster.MoveTpPos(monster, num)
  local posx, posy, posz = get_area_pos(num)
  local pos = {
    x = posx,
    y = posy,
    z = posz
  }
  return pos
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  local distance = check_npc_distance(monster.npc, get_come_on_hero(), 26, true)
  if get_sync_var("cam2") == true and true == monster.HitTrans then
    monster.HitTrans = false
    if get_cur_camera_id() ~= 107090301 then
      set_camera(107090301, true)
    end
    
    local function delay()
      flash_to_pos(monster.npc, -124, 143.75, -50.00005)
      monster:transState(monster.states.jumpHit, true)
    end
    
    if not distance then
      monster:doAfter(delay, 1)
    end
  end
end

return monster
