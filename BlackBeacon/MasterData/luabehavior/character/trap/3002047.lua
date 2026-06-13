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
  monster.all_value = {
    10,
    20,
    20
  }
  monster.value = monster.all_value[1]
  if monster.npc.id == 3002048 then
    monster.value = monster.all_value[2]
  end
  if monster.npc.id == 3002049 then
    monster.value = monster.all_value[3]
  end
  set_can_searched(monster.npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  local skills = {}
  local actMoves = {"pace"}
  local nodes = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.wander(_ENV.pace)
    _ENV.gotTarget(_ENV.wander)
  end
  do
    local states = monster.states
    states.pace.timer = get_npc_time(monster.npc)
    
    function states.pace.start(pace)
      local elapse = 1 + math.random() * 1.5
      pace.timer = get_npc_time(monster.npc) + elapse
      if monster.npc.id == 3002049 then
        pace.timer = get_npc_time(monster.npc) + 0.5 + math.random() * 0.5
      end
      local angle = math.random(45, 315)
      local monster = pace.monster
      monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, angle, 100000)
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, true)
      move_to_pos(monster.npc, monster.TEMP_POS)
      switch_move_type(monster.npc, 0)
      if monster.npc.id == 3002048 then
        set_npc_hp_visible(monster.npc, true)
        switch_move_type(monster.npc, 1)
      end
    end
    
    function states.pace.tickTrans(pace)
      if get_npc_time(pace.monster.npc) > pace.timer then
        return pace
      end
    end
    
    states.dead.delay.remove = 1.5
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type then
    if monster.npc.id == 3002048 then
      if attacker.id == 3002045 then
        cast_magic(monster.npc, monster.npc, 300204806, 1)
      else
        cast_magic(monster.npc, monster.npc, 300204803, 1)
      end
    else
      cast_magic(monster.npc, monster.npc, 3002002003, 2)
    end
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if get_cur_room_id() == 800201 then
    add_task_progress(8002011, monster.value)
    add_task_progress(8002012, monster.value)
    add_task_progress(8002013, monster.value)
  end
  if get_cur_room_id() == 800202 then
    add_task_progress(8002021, monster.value)
    add_task_progress(8002022, monster.value)
    add_task_progress(8002023, monster.value)
  end
  if get_cur_room_id() == 800203 then
    add_task_progress(8002031, monster.value)
    add_task_progress(8002032, monster.value)
    add_task_progress(8002033, monster.value)
  end
  if get_cur_room_id() == 800204 then
    add_task_progress(8002041, monster.value)
    add_task_progress(8002042, monster.value)
    add_task_progress(8002043, monster.value)
  end
  if monster.npc.id == 3002047 then
    cast_magic(monster.npc, monster.npc, 300204804)
  else
    cast_magic(monster.npc, monster.npc, 300204805)
  end
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
