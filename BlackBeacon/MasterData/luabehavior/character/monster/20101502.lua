local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {}
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.nightSwitch = true
  monster.crystal = true
  do
    local _ENV = monster.states
    _ENV.active(_ENV.gotTarget, _ENV.noTarget)
    _ENV.gotTarget(_ENV.idle)
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if check_magic(monster.npc, 2020430113) then
    monster.search = {minDis = 8, maxDis = 8}
  end
end

return monster
