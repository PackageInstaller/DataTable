local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  monster.pkValue = 0
  local cumulativeTime = 0
  local actSkills = {}
  local actMoves = {
    "wait",
    "findGoods1",
    "findGoods2"
  }
  local nodes = {"default"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.root(_ENV.default, _ENV.decisionFailed)
    _ENV.default(_ENV.wait, _ENV.findGoods1, _ENV.findGoods2)
  end
  
  function states.findGoods1.tick(findGoods1)
    cumulativeTime = cumulativeTime + 0.05
    if cumulativeTime >= 0.5 then
      cumulativeTime = 0
      monster.pkValue = monster.pkValue - 1
      set_sync_var("shouldDecrease", true)
    end
    if monster.pkValue < 1 then
      set_sync_var("needReset1", true)
      monster:transState(monster.states.wait)
    end
  end
  
  function states.findGoods2.tick(findGoods2)
    cumulativeTime = cumulativeTime + 0.05
    if cumulativeTime >= 0.5 then
      cumulativeTime = 0
      monster.pkValue = monster.pkValue - 1
      set_sync_var("shouldDecrease", true)
    end
    if monster.pkValue < 1 then
      set_sync_var("needReset2", true)
      monster:transState(monster.states.wait)
    end
  end
end

function monster.on_story_finish(monster, story_id)
  if 2230113 == story_id then
    monster.pkValue = 0
    return
  end
  if 2230116 == story_id then
    monster.pkValue = 35
    return
  end
end

function monster.on_self_magic_begin(monster, target, magic_id)
  if 3000001 == magic_id then
    monster:transState(monster.states.wait)
  end
  if 3000002 == magic_id then
    monster:transState(monster.states.findGoods1)
  end
  if 3000003 == magic_id then
    monster:transState(monster.states.findGoods2)
  end
  if 3000004 == magic_id then
    local pkValueChange = get_sync_var("pkValueChange")
    monster.pkValue = monster.pkValue + pkValueChange
  end
end

return monster
