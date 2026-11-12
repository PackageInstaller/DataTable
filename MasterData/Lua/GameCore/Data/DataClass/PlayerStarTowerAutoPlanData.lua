local StarTowerAutoDecision = require("Game.Adventure.StarTower.StarTowerAutoDecision")
local PlayerStarTowerAutoPlanData = class("PlayerStarTowerAutoPlanData")
local SCHEMA_VERSION = 1
local DEFAULT_PLAN_COUNT = ConfigTable.GetConfigNumber("TowerVitaOptionMax")
local OptionValueType = {
  Boolean = "Boolean",
  Integer = "Integer",
  List = "List"
}
local OptionConfig = {
  {
    sKey = "PresetFirstSwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.PresetFirstSwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapPotential",
      "bPresetFirst"
    }
  },
  {
    sKey = "PresetOnlySwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.PresetOnlySwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapPotential",
      "bPresetOnly"
    }
  },
  {
    sKey = "PotentialSort",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.PotentialSort,
    sType = OptionValueType.List,
    tbPath = {
      "mapPotential",
      "tbPotentialSort"
    }
  },
  {
    sKey = "PotentialRerollSwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.PotentialRerollSwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapPotential",
      "bPotentialReroll"
    }
  },
  {
    sKey = "PotentialRerollCoinNumSelector",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.PotentialRerollCoinNumSelector,
    sType = OptionValueType.Integer,
    tbPath = {
      "mapPotential",
      "nPotentialRerollCoinNum"
    }
  },
  {
    sKey = "ShopFirstChoose",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopFirstChoose,
    sType = OptionValueType.Integer,
    tbPath = {"mapShop", "nShopFirst"}
  },
  {
    sKey = "ShopUpgradeDropdown",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopUpgradeDropdown,
    sType = OptionValueType.Integer,
    tbPath = {
      "mapShop",
      "nShopUpgradePrice"
    }
  },
  {
    sKey = "ShopSort",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopSort,
    sType = OptionValueType.List,
    tbPath = {"mapShop", "tbShopSort"}
  },
  {
    sKey = "ShopCoinRerollSwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopCoinRerollSwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapShop",
      "bShopCoinReroll"
    }
  },
  {
    sKey = "ShopCoinNumSelector",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopCoinNumSelector,
    sType = OptionValueType.Integer,
    tbPath = {
      "mapShop",
      "nShopCoinNum"
    }
  },
  {
    sKey = "ShopFinalRerollSwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopFinalRerollSwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapShop",
      "bShopFinalReroll"
    }
  },
  {
    sKey = "ShopFinalAllInSwitch",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.ShopFinalAllInSwitch,
    sType = OptionValueType.Boolean,
    tbPath = {
      "mapShop",
      "bShopFinalAllIn"
    }
  },
  {
    sKey = "EventTendency",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.EventTendency,
    sType = OptionValueType.Integer,
    tbPath = {
      "mapEvent",
      "nEventTendency"
    }
  },
  {
    sKey = "EventSort",
    nOptionId = AllEnum.StarTowerAutoDecisionSettings.EventSort,
    sType = OptionValueType.List,
    tbPath = {
      "mapEvent",
      "tbEventSort"
    }
  }
}
local mapOptionConfigById = {}

local function _RefreshOptionConfigIndex()
  mapOptionConfigById = {}
  for _, mapConfig in ipairs(OptionConfig) do
    mapOptionConfigById[mapConfig.nOptionId] = mapConfig
  end
end

_RefreshOptionConfigIndex()

local function _IsTable(value)
  return type(value) == "table"
end

local function _ToNumber(value, nDefault)
  local nValue = tonumber(value)
  if nValue == nil then
    return nDefault or 0
  end
  return nValue
end

local function _ToBool(value, bDefault)
  if value == nil then
    return bDefault == true
  end
  return value == true
end

local function _GetField(mapData, sLocalKey, sServerKey, defaultValue)
  if not _IsTable(mapData) then
    return defaultValue
  end
  if mapData[sLocalKey] ~= nil then
    return mapData[sLocalKey]
  end
  if sServerKey ~= nil and mapData[sServerKey] ~= nil then
    return mapData[sServerKey]
  end
  return defaultValue
end

local function _Clone(value)
  if clone ~= nil then
    return clone(value)
  end
  if type(value) ~= "table" then
    return value
  end
  local ret = {}
  for k, v in pairs(value) do
    ret[k] = _Clone(v)
  end
  return ret
end

local function _CopyArray(tbList)
  local tbRet = {}
  if not _IsTable(tbList) then
    return tbRet
  end
  for _, value in ipairs(tbList) do
    table.insert(tbRet, value)
  end
  return tbRet
end

local function _BuildEnumSet(mapEnum)
  local mapSet = {}
  if not _IsTable(mapEnum) then
    return mapSet
  end
  for _, nValue in pairs(mapEnum) do
    if type(nValue) == "number" then
      mapSet[nValue] = true
    end
  end
  return mapSet
end

local ValidPotentialRule = _BuildEnumSet(StarTowerAutoDecision.PotentialRule)
local ValidShopRule = _BuildEnumSet(StarTowerAutoDecision.ShopRule)
local ValidEventRule = _BuildEnumSet(StarTowerAutoDecision.EventRule)

local function _NormalizePriority(tbPriority, mapValidRule)
  local tbRet = {}
  local mapAdded = {}
  if not _IsTable(tbPriority) then
    return tbRet
  end
  for _, nRule in ipairs(tbPriority) do
    nRule = _ToNumber(nRule, 0)
    if mapValidRule[nRule] == true and mapAdded[nRule] ~= true then
      table.insert(tbRet, nRule)
      mapAdded[nRule] = true
    end
  end
  return tbRet
end

local function _RemoveFromArray(tbList, value)
  if not _IsTable(tbList) then
    return false
  end
  for i = #tbList, 1, -1 do
    if tbList[i] == value then
      table.remove(tbList, i)
      return true
    end
  end
  return false
end

local function _InsertUnique(tbList, value, nIndex)
  if not _IsTable(tbList) then
    return false
  end
  _RemoveFromArray(tbList, value)
  nIndex = _ToNumber(nIndex, #tbList + 1)
  if nIndex < 1 then
    nIndex = 1
  elseif nIndex > #tbList + 1 then
    nIndex = #tbList + 1
  end
  table.insert(tbList, nIndex, value)
  return true
end

local function _SortPlanList(tbPlanList)
  if not _IsTable(tbPlanList) then
    return
  end
  table.sort(tbPlanList, function(a, b)
    return _ToNumber(a and a.nPlanId, 0) < _ToNumber(b and b.nPlanId, 0)
  end)
end

local function _GetValueByPath(mapData, tbPath)
  local value = mapData
  if not _IsTable(tbPath) then
    return value
  end
  for _, key in ipairs(tbPath) do
    if not _IsTable(value) then
      return nil
    end
    value = value[key]
  end
  return value
end

local function _SetValueByPath(mapData, tbPath, value)
  if not (_IsTable(mapData) and _IsTable(tbPath)) or #tbPath <= 0 then
    return false
  end
  local mapTarget = mapData
  for i = 1, #tbPath - 1 do
    local key = tbPath[i]
    if not _IsTable(mapTarget[key]) then
      mapTarget[key] = {}
    end
    mapTarget = mapTarget[key]
  end
  mapTarget[tbPath[#tbPath]] = value
  return true
end

local function _IsArrayEqual(tbLeft, tbRight)
  if not _IsTable(tbLeft) or not _IsTable(tbRight) then
    return tbLeft == tbRight
  end
  if #tbLeft ~= #tbRight then
    return false
  end
  for i = 1, #tbLeft do
    if tbLeft[i] ~= tbRight[i] then
      return false
    end
  end
  return true
end

local function _IsOptionValueEqual(leftValue, rightValue, sType)
  if sType == OptionValueType.List then
    return _IsArrayEqual(leftValue or {}, rightValue or {})
  end
  return leftValue == rightValue
end

local function _GetListValue(mapList)
  if not _IsTable(mapList) then
    return {}
  end
  if _IsTable(mapList.Values) then
    return _CopyArray(mapList.Values)
  end
  if _IsTable(mapList.List) then
    return _CopyArray(mapList.List)
  end
  if _IsTable(mapList.Value) then
    return _CopyArray(mapList.Value)
  end
  return _CopyArray(mapList)
end

local function _GetServerOptionValue(mapOption, sType)
  if not _IsTable(mapOption) then
    return nil
  end
  local mapData = _IsTable(mapOption.Data) and mapOption.Data or mapOption
  if sType == OptionValueType.Boolean then
    return _ToBool(_GetField(mapData, "bValue", "Boolean", nil), false)
  elseif sType == OptionValueType.Integer then
    return _ToNumber(_GetField(mapData, "nValue", "Integer", nil), 0)
  elseif sType == OptionValueType.List then
    return _GetListValue(_GetField(mapData, "tbValue", "List", nil))
  end
end

local function _BuildServerOption(nOptionId, sType, value)
  local mapOption = {Id = nOptionId}
  if sType == OptionValueType.Boolean then
    mapOption.Boolean = value == true
  elseif sType == OptionValueType.Integer then
    mapOption.Integer = _ToNumber(value, 0)
  elseif sType == OptionValueType.List then
    mapOption.List = {
      Values = _CopyArray(value)
    }
  end
  return mapOption
end

local function _ParseDefaultOptionValue(sDefaultValue, sType)
  if sDefaultValue == nil or sDefaultValue == "" then
    return nil
  end
  local value = sDefaultValue
  if type(value) == "string" then
    value = decodeJson(value)
  end
  if sType == OptionValueType.Boolean then
    if type(value) == "boolean" then
      return value
    end
    if value == 0 then
      return false
    end
    if value == 1 then
      return true
    end
    return nil
  elseif sType == OptionValueType.Integer then
    if type(value) == "number" then
      return value
    end
    return nil
  elseif sType == OptionValueType.List then
    if not _IsTable(value) then
      return nil
    end
    local tbRet = {}
    for _, nValue in ipairs(value) do
      if type(nValue) ~= "number" then
        return nil
      end
      table.insert(tbRet, nValue)
    end
    return tbRet
  end
  return nil
end

local function _ApplyConfigDefaultValues(mapDefaultPlan)
  if not _IsTable(mapDefaultPlan) then
    return
  end
  for _, mapOptionConfig in ipairs(OptionConfig) do
    local mapOptionData = ConfigTable.GetData("TowerVitaOption", mapOptionConfig.nOptionId)
    local value = mapOptionData and _ParseDefaultOptionValue(mapOptionData.DefaultValue, mapOptionConfig.sType) or nil
    if value ~= nil then
      _SetValueByPath(mapDefaultPlan, mapOptionConfig.tbPath, value)
    else
    end
  end
end

function PlayerStarTowerAutoPlanData:Init()
  self.bGetData = false
  self.nSelectedPlanId = 1
  self.nMaxTokenCount = ConfigTable.GetConfigNumber("TowerVitaEnergyMax") or 0
  self.tbPlanList = {}
  self.mapPlanById = {}
  self.mapDirtyPlan = {}
  self.sDefaultPlanName = ConfigTable.GetUIText("AutoDecision_PlanDefaultName")
  self.mapDefaultPlan = {
    mapPotential = {
      bPresetFirst = true,
      bPresetOnly = false,
      tbPotentialSort = {},
      bPotentialReroll = true,
      nPotentialRerollCoinNum = 100
    },
    mapShop = {
      nShopFirst = StarTowerAutoDecision.ShopMode.BuyFirst,
      nShopUpgradePrice = 180,
      tbShopSort = {},
      bShopCoinReroll = true,
      nShopCoinNum = 800,
      bShopFinalReroll = true,
      bShopFinalAllIn = true
    },
    mapEvent = {
      nEventTendency = StarTowerAutoDecision.EventTendency.Standard,
      tbEventSort = {}
    }
  }
  _ApplyConfigDefaultValues(self.mapDefaultPlan)
end

function PlayerStarTowerAutoPlanData:UnInit()
  self.bGetData = false
  self.nSelectedPlanId = 1
  self.tbPlanList = {}
  self.mapPlanById = {}
  self.mapDirtyPlan = {}
end

function PlayerStarTowerAutoPlanData:ApplyServerOptions(mapPlan, tbOption)
  if not _IsTable(mapPlan) or not _IsTable(tbOption) then
    return mapPlan
  end
  for _, mapOption in ipairs(tbOption) do
    local nOptionId = _ToNumber(_GetField(mapOption, "nOptionId", "Id", nil), 0)
    local mapConfig = mapOptionConfigById[nOptionId]
    if mapConfig ~= nil then
      local value = _GetServerOptionValue(mapOption, mapConfig.sType)
      if value ~= nil then
        _SetValueByPath(mapPlan, mapConfig.tbPath, value)
      end
    end
  end
  return mapPlan
end

function PlayerStarTowerAutoPlanData:CreatePlanFromServerProject(mapProject, nFallbackPlanId)
  local nPlanId = _ToNumber(_GetField(mapProject, "nPlanId", "Id", nil), nFallbackPlanId or 1)
  local mapPlan = self:GetDefaultPlan(nPlanId)
  mapPlan.nSchemaVersion = _ToNumber(_GetField(mapProject, "nSchemaVersion", "SchemaVersion", nil), SCHEMA_VERSION)
  mapPlan.sName = tostring(_GetField(mapProject, "sName", "Name", mapPlan.sName))
  self:ApplyServerOptions(mapPlan, mapProject.Options or mapProject.tbOptions)
  return mapPlan
end

function PlayerStarTowerAutoPlanData:GetDefaultPlan(nPlanId)
  nPlanId = _ToNumber(nPlanId, 1)
  local mapPlan = _Clone(self.mapDefaultPlan or {})
  mapPlan.nSchemaVersion = SCHEMA_VERSION
  mapPlan.nPlanId = nPlanId
  mapPlan.sName = self.sDefaultPlanName .. nPlanId
  mapPlan.bEnabled = true
  return mapPlan
end

function PlayerStarTowerAutoPlanData:NormalizePlan(mapPlan, nFallbackPlanId)
  local mapDefault = self:GetDefaultPlan(nFallbackPlanId)
  if not _IsTable(mapPlan) then
    return mapDefault
  end
  if mapPlan.Options ~= nil or mapPlan.tbOptions ~= nil then
    mapPlan = self:CreatePlanFromServerProject(mapPlan, nFallbackPlanId)
  end
  local mapPotential = mapPlan.mapPotential or mapPlan.Potential or {}
  local mapShop = mapPlan.mapShop or mapPlan.Shop or {}
  local mapEvent = mapPlan.mapEvent or mapPlan.Event or {}
  local nPlanId = _ToNumber(_GetField(mapPlan, "nPlanId", "PlanId", mapPlan.Id), mapDefault.nPlanId)
  local mapRet = self:GetDefaultPlan(nPlanId)
  mapRet.nSchemaVersion = _ToNumber(_GetField(mapPlan, "nSchemaVersion", "SchemaVersion", nil), SCHEMA_VERSION)
  mapRet.sName = tostring(_GetField(mapPlan, "sName", "Name", mapRet.sName))
  mapRet.bEnabled = _ToBool(_GetField(mapPlan, "bEnabled", "Enabled", nil), mapRet.bEnabled)
  mapRet.mapPotential.bPresetFirst = _ToBool(_GetField(mapPotential, "bPresetFirst", "PresetFirst", mapPotential.bPreferPresetPotential), mapRet.mapPotential.bPresetFirst)
  mapRet.mapPotential.bPresetOnly = mapRet.mapPotential.bPresetFirst and _ToBool(_GetField(mapPotential, "bPresetOnly", "PresetOnly", nil), mapRet.mapPotential.bPresetOnly)
  mapRet.mapPotential.tbPotentialSort = _NormalizePriority(_GetField(mapPotential, "tbPotentialSort", "PotentialSort", mapPotential.tbRulePriority or mapPotential.RulePriority), ValidPotentialRule)
  mapRet.mapPotential.bPotentialReroll = _ToBool(_GetField(mapPotential, "bPotentialReroll", "PotentialReroll", mapPotential.bRerollWhenNoTarget), mapRet.mapPotential.bPotentialReroll)
  mapRet.mapPotential.nPotentialRerollCoinNum = _ToNumber(_GetField(mapPotential, "nPotentialRerollCoinNum", "PotentialRerollCoinNum", mapPotential.nRerollCoinMin), mapRet.mapPotential.nPotentialRerollCoinNum)
  mapRet.mapShop.nShopFirst = _ToNumber(_GetField(mapShop, "nShopFirst", "ShopFirst", mapShop.nMode), mapRet.mapShop.nShopFirst)
  if mapRet.mapShop.nShopFirst ~= StarTowerAutoDecision.ShopMode.BuyFirst and mapRet.mapShop.nShopFirst ~= StarTowerAutoDecision.ShopMode.UpgradeFirst then
    mapRet.mapShop.nShopFirst = StarTowerAutoDecision.ShopMode.BuyFirst
  end
  mapRet.mapShop.nShopUpgradePrice = _ToNumber(_GetField(mapShop, "nShopUpgradePrice", "ShopUpgradePrice", mapShop.nUpgradeMaxPrice), mapRet.mapShop.nShopUpgradePrice)
  mapRet.mapShop.tbShopSort = _NormalizePriority(_GetField(mapShop, "tbShopSort", "ShopSort", mapShop.tbRulePriority or mapShop.RulePriority), ValidShopRule)
  mapRet.mapShop.bShopCoinReroll = _ToBool(_GetField(mapShop, "bShopCoinReroll", "ShopCoinReroll", mapShop.bRerollWhenNoTarget), mapRet.mapShop.bShopCoinReroll)
  mapRet.mapShop.nShopCoinNum = _ToNumber(_GetField(mapShop, "nShopCoinNum", "ShopCoinNum", mapShop.nRerollCoinMin), mapRet.mapShop.nShopCoinNum)
  mapRet.mapShop.bShopFinalReroll = _ToBool(_GetField(mapShop, "bShopFinalReroll", "ShopFinalReroll", mapShop.bRerollWhenFinalNoTarget), mapRet.mapShop.bShopFinalReroll)
  mapRet.mapShop.bShopFinalAllIn = _ToBool(_GetField(mapShop, "bShopFinalAllIn", "ShopFinalAllIn", mapShop.bSpendAllWhenFinalNoTarget), mapRet.mapShop.bShopFinalAllIn)
  mapRet.mapEvent.nEventTendency = _ToNumber(_GetField(mapEvent, "nEventTendency", "EventTendency", mapEvent.nTendency), mapRet.mapEvent.nEventTendency)
  if mapRet.mapEvent.nEventTendency ~= StarTowerAutoDecision.EventTendency.Stable and mapRet.mapEvent.nEventTendency ~= StarTowerAutoDecision.EventTendency.Standard and mapRet.mapEvent.nEventTendency ~= StarTowerAutoDecision.EventTendency.Aggressive then
    mapRet.mapEvent.nEventTendency = StarTowerAutoDecision.EventTendency.Standard
  end
  mapRet.mapEvent.tbEventSort = _NormalizePriority(_GetField(mapEvent, "tbEventSort", "EventSort", mapEvent.tbRulePriority or mapEvent.RulePriority), ValidEventRule)
  return mapRet
end

function PlayerStarTowerAutoPlanData:CachePlanData(mapNetData)
  self.tbPlanList = {}
  self.mapPlanById = {}
  local tbPlan
  if _IsTable(mapNetData) then
    tbPlan = mapNetData.tbPlanList or mapNetData.Projects or mapNetData.Plans or mapNetData.List
    self.nSelectedPlanId = _ToNumber(_GetField(mapNetData, "nSelectedPlanId", "UseId", nil), self.nSelectedPlanId)
  end
  if _IsTable(tbPlan) then
    for nIndex, mapPlan in ipairs(tbPlan) do
      self:AddPlan(mapPlan, nil, true, nIndex)
    end
  end
  for nPlanId = 1, DEFAULT_PLAN_COUNT do
    if self.mapPlanById[nPlanId] == nil then
      self:AddPlan(self:GetDefaultPlan(nPlanId), nil, true)
    end
  end
  _SortPlanList(self.tbPlanList)
  if self.mapPlanById[self.nSelectedPlanId] == nil then
    self.nSelectedPlanId = self.tbPlanList[1] and self.tbPlanList[1].nPlanId or 1
  end
end

function PlayerStarTowerAutoPlanData:GetNextPlanId()
  local nNextPlanId = 1
  for _, mapPlan in ipairs(self.tbPlanList or {}) do
    local nPlanId = _ToNumber(mapPlan.nPlanId, 0)
    if nNextPlanId <= nPlanId then
      nNextPlanId = nPlanId + 1
    end
  end
  while self.mapPlanById[nNextPlanId] ~= nil do
    nNextPlanId = nNextPlanId + 1
  end
  return nNextPlanId
end

function PlayerStarTowerAutoPlanData:AddPlan(mapPlan, callback, bSilent, nFallbackPlanId)
  local nPlanId = nFallbackPlanId
  if _IsTable(mapPlan) then
    nPlanId = _ToNumber(_GetField(mapPlan, "nPlanId", "PlanId", mapPlan.Id), nFallbackPlanId or 0)
  end
  if nPlanId == nil or nPlanId <= 0 then
    nPlanId = self:GetNextPlanId()
  end
  local mapNewPlan = self:NormalizePlan(mapPlan, nPlanId)
  if self.mapPlanById[mapNewPlan.nPlanId] ~= nil then
    return self:UpdatePlan(mapNewPlan.nPlanId, mapNewPlan, callback, bSilent)
  end
  table.insert(self.tbPlanList, mapNewPlan)
  _SortPlanList(self.tbPlanList)
  self.mapPlanById[mapNewPlan.nPlanId] = mapNewPlan
  if not bSilent then
    self:MarkDirty(mapNewPlan.nPlanId)
    self:HitPlanChangeEvent(mapNewPlan.nPlanId)
  end
  if callback ~= nil then
    callback(true, _Clone(mapNewPlan))
  end
  return true, mapNewPlan
end

function PlayerStarTowerAutoPlanData:DeletePlan(nPlanId, callback, bSilent)
  nPlanId = _ToNumber(nPlanId, 0)
  if self.mapPlanById[nPlanId] == nil then
    if callback ~= nil then
      callback(false, "PlanNotFound")
    end
    return false
  end
  self.mapPlanById[nPlanId] = nil
  for i = #self.tbPlanList, 1, -1 do
    if self.tbPlanList[i].nPlanId == nPlanId then
      table.remove(self.tbPlanList, i)
      break
    end
  end
  if self.nSelectedPlanId == nPlanId then
    self.nSelectedPlanId = self.tbPlanList[1] and self.tbPlanList[1].nPlanId or 1
  end
  if not bSilent then
    self:MarkDirty(nPlanId, true)
    self:HitPlanChangeEvent(nPlanId)
  end
  if callback ~= nil then
    callback(true)
  end
  return true
end

function PlayerStarTowerAutoPlanData:UpdatePlan(nPlanId, mapPlan, callback, bSilent)
  nPlanId = _ToNumber(nPlanId, 0)
  if self.mapPlanById[nPlanId] == nil then
    if callback ~= nil then
      callback(false, "PlanNotFound")
    end
    return false
  end
  local mapNewPlan = self:NormalizePlan(mapPlan, nPlanId)
  mapNewPlan.nPlanId = nPlanId
  for i, mapOldPlan in ipairs(self.tbPlanList) do
    if mapOldPlan.nPlanId == nPlanId then
      self.tbPlanList[i] = mapNewPlan
      break
    end
  end
  self.mapPlanById[nPlanId] = mapNewPlan
  if not bSilent then
    self:MarkDirty(nPlanId)
    self:HitPlanChangeEvent(nPlanId)
  end
  if callback ~= nil then
    callback(true, _Clone(mapNewPlan))
  end
  return true, mapNewPlan
end

function PlayerStarTowerAutoPlanData:ResetPlan(nPlanId, callback, bSilent)
  nPlanId = _ToNumber(nPlanId, self.nSelectedPlanId)
  return self:UpdatePlan(nPlanId, self:GetDefaultPlan(nPlanId), callback, bSilent)
end

function PlayerStarTowerAutoPlanData:GetPlanById(nPlanId, bRaw)
  local mapPlan = self.mapPlanById[_ToNumber(nPlanId, 0)]
  if bRaw then
    return mapPlan
  end
  return _Clone(mapPlan)
end

function PlayerStarTowerAutoPlanData:GetPlanList(bRaw)
  if bRaw then
    return self.tbPlanList
  end
  return _Clone(self.tbPlanList)
end

function PlayerStarTowerAutoPlanData:GetSelectedPlanId()
  return self.nSelectedPlanId
end

function PlayerStarTowerAutoPlanData:GetSelectedPlan(bRaw)
  return self:GetPlanById(self.nSelectedPlanId, bRaw)
end

function PlayerStarTowerAutoPlanData:SelectPlan(nPlanId, callback, bSilent)
  nPlanId = _ToNumber(nPlanId, 0)
  if self.mapPlanById[nPlanId] == nil then
    if callback ~= nil then
      callback(false, "PlanNotFound")
    end
    return false
  end
  self.nSelectedPlanId = nPlanId
  if not bSilent then
    self:MarkDirty(0)
    self:HitPlanChangeEvent(nPlanId)
  end
  if callback ~= nil then
    callback(true, nPlanId)
  end
  return true
end

function PlayerStarTowerAutoPlanData:SetPlanName(nPlanId, sName, callback)
  return self:SetPlanField(nPlanId, {"sName"}, tostring(sName or ""), callback)
end

function PlayerStarTowerAutoPlanData:SetPlanField(nPlanId, tbPath, value, callback, bSilent)
  local mapPlan = self:GetPlanById(nPlanId, true)
  if not (mapPlan ~= nil and _IsTable(tbPath)) or #tbPath <= 0 then
    if callback ~= nil then
      callback(false, "InvalidParam")
    end
    return false
  end
  local mapTarget = mapPlan
  for i = 1, #tbPath - 1 do
    local key = tbPath[i]
    if not _IsTable(mapTarget[key]) then
      mapTarget[key] = {}
    end
    mapTarget = mapTarget[key]
  end
  mapTarget[tbPath[#tbPath]] = value
  return self:UpdatePlan(nPlanId, mapPlan, callback, bSilent)
end

function PlayerStarTowerAutoPlanData:GetPlanField(nPlanId, tbPath)
  local value = self:GetPlanById(nPlanId, true)
  if not _IsTable(tbPath) then
    return _Clone(value)
  end
  for _, key in ipairs(tbPath) do
    if not _IsTable(value) then
      return nil
    end
    value = value[key]
  end
  return _Clone(value)
end

function PlayerStarTowerAutoPlanData:SetRulePriority(nPlanId, sGroup, tbRulePriority, callback)
  local mapPlan = self:GetPlanById(nPlanId, true)
  local mapGroup, mapValidRule = self:GetRuleGroup(mapPlan, sGroup)
  if mapGroup == nil then
    if callback ~= nil then
      callback(false, "InvalidGroup")
    end
    return false
  end
  self:SetRulePriorityList(mapGroup, sGroup, _NormalizePriority(tbRulePriority, mapValidRule))
  return self:UpdatePlan(nPlanId, mapPlan, callback)
end

function PlayerStarTowerAutoPlanData:AddRule(nPlanId, sGroup, nRule, nIndex, callback)
  local mapPlan = self:GetPlanById(nPlanId, true)
  local mapGroup, mapValidRule = self:GetRuleGroup(mapPlan, sGroup)
  nRule = _ToNumber(nRule, 0)
  if mapGroup == nil or mapValidRule[nRule] ~= true then
    if callback ~= nil then
      callback(false, "InvalidRule")
    end
    return false
  end
  _InsertUnique(self:GetRulePriorityList(mapGroup, sGroup), nRule, nIndex)
  return self:UpdatePlan(nPlanId, mapPlan, callback)
end

function PlayerStarTowerAutoPlanData:RemoveRule(nPlanId, sGroup, nRule, callback)
  local mapPlan = self:GetPlanById(nPlanId, true)
  local mapGroup = self:GetRuleGroup(mapPlan, sGroup)
  if mapGroup == nil then
    if callback ~= nil then
      callback(false, "InvalidGroup")
    end
    return false
  end
  _RemoveFromArray(self:GetRulePriorityList(mapGroup, sGroup), _ToNumber(nRule, 0))
  return self:UpdatePlan(nPlanId, mapPlan, callback)
end

function PlayerStarTowerAutoPlanData:MoveRule(nPlanId, sGroup, nRule, nIndex, callback)
  return self:AddRule(nPlanId, sGroup, nRule, nIndex, callback)
end

function PlayerStarTowerAutoPlanData:GetRuleGroup(mapPlan, sGroup)
  if not _IsTable(mapPlan) then
    return nil
  end
  if sGroup == "Potential" or sGroup == "potential" or sGroup == "mapPotential" then
    return mapPlan.mapPotential, ValidPotentialRule
  elseif sGroup == "Shop" or sGroup == "shop" or sGroup == "mapShop" then
    return mapPlan.mapShop, ValidShopRule
  elseif sGroup == "Event" or sGroup == "event" or sGroup == "mapEvent" then
    return mapPlan.mapEvent, ValidEventRule
  end
end

function PlayerStarTowerAutoPlanData:GetRulePriorityList(mapGroup, sGroup)
  if not _IsTable(mapGroup) then
    return nil
  end
  if sGroup == "Potential" or sGroup == "potential" or sGroup == "mapPotential" then
    mapGroup.tbPotentialSort = mapGroup.tbPotentialSort or {}
    return mapGroup.tbPotentialSort
  elseif sGroup == "Shop" or sGroup == "shop" or sGroup == "mapShop" then
    mapGroup.tbShopSort = mapGroup.tbShopSort or {}
    return mapGroup.tbShopSort
  elseif sGroup == "Event" or sGroup == "event" or sGroup == "mapEvent" then
    mapGroup.tbEventSort = mapGroup.tbEventSort or {}
    return mapGroup.tbEventSort
  end
end

function PlayerStarTowerAutoPlanData:SetRulePriorityList(mapGroup, sGroup, tbRulePriority)
  if sGroup == "Potential" or sGroup == "potential" or sGroup == "mapPotential" then
    mapGroup.tbPotentialSort = tbRulePriority
  elseif sGroup == "Shop" or sGroup == "shop" or sGroup == "mapShop" then
    mapGroup.tbShopSort = tbRulePriority
  elseif sGroup == "Event" or sGroup == "event" or sGroup == "mapEvent" then
    mapGroup.tbEventSort = tbRulePriority
  end
end

function PlayerStarTowerAutoPlanData:BuildDecisionPlan(mapPlanOrId)
  local mapPlan = mapPlanOrId
  if type(mapPlanOrId) == "number" then
    mapPlan = self:GetPlanById(mapPlanOrId, true)
  end
  mapPlan = self:NormalizePlan(mapPlan, self.nSelectedPlanId)
  return {
    bEnabled = mapPlan.bEnabled,
    bPreferPresetPotential = mapPlan.mapPotential.bPresetFirst,
    bPresetOnly = mapPlan.mapPotential.bPresetOnly,
    tbPotentialRulePriority = _CopyArray(mapPlan.mapPotential.tbPotentialSort),
    bPotentialReroll = mapPlan.mapPotential.bPotentialReroll,
    nPotentialRerollCoinMin = mapPlan.mapPotential.nPotentialRerollCoinNum,
    nShopMode = mapPlan.mapShop.nShopFirst,
    tbShopRulePriority = _CopyArray(mapPlan.mapShop.tbShopSort),
    nShopRerollCoinMin = mapPlan.mapShop.nShopCoinNum,
    nShopUpgradeMaxPrice = mapPlan.mapShop.nShopUpgradePrice,
    bShopRerollWhenNoTarget = mapPlan.mapShop.bShopCoinReroll,
    bShopRerollWhenFinalNoTarget = mapPlan.mapShop.bShopFinalReroll,
    bShopSpendAllWhenFinalNoTarget = mapPlan.mapShop.bShopFinalAllIn,
    nEventTendency = mapPlan.mapEvent.nEventTendency,
    tbEventRulePriority = _CopyArray(mapPlan.mapEvent.tbEventSort)
  }
end

function PlayerStarTowerAutoPlanData:GetSelectedDecisionPlan()
  return self:BuildDecisionPlan(self.nSelectedPlanId)
end

function PlayerStarTowerAutoPlanData:CreatePlanFromDecisionPlan(nPlanId, mapDecisionPlan, sName)
  mapDecisionPlan = mapDecisionPlan or {}
  return self:NormalizePlan({
    nPlanId = nPlanId,
    sName = sName,
    bEnabled = mapDecisionPlan.bEnabled,
    mapPotential = {
      bPresetFirst = mapDecisionPlan.mapPotential.bPresetFirst,
      bPresetOnly = mapDecisionPlan.mapPotential.bPresetOnly,
      tbPotentialSort = mapDecisionPlan.mapPotential.tbPotentialSort,
      bPotentialReroll = mapDecisionPlan.mapPotential.bPotentialReroll,
      nPotentialRerollCoinNum = mapDecisionPlan.mapPotential.nPotentialRerollCoinNum
    },
    mapShop = {
      nShopFirst = mapDecisionPlan.mapShop.nShopFirst,
      tbShopSort = mapDecisionPlan.mapShop.tbShopSort,
      nShopCoinNum = mapDecisionPlan.mapShop.nShopCoinNum,
      nShopUpgradePrice = mapDecisionPlan.mapShop.nShopUpgradePrice,
      bShopCoinReroll = mapDecisionPlan.mapShop.bShopCoinReroll,
      bShopFinalReroll = mapDecisionPlan.mapShop.bShopFinalReroll,
      bShopFinalAllIn = mapDecisionPlan.mapShop.bShopFinalAllIn
    },
    mapEvent = {
      nEventTendency = mapDecisionPlan.mapEvent.nEventTendency,
      tbEventSort = mapDecisionPlan.mapEvent.tbEventSort
    }
  }, nPlanId)
end

function PlayerStarTowerAutoPlanData:UpdatePlanFromDecisionPlan(nPlanId, mapDecisionPlan, callback)
  local mapOldPlan = self:GetPlanById(nPlanId, true)
  local sName = mapDecisionPlan and mapDecisionPlan.sName or mapOldPlan and mapOldPlan.sName or nil
  return self:UpdatePlan(nPlanId, self:CreatePlanFromDecisionPlan(nPlanId, mapDecisionPlan, sName), callback)
end

function PlayerStarTowerAutoPlanData:BuildServerPlan(mapPlanOrId)
  local mapPlan = mapPlanOrId
  if type(mapPlanOrId) == "number" then
    mapPlan = self:GetPlanById(mapPlanOrId, true)
  end
  mapPlan = self:NormalizePlan(mapPlan, self.nSelectedPlanId)
  local mapDefault = self:GetDefaultPlan(mapPlan.nPlanId)
  local tbOptions = {}
  for _, mapConfig in ipairs(OptionConfig) do
    local value = _GetValueByPath(mapPlan, mapConfig.tbPath)
    local defaultValue = _GetValueByPath(mapDefault, mapConfig.tbPath)
    if not _IsOptionValueEqual(value, defaultValue, mapConfig.sType) then
      table.insert(tbOptions, _BuildServerOption(mapConfig.nOptionId, mapConfig.sType, value))
    end
  end
  table.sort(tbOptions, function(a, b)
    return _ToNumber(a and a.Id, 0) < _ToNumber(b and b.Id, 0)
  end)
  return {
    Id = mapPlan.nPlanId,
    Name = mapPlan.sName,
    Options = tbOptions
  }
end

function PlayerStarTowerAutoPlanData:BuildServerProject(mapPlanOrId)
  return self:BuildServerPlan(mapPlanOrId)
end

function PlayerStarTowerAutoPlanData:MarkDirty(nPlanId, bDelete)
  self.mapDirtyPlan[nPlanId] = {
    nPlanId = nPlanId,
    bDelete = bDelete == true
  }
end

function PlayerStarTowerAutoPlanData:ClearDirty(nPlanId)
  if nPlanId == nil then
    self.mapDirtyPlan = {}
    return
  end
  self.mapDirtyPlan[nPlanId] = nil
end

function PlayerStarTowerAutoPlanData:IsDirty(nPlanId)
  if nPlanId == nil then
    return next(self.mapDirtyPlan) ~= nil
  end
  return self.mapDirtyPlan[nPlanId] ~= nil
end

function PlayerStarTowerAutoPlanData:HitPlanChangeEvent(nPlanId)
  EventManager.Hit("StarTowerAutoPlanChange", nPlanId)
end

function PlayerStarTowerAutoPlanData:IsInited()
  return self.bGetData
end

function PlayerStarTowerAutoPlanData:EnsureInited(callback)
  if self:IsInited() then
    if callback ~= nil then
      callback(true, self:GetPlanList())
    end
    return true
  end
  return self:SendGetPlanList(callback, false)
end

function PlayerStarTowerAutoPlanData:SendGetPlanList(callback, bForce)
  if self.bGetData and bForce ~= true then
    if callback ~= nil then
      callback(true, self:GetPlanList())
    end
    return true
  end
  
  local function netCallback(_, mapNetData)
    self.bGetData = true
    self:CachePlanData(mapNetData)
    self:ClearDirty()
    if callback ~= nil then
      callback(true, self:GetPlanList(), mapNetData)
    end
    self:HitPlanChangeEvent(self.nSelectedPlanId)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_vita_project_list_req, {}, nil, netCallback)
  return true
end

function PlayerStarTowerAutoPlanData:SendUpdatePlan(nPlanId, callback)
  nPlanId = _ToNumber(nPlanId, self.nSelectedPlanId)
  local mapPlan = self:GetPlanById(nPlanId, true)
  if mapPlan == nil then
    if callback ~= nil then
      callback(false, "PlanNotFound")
    end
    return false
  end
  local nMsgId = NetMsgId.Id.tower_vita_project_update_req
  if nMsgId == nil then
    if callback ~= nil then
      callback(false, "NetMsgMissing")
    end
    return false
  end
  local msgData = {
    Projects = self:BuildServerProject(mapPlan)
  }
  
  local function netCallback(_, mapNetData)
    local mapProject = _IsTable(mapNetData) and mapNetData.Projects or nil
    if _IsTable(mapProject) then
      local nResponsePlanId = _ToNumber(mapProject.Id, nPlanId)
      if nResponsePlanId ~= nPlanId then
        if callback ~= nil then
          callback(false, "ProjectIdMismatch")
        end
        return
      end
      self:UpdatePlan(nPlanId, mapProject, nil, true)
    end
    self:ClearDirty(nPlanId)
    if callback ~= nil then
      callback(true, self:GetPlanById(nPlanId), mapNetData)
    end
    self:HitPlanChangeEvent(nPlanId)
  end
  
  HttpNetHandler.SendMsg(nMsgId, msgData, nil, netCallback)
  return true
end

function PlayerStarTowerAutoPlanData:SendRenamePlan(nPlanId, sName, callback)
  local function cb()
    local thisPlan = self:GetPlanById(nPlanId, true)
    
    if thisPlan ~= nil then
      thisPlan.sName = sName
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_vita_project_name_update_req, {Id = nPlanId, Name = sName}, nil, cb)
end

function PlayerStarTowerAutoPlanData:SyncDirtyPlans(callback)
  local tbDirty = {}
  for _, mapDirty in pairs(self.mapDirtyPlan) do
    table.insert(tbDirty, mapDirty)
  end
  if #tbDirty <= 0 then
    if callback ~= nil then
      callback(true)
    end
    return true
  end
  local nTotal = #tbDirty
  local nFinish = 0
  local bAllSuccess = true
  local sFailedReason
  
  local function oneCallback(bSuccess, sReason)
    nFinish = nFinish + 1
    if bSuccess ~= true then
      bAllSuccess = false
      sFailedReason = sFailedReason or sReason
    end
    if nFinish >= nTotal and callback ~= nil then
      callback(bAllSuccess, sFailedReason)
    end
  end
  
  for _, mapDirty in ipairs(tbDirty) do
    if mapDirty.nPlanId == 0 then
      self:ClearDirty(0)
      oneCallback(true)
    elseif mapDirty.bDelete then
      oneCallback(false, "DeleteNotSupported")
    else
      self:SendUpdatePlan(mapDirty.nPlanId, oneCallback)
    end
  end
  return true
end

function PlayerStarTowerAutoPlanData:GetTokenCount()
  return PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.AutoDecisionToken) or 0
end

function PlayerStarTowerAutoPlanData:GetMaxTokenCount()
  return self.nMaxTokenCount
end

function PlayerStarTowerAutoPlanData:SendTokenBuy(nTokenCount, callback)
  local function cb(_, mapNetData)
    if mapNetData.Change ~= nil then
      HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapNetData.Change))
    end
    if callback ~= nil then
      callback(true, mapNetData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_vita_energy_buy_req, {Value = nTokenCount}, nil, cb)
end

function PlayerStarTowerAutoPlanData:SendSetSelectedPlanId(nPlanId, callback)
  local function cb(_, mapNetData)
    self.nSelectedPlanId = nPlanId
    
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.tower_vita_project_set_req, {Id = nPlanId}, nil, cb)
end

return PlayerStarTowerAutoPlanData
