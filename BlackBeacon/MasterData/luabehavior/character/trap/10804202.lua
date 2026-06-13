local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 4032905, 1)
  set_npc_status(npc, 3, true)
  local skills = {}
  local actMoves = {"talk", "walk"}
  local nodes = {"default"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.root(_ENV.talk, _ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.walk)
  end
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  monster.posAmout = 0
  for i = 1, 14 do
    local posName
    if get_npc_id(monster.npc) == 10804202 then
      posName = "a" .. i
    end
    if get_npc_id(monster.npc) == 10804203 then
      posName = "b" .. i
    end
    if get_npc_id(monster.npc) == 10804204 then
      posName = "c" .. i
    end
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
  monster.faceTarget = {}
  monster.currentFaceIndex = 1
  monster.faceAmout = 0
  for j = 1, 14 do
    local faceName = "F" .. j
    local hasFace = pcall(get_area_pos, faceName)
    if hasFace then
      monster.faceAmout = monster.faceAmout + 1
      local faceX, faceY, faceZ = get_area_pos(faceName)
      local currentFace = {
        x = faceX,
        y = faceY,
        z = faceZ
      }
      table.insert(monster.faceTarget, currentFace)
    end
  end
  do
    local default = monster.states.default
    local walk = monster.states.walk
    local talk = monster.states.talk
    
    function default.isReady()
      return true
    end
    
    function talk.isReady()
      return true
    end
    
    function walk.isReady()
      return true
    end
    
    talk.lookTime = 0
    
    function talk.start(talk)
      remove_missile_by_id(108042020101, monster.npc, false)
      abort_magic_by_id(monster.npc, 399931, 1)
      abort_magic_by_id(monster.npc, 1080420102, 1)
      math.randomseed(os.time())
      local elapse = 0.13 + 0.2 * math.random() * 1
      talk.lookTime = get_npc_time(monster.npc) + elapse
    end
    
    function talk.tickTrans(talk)
      if get_npc_time(talk.monster.npc) > talk.lookTime and get_sync_var("face") ~= nil and 0 ~= get_sync_var("face") then
        lookat_position(monster.npc, monster.faceTarget[monster.currentFaceIndex].x, monster.faceTarget[monster.currentFaceIndex].z, false)
      end
      if get_sync_var("move_start") then
        return monster.states.walk
      end
    end
    
    function walk.start(walk)
      cast_magic(npc, npc, 399931, 1)
      cast_missile_new(npc, npc, nil, nil, 108042020101, 1)
      cast_magic(npc, npc, 1080420102, 1)
      monster.currentPosIndex = get_sync_var("target")
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
      monster.currentFaceIndex = monster.currentPosIndex
    end
    
    function walk.tickTrans(walk)
      if check_npc_distance_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex].x, monster.moveTarget[monster.currentPosIndex].z, 1, false) then
        set_sync_var("move_start", false)
        return monster.states.talk
      end
    end
  end
end

return monster
