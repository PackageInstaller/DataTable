local function getCloneTarget(list)
  local new_target = {}
  
  new_target.num = list[3]
  
  function new_target.Update(statisticSelf, statisticEnemy)
    local val = 0
    for i = 1, #statisticSelf.cardNumList do
      local skill_num = statisticSelf.cardNumList[i] % 10000 // 10
      if skill_num == new_target.num then
        val = val + 1
      end
    end
    return val
  end
  
  return new_target
end

return getCloneTarget
