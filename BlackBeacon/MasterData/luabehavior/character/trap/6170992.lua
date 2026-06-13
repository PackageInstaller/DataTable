local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local monsterTool = import("common.monster_tool")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
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
  local skills = {
    atk = {617099201, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  monster.missile_id = 61709910101
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 2010050113, 1)
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050112, 1)
  cast_magic(npc, npc, 30010050101, 1)
  cast_magic(npc, npc, 300100501012, 1)
  cast_magic(npc, npc, 300100501013, 1)
  set_npc_hp_visible(npc, false)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, monster.missile_id, monster.on_water_catch_npc, monster)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.atk, _ENV.stand)
  end
  
  function states.atk.finTrans(atk)
    return atk
  end
  
  function states.atk.start(atk)
    atk.base.start(atk)
    if not monster.tool:checkMagicToTeam(2010050123) then
      monster.tool:castMagicToTeam(2010050123, 1)
    end
  end
end

function monster.on_remove(monster)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, monster.npc, monster.missile_id, monster)
end

function monster.on_water_catch_npc(monster, owner, target_npc, missile_cfg, missile)
end

function monster.on_start(monster)
end

return monster
