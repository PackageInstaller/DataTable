local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300204801, 1)
  monster.npc:set_enable_rvo(false)
  monster.hit = false
  monster.comboTimes = 0
  monster.comboScore = 0
  cast_magic(monster.npc, monster.npc, 300207107, 1, 60)
  set_hud_config("dying", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 1, 300207107)
  active_hud(monster.npc, "dying", "effectpoint_ground", true, "即将消失")
  monster.wander = {
    minDis = 1,
    maxDis = 1.5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    rotate_start = {300207102},
    rotate_loop = {300207103},
    rotate_end = {300207104}
  }
  local nodes = {
    "rotate_start"
  }
  local actMoves = {"escape"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.evade, _ENV.wander)
    _ENV.evade(_ENV.freeCounter)
    _ENV.freeCounter(_ENV.rotate_start(_ENV.rotate_loop(_ENV.rotate_end)))
    _ENV.wander(_ENV.escape)
  end
  do
    local escape = monster.states.escape
    local centre = {
      33,
      get_npc_pos(get_come_on_hero()),
      135
    }
    escape.changeTime = 0
    
    function escape.start(escape)
      math.randomseed(os.time())
      if monster.arrive == true then
        monster.arrive = false
        monster.angleElapse = math.random(-30, 30)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, centre, monster.angleElapse, 100000)
      else
        monster.angleElapse = math.random(-60, 60)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      end
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TEMP_POS)
      local rValue = math.random() * 1 + 2
      escape.changeTime = get_npc_time(monster.npc) + rValue
    end
    
    function escape.tickTrans(escape)
      if get_npc_time(monster.npc) > escape.changeTime then
        return monster.states.escape
      end
      if monster.arrive == true then
        return monster.states.escape
      end
      local rotate_start = monster.states.rotate_start
      if rotate_start.isReady(rotate_start) then
        monster.hit = false
        monster:transState(rotate_start, true)
      end
    end
  end
  do
    local rotate_start = monster.states.rotate_start
    local rotate_end = monster.states.rotate_end
    
    function rotate_start.isReady(rotate_start)
      if monster.state.name ~= "rotate_start" and monster.state.name ~= "rotate_loop" and monster.state.name ~= "rotate_end" and monster.hit == true then
        return true
      else
        return false
      end
    end
    
    function rotate_start.start(rotate_start)
      rotate_start.base.start(rotate_start)
    end
    
    function rotate_end.finTrans(rotate_end)
      rotate_end.base.finTrans(rotate_end)
      monster.hit = false
      return monster.states.wander
    end
  end
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  print("计时magicBegin", magic_id)
end

function monster.on_target_self_magic_end(monster, npc, magic_id, magic_level, magic_kind, magic_type)
  print("计时magicEnd", magic_id)
  if 300207107 == magic_id and 0 == get_magic_num(monster.npc, 300207107) then
    active_hud(monster.npc, "dying", "effectpoint_ground", false, "即将消失")
    local facePos = get_npc_offset_position(monster.npc, nil, 0, 0)
    create_scene_effect("FX_SC05_jingcusi_1", monster.npc:get_pos_vec3(), 2, nil, facePos)
    cast_magic(monster.npc, monster.npc, 300205302, 1)
  end
end

function monster.on_remove_npc(monster)
  print("remove")
  cast_magic(monster.npc, get_come_on_hero(), 300207108, 1)
  cast_magic(monster.npc, get_come_on_hero(), 300207109, 1)
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if 300106301 == skill_id then
    cast_magic(monster.npc, monster.npc, 201051010207, 1)
  end
  if missile_cfg.Id == 10010042101 then
    cast_magic(monster.npc, monster.npc, 300207106, 1)
    monster.hit = true
    cast_magic(monster.npc, monster.npc, 300207105, 1)
    monster.comboTimes = get_magic_num(monster.npc, 300207105)
    if monster.comboTimes > 1 then
      monster.comboScore = 2 ^ (monster.comboTimes - 2)
      local magicScoreId = 300207099 + monster.comboTimes
      print("计连击magic", magicScoreId)
      cast_magic(monster.npc, monster.npc, magicScoreId, 1)
    else
      monster.comboScore = 0
    end
    if get_cur_room_id() == 800601 then
      add_task_progress(8006011, monster.comboScore)
      add_task_progress(8006012, monster.comboScore)
    end
    if get_cur_room_id() == 800602 then
      add_task_progress(8006021, monster.comboScore)
      add_task_progress(8006022, monster.comboScore)
    end
    if get_cur_room_id() == 800603 then
      add_task_progress(8006031, monster.comboScore)
      add_task_progress(8006032, monster.comboScore)
    end
    if get_cur_room_id() == 800604 then
      add_task_progress(8006041, monster.comboScore)
      add_task_progress(8006042, monster.comboScore)
    end
  end
  if missile_cfg.Id == 30010670301 then
    abort_skill(monster.npc, false)
    abort_magic_by_id(monster.npc, 201052010301)
    enter_stun(monster.npc, false, 0.5)
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if 300207106 ~= magic_id then
    cast_magic(monster.npc, get_come_on_hero(), 300207108, 1)
    cast_magic(monster.npc, get_come_on_hero(), 300207109, 1)
  end
  active_hud(monster.npc, "dying", "effectpoint_ground", false, "即将消失")
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
