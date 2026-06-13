local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  set_can_searched(monster.npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300204801, 1)
  cast_magic(npc, npc, 300205901, 1)
  cast_missile_new(monster.npc, monster.npc, nil, nil, 30020590101, 1)
  create_scene_effect("fx_common_monster_born", get_npc_pos(npc), 0)
  monster.npc:set_enable_rvo(false)
  monster.value = 2
  local actSkills = {}
  local nodes = {}
  local actMoves = {"escape"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.root(_ENV.escape, _ENV.decisionFailed)
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
    escape.changeTime = 0
    
    function escape.start(escape)
      math.randomseed(os.time())
      if monster.arrive == true then
        monster.angleElapse = math.random(0, 30) * math.random(-1, 1)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, monster.center, monster.angleElapse, 100000)
        monster.arrive = false
      elseif true == monster.crash then
        monster.angleElapse = math.random(150, 210)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
        monster.crash = false
        print("crash.escape.start", monster.crash)
      else
        monster.angleElapse = math.random(0, 60) * math.random(-1, 1)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      end
      if monster.TEMP_POS ~= nil then
        lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
        move_to_pos(monster.npc, monster.TEMP_POS)
        switch_move_type(monster.npc, 1)
      end
      local rValue = math.random() * 4 + 4
      escape.changeTime = get_npc_time(monster.npc) + rValue
    end
    
    function escape.tickTrans(escape)
      if monster.arrive == true then
        return monster.states.escape
      end
      if true == monster.crash then
        print("crash.escape.tickTrans", monster.crash)
        return monster.states.escape
      end
      if get_npc_time(escape.monster.npc) > escape.changeTime then
        return monster.states.escape
      end
    end
  end
  states.dead.delay.remove = 0.5
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30020640201 then
    cast_magic(monster.npc, monster.npc, 300205301, 1)
  end
  if missile_cfg.Id == 30020590101 or missile_cfg.Id == 30020600101 then
    print("撞到一起")
    monster.crash = true
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  cast_magic(monster.npc, monster.npc, 300800502, 1)
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
