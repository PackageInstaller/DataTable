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
  set_can_searched(npc, false)
  local skills = {
    turnback = {319000501, 0},
    turnfront = {319000502, 0},
    hurt = {319000503, 0},
    frontidle = {319000504, 0},
    backidle = {319000505, 0},
    hurtidle = {319000506, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.CD = 5
  monster.fire = true
  monster.timecount = 0
  monster.turn = false
  monster.canbehit = true
  monster.switchbabel = true
  monster.timeswitch = 3190005001
  cast_magic(npc, npc, 399001, 1)
  if check_magic(monster.npc, monster.timeswitch) then
    monster.timecount = -4
  else
    monster.timecount = 0
  end
  do
    local _ENV = monster.states
    _ENV.active(_ENV.stand, _ENV.turnfront, _ENV.turnback, _ENV.backidle, _ENV.hurt, _ENV.hurtidle)
  end
  local states = monster.states
  
  function states.stand.start(stand)
    local npc = stand.monster.npc
    stop_move(npc)
  end
  
  function states.stand.tickTrans(stand)
    if get_npc_time(monster.npc) - monster.timecount >= monster.CD and monster.switchbabel and get_sync_var("bb_switch") then
      monster.timecount = get_npc_time(monster.npc)
      if monster.turn == false then
        abort_skill(monster.npc, true)
        monster.tree:transState(monster.states.turnback)
        monster.turn = true
      else
        abort_skill(monster.npc, true)
        monster.tree:transState(monster.states.turnfront)
        monster.turn = false
      end
    end
  end
  
  function states.stand.finTrans(stand)
    return stand
  end
  
  function states.turnfront.finTrans(turnfront)
    return turnfront.monster.states.stand
  end
  
  function states.turnback.finTrans(turnback)
    return turnback.monster.states.backidle
  end
  
  function states.backidle.tickTrans(backidle)
    if get_npc_time(monster.npc) - monster.timecount >= monster.CD and monster.switchbabel and get_sync_var("bb_switch") then
      monster.timecount = get_npc_time(monster.npc)
      if monster.turn == false then
        abort_skill(monster.npc, true)
        monster.tree:transState(monster.states.turnback)
        monster.turn = true
      else
        abort_skill(monster.npc, true)
        monster.tree:transState(monster.states.turnfront)
        monster.turn = false
      end
    end
  end
  
  function states.backidle.finTrans(backidle)
    return backidle
  end
  
  function states.hurt.start(hurt)
    hurt.base.start(hurt)
    monster.canbehit = false
    monster.switchbabel = false
  end
  
  function states.hurt.finish(hurt)
    hurt.base.finish(hurt)
    print("114514")
    cast_magic(monster.npc, monster.npc, 399933, 1)
    if get_cur_room_id() == 3190102 then
      if get_sync_var("wave1") == true and get_sync_var("wave2") == false and false == get_sync_var("wave3") and false == get_sync_var("wave4") then
        on_level_counter_add("W1", 0)
      elseif get_sync_var("wave1") == false and true == get_sync_var("wave2") and false == get_sync_var("wave3") and false == get_sync_var("wave4") then
        on_level_counter_add("W2", 0)
      elseif get_sync_var("wave1") == false and get_sync_var("wave2") == false and true == get_sync_var("wave3") and false == get_sync_var("wave4") then
        on_level_counter_add("W3", 0)
      elseif get_sync_var("wave1") == false and get_sync_var("wave2") == false and false == get_sync_var("wave3") and true == get_sync_var("wave4") then
        on_level_counter_add("W4", 0)
      end
    end
    if true == get_sync_var("progress") then
      update_progress_display(5)
    end
  end
  
  function states.hurt.finTrans(hurt)
    return hurt.monster.states.hurtidle
  end
  
  function states.hurtidle.finTrans(hurtidle)
    return hurtidle
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if monster.canbehit == true and monster.turn == false then
    abort_skill(monster.npc, true)
    monster.tree:transState(monster.states.hurt)
  end
end

return monster
