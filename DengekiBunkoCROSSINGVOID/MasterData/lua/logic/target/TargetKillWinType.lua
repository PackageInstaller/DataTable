local function getCloneTarget(list)
  local new_target = {}
  
  function new_target.Update(statisticSelf, statisticEnemy)
    if statisticEnemy.initCount == #statisticEnemy.deadInfo then
      local info = statisticEnemy.deadInfo[#statisticEnemy.deadInfo]
      return info.kind
    end
    return -1
  end
  
  return new_target
end

return getCloneTarget
