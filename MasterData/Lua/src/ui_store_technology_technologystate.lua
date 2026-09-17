local this = {}
local C_TechnologyStore = CS.Lens.Gameplay.UI.TechnologyStore

local function toArray(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or 0
  for i = 0, count - 1 do
    res[#res + 1] = list[i]
  end
  return res
end

local function toMapFromPairs(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or 0
  for i = 0, count - 1 do
    local kv = list[i]
    if kv ~= nil then
      res[kv.Key] = kv.Value
    end
  end
  return res
end

local function toRedMap(list)
  local res = {}
  if list == nil then
    return res
  end
  local count = list.Count or 0
  for i = 0, count - 1 do
    local key = list[i]
    if key ~= nil then
      res[key] = 1
    end
  end
  return res
end

function this:init()
  this.super.init(self)
end

function this:getTechTypeInfo(techType)
  return C_TechnologyStore.GetStore():getTechTypeInfo(techType)
end

function this:getTechTypeSubCnt(techType, tabId)
  return C_TechnologyStore.GetStore():getTechTypeSubCnt(techType, tabId)
end

function this:getAllTechnology()
  return toMapFromPairs(C_TechnologyStore.GetStore():getAllTechnology())
end

function this:isTechnologyUnlock(techTreeId)
  return C_TechnologyStore.GetStore():isTechnologyUnlock(techTreeId)
end

function this:getTechnologyInfo(techTreeId)
  return C_TechnologyStore.GetStore():getTechnologyInfo(techTreeId)
end

function this:getCurTechnologyLevelById(techTreeId)
  return C_TechnologyStore.GetStore():getCurTechnologyLevelById(techTreeId)
end

function this:getCurTechnologyMaxLevelById(techTreeId)
  return C_TechnologyStore.GetStore():getCurTechnologyMaxLevelById(techTreeId)
end

function this:getAllCurTechnologyList()
  return toArray(C_TechnologyStore.GetStore():getAllCurTechnologyList())
end

function this:getAllCurTechnologyListByType(type)
  return toArray(C_TechnologyStore.GetStore():getAllCurTechnologyListByType(type))
end

function this:getTechnologyTypeRedList()
  return toRedMap(C_TechnologyStore.GetStore():getTechnologyTypeRedList())
end

function this:GetTechnologyRedByTreeId(treeId)
  return C_TechnologyStore.GetStore():GetTechnologyRedByTreeId(treeId)
end

return this
