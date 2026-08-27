local EpAutoUtil = {}
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function EpAutoUtil.AbleGetNewChip(dynPlayer)
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if isOverLimit then
    return true, false
  end
  local ableGetNew = true
  if nowCount == nowLimit then
    local costItemId, costItemNum = dynPlayer:GetChipUpgradeLimitPrice()
    local curMoney = dynPlayer:GetItemCount(costItemId)
    ableGetNew = costItemNum <= curMoney
  end
  return false, ableGetNew
end

function EpAutoUtil.GetAutoBestValueChip(dynPlayer, chipList, totalPowerDic)
  local fightPower = -1
  local totalPower = -1
  local quality = -1
  local bestChipData
  for k, chipData in pairs(chipList) do
    repeat
      local tmpPower = dynPlayer:GetChipCombatEffect(chipData, false, true)
      if tmpPower == fightPower then
        local tmpTotalPower = totalPowerDic[chipData]
      end
      if tmpTotalPower == totalPower and quality < chipData:GetQuality() or totalPower < tmpTotalPower or fightPower < tmpPower then
        goto lbl_28
      end
      do break end -- pseudo-goto
      ::lbl_28::
      bestChipData = chipData
      fightPower = tmpPower
      totalPower = totalPowerDic[chipData]
      quality = chipData:GetQuality()
    until true
  end
  return bestChipData
end

local eventAutoChoiceFuncTab = {
  [ExplorationEnum.eAutoEventChoiceType.AllRoleHpLess] = function(auto_choice_arg, dynPlayer)
    local hp = auto_choice_arg[1] * 10
    local autoSuccess = true
    for _, dynHero in ipairs(dynPlayer.heroList) do
      if hp < dynHero.hpPer then
        autoSuccess = false
        break
      end
    end
    return autoSuccess
  end,
  [ExplorationEnum.eAutoEventChoiceType.OneRoleHpLess] = function(auto_choice_arg, dynPlayer)
    local hp = auto_choice_arg[1] * 10
    local autoSuccess = false
    for _, dynHero in ipairs(dynPlayer.heroList) do
      if hp >= dynHero.hpPer then
        autoSuccess = true
        break
      end
    end
    return autoSuccess
  end,
  [ExplorationEnum.eAutoEventChoiceType.HasItemCount] = function(auto_choice_arg, dynPlayer)
    local autoSuccess = false
    if dynPlayer:GetItemCount(auto_choice_arg[1]) >= auto_choice_arg[2] then
      autoSuccess = true
    end
    return autoSuccess
  end,
  [ExplorationEnum.eAutoEventChoiceType.RoleAvgHpLess] = function(auto_choice_arg, dynPlayer)
    local autoSuccess = false
    local totalHp = 0
    local c = 0
    for _, dynHero in ipairs(dynPlayer.heroList) do
      if not dynHero.onBench then
        totalHp = totalHp + dynHero.hpPer
        c = c + 1
      end
    end
    local avgHp = 0
    if 0 < c then
      avgHp = totalHp / c
    end
    if avgHp <= auto_choice_arg[1] * 10 then
      autoSuccess = true
    end
    return autoSuccess
  end,
  [ExplorationEnum.eAutoEventChoiceType.RoleAvgHpGreate] = function(auto_choice_arg, dynPlayer)
    local autoSuccess = false
    local totalHp = 0
    local c = 0
    for _, dynHero in ipairs(dynPlayer.heroList) do
      if not dynHero.onBench then
        totalHp = totalHp + dynHero.hpPer
        c = c + 1
      end
    end
    local avgHp = 0
    if 0 < c then
      avgHp = totalHp / c
    end
    if avgHp > auto_choice_arg[1] * 10 then
      autoSuccess = true
    end
    return autoSuccess
  end
}

function EpAutoUtil.IsEventChoiceAutoSuccess(auto_choice_type, auto_choice_arg, dynPlayer)
  if auto_choice_type <= 0 then
    return false
  end
  local func = eventAutoChoiceFuncTab[auto_choice_type]
  if func == nil then
    return false
  end
  return func(auto_choice_arg, dynPlayer)
end

return EpAutoUtil
