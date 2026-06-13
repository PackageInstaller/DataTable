local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  monster.moveTrigger = false
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  monster.posAmout = 0
  for i = 1, 5 do
    local posName = "M" .. i
    local hasPos = pcall(get_area_pos, posName)
    if hasPos then
      monster.posAmout = monster.posAmout + 1
      local posX, posY, posZ = get_area_pos(posName)
      local currentPos = {
        x = posX,
        y = posY,
        z = posZ
      }
      table.insert(monster.moveTarget, currentPos)
    end
  end
  local actSkills = {}
  local actMoves = {"wait", "move"}
  local nodes = {"default"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.root(_ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.wait, _ENV.move)
  end
  
  function states.wait.start(wait)
    stop_move(monster.npc)
    wait.base.start(wait)
  end
  
  function states.wait.tick(wait)
    monster.moveTrigger = get_sync_var("moveTrigger")
    if monster.moveTrigger == true then
      set_sync_var("moveTrigger", false)
      monster:transState(monster.states.move)
    end
    wait.base.tick(wait)
  end
  
  function states.move.start(move)
    move.base.start(move)
  end
  
  function states.move.tick(move)
    if check_npc_distance_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex].x, monster.moveTarget[monster.currentPosIndex].z, 1, false) == true then
      monster.currentPosIndex = monster.currentPosIndex + 1
      if 4 == monster.currentPosIndex then
        monster:transState(monster.states.wait)
        set_sync_var("needReturn", true)
      elseif monster.currentPosIndex > monster.posAmout then
        monster:transState(monster.states.wait)
        set_sync_var("hasArrived", true)
      end
    else
      monster.moveToNextPos()
    end
    move.base.tick(move)
  end
  
  function monster.moveToNextPos()
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
  end
end

function monster.on_self_magic_begin(monster, target, magic_id)
  if 3000001 == magic_id then
    monster:transState(monster.states.wait)
  end
  if 3000002 == magic_id then
    monster.currentPosIndex = 1
    monster:transState(monster.states.move)
  end
  if 3000003 == magic_id then
    monster:transState(monster.states.move)
  end
end

return monster
