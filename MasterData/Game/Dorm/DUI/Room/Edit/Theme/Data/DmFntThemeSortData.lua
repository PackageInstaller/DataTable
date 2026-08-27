local DmFntThemeSortData = class("DmFntThemeSortData")
local DmThemeSortEnum = require("Game.Dorm.DUI.Room.Edit.Theme.Sort.DmThemeSortEnum")
local eDmFntThemeSortType = DmThemeSortEnum.eDmFntThemeSortType
local _inDmBigRoom, _reverseSort, themeUseableNRateDic

local function bigRoomSortFunc(a, b)
  if a.dmFntThemeCfg.only_big == b.dmFntThemeCfg.only_big then
    return nil
  end
  if _inDmBigRoom then
    return a.dmFntThemeCfg.only_big
  else
    return not a.dmFntThemeCfg.only_big
  end
end

local eSortFunc = {
  [eDmFntThemeSortType.Default] = function(a, b)
    local result = bigRoomSortFunc(a, b)
    if result ~= nil then
      return result
    end
    local inSellA, inSellB = a:IsDmFntThemeInSell(), b:IsDmFntThemeInSell()
    if inSellA ~= inSellB then
      if _reverseSort then
        return inSellB
      end
      return inSellA
    end
    if a.dmFntThemeCfg.sortord ~= b.dmFntThemeCfg.sortord then
      if _reverseSort then
        return a.dmFntThemeCfg.sortord < b.dmFntThemeCfg.sortord
      end
      return a.dmFntThemeCfg.sortord > b.dmFntThemeCfg.sortord
    end
    if _reverseSort then
      return a.id < b.id
    end
    return a.id > b.id
  end,
  [eDmFntThemeSortType.Comfort] = function(a, b)
    local result = bigRoomSortFunc(a, b)
    if result ~= nil then
      return result
    end
    local comfortA = a:GetDmFntThemeComformt()
    local comfortB = b:GetDmFntThemeComformt()
    if comfortA ~= comfortB then
      if _reverseSort then
        return comfortA < comfortB
      end
      return comfortA > comfortB
    end
    if _reverseSort then
      return a.id < b.id
    end
    return a.id > b.id
  end,
  [eDmFntThemeSortType.UseableRate] = function(a, b)
    local result = bigRoomSortFunc(a, b)
    if result ~= nil then
      return result
    end
    themeUseableNRateDic = themeUseableNRateDic or {}
    local useableRateA = themeUseableNRateDic[a.id]
    local useableRateB = themeUseableNRateDic[b.id]
    if useableRateA == nil then
      useableRateA = a:GetDmFntThemeUseableNum() / a:GetDmFntThemeTotalNum()
      themeUseableNRateDic[a.id] = useableRateA
    end
    if useableRateB == nil then
      useableRateB = b:GetDmFntThemeUseableNum() / b:GetDmFntThemeTotalNum()
      themeUseableNRateDic[b.id] = useableRateB
    end
    if useableRateA ~= useableRateB then
      if _reverseSort then
        return useableRateA < useableRateB
      end
      return useableRateA > useableRateB
    end
    if _reverseSort then
      return a.id < b.id
    end
    return a.id > b.id
  end
}

function DmFntThemeSortData:GetDmThemeSortFunc(inDmBigRoom)
  local sortType, isReverse = self:GetDmThemeCurSortType()
  _inDmBigRoom = inDmBigRoom
  _reverseSort = isReverse
  local sortFunc = eSortFunc[sortType]
  return sortFunc
end

function DmFntThemeSortData.ClearDmThemeSort()
  _inDmBigRoom = nil
  _reverseSort = nil
  themeUseableNRateDic = nil
end

function DmFntThemeSortData:ctor(inBigRoom)
  self._sortReverseDic = {}
  self._curSortType = eDmFntThemeSortType.Default
end

function DmFntThemeSortData:GetDmThemeCurSortTypeReverse(sortType)
  return self._sortReverseDic[sortType] or false
end

function DmFntThemeSortData:ChangeDmThemeCurSortTypeReverse(sortType)
  self._sortReverseDic[sortType] = not self._sortReverseDic[sortType]
end

function DmFntThemeSortData:IsDmThemeCurSortType(sortType)
  return self._curSortType == sortType
end

function DmFntThemeSortData:GetDmThemeCurSortType()
  return self._curSortType, self._sortReverseDic[self._curSortType]
end

function DmFntThemeSortData:SetDmThemeCurSortType(sortType)
  self._curSortType = sortType
end

return DmFntThemeSortData
