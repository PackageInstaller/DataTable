local HeroSortEnum = {}
HeroSortEnum.eSortResource = {
  heroList = 1,
  boardHero = 2,
  formation = 3,
  factory = 4,
  adjSelect = 5
}
HeroSortEnum.eSortMannerType = {
  Rank = 1,
  Level = 2,
  Id = 3,
  GetOrder = 4,
  Power = 6,
  SpecWeapon = 7
}
HeroSortEnum.defaultShow = {
  [1] = HeroSortEnum.eSortMannerType.Rank,
  [2] = HeroSortEnum.eSortMannerType.Level,
  [3] = HeroSortEnum.eSortMannerType.Power,
  [4] = HeroSortEnum.eSortMannerType.GetOrder,
  [5] = HeroSortEnum.eSortMannerType.SpecWeapon
}

local function PreCommonSort(hero1, hero2)
  if hero1.isLockedHero ~= hero2.isLockedHero then
    return hero1.isLockedHero == true
  end
  return nil
end

local function CommonSort(hero1, hero2)
  if PlayerDataCenter.favorHeroData ~= nil then
    local isFavor1 = PlayerDataCenter.favorHeroData:IsFavorHero(hero1.dataId)
    local isFavor2 = PlayerDataCenter.favorHeroData:IsFavorHero(hero2.dataId)
    if isFavor1 ~= isFavor2 then
      return isFavor1 == true
    end
  end
  return nil
end

local function SpecWeaponSort(hero1, hero2, isUpper)
  local weaponId1 = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(hero1.dataId)
  local weaponData1 = hero1:GetHeroDataSpecWeapon(weaponId1)
  local weaponId2 = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(hero2.dataId)
  local weaponData2 = hero2:GetHeroDataSpecWeapon(weaponId2)
  if not isUpper then
    local tempId = weaponId1
    weaponId1 = weaponId2
    weaponId2 = tempId
    local tempData = weaponData1
    weaponData1 = weaponData2
    weaponData2 = tempData
  end
  local hasWeapon1 = weaponId1 ~= nil
  local hasWeapon2 = weaponId2 ~= nil
  if hasWeapon1 ~= hasWeapon2 then
    return hasWeapon1
  end
  local hasUpgrade1 = weaponData1 ~= nil
  local hasUpgrade2 = weaponData2 ~= nil
  if hasUpgrade1 ~= hasUpgrade2 then
    return hasUpgrade1
  end
  if hasWeapon1 == true and hasUpgrade1 == true then
    local level1 = weaponData1:GetSpecWeaponCurLevel()
    local step1 = weaponData1:GetSpecWeaponCurStep()
    local level2 = weaponData2:GetSpecWeaponCurLevel()
    local step2 = weaponData2:GetSpecWeaponCurStep()
    if step1 ~= step2 then
      return step1 > step2
    else
      local result = CommonSort(hero1, hero2)
      if result ~= nil then
        return result
      end
    end
    if level1 ~= level2 then
      return level1 > level2
    else
      local result = CommonSort(hero1, hero2)
      if result ~= nil then
        return result
      end
    end
  else
    local result = CommonSort(hero1, hero2)
    if result ~= nil then
      return result
    end
  end
  return hero1.dataId > hero2.dataId
end

HeroSortEnum.SortMannerDefine = {
  [HeroSortEnum.eSortMannerType.Rank] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.rank > hero2.rank then
        return true
      elseif hero1.rank == hero2.rank then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
        if hero1.level > hero2.level then
          return true
        elseif hero1.level == hero2.level then
          return hero1.dataId > hero2.dataId
        end
      end
      return false
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.rank < hero2.rank then
        return true
      elseif hero1.rank == hero2.rank then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
        if hero1.level < hero2.level then
          return true
        elseif hero1.level == hero2.level then
          return hero1.dataId < hero2.dataId
        end
      end
      return false
    end
  },
  [HeroSortEnum.eSortMannerType.GetOrder] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.ts > hero2.ts then
        return true
      elseif hero1.ts == hero2.ts then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
      end
      return false
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.ts < hero2.ts then
        return true
      elseif hero1.ts == hero2.ts then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
      end
      return false
    end
  },
  [HeroSortEnum.eSortMannerType.Level] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.level > hero2.level then
        return true
      elseif hero1.level == hero2.level then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
        if hero1.rank > hero2.rank then
          return true
        elseif hero1.rank == hero2.rank then
          return hero1.dataId > hero2.dataId
        end
      end
      return false
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if hero1.level < hero2.level then
        return true
      elseif hero1.level == hero2.level then
        local result = CommonSort(hero1, hero2)
        if result ~= nil then
          return result
        end
        if hero1.rank < hero2.rank then
          return true
        elseif hero1.rank == hero2.rank then
          return hero1.dataId < hero2.dataId
        end
      end
      return false
    end
  },
  [HeroSortEnum.eSortMannerType.Id] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      local result = CommonSort(hero1, hero2)
      if result ~= nil then
        return result
      end
      return hero1.dataId > hero2.dataId
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      local result = CommonSort(hero1, hero2)
      if result ~= nil then
        return result
      end
      return hero1.dataId < hero2.dataId
    end
  },
  [HeroSortEnum.eSortMannerType.Power] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if not hero1.isLockedHero and not hero2.isLockedHero then
        local pow1 = hero1:TryGetCachedPower()
        local pow2 = hero2:TryGetCachedPower()
        if pow1 ~= pow2 then
          return pow1 > pow2
        else
          local result = CommonSort(hero1, hero2)
          if result ~= nil then
            return result
          end
        end
      end
      return hero1.dataId > hero2.dataId
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      if not hero1.isLockedHero and not hero2.isLockedHero then
        local pow1 = hero1:TryGetCachedPower()
        local pow2 = hero2:TryGetCachedPower()
        if pow1 ~= pow2 then
          return pow1 < pow2
        else
          local result = CommonSort(hero1, hero2)
          if result ~= nil then
            return result
          end
        end
      end
      return hero1.dataId < hero2.dataId
    end
  },
  [HeroSortEnum.eSortMannerType.SpecWeapon] = {
    descSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      local specRes = SpecWeaponSort(hero1, hero2, true)
      return specRes
    end,
    asceSort = function(hero1, hero2)
      local preResult = PreCommonSort(hero1, hero2)
      if preResult ~= nil then
        return preResult
      end
      local specRes = SpecWeaponSort(hero1, hero2, false)
      return specRes
    end
  }
}
return HeroSortEnum
