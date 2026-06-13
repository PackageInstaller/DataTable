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
  local skills = {}
  local nodes = {}
  local actMoves = {"move", "stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  monster.step = 1
  monster.time = 0
  monster.timer = 1
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand, _ENV.move)
  end
  
  function states.move.start()
    monster.pos = monster.goal[monster.step]
    if monster.pos ~= nil then
      switch_move_type(npc, 0)
      print("目标x = ", monster.pos.x)
      print("目标y = ", monster.pos.y)
      print("目标z = ", monster.pos.z)
      move_to_pos(npc, monster.pos)
      monster.time = get_npc_time(npc)
    end
  end
  
  function states.move.tickTrans(move)
    if monster.timer + monster.time < get_npc_time(npc) then
      return move.monster.states.stand
    end
  end
  
  function states.move.finish()
    monster.step = monster.step + 1
    if 2 == monster.step and get_sync_var("pass_T1") == false then
      set_sync_var("pass_T1", true)
      start_stroy(tonumber(get_sync_var("storyID")))
      print("成功播放剧情")
    end
    if monster.goal[monster.step] == nil then
      stop_move(npc)
      set_sync_var("End", true)
      return
    end
  end
  
  function states.stand.tickTrans(stand)
    if get_npc_distance(npc, 1, get_come_on_hero(), true) <= 2 and monster.goal[monster.step] ~= nil then
      return stand.monster.states.move
    end
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  if get_cur_room_id() == 3140101 then
    monster.TargetPos2X, monster.TargetPos2Y, monster.TargetPos2Z = get_area_pos("T2")
    monster.TargetPos3X, monster.TargetPos3Y, monster.TargetPos3Z = get_area_pos("T3")
    monster.TargetPos4X, monster.TargetPos4Y, monster.TargetPos4Z = get_area_pos("T4")
    monster.N2 = {
      x = monster.TargetPos2X,
      y = monster.TargetPos2Y,
      z = monster.TargetPos2Z
    }
    monster.N3 = {
      x = monster.TargetPos3X,
      y = monster.TargetPos3Y,
      z = monster.TargetPos3Z
    }
    monster.N4 = {
      x = monster.TargetPos4X,
      y = monster.TargetPos4Y,
      z = monster.TargetPos4Z
    }
    monster.goal = {
      monster.N2,
      monster.N3,
      monster.N4
    }
  end
  if get_cur_room_id() == 3140102 then
    monster.TargetPos2X, monster.TargetPos2Y, monster.TargetPos2Z = get_area_pos("T2")
    monster.N2 = {
      x = monster.TargetPos2X,
      y = monster.TargetPos2Y,
      z = monster.TargetPos2Z
    }
    monster.goal = {
      monster.N2
    }
  end
end

return monster
