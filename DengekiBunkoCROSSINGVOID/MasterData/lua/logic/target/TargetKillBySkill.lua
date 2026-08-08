local function getCloneTarget(list)
  local new_target = {}
  
  new_target.kind = list[3]
  
  function new_target.Update(statisticSelf, statisticEnemy)
    local val = 0
    for i = 1, #statisticEnemy.deadInfo do
      if statisticEnemy.deadInfo[i].kind == new_target.kind then
        val = val + 1
      end
    end
    return val
  end
  
  return new_target
end

return getCloneTarget
