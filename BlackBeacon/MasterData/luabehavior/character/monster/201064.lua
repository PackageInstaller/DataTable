local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.born = 1
  local t = monster.create_skill_node_cfg
  local skills = {
    skillMove = t(nil, 2, 3)
  }
  local actMoves = {"idle2"}
  monstBase._init(monster, skills, actMoves, nil)
  monster.search.minDis = math.huge
  monster.search.maxDis = math.huge
  local states = monster.states
  do
    local _ENV = states
    _ENV.freeAtk(_ENV.skillMove)
    _ENV.wander(_ENV.idle2)
  end
  states.attack.interval = 0
  
  function states.idle2.start(idle2)
    local monster = idle2.monster
    abort_skill(monster.npc, true)
    stop_move(monster.npc)
    lookat_npc(monster.npc, monster.target, true)
  end
  
  function states.skillMove.start(skillMove)
    skillMove.base.start(skillMove)
    monster:setLine()
  end
  
  function states.skillMove.tick(skillMove)
    skillMove.base.tick(skillMove)
    monster:setLine()
  end
end

local Unity = CS.UnityEngine

function monster.on_start(monster)
  monster.base.on_start(monster)
  set_camera(20106501, true)
  change_follow_target_new(3, monster.npc, {
    5,
    10,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
  local hero = get_come_on_hero()
  
  local function attachArrow(npc)
    local npcObj = npc.gameobj
    local name = tostring(npc.id) .. "arrow"
    local cube = monster:getDebugObj(name, Const.DEBUG_MESH_TYPE.CUBE, npc.gameobj)
    cube:GetComponent(typeof(Unity.BoxCollider)).enabled = false
    cube.transform.localScale = Unity.Vector3(0.2, 0.2, 1.5)
    cube.transform:SetParent(npcObj.transform)
    cube.transform.localPosition = Unity.Vector3(0, 0.2, 0.75)
    cube.transform.localEulerAngles = Unity.Vector3(0, 0, 0)
  end
  
  attachArrow(monster.npc)
  attachArrow(hero)
  local npc = monster.npc
  local npcObj = npc.gameobj
  local name = tostring(npc.id) .. "shiftLineP"
  local cube = monster:getDebugObj(name, Const.DEBUG_MESH_TYPE.CUBE, npc.gameobj)
  cube:GetComponent(typeof(Unity.BoxCollider)).enabled = false
  cube.transform.localScale = Unity.Vector3(9999, 0.1, 0.1)
  cube.transform:SetParent(npcObj.transform)
  cube.transform.localPosition = Unity.Vector3(0, 0.2, 0)
  cube.transform.localEulerAngles = Unity.Vector3(0, 0, 0)
  monster.pLine = cube
  name = tostring(npc.id) .. "shiftLineRoot"
  local root = monster:getDebugObj(name, nil, npc.gameobj)
  root.transform:SetParent(npcObj.transform)
  root.transform.localPosition = Unity.Vector3(0, 0, 0)
  root.transform.localEulerAngles = Unity.Vector3(0, 0, 0)
  root.transform.localScale = Unity.Vector3(1, 1, 1)
  name = tostring(npc.id) .. "shiftLine"
  cube = monster:getDebugObj(name, Const.DEBUG_MESH_TYPE.CUBE, root)
  cube:GetComponent(typeof(Unity.BoxCollider)).enabled = false
  cube.transform.localScale = Unity.Vector3(0.1, 0.1, 30)
  cube.transform:SetParent(root.transform)
  cube.transform.localPosition = Unity.Vector3(0, 0.2, 15)
  cube.transform.localEulerAngles = Unity.Vector3(0, 0, 0)
  monster.sLine = root
  monster:setLine(0)
end

function monster.on_input(monster, id)
  if id == Const.INPUT_CODE.COMMON then
    return monster:transState(monster.states.idle2, true)
  end
end

function monster.getShiftAngle(monster)
  return monster.npc.skill_mgr.v_cur_skill.v_shift_deg
end

function monster.setLine(monster, angle)
  angle = angle or monster:getShiftAngle() or 0
  if angle == monster.shiftAngle then
    return
  end
  monster.sLine.transform.localEulerAngles = Unity.Vector3(0, angle, 0)
  monster.pLine.transform.localEulerAngles = Unity.Vector3(0, angle, 0)
end

function monster.on_skill_shift_pause(monster, keyframe_id, is_stop)
  monster:debugOutput("on_skill_shift_pause is called,", keyframe_id, tostring(is_stop))
end

return monster
