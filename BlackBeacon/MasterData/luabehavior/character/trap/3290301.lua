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
  local pointAmount = 6
  for i = 1, pointAmount do
    local posName = "T" .. i
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
  local actSkills = {
    stung = {329030101}
  }
  local actMoves = {"wait", "move"}
  local nodes = {"default", "hitten"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  cast_missile(monster.npc, monster.npc, nil, nil, 32903010202, 1)
  do
    local _ENV = states
    _ENV.root(_ENV.default, _ENV.hitten, _ENV.decisionFailed)
    _ENV.default(_ENV.wait, _ENV.move)
    _ENV.hitten(_ENV.stung)
  end
  
  function states.wait.start(wait)
    stop_move(monster.npc)
    wait.base.start(wait)
  end
  
  function states.wait.tick(wait)
    monster.moveTrigger = get_sync_var("moveTriggerNo")
    if monster.moveTrigger == true then
      monster:transState(monster.states.move)
    end
    wait.base.tick(wait)
  end
  
  function states.move.start(move)
    move.base.start(move)
  end
  
  function states.move.tick(move)
    if check_npc_distance_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex].x, monster.moveTarget[monster.currentPosIndex].z, 1, false) then
      monster.currentPosIndex = monster.currentPosIndex % pointAmount + 1
    else
      monster.moveToNextPos()
    end
    move.base.tick(move)
  end
  
  function monster.moveToNextPos()
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
  end
  
  function states.stung.start(stung)
    local monster = stung.monster
    stung.base.start(stung)
  end
  
  states.stung.default = states.default
  
  function states.stung.finTrans(stung)
    cast_missile(monster.npc, monster.npc, nil, nil, 32903010202, 1)
    return stung.default
  end
  
  function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 32903010202 and check_npc_distance(monster.npc, get_come_on_hero(), 2, false) then
      monster:transState(monster.states.hitten, true)
      lookat_npc(monster.npc, get_come_on_hero(), true)
      math.randomseed(os.time())
      call_scene_logic_custom_event("stopStory")
      start_stroy(3229400 + math.random(1, 3))
    end
  end
end

return monster
