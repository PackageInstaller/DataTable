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
  local actMoves = {"move"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  monster.targetPos = {
    x = 0,
    y = 0,
    z = 0
  }
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.move)
  end
  
  function states.move.start()
    monster.targetPos = {
      x = get_sync_var("201114_TargetPosX"),
      y = get_sync_var("201114_TargetPosY"),
      z = get_sync_var("201114_TargetPosZ")
    }
    move_to_pos(npc, monster.targetPos)
    switch_move_type(npc, 1)
  end
  
  function states.move.tickTrans(move)
    if get_sync_var("201114_TargetPosX") ~= monster.targetPos.x or get_sync_var("201114_TargetPosY") ~= monster.targetPos.y or get_sync_var("201114_TargetPosZ") ~= monster.targetPos.z then
      return move
    end
  end
end

function monster.on_self_enter_area(monster, area)
  if area.Tag == "destory" then
    print("----------------------长生军已进入tp区域")
    create_scene_effect("Fx_H1001015_exatk05_flash_1", get_npc_pos(monster.npc), 0.6, "Fx_H1001015_exatk05_flash_1_Clone1")
    remove_npc(monster.npc)
  end
end

return monster
