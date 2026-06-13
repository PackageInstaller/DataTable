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
  monster.search = {}
  monster.fadeoutTime = get_npc_time(monster.npc) + 8
  monster.mosquitoTime = monster.fadeoutTime + 1
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  local skills = {
    boom_expend = {300106701, 0},
    boom_delay = {300106702, 0},
    boom = {300106703, 0},
    boom2 = {300106703, 0},
    check = {300106704, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.check, _ENV.boom_expend(_ENV.boom), _ENV.boom_delay(_ENV.boom2))
    _ENV.wander(_ENV.wanderStand)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
  end
  
  function states.check.start(check)
    check.base.start(check)
    abort_magic_by_id(monster.npc, 399933)
  end
  
  function states.check.tick(check)
    if get_npc_time(monster.npc) > monster.fadeoutTime then
      monster.fadeoutTime = math.huge
      set_npc_status(monster.npc, 3, true)
      create_scene_effect("Fx_M201049_skill01_1_2", get_npc_pos(monster.npc), 0)
      create_scene_effect("Fx_M201049_skill01_2_3", get_npc_pos(monster.npc), 0)
      add_npc(2, 3002054, get_npc_pos(monster.npc), get_npc_pos(get_come_on_hero()) * -1, 2, 1)
      cast_magic(monster.npc, monster.npc, 300207201, 1)
    end
    if get_npc_time(monster.npc) > monster.mosquitoTime then
      monster.mosquitoTime = math.huge
      remove_npc(monster.npc)
    end
  end
  
  function states.check.finTrans(check)
    return check
  end
  
  function states.boom_expend.start(boom_expend)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    boom_expend.base.start(boom_expend)
  end
  
  function states.boom.isReady()
    return true
  end
  
  function states.boom.start(boom)
    monster.removeTime = get_npc_time(monster.npc) + 2
    boom.base.start(boom)
  end
  
  function states.boom.tick(boom)
    if get_npc_time(monster.npc) > monster.removeTime then
      remove_npc(monster.npc)
    end
  end
  
  function states.boom.finTrans(boom)
    return boom.monster.states.standIdle
  end
  
  function states.boom_delay.start(boom_delay)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    boom_delay.base.start(boom_delay)
  end
  
  function states.boom2.start(boom2)
    monster.removeTime2 = get_npc_time(monster.npc) + 2
    boom2.base.start(boom2)
  end
  
  function states.boom2.tick(boom2)
    if get_npc_time(monster.npc) > monster.removeTime2 then
      remove_npc(monster.npc)
    end
  end
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
  states.wander.tick = nil
  
  function states.standIdle.finTrans(standIdle)
    return standIdle.monster.states.standIdle
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300106704 == skill_id and 5 ~= get_role_kind(hit_target) and 6 ~= get_role_kind(hit_target) and 2 ~= get_role_kind(hit_target) and 3 ~= get_role_kind(hit_target) and not check_magic(hit_target, 30010660103) then
    monster.tree:transState(monster.states.boom_expend, true)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type and 1 == get_role_kind(attacker) then
    monster.tree:transState(monster.states.boom_delay, true)
  end
  if attacker == get_come_on_hero() then
    remove_missile(missile)
    stop_effect(attacker, 10010042104)
    stop_effect(attacker, 10010042105)
    print("扣分了")
    if get_cur_room_id() == 800601 then
    end
    if get_cur_room_id() == 800602 then
      add_task_progress(8006023, 1)
    end
    if get_cur_room_id() == 800603 then
      add_task_progress(8006033, 1)
    end
    if get_cur_room_id() == 800604 then
      add_task_progress(8006043, 1)
    end
    cast_magic(monster.npc, monster.npc, 300206910, 1)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
