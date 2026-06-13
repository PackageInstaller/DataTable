local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  monster.born = 300204601
  monster.search = {}
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  local actSkills = {
    waitAim = {300204602},
    atkMove = {300204603},
    boom = {300204604}
  }
  local actMoves = {"waitIdle", "disappear"}
  local nodes = {"wait", "atk"}
  monster.missile_move = 30020460301
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, monster.missile_move, monster.on_missile_hit_monster, monster)
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.atk, _ENV.disappear, _ENV.decisionFailed)
    _ENV.wait(_ENV.waitIdle, _ENV.waitAim)
    _ENV.atk(_ENV.atkMove, _ENV.boom)
  end
  
  function states.waitIdle.start(waitIdle)
    local monster = waitIdle.monster
    abort_skill(monster.npc, true)
    stop_move(npc)
    waitIdle.base.start(waitIdle)
  end
  
  states.waitIdle.waitAim = states.waitAim
  
  function states.waitIdle.tickTrans(waitIdle)
    local waitAim = waitIdle.waitAim
    if waitAim:isReady() then
      return waitAim
    end
  end
  
  function states.waitAim.isReady(waitAim)
    if not waitAim.base.isReady(waitAim) then
      return false
    end
    local monster = waitAim.monster
    local player = get_come_on_hero()
    return check_npc_distance(monster.npc, player, 4, true)
  end
  
  function states.waitAim.start(waitAim)
    local monster = waitAim.monster
    local player = get_come_on_hero()
    lookat_npc(monster.npc, player, true)
    waitAim.base.start(waitAim)
  end
  
  function states.waitAim.tick(waitAim)
    local monster = waitAim.monster
    local player = get_come_on_hero()
    lookat_npc(monster.npc, player, false)
  end
  
  states.waitAim.waitIdle = states.waitIdle
  
  function states.waitAim.tickTrans(waitAim)
    if not waitAim:isReady() then
      return waitAim.waitIdle
    end
  end
  
  function states.waitAim.finish(waitAim)
    local monster = waitAim.monster
    waitAim.base.finish(waitAim)
  end
  
  function states.atk.isReady()
    return true
  end
  
  states.atkMove.isAtkMove = true
  
  function states.atkMove.start(atkMove)
    local monster = atkMove.monster
    cast_magic(monster.npc, monster.npc, Const.LOCK_MASK)
    set_npc_status(monster.npc, 3, true)
    set_npc_status(monster.npc, 4, true)
    local player = get_come_on_hero()
    local tarPos = get_npc_offset_position(monster.npc, player:get_pos_vec3(), 180, 100)
    cast_magic(monster.npc, monster.npc, Const.MONSTER_EVADE.CLEAR_SLOMO)
    lookat_position(monster.npc, tarPos.x, tarPos.z, true)
    atkMove.base.start(atkMove)
  end
  
  states.atkMove.boom = states.boom
  
  function states.atkMove.finTrans(atkMove)
    return atkMove.boom
  end
  
  function states.boom.isReady()
    return true
  end
  
  states.boom.disappear = states.disappear
  
  function states.boom.finTrans(boom)
    return boom.disappear
  end
  
  function states.disappear.isReady()
    return true
  end
  
  function states.disappear.start(disappear)
    remove_npc(disappear.monster.npc)
  end
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.missile_move, monster)
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster:transState(monster.states.atkMove, true)
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == monster.missile_move and monster.state.isAtkMove then
    return monster:finTrans()
  end
end

function monster.on_missile_hit_monster(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and 1 ~= get_role_kind(target_npc) and 5 ~= get_role_kind(target_npc) and not target_npc:is_summons() then
    remove_missile(missile)
  end
end

function monster:on_room_pass(room_id)
end

return monster
