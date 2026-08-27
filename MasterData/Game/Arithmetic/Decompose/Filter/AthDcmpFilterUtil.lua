local AthDcmpFilterUtil = {}
AthDcmpFilterUtil.FilterTypeBaseMax = 3
AthDcmpFilterUtil.FilterType = {
  Area = 1,
  Quality = 2,
  Size = 3,
  Suit = 4,
  MainAttri = 5,
  Max = 6
}
AthDcmpFilterUtil.FilterBaseValue = {
  [AthDcmpFilterUtil.FilterType.Area] = {
    1,
    2,
    3
  },
  [AthDcmpFilterUtil.FilterType.Quality] = {
    3,
    4,
    5
  },
  [AthDcmpFilterUtil.FilterType.Size] = {1, 2}
}
AthDcmpFilterUtil.FilterFunc = {
  [AthDcmpFilterUtil.FilterType.Area] = function(athData, valueDic)
    local area = athData:GetAthAreaType()
    return valueDic[area] == true
  end,
  [AthDcmpFilterUtil.FilterType.Quality] = function(athData, valueDic)
    local quality = athData:GetAthQuality()
    return valueDic[quality] == true
  end,
  [AthDcmpFilterUtil.FilterType.Size] = function(athData, valueDic)
    local size = athData:GetAthSize()
    return valueDic[size] == true
  end,
  [AthDcmpFilterUtil.FilterType.Suit] = function(athData, valueDic)
    local suitId = athData:GetAthSuit()
    return valueDic[suitId] == true
  end,
  [AthDcmpFilterUtil.FilterType.MainAttri] = function(athData, valueDic)
    local mainAttrId = athData:GetAthMainAttrId(true)
    return valueDic[mainAttrId] == true
  end
}
AthDcmpFilterUtil.FilterGroupType = {
  Basic = 1,
  Title = 2,
  Dynamic = 3
}
return AthDcmpFilterUtil
