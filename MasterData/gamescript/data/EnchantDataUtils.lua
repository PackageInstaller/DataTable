local EnchantDataUtils = {}
local EnchantGroupMap
local UndefineQualitySort = 999
local EnchantSortValueTable
local ENCHANT_GROUP_LANG_PREFIX = "EnchantGroup_"
local ENCHANT_TYPE_LANG_SUFFIX = "EnchantConfigTypeName"

function EnchantDataUtils.GetEnchantConfig(tid)
  if not tid then
    return
  end
  return DT.EnchantConfig[tid]
end

function EnchantDataUtils.GetEnchantName(tid)
  local config = EnchantDataUtils.GetEnchantConfig(tid)
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.Name
end

function EnchantDataUtils.GetEnchantIcon(tid)
  local config = EnchantDataUtils.GetEnchantConfig(tid)
  if not config then
    return ""
  end
  return config.Icon
end

function EnchantDataUtils.GetEnchantSortValue(quality)
  if not quality then
    return UndefineQualitySort
  end
  if EnchantSortValueTable then
    return EnchantSortValueTable[quality] or UndefineQualitySort
  end
  EnchantSortValueTable = {}
  local sortValueTable = DT.GetOriginalConstant("EnchantGroupCollation")
  for sortValue, _quality in ipairs(sortValueTable) do
    EnchantSortValueTable[_quality] = sortValue
  end
  return EnchantSortValueTable[quality] or UndefineQualitySort
end

function EnchantDataUtils.GetEnchantListByGroup(group)
  if not group then
    return {}
  end
  if EnchantGroupMap then
    return EnchantGroupMap[group] or {}
  end
  EnchantGroupMap = {}
  for enchantTid, config in pairs(DT.EnchantConfig) do
    if not config or not config.EnchantGroup then
    else
      if not EnchantGroupMap[config.EnchantGroup] then
        EnchantGroupMap[config.EnchantGroup] = {}
      end
      table.insert(EnchantGroupMap[config.EnchantGroup], enchantTid)
    end
  end
  for _, list in pairs(EnchantGroupMap) do
    if #list > 1 then
      table.sort(list, function(a, b)
        local configA = EnchantDataUtils.GetEnchantConfig(a)
        local configB = EnchantDataUtils.GetEnchantConfig(b)
        local qualityA = configA and configA.Quality or ""
        local qualityB = configB and configB.Quality or ""
        local sortValueA = EnchantDataUtils.GetEnchantSortValue(qualityA)
        local sortValueB = EnchantDataUtils.GetEnchantSortValue(qualityB)
        if sortValueA == sortValueB then
          if configA.sort and configB.sort then
            return configA.sort < configB.sort
          else
            return a < b
          end
        end
        return sortValueA < sortValueB
      end)
    end
  end
  return EnchantGroupMap[group] or {}
end

function EnchantDataUtils.GetEnchantGroupName(group)
  if not group then
    return
  end
  local langKey = ENCHANT_GROUP_LANG_PREFIX .. group
  do return LT.Text end
  return LT.Text, langKey
end

function EnchantDataUtils.GetTypeName(tid)
  local config = EnchantDataUtils.GetEnchantConfig(tid)
  if not config or not config.Quality then
    return ""
  end
  local langKey = config.Quality .. ENCHANT_TYPE_LANG_SUFFIX
  do return LT.Text end
  return LT.Text, langKey
end

return EnchantDataUtils
