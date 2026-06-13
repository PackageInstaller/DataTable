local monsterActionMove = {}
monsterActionMove.__index = monsterActionMove

function monsterActionMove.insertFun(act, funName, newFun)
  act.tool.insert(act, funName, newFun)
end

function monsterActionMove.removeFun(act, funName, newFun)
  act.tool.remove(act, funName, newFun)
end

function monsterActionMove.new(base, name, monster)
  local result = setmetatable({}, base)
  result.base = base
  result.name = name
  result.monster = monster
  result.tree = monster.tree
  result.tool = monster.tool
  result.type = "action"
  result.parent = nil
  result.nextSibling = nil
  result.trans = {
    prio = 0,
    enable = {},
    disable = {}
  }
  return result
end

function monsterActionMove.isReady()
  return true
end

function monsterActionMove.tick()
end

function monsterActionMove.tickTrans()
end

function monsterActionMove.finish()
end

function monsterActionMove.finTrans()
end

function monsterActionMove.start(act, type)
  if not type then
    return
  end
  local monster = act.monster
  switch_move_type(monster.npc, type)
  moveto_npc(monster.npc, monster.target)
end

function monsterActionMove.isInTree(act)
  local node = act
  local monster = act.monster
  local i = 1
  while true do
    if not node.parent then
      if node.name == "root" then
        return true
      else
        return false
      end
    end
    node = node.parent
    i = i + 1
    if i >= 100 then
      Util.debug_output("loop overflows", monster.npc.id, monster.npc.uuid, act.name)
      return false
    end
  end
end

function monsterActionMove.isRunning(act)
  local tree = act.monster.tree
  local states = tree.states
  for _, _state in ipairs(states) do
    if _state == act then
      return true
    end
  end
  return false
end

function monsterActionMove.chooseChildAction(act)
  return act.tree:chooseChildAction(act)
end

return monsterActionMove
