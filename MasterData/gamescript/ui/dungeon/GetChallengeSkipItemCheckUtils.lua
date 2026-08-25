local GetChallengeSkipItemCheckUtils = System.NewClass("GetChallengeSkipItemCheckUtils")

function GetChallengeSkipItemCheckUtils.ItemIsOverMax(AddValue)
  local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
  local currencyItemId = params[1]
  local limit = GetChallengeSkipItemCheckUtils.GetLimit()
  local ownNum = ItemDataUtils.GetItemNum(currencyItemId)
  return limit < ownNum + AddValue
end

function GetChallengeSkipItemCheckUtils.TipsShow(func)
  Alert.Show(20199, nil, func)
end

function GetChallengeSkipItemCheckUtils.GetLimit()
  local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
  local currencyItemId = params[1]
  local itemInfoArr = DT.GetOriginalConstant("MaximumNumberOfKeysHeld")
  for i = 1, #itemInfoArr, 2 do
    local limitItemId = itemInfoArr[i]
    local limit = itemInfoArr[i + 1]
    if limitItemId == currencyItemId then
      return limit
    end
  end
  return 0
end

return GetChallengeSkipItemCheckUtils
