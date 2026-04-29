_class("UIEducationData", Object)
UIEducationData = UIEducationData
local UIEducationDataEnum = {
  Reason_CanUp = 0,
  Reason_Asset = 1,
  Reason_Condition = 2,
  Reason_Full = 3
}
_enum("UIEducationDataEnum", UIEducationDataEnum)

function UIEducationData:Constructor()
  self._list = nil
  self._smelt = nil
  self._one = nil
  self:Init()
end

function UIEducationData:Dispose()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._callbackItemChanged)
end

function UIEducationData:Init()
  local lstName = {
    [ElementType.ElementType_Blue] = "str_education_main_blue_name",
    [ElementType.ElementType_Red] = "str_education_main_red_name",
    [ElementType.ElementType_Green] = "str_education_main_green_name",
    [ElementType.ElementType_Yellow] = "str_education_main_yellow_name"
  }
  local petElementName = self:GetPetElementName()
  self._list = {
    [ElementType.ElementType_Blue] = {},
    [ElementType.ElementType_Red] = {},
    [ElementType.ElementType_Green] = {},
    [ElementType.ElementType_Yellow] = {}
  }
  local allCfg = Cfg.cfg_pet_property_cultivate({})
  for k, v in pairs(allCfg) do
    table.insert(self._list[v.ElementType], v)
  end
  for k, v in pairs(self._list) do
    table.sort(v, function(a, b)
      local aKey = self:LevelKey(a.Phase, a.Level)
      local bKey = self:LevelKey(b.Phase, b.Level)
      return aKey < bKey
    end)
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local dataProperty = petModule:GetPropertyCultivateData()
  local elements = {}
  for k, v in pairs(lstName) do
    local stage = 0
    local level = 0
    if dataProperty[k] ~= nil then
      stage = dataProperty[k].phase
      level = dataProperty[k].lv
    end
    elements[k] = UIEducationDataElement:New(self, k, v, petElementName[k])
    elements[k]:SetCurrentLevel(stage, level)
    Log.info("[UIEducationData] elementType, stage, level ->: ", k, stage, level)
  end
  self._list = elements
  self._callbackItemChanged = GameHelper:GetInstance():CreateCallback(self.OnItemCountChanged, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._callbackItemChanged)
end

function UIEducationData:OnItemCountChanged()
  self:SetRedDirty(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EducationChanged, true)
end

function UIEducationData:SetRedDirty(redDirty)
  for k, v in pairs(self._list) do
    v:SetRedDirty(redDirty)
  end
end

function UIEducationData:TestCondition()
  for k, v in pairs(self._list) do
    v:TestCondition()
  end
end

function UIEducationData:GetPetElementName(elementType)
  if self._petElementName == nil then
    UIEducationData._petElementName = {
      [ElementType.ElementType_Blue] = "str_pet_element_name_blue",
      [ElementType.ElementType_Red] = "str_pet_element_name_red",
      [ElementType.ElementType_Green] = "str_pet_element_name_green",
      [ElementType.ElementType_Yellow] = "str_pet_element_name_yellow",
      [ElementType.ElementType_None] = "str_education_upstage_condition_anytower",
      [ElementType.ElementType_Any] = "str_education_upstage_condition_anytower"
    }
  end
  if elementType ~= nil then
    return StringTable.Get(self._petElementName[elementType])
  else
    return self._petElementName
  end
end

function UIEducationData:Get(elementType)
  if elementType == nil then
    return self._list
  else
    return self._list[elementType]
  end
  return self._list[elementType]
end

function UIEducationData:LevelKey(idStage, idLevel)
  return idStage * 100000 + idLevel
end

function UIEducationData:EmptyCfg(elementType)
  return {
    ID = 0,
    ElementType = elementType,
    Phase = 1,
    Level = 0,
    NeedItem = nil,
    Attack = 0,
    Defence = 0,
    Health = 0,
    Hit = 0,
    Doge = 0,
    Crit = 0,
    CritHurt = 0,
    PropertyRestraint = 0,
    MainSkillDamage = 0,
    OpenCondition = nil,
    SupplyPieceWeight = nil
  }
end

function UIEducationData:HasRed()
  local hasRed = false
  local list = self:Get()
  for k, v in pairs(list) do
    hasRed = hasRed or v:HasRed()
  end
  return hasRed
end

function UIEducationData:SmeltCost(idAsset, count)
  if self._smelt == nil then
    self._smelt = UIEducationDataSmelt:New(true)
  end
  self._smelt:ClearCost()
  return self._smelt:SmeltCost(idAsset, count)
end

function UIEducationData:GetSmeltCost()
  return self._smelt:GetCost()
end

function UIEducationData:GetSmeltResult()
  return self._smelt:GetResult()
end

function UIEducationData:TryLevelUp(theElement)
  local ret = self._one:OneRet(theElement:ElementType())
  if ret:GetReason() ~= UIEducationDataEnum.Reason_CanUp then
    return false, ret
  end
  local curIndex = ret:GetIndex()
  local maxIndex = theElement:GetDataLevelCount()
  local nxtIndex = math.min(curIndex + 1, maxIndex)
  if nxtIndex == curIndex then
    return false, ret:SetReason(UIEducationDataEnum.Reason_Full)
  end
  local nxtDataLevel = theElement:GetDataLevel(nxtIndex)
  if not nxtDataLevel:IsMetCondition() then
    return false, ret:SetReason(UIEducationDataEnum.Reason_Condition)
  end
  local trace = UIEducationDataSmelt:New()
  trace:ReplaceItem(self._one)
  local needGold = nxtDataLevel:NeedGold()
  local needAssets = nxtDataLevel:NeedAsset(true)
  local haveCount = 0
  local needCount = 0
  if needGold ~= nil then
    haveCount = trace:AfterSmeltCount(needGold.assetid)
    needCount = needGold.count
  end
  if haveCount < needCount then
    return false, ret:SetReason(UIEducationDataEnum.Reason_Asset)
  elseif 0 < needCount then
    trace:AddCost(needGold.assetid, needCount)
  end
  local needAssetCount = 0
  if needAssets ~= nil then
    needAssetCount = #needAssets
  end
  for i = 1, needAssetCount do
    local needAsset = needAssets[i]
    local haveCount = trace:AfterSmeltCount(needAsset.assetid)
    local needCount = needAsset.count
    if haveCount >= needCount then
      trace:AddCost(needAsset.assetid, needCount)
    else
      trace:AddCost(needAsset.assetid, haveCount)
      needCount = needCount - haveCount
      self._smelt:ClearCost()
      self._smelt:ReplaceItem(trace)
      local smeltResult = self._smelt:SmeltCost(needAsset.assetid, needCount)
      if smeltResult then
        trace:AppendSmelt(self._smelt, true)
      else
        return false, ret:SetReason(UIEducationDataEnum.Reason_Asset)
      end
    end
  end
  ret:SetIndex(curIndex + 1)
  self._one:AppendSmelt(trace, true)
  return true, ret
end

function UIEducationData:One()
  if self._smelt == nil then
    self._smelt = UIEducationDataSmelt:New(true)
  end
  if self._one == nil then
    self._one = UIEducationDataOne:New()
  end
  self._smelt:ClearCost()
  self._one:ClearCost()
  self._one:InitRet(self._list)
  local sortLevel = {}
  for k, v in pairs(self._list) do
    table.insert(sortLevel, v)
  end
  table.sort(sortLevel, function(a, b)
    return a:GetCurrentLuaIndex() > b:GetCurrentLuaIndex()
  end)
  local refType = ElementType.ElementType_Green
  while 0 < refType do
    local elementRef = sortLevel[refType]
    local oneRetRef = self._one:OneRet(elementRef:ElementType())
    local elementNxt = sortLevel[refType + 1]
    local oneRetNxt = self._one:OneRet(elementNxt:ElementType())
    local endCount = 0
    local nxtCount = ElementType.ElementType_Yellow - refType
    local sortElement = {}
    for i = refType + 1, ElementType.ElementType_Yellow do
      table.insert(sortElement, sortLevel[i])
    end
    table.sort(sortElement, function(a, b)
      return a:ElementType() < b:ElementType()
    end)
    while oneRetRef:GetIndex() > oneRetNxt:GetIndex() do
      endCount = 0
      for i = 1, ElementType.ElementType_Yellow - refType do
        local elementValue = sortElement[i]
        local result, oneRetValue = self:TryLevelUp(elementValue)
        if oneRetValue:GetReason() ~= UIEducationDataEnum.Reason_CanUp then
          endCount = endCount + 1
        elseif oneRetRef:GetIndex() <= oneRetValue:GetIndex() then
          endCount = endCount + 1
        end
      end
      if nxtCount <= endCount then
        break
      end
    end
    refType = refType - 1
  end
  local endCount = 0
  local nxtCount = ElementType.ElementType_Yellow
  while endCount < nxtCount do
    endCount = 0
    for k, v in pairs(self._list) do
      local elementValue = v
      local result, oneRetValue = self:TryLevelUp(elementValue)
      if oneRetValue:GetReason() ~= UIEducationDataEnum.Reason_CanUp then
        endCount = endCount + 1
      end
    end
  end
  for k, v in pairs(self._list) do
    local elementValue = v
    local oneRetValue = self._one:OneRet(elementValue:ElementType())
    local dataLevel = elementValue:GetDataLevel(oneRetValue:GetIndex())
    oneRetValue:SetStage(dataLevel:GetStage())
    oneRetValue:SetLevel(dataLevel:GetLevel())
  end
  return self._one
end

_class("UIEducationDataSmelt", Object)
UIEducationDataSmelt = UIEducationDataSmelt

function UIEducationDataSmelt:Constructor(initSmelt)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._aircraftModule = nil
  self._room = nil
  self._map = {}
  self._lstRet = {}
  self._dicRet = {}
  self._cost = {}
  self._surplus = {}
  if initSmelt then
    self:InitSmelt()
  end
end

function UIEducationDataSmelt:InitSmelt()
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self._room = self._aircraftModule:GetRoomByRoomType(AirRoomType.SmeltRoom)
  local allSmelt = Cfg.cfg_item_smelt({})
  for k, v in pairs(allSmelt) do
    if v.Output ~= nil and #v.Output >= 2 then
      local idAsset = v.Output[1]
      self._map[idAsset] = v
    end
  end
end

function UIEducationDataSmelt:ClearCost()
  self._lstRet = {}
  self._dicRet = {}
  self._cost = {}
  self._surplus = {}
end

function UIEducationDataSmelt:GetCost()
  return self._cost
end

function UIEducationDataSmelt:GetSurplus()
  return self._surplus
end

function UIEducationDataSmelt:GetResult()
  return self._lstRet
end

function UIEducationDataSmelt:AddResult(idSmelt, count)
  if count <= 0 then
    return
  end
  local asset = self._dicRet[idSmelt]
  if asset == nil then
    asset = RoleAsset:New()
    asset.assetid = idSmelt
    asset.count = 0
    table.insert(self._lstRet, asset)
    self._dicRet[idSmelt] = asset
  end
  asset.count = asset.count + count
end

function UIEducationDataSmelt:AddCost(idAsset, count)
  if count <= 0 then
    return
  end
  local asset = self._surplus[idAsset]
  if asset ~= nil then
    local min = math.min(asset.count, count)
    count = count - min
    asset.count = asset.count - min
  end
  if count <= 0 then
    return
  end
  local asset = self._cost[idAsset]
  if asset == nil then
    asset = RoleAsset:New()
    asset.assetid = idAsset
    asset.count = 0
    self._cost[idAsset] = asset
  end
  asset.count = asset.count + count
end

function UIEducationDataSmelt:AddSurplus(idAsset, count)
  if count <= 0 then
    return
  end
  local asset = self._surplus[idAsset]
  if asset == nil then
    asset = RoleAsset:New()
    asset.assetid = idAsset
    asset.count = 0
    self._surplus[idAsset] = asset
  end
  asset.count = asset.count + count
end

function UIEducationDataSmelt:AppendSmelt(other, swapItem)
  for k, v in pairs(other._lstRet) do
    self:AddResult(v.assetid, v.count)
  end
  if swapItem then
    local tmp = self._cost
    self._cost = other._cost
    other._cost = tmp
    local tmp = self._surplus
    self._surplus = other._surplus
    other._surplus = tmp
  else
    self:ReplaceItem(other)
  end
end

function UIEducationDataSmelt:ReplaceItem(other)
  self._cost = {}
  self._surplus = {}
  for k, v in pairs(other._cost) do
    local asset = RoleAsset:New()
    asset.assetid = v.assetid
    asset.count = v.count
    self._cost[k] = asset
  end
  for k, v in pairs(other._surplus) do
    local asset = RoleAsset:New()
    asset.assetid = v.assetid
    asset.count = v.count
    self._surplus[k] = asset
  end
end

function UIEducationDataSmelt:AfterSmeltCount(idAsset)
  local costCount = 0
  local surplusCount = 0
  local haveCount = self._itemModule:GetItemCount(idAsset)
  local asset = self._cost[idAsset]
  if asset ~= nil then
    costCount = asset.count
  end
  local asset = self._surplus[idAsset]
  if asset ~= nil then
    surplusCount = asset.count
  end
  return math.max(haveCount + surplusCount - costCount, 0)
end

function UIEducationDataSmelt:SmeltCost(idAsset, count)
  local needCount = count
  local haveCount = self:AfterSmeltCount(idAsset)
  if needCount <= haveCount then
    self:AddCost(idAsset, needCount)
    return true, self._cost, self._lstRet
  else
    self:AddCost(idAsset, haveCount)
    needCount = needCount - haveCount
  end
  local cfgSmelt = self._map[idAsset]
  if cfgSmelt == nil then
    return false
  end
  if self._room == nil then
    self._room = self._aircraftModule:GetRoomByRoomType(AirRoomType.SmeltRoom)
  end
  if self._aircraftModule:IsSmeltItemLockEx(self._room, cfgSmelt) then
    return false
  end
  local multiple = math.ceil(needCount / cfgSmelt.Output[2])
  if cfgSmelt.SInput ~= nil then
    for k, v in pairs(cfgSmelt.SInput) do
      local costItem = v[1]
      local costCount = v[2] * multiple
      local haveCount = self:AfterSmeltCount(costItem)
      if costCount <= haveCount then
        self:AddCost(costItem, costCount)
      else
        return false
      end
    end
  end
  if cfgSmelt.Input ~= nil then
    for k, v in pairs(cfgSmelt.Input) do
      local costItem = v[1]
      local costCount = v[2] * multiple
      local result = self:SmeltCost(costItem, costCount)
      if not result then
        return false
      end
    end
    local surplusCount = cfgSmelt.Output[2] * multiple - needCount
    self:AddResult(cfgSmelt.ID, multiple)
    self:AddSurplus(idAsset, surplusCount)
    return true, self._cost, self._lstRet
  else
    return false
  end
  return false
end

_class("UIEducationDataCurLevel", Object)
UIEducationDataCurLevel = UIEducationDataCurLevel

function UIEducationDataCurLevel:Constructor()
  self._stage = 0
  self._level = 0
  self._index = 1
  self._reason = UIEducationDataEnum.Reason_CanUp
end

function UIEducationDataCurLevel:GetStage()
  return self._stage
end

function UIEducationDataCurLevel:SetStage(stage)
  self._stage = stage
  return self._stage
end

function UIEducationDataCurLevel:GetLevel()
  return self._level
end

function UIEducationDataCurLevel:SetLevel(level)
  self._level = level
  return self._level
end

function UIEducationDataCurLevel:GetIndex()
  return self._index
end

function UIEducationDataCurLevel:SetIndex(index)
  self._index = index
  return self._index
end

function UIEducationDataCurLevel:GetReason()
  return self._reason
end

function UIEducationDataCurLevel:SetReason(reason)
  self._reason = reason
  return self
end

_class("UIEducationDataOne", UIEducationDataSmelt)
UIEducationDataOne = UIEducationDataOne

function UIEducationDataOne:Constructor()
  self._oneRet = {}
  self:InitRet(nil)
end

function UIEducationDataOne:InitRet(lstElement)
  for i = 1, ElementType.ElementType_Yellow do
    self._oneRet[i] = UIEducationDataCurLevel:New()
  end
  if lstElement ~= nil then
    for i = 1, ElementType.ElementType_Yellow do
      local luaIndex = lstElement[i]:GetCurrentLuaIndex()
      self._oneRet[i]:SetIndex(luaIndex)
    end
  end
end

function UIEducationDataOne:OneRet(elementType)
  return self._oneRet[elementType]
end

_class("UIEducationDataLevel", Object)
UIEducationDataLevel = UIEducationDataLevel

function UIEducationDataLevel:Constructor(element, luaIndex)
  self._element = element
  self._luaIndex = luaIndex
  self._cfg = nil
  self._lstCondition = {}
  self._dicCondition = {}
  self._needAsset = {}
end

function UIEducationDataLevel:InitLevelData(cfg)
  self._cfg = cfg
  self._lstCondition = {}
  self._dicCondition = {}
  self._needAsset = {}
  if self._cfg.OpenCondition ~= nil then
    self._lstCondition, self._dicCondition = UIEducationCondition:Unmarshal(self._cfg.OpenCondition)
    for k, v in pairs(self._lstCondition) do
      v:Test()
    end
  end
  if self._cfg.NeedItem ~= nil then
    for k, v in pairs(self._cfg.NeedItem) do
      local asset = RoleAsset:New()
      asset.assetid = v[1]
      asset.count = v[2]
      self._needAsset[asset.assetid] = asset
    end
  end
end

function UIEducationDataLevel:ParentElement()
  return self._element
end

function UIEducationDataLevel:LuaIndex()
  return self._luaIndex
end

function UIEducationDataLevel:GetCfg()
  return self._cfg
end

function UIEducationDataLevel:GetStage()
  return self._cfg.Phase
end

function UIEducationDataLevel:GetLevel()
  return self._cfg.Level
end

function UIEducationDataLevel:LevelKey()
  local data = self._element:ParentData()
  return data:LevelKey(self:GetStage(), self:GetLevel())
end

function UIEducationDataLevel:GetCondition(isDictionary)
  if isDictionary then
    return self._dicCondition
  else
    return self._lstCondition
  end
end

function UIEducationDataLevel:IsMetCondition()
  local metCondition = true
  for k, v in pairs(self._dicCondition) do
    if v:GetCompleted() < v:GetQuantity() then
      metCondition = false
      break
    end
  end
  return metCondition
end

function UIEducationDataLevel:NeedGold()
  local asset = self._needAsset[RoleAssetID.RoleAssetGold]
  if asset == nil then
    asset = RoleAsset:New()
    asset.assetid = RoleAssetID.RoleAssetGold
  end
  return asset
end

function UIEducationDataLevel:NeedAsset(getAll)
  local lst = {}
  for k, v in pairs(self._needAsset) do
    if k ~= RoleAssetID.RoleAssetGold then
      if not getAll then
        return v
      else
        table.insert(lst, v)
      end
    end
  end
  return lst
end

_class("UIEducationDataElement", Object)
UIEducationDataElement = UIEducationDataElement

function UIEducationDataElement:Constructor(data, elementType, nameStrID, elementStrID)
  self._data = data
  self._elementType = elementType
  self._nameStrID = nameStrID
  self._elementStrID = elementStrID
  self._cur = UIEducationDataCurLevel:New()
  self._redDirty = true
  self._hasRed = true
  self:InitLevelData()
end

function UIEducationDataElement:ParentData()
  return self._data
end

function UIEducationDataElement:ElementType()
  return self._elementType
end

function UIEducationDataElement:GetName()
  return StringTable.Get(self._nameStrID)
end

function UIEducationDataElement:GetElementName()
  return StringTable.Get(self._elementStrID)
end

function UIEducationDataElement:InitLevelData()
  self._lstLevel = {}
  self._dicLevel = {}
  local allCfg = self._data:Get(self._elementType)
  for k, v in pairs(allCfg) do
    local level = UIEducationDataLevel:New(self, k)
    level:InitLevelData(v)
    table.insert(self._lstLevel, level)
    self._dicLevel[level:LevelKey()] = level
  end
end

function UIEducationDataElement:TestCondition()
  for k, v in pairs(self._lstLevel) do
    local lstCondition = v:GetCondition()
    for sk, sv in pairs(lstCondition) do
      sv:Test()
    end
  end
end

function UIEducationDataElement:SetCurrentLevel(stage, level)
  self._cur:SetStage(stage)
  self._cur:SetLevel(level)
  self._cur:SetIndex(1)
  local curKey = self._data:LevelKey(stage, level)
  if self._dicLevel[curKey] == nil then
    self._cur:SetIndex(1)
  else
    for k, v in pairs(self._lstLevel) do
      if self._cur:GetStage() == v:GetStage() and self._cur:GetLevel() == v:GetLevel() then
        self._cur:SetIndex(k)
        break
      end
    end
  end
  if self._cur:GetIndex() == 1 then
    self._cur:SetStage(0)
    self._cur:SetLevel(0)
    self._cur:SetIndex(1)
  end
  self._redDirty = true
end

function UIEducationDataElement:SetRedDirty(redDirty)
  self._redDirty = redDirty
end

function UIEducationDataElement:GetDataLevelCount()
  return #self._lstLevel
end

function UIEducationDataElement:GetDataLevel(index)
  return self._lstLevel[index]
end

function UIEducationDataElement:DataLevelByIndex(index)
  return self._lstLevel[index]
end

function UIEducationDataElement:DataLevelByLevel(stage, level)
  local key = self._data:LevelKey(stage, level)
  return self._dicLevel[key]
end

function UIEducationDataElement:GetCurrentDataLevel()
  return self._lstLevel[self._cur:GetIndex()]
end

function UIEducationDataElement:GetCurrent()
  return self._cur
end

function UIEducationDataElement:GetCurrentStage()
  return self._cur:GetStage()
end

function UIEducationDataElement:GetCurrentLevel()
  return self._cur:GetLevel()
end

function UIEducationDataElement:GetCurrentMaxStage()
  local count = #self._lstLevel
  return self._lstLevel[count]:GetStage()
end

function UIEducationDataElement:GetStageMaxLevel(idStage)
  local maxLevel = 0
  local count = #self._lstLevel
  for i = 1, count do
    local dataLevel = self._lstLevel[i]
    if idStage == dataLevel:GetStage() then
      maxLevel = dataLevel:GetLevel()
    end
  end
  return maxLevel
end

function UIEducationDataElement:GetCurrentMaxLevel()
  local maxLevel = self._cur:GetLevel()
  local count = #self._lstLevel
  for i = self._cur:GetIndex(), count do
    local dataLevel = self._lstLevel[i]
    if self._cur:GetStage() == dataLevel:GetStage() then
      maxLevel = dataLevel:GetLevel()
    end
  end
  return maxLevel
end

function UIEducationDataElement:GetCurrentLuaIndex()
  return self._cur:GetIndex()
end

function UIEducationDataElement:IsSupplyPieceWeightChanged(curWeight, nxtWeight)
  for k, v in pairs(curWeight) do
    if nxtWeight[k] ~= v then
      return true
    end
  end
  for k, v in pairs(nxtWeight) do
    if curWeight[k] ~= v then
      return true
    end
    if 0 < v then
      return true
    end
  end
  return false
end

function UIEducationDataElement:UpdateRedDot()
  if not self._redDirty then
    return
  else
    self._hasRed = false
    self._redDirty = false
  end
  local curIndex = self:GetCurrentLuaIndex()
  local maxIndex = self:GetDataLevelCount()
  local nxtIndex = math.min(curIndex + 1, maxIndex)
  if nxtIndex == curIndex then
    return self._hasRed
  end
  local nxtDataLevel = self:GetDataLevel(nxtIndex)
  if not nxtDataLevel:IsMetCondition() then
    return self._hasRed
  end
  local needGold = nxtDataLevel:NeedGold()
  local needAssets = nxtDataLevel:NeedAsset(true)
  local itemModule = GameGlobal.GetModule(ItemModule)
  if needGold ~= nil then
    local haveCount = itemModule:GetItemCount(needGold.assetid)
    local needCount = needGold.count
    if haveCount < needCount then
      return self._hasRed
    end
  end
  local needAssetCount = 0
  if needAssets ~= nil then
    needAssetCount = #needAssets
  end
  for i = 1, needAssetCount do
    local needAsset = needAssets[i]
    local haveCount = itemModule:GetItemCount(needAsset.assetid)
    local needCount = needAsset.count
    if haveCount < needCount then
      return self._hasRed
    end
  end
  self._hasRed = true
  return self._hasRed
end

function UIEducationDataElement:HasRed()
  if self._redDirty then
    self:UpdateRedDot()
  end
  return self._hasRed
end
