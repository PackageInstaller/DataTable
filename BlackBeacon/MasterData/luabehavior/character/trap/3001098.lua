local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster:_init(npc)
  self.npc = npc
  self.search = {}
  local actSkills = {
    wait = {300109801}
  }
  local actMoves = {}
  local nodes = {}
  monstBase._init(self, actSkills, actMoves, nodes)
  local states = self.states
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.decisionFailed)
  end
end

return monster
