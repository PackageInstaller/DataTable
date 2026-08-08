local function getCloneTarget(list)
  local new_target = {}
  
  new_target.order = list[3]
  
  function new_target.Update(statisticSelf, statisticEnemy)
    if #statisticEnemy.deadInfo > 0 then
      if new_target.order == 1 then
        return statisticEnemy.deadInfo[1].seat
      elseif new_target.order == 2 and statisticEnemy.initCount == #statisticEnemy.deadInfo then
        return statisticEnemy.deadInfo[#statisticEnemy.deadInfo].seat
      end
    end
    return 0
  end
  
  return new_target
end

return getCloneTarget
