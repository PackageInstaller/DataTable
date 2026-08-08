local function getCloneTarget(list)
  local new_target = {}
  
  new_target.CanNotFinishInFight = 1
  
  function new_target.Update(statisticSelf, statisticEnemy)
    return statisticSelf.gameRound
  end
  
  return new_target
end

return getCloneTarget
