local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  set_npc_ignore_sync_area(npc, false)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  time_scale_immune(npc, true)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 30010050101, 1)
  cast_magic(npc, npc, 300100501012, 1)
  cast_magic(npc, npc, 300100501013, 1)
  local skills = {}
  local nodes = {}
  local actMoves = {"move", "stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  set_npc_ignore_sync_area(monster.npc, false)
  monster.TargetPos1X, monster.TargetPos1Y, monster.TargetPos1Z = get_area_pos("run1")
  monster.TargetPos2X, monster.TargetPos2Y, monster.TargetPos2Z = get_area_pos("run2")
  monster.TargetPos3X, monster.TargetPos3Y, monster.TargetPos3Z = get_area_pos("run3")
  monster.TargetPos4X, monster.TargetPos4Y, monster.TargetPos4Z = get_area_pos("run4")
  monster.TargetPos5X, monster.TargetPos5Y, monster.TargetPos5Z = get_area_pos("run5")
  monster.TargetPos6X, monster.TargetPos6Y, monster.TargetPos6Z = get_area_pos("run6")
  monster.TargetPos7X, monster.TargetPos7Y, monster.TargetPos7Z = get_area_pos("run7")
  monster.TargetPos8X, monster.TargetPos8Y, monster.TargetPos8Z = get_area_pos("run8")
  monster.TargetPos9X, monster.TargetPos9Y, monster.TargetPos9Z = get_area_pos("run9")
  monster.TargetPos10X, monster.TargetPos10Y, monster.TargetPos10Z = get_area_pos("run10")
  local N1 = {
    x = monster.TargetPos1X,
    y = monster.TargetPos1Y,
    z = monster.TargetPos1Z
  }
  local N2 = {
    x = monster.TargetPos2X,
    y = monster.TargetPos2Y,
    z = monster.TargetPos2Z
  }
  local N3 = {
    x = monster.TargetPos3X,
    y = monster.TargetPos3Y,
    z = monster.TargetPos3Z
  }
  local N4 = {
    x = monster.TargetPos4X,
    y = monster.TargetPos4Y,
    z = monster.TargetPos4Z
  }
  local N5 = {
    x = monster.TargetPos5X,
    y = monster.TargetPos5Y,
    z = monster.TargetPos5Z
  }
  local N6 = {
    x = monster.TargetPos6X,
    y = monster.TargetPos6Y,
    z = monster.TargetPos6Z
  }
  local N7 = {
    x = monster.TargetPos7X,
    y = monster.TargetPos7Y,
    z = monster.TargetPos7Z
  }
  local N8 = {
    x = monster.TargetPos8X,
    y = monster.TargetPos8Y,
    z = monster.TargetPos8Z
  }
  local N9 = {
    x = monster.TargetPos9X,
    y = monster.TargetPos9Y,
    z = monster.TargetPos9Z
  }
  local N10 = {
    x = monster.TargetPos10X,
    y = monster.TargetPos10Y,
    z = monster.TargetPos10Z
  }
  monster.step = 1
  monster.goal = {
    N1,
    N2,
    N3,
    N4,
    N5,
    N6,
    N7,
    N8,
    N9,
    N10
  }
  monster.stepmode = true
  monster.startMove = true
  monster.timecount = 0
  monster.timegap = 1
  monster.hero = get_come_on_hero()
  monster.outdistance = 20
  monster.rundistance = 15
  monster.runaway = 5
  monster.running = false
  monster.buffrun = 3190003001
  cast_magic(monster.npc, monster.npc, monster.buffrun)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand, _ENV.move)
  end
  
  function states.stand.start()
    stop_move(npc)
  end
  
  function states.stand.tick()
    if monster.goal[monster.step] == nil then
      set_sync_var("nowaytorun", true)
      stop_move(monster.npc)
      update_progress_display(30)
    end
  end
  
  function states.stand.tickTrans(stand)
    if get_npc_distance(monster.npc, 1, monster.hero, true) <= monster.rundistance and monster.goal[monster.step] then
      return stand.monster.states.move
    end
  end
  
  function states.move.start(move)
    local pos
    pos = monster.goal[monster.step]
    if nil ~= pos then
      move_to_pos(monster.npc, pos)
    end
  end
  
  function states.move.tick()
    if get_npc_distance(monster.npc, 1, monster.hero, true) < monster.runaway and monster.running == false then
      monster.running = true
      cast_magic(monster.npc, monster.npc, monster.buffrun)
      update_progress_display(5)
    end
  end
  
  function states.move.tickTrans(move)
    if get_npc_distance(monster.npc, 1, monster.hero, true) > monster.outdistance and monster.goal[monster.step] then
      return move.monster.states.stand
    end
    if monster.isSamePos(monster, get_npc_pos(monster.npc), monster.goal[monster.step], 0.5) then
      monster.step = monster.step + 1
      pos = monster.goal[monster.step]
      return move.monster.states.stand
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if magic_id == monster.buffrun then
    monster.running = false
  end
end

function monster.isSamePos(monster, pos1, pos2, tollerance)
  return tollerance >= (pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.z - pos2.z) * (pos1.z - pos2.z)
end

function monster.on_self_enter_area(monster, area)
  local areaName = area.Tag
  local areaactor = area.Key
  if "zhangai1" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/10/L11_/A4", true, true)
    update_progress_display(10)
  elseif "zhangai2" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/0/L0_/A4", true, true)
    update_progress_display(10)
  elseif "zhangai3" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/01/L1_/A4", true, true)
    update_progress_display(10)
  elseif "zhangai4" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/5/L6_/A4", true, true)
    update_progress_display(10)
  elseif "zhangai5" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/6/L7_/A4", true, true)
    update_progress_display(10)
  elseif "zhangai6" == areaactor then
    update_progress_display(10)
  elseif "zhangai7" == areaactor then
    set_sceneobj_visible_save_state("/Root/Level/14/L15_/A4", true, true)
    update_progress_display(10)
  end
end

return monster
