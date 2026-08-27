local FairySortEnum = {}
FairySortEnum.SortMannerType = {Order = 1, Level = 2}

local function CommonFairySort(fairy1, fairy2)
  local favor1 = fairy1:GetIsFavouriteFairy()
  local favor2 = fairy2:GetIsFavouriteFairy()
  if favor1 ~= favor2 then
    return favor1 == true
  end
  return nil
end

FairySortEnum.SortMannerDefine = {
  [FairySortEnum.SortMannerType.Order] = {
    descSort = function(fairy1, fairy2)
      local commonResult = CommonFairySort(fairy1, fairy2)
      if commonResult ~= nil then
        return commonResult
      end
      local fairy1Uid = fairy1:GetFairyUID()
      local fairy2Uid = fairy2:GetFairyUID()
      local realTime1 = fairy1Uid & CommonUtil.UInt32Max
      local realTime2 = fairy2Uid & CommonUtil.UInt32Max
      return realTime1 > realTime2
    end,
    asceSort = function(fairy1, fairy2)
      local commonResult = CommonFairySort(fairy1, fairy2)
      if commonResult ~= nil then
        return commonResult
      end
      local fairy1Uid = fairy1:GetFairyUID()
      local fairy2Uid = fairy2:GetFairyUID()
      local realTime1 = fairy1Uid & CommonUtil.UInt32Max
      local realTime2 = fairy2Uid & CommonUtil.UInt32Max
      return realTime1 < realTime2
    end
  },
  [FairySortEnum.SortMannerType.Level] = {
    descSort = function(fairy1, fairy2)
      local commonResult = CommonFairySort(fairy1, fairy2)
      if commonResult ~= nil then
        return commonResult
      end
      local lv1 = fairy1:GetFairyCurLevel()
      local lv2 = fairy2:GetFairyCurLevel()
      if lv1 ~= lv2 then
        return lv1 > lv2
      end
      local quality1 = fairy1:GetCurFairyQuality()
      local quality2 = fairy2:GetCurFairyQuality()
      if quality1 ~= quality2 then
        return quality1 < quality2
      end
      return fairy1:GetFairyUID() > fairy2:GetFairyUID()
    end,
    asceSort = function(fairy1, fairy2)
      local commonResult = CommonFairySort(fairy1, fairy2)
      if commonResult ~= nil then
        return commonResult
      end
      local lv1 = fairy1:GetFairyCurLevel()
      local lv2 = fairy2:GetFairyCurLevel()
      if lv1 ~= lv2 then
        return lv1 < lv2
      end
      local quality1 = fairy1:GetCurFairyQuality()
      local quality2 = fairy2:GetCurFairyQuality()
      if quality1 ~= quality2 then
        return quality1 > quality2
      end
      return fairy1:GetFairyUID() < fairy2:GetFairyUID()
    end
  }
}
return FairySortEnum
