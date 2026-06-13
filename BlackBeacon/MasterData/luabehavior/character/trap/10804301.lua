local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_npc_ignore_sync_area(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 399932, 1)
  set_npc_status(npc, 4, true)
  cast_magic(npc, npc, 1080420101, 1)
  local skills = {}
  local actMoves = {"talk", "move_start"}
  local nodes = {"default"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.root(_ENV.talk, _ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.move_start)
  end
  cast_missile_new(monster.npc, monster.npc, nil, nil, 108041010101, 1)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 108041010101, monster.playerHiding, monster)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, monster.npc, 108041010101, monster.playerLeft, monster)
  monster.relax = {}
  monster.check = {}
  monster.relax.x, monster.relax.y, monster.relax.z = get_area_pos("relax")
  monster.check.x, monster.check.y, monster.check.z = get_area_pos("F2")
  monster.moveTarget = {}
  monster.currentPosIndex = 1
  table.insert(monster.moveTarget, monster.check)
  table.insert(monster.moveTarget, monster.relax)
  monster.arrive = true
  monster.playerIn = false
  monster.storyID = nil
  monster.moveTime = 0
  do
    local default = monster.states.default
    local move_start = monster.states.move_start
    local talk = monster.states.talk
    
    function default.isReady()
      return true
    end
    
    function talk.isReady()
      return true
    end
    
    function move_start.isReady()
      return true
    end
    
    function talk.start(talk)
      monster.storyID = 905080610 + monster.currentPosIndex
      abort_magic_by_id(monster.npc, 1080420102, 1)
    end
    
    function talk.tickTrans(talk)
      monster.currentPosIndex = get_sync_var("worker")
      if get_sync_var("gameOver") then
        cast_magic(monster.npc, monster.npc, 1080410701, 1, 1)
      else
        abort_magic_by_id(monster.npc, 1080410701, 1)
      end
      if get_npc_time(monster.npc) > monster.moveTime and 0 ~= monster.moveTime then
        call_scene_logic_custom_event("cantHear")
        return monster.states.move_start
      end
      if 1 == get_sync_var("worker") then
        call_scene_logic_custom_event("cantHear")
        return monster.states.move_start
      end
      print("剧情ID唯实社:" .. tostring(monster.storyID) .. " 进阵" .. tostring(monster.playerIn))
      if monster.storyID ~= nil and monster.playerIn == true then
        start_stroy(monster.storyID)
        monster.storyID = nil
      end
    end
    
    function move_start.start(move_start)
      cast_magic(npc, npc, 1080420102, 1)
      set_sync_var("move_start2", true)
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.moveTarget[monster.currentPosIndex])
      monster.arrive = false
    end
    
    function move_start.tickTrans(move_start)
      set_sync_var("move_start2", false)
      if get_sync_var("gameOver") then
        cast_magic(monster.npc, monster.npc, 1080410701, 1, 1)
      else
        abort_magic_by_id(monster.npc, 1080410701, 1)
      end
      if monster.arrive == true then
        return monster.states.talk
      end
    end
  end
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if tostring(akey) == "relax" or tostring(akey) == "F2" then
    monster.arrive = true
  else
    monster.currentPosIndex = monster.currentPosIndex
  end
  if tostring(akey) == "F2" then
    monster.moveTime = get_npc_time(monster.npc) + 5
    set_sync_var("worker", 2)
  end
  if tostring(akey) == "relax" then
    monster.moveTime = 0
  end
end

function monster.playerHiding(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    print("玩家进入圈子")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410801, 1, 1)
    cast_magic(monster.npc, monster.npc, 108041010102, 1, 1)
    abort_magic_by_id(get_come_on_hero(), 1080410201, 5)
    if 1 == get_magic_num(get_come_on_hero(), 1080410801) then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080402, 1, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410202, 1)
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410501, 1)
      print("进入安全区")
    end
    monster.playerIn = true
  end
end

function monster.playerLeft(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and target_npc == get_come_on_hero() then
    print("玩家走出圈子")
    abort_magic_by_id(get_come_on_hero(), 1080410801, 1)
    abort_magic_by_id(monster.npc, 108041010102)
    if get_magic_num(get_come_on_hero(), 1080410801) < 1 then
      cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410301, 1)
      abort_magic_by_id(get_come_on_hero(), 1080410501, 1)
      abort_magic_by_id(get_come_on_hero(), 1080402, 1)
      print("离开安全区")
    end
    monster.playerIn = false
    call_scene_logic_custom_event("cantHear")
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(hit_target) and missile_cfg.Id == 108041010101 then
    cast_magic(get_come_on_hero(), get_come_on_hero(), 1080410101, 1, 2)
  end
end

function monster.on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    remove_missile_by_id(108041010101, monster.npc, false)
    abort_magic_by_id(monster.npc, 108041010102)
  end
end

function monster.on_self_magic_end(target, magic_id, magic_level, magic_kind, magic_type)
  if 1080410701 == magic_id then
    cast_missile_new(monster.npc, monster.npc, nil, nil, 108041010101, 1)
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(108041010101, monster.npc, false)
  abort_magic_by_id(monster.npc, 108041010102)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, 108041010101, monster.npc)
end

return monster
