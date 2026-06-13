local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  local monster = monster
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 1
  local skills = {
    am1h1 = {},
    am2h1g2 = {},
    am1hN = {},
    am2h1g1 = {},
    am1h1cd5 = {},
    sm1h1 = {},
    sm2h1g2 = {},
    sm1hN = {},
    sm2h1g1 = {},
    sm1h1cd5 = {}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.freeAtk(_ENV.am1h1, _ENV.am2h1g2, _ENV.am1hN, _ENV.am2h1g1, _ENV.am1h1cd5, _ENV.sm1h1, _ENV.sm2h1g2, _ENV.sm1hN, _ENV.sm2h1g1, _ENV.sm1h1cd5)
    _ENV.wander(_ENV.stand)
  end
  states.freeAtk.isReady = Const.FALSE_FUN
  
  function states.stand.start(stand)
    stop_move(stand.monster.npc)
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  return lookat_npc(monster.npc, get_come_on_hero(), true)
end

function monster.on_self_skill_begin(monster, skill_id, skill_type, skill_cfg)
  monster.base.on_self_skill_begin(monster, skill_id, skill_type, skill_cfg)
  if not monster.target then
    return
  end
  return lookat_npc(monster.npc, monster.target, true)
end

return monster
