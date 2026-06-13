local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  set_can_searched(monster.npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300206001, 1)
  cast_missile_new(monster.npc, monster.npc, nil, nil, 30020600401, 1)
  create_scene_effect("fx_common_monster_born", get_npc_pos(npc), 0)
  monster.npc:set_enable_rvo(false)
  monster.value = 3
  math.randomseed(os.time())
  monster.dieTimeTime = get_npc_time(monster.npc) + 4 + 2 * math.random()
  monster.hasDied = false
  local actSkills = {
    stun1_1 = {300206001},
    stun1_2 = {300206002},
    stun1_3 = {300206003}
  }
  local nodes = {"relax"}
  local actMoves = {"escape"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.root(_ENV.escape, _ENV.relax, _ENV.decisionFailed)
    _ENV.relax(_ENV.stun1_1(_ENV.stun1_2(_ENV.stun1_3)))
  end
  monster.arrive = false
  monster.crash = false
  monster.center = {
    x = 130,
    y = get_npc_pos(get_come_on_hero()).y,
    z = 105.5
  }
  do
    local escape = monster.states.escape
    local relax = monster.states.relax
    escape.changeTime = 0
    
    function escape.start(escape)
      if monster.hasDied == true then
        remove_npc(npc)
        print("死2" .. tostring(monster.hasDied))
      end
      math.randomseed(os.time())
      if true == monster.arrive then
        monster.angleElapse = math.random(0, 30) * math.random(-1, 1)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, monster.center, monster.angleElapse, 100000)
        monster.arrive = false
      elseif true == monster.crash then
        monster.angleElapse = math.random(150, 210)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
        monster.crash = false
      else
        monster.angleElapse = math.random(0, 60) * math.random(-1, 1)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      end
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
      move_to_pos(monster.npc, monster.TEMP_POS)
      switch_move_type(monster.npc, 0)
      local rValue = math.random() * 3 + 2
      escape.changeTime = get_npc_time(escape.monster.npc) + rValue
    end
    
    function escape.tickTrans(escape)
      if monster.arrive == true then
        return monster.states.escape
      end
      if get_npc_time(monster.npc) > monster.dieTimeTime and monster.hasDied == false then
        return monster.states.relax
      end
      if get_npc_time(escape.monster.npc) > escape.changeTime then
        return monster.states.escape
      end
    end
  end
  do
    local relax = monster.states.relax
    local escape = monster.states.escape
    local thunderTime = 0
    
    function relax.start(relax)
      abort_magic_by_id(monster.npc, 300206001, 1)
      set_npc_status(npc, 1, true)
      monster.hasDied = true
      thunderTime = get_npc_time(relax.monster.npc) + 2.8
    end
    
    function relax.tick(relax)
      if get_npc_time(relax.monster.npc) > thunderTime then
        create_scene_effect("Fx_M201041_atk02_1_2", get_npc_pos(npc), 0)
        thunderTime = math.huge
      end
    end
    
    function relax.finish(relax)
      monster.value = 0
    end
    
    function relax.finTrans(relax)
      print("死0" .. tostring(monster.hasDied))
      return relax.monster.states.escape
    end
  end
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30020640201 then
    cast_magic(monster.npc, monster.npc, 300205302, 1)
  end
  if attacker == get_come_on_hero() then
    cast_magic(monster.npc, monster.npc, 300800503, 1)
    cast_magic(monster.npc, monster.npc, 300205302, 1)
  end
  if missile_cfg.Id == 30020590101 or missile_cfg.Id == 30020600101 then
    monster.crash = true
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if get_cur_room_id() == 800401 then
    add_task_progress(8004011, monster.value)
    add_task_progress(8004012, monster.value)
    add_task_progress(8004013, monster.value)
  end
  if get_cur_room_id() == 800402 then
    add_task_progress(8004021, monster.value)
    add_task_progress(8004022, monster.value)
    add_task_progress(8004023, monster.value)
  end
  if get_cur_room_id() == 800403 then
    add_task_progress(8004031, monster.value)
    add_task_progress(8004032, monster.value)
    add_task_progress(8004033, monster.value)
  end
  if get_cur_room_id() == 800404 then
    add_task_progress(8004041, monster.value)
    add_task_progress(8004042, monster.value)
    add_task_progress(8004043, monster.value)
  end
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
