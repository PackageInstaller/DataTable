local function getCloneTarget(list)
  local new_target = {}
  
  function new_target.Update(statisticSelf, statisticEnemy)
    return statisticSelf.totalDamage
  end
  
  return new_target
end

return getCloneTarget
