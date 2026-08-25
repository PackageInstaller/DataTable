local ItemType = CommonDefine.ItemType
local tableInsert = table.insert
local tableSort = table.sort
local strContains = string.contains
local PerAttrKey = "_per"

local function createAwakerAttrModellState(awakerModel)
  local state = {}
  state.awakerModel = awakerModel
  
  function state.selectAwaker()
    return state.awakerModel.selectAwakerData
  end
  
  local function attrSort(a, b)
    local cfgA = DT.ActorAttrType[a.tid]
    local cfgB = DT.ActorAttrType[b.tid]
    local sortA = cfgA.AttributeSort or 0
    local sortB = cfgB.AttributeSort or 0
    return sortA < sortB
  end
  
  function state.clientAttrs()
    local awaker = state.selectAwaker
    if not awaker then
      return {}
    end
    local attrList = {}
    local diifAttrMap = AwakerDataUtils.GetAwakerDiffAttrMap(awaker)
    local clientAttrs = awaker.clientAttrs
    if not clientAttrs and not state.awakerModel:HasOwnedAwaker(state.awakerModel.selectAwakerId) then
      clientAttrs = AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs)
    end
    for _, attr in ipairs(clientAttrs or {}) do
      if not attr then
      elseif state:IsBaseAttr(attr.tid) then
      else
        local v = table.clone(attr)
        local attrKey = v.type
        local perAttrKey = attrKey .. PerAttrKey
        local perValue = awaker.attrs[perAttrKey]
        local addValue = diifAttrMap[attrKey] and diifAttrMap[attrKey].addValue or nil
        if perValue then
          v.perAddCount = perValue
        end
        if addValue then
          v.addCount = addValue
        end
        v.attrDesc = AttrUtils.CalAttrDesc(awaker, v.attrDesc, attrKey, attr.tid)
        tableInsert(attrList, v)
      end
    end
    tableSort(attrList, attrSort)
    return attrList
  end
  
  function state.baseAttrs()
    local awaker = state.selectAwaker
    if not awaker then
      return {}
    end
    local attrs = {}
    local clientAttrs = awaker.clientAttrs
    if not clientAttrs and not state.awakerModel:HasOwnedAwaker(state.awakerModel.selectAwakerId) and not table.next(DataCenter.awakerData.mockAwakerMap) then
      clientAttrs = AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs)
    end
    if not clientAttrs then
      return attrs
    end
    for _, attr in pairs(clientAttrs) do
      if not attr then
      else
        local cfg = DT.ActorAttrType[attr.tid]
        if not cfg then
          Logger.Info("找不到属性配置:", attr.tid)
        elseif state:IsBaseAttr(attr.tid) then
          local v = table.clone(attr)
          local attrKey = cfg.Name .. PerAttrKey
          local baseValue = v.count
          local perVal = awaker.attrs[attrKey]
          v.attrDesc = AttrUtils.CalAttrDesc(awaker, v.attrDesc, attrKey)
          if perVal then
            perVal = perVal / 100
            v.count = AttrUtils.GetAwakerFinalAttr(baseValue, perVal)
          end
          tableInsert(attrs, v)
        end
      end
    end
    tableSort(attrs, attrSort)
    return attrs
  end
  
  function state.trinkets()
    local awaker = state.selectAwaker
    if not awaker then
      return {}
    end
    local trinketIds = awaker.trinkets
    if not trinketIds then
      return {}
    end
    local trinkets = {}
    for pos, id in pairs(trinketIds) do
      local data = ItemDataUtils.GetItemByUid(id)
      trinkets[pos] = data
    end
    return trinkets
  end
  
  function state.suitAttrs()
    local awaker = state.selectAwaker
    if not awaker then
      return {}
    end
    return awaker.suitAttr
  end
  
  function state.baseTrinketAttrs()
    local finalTrinketAttrs = state.finalTrinketAttrs
    local showAttrList = {
      "physique",
      "atk",
      "def"
    }
    local attrs = {}
    for index, attrName in ipairs(showAttrList) do
      for _, attr in pairs(finalTrinketAttrs) do
        local cfg = DT.ActorAttrType[attr.tid]
        local cfgAttrName = cfg and cfg.Name
        if cfgAttrName == attrName then
          attrs[index] = attr
          break
        end
      end
    end
    return attrs
  end
  
  function state.finalTrinketAttrs()
    local awakerId = state.awakerModel.selectAwakerId
    local awaker = state.awakerModel:GetAwakerData(awakerId)
    if not awaker then
      return {}
    end
    
    local function AttrMapToList(attrMap)
      local attrList = {}
      if not attrMap then
        return attrList
      end
      for _, attr in pairs(attrMap) do
        if not state:IsBaseAttr(attr.tid) then
          tableInsert(attrList, attr)
        end
      end
      
      local function sortFunc(a, b)
        local sortA = DT.ActorAttrType[a.tid].AttributeSort or 0
        local sortB = DT.ActorAttrType[b.tid].AttributeSort or 0
        return sortA < sortB
      end
      
      tableSort(attrList, sortFunc)
      return attrList
    end
    
    local attrMap = {}
    for attrId, attrConfig in pairs(DT.ActorAttrType) do
      if not attrConfig or not attrConfig.TrinketShow then
      else
        local attrDesc = AttrUtils.GetAttrDesc(attrId)
        local attr = {
          tid = attrId,
          type = attrConfig.Name,
          count = 0,
          name = LT.Text(attrConfig.Text),
          isPercent = attrConfig.Percentage,
          attrDesc = AttrUtils.CalAttrDesc(awaker, attrDesc, attrConfig.Name)
        }
        attrMap[attrConfig.Name] = attr
      end
    end
    local trinkets = state.trinkets
    for _, trinket in pairs(trinkets) do
      if not trinket or not trinket.attrs then
      else
        local config = ItemDataUtils.GetItemConfig(trinket.tid)
        if not config or config.Type ~= ItemType.Trinket then
        else
          for _, attrInfo in pairs(trinket.attrs) do
            if not attrInfo then
            else
              local attrConfig = DT.ActorAttrType[attrInfo.attrId]
              if not attrConfig then
              else
                local attr = attrMap[attrConfig.Name]
                if not attr then
                  attr = {
                    tid = attrInfo.attrId,
                    type = attrConfig.Name,
                    count = attrInfo.val,
                    name = LT.Text(attrConfig.Text),
                    isPercent = attrConfig.Percentage
                  }
                  attrMap[attrConfig.Name] = attr
                else
                  attr.count = attr.count + attrInfo.val
                end
              end
            end
          end
        end
      end
    end
    local suitAttrs = state.suitAttrs
    if not suitAttrs then
      do return AttrMapToList end
      return AttrMapToList, attrMap, pairs(trinkets)
    end
    local attrTypeMap = AttrUtils.GetAttrTypeMap()
    for attrKey, attrValue in pairs(suitAttrs) do
      if strContains(attrKey, "skillslot") then
      else
        local baseAttr = attrMap[attrKey]
        local attrId = baseAttr and baseAttr.tid or attrTypeMap[attrKey]
        local config = DT.ActorAttrType[attrId]
        local value = attrValue
        if not baseAttr then
          baseAttr = {
            tid = attrId,
            type = attrKey,
            count = value,
            name = LT.Text(config.Text),
            isPercent = config.Percentage
          }
          attrMap[attrKey] = baseAttr
        else
          baseAttr.count = baseAttr.count + value
        end
      end
    end
    local attrList = AttrMapToList(attrMap)
    Logger.Debug("trinket final total attrList:", table.tostring(attrList))
    tableSort(attrList, attrSort)
    return attrList
  end
  
  return state
end

local function createAwakerAttrModellViews(_data)
  local views = {}
  local BaseAttrMap = {
    physique = true,
    atk = true,
    def = true,
    ulti_energy_max = true
  }
  
  function views:IsBaseAttr(attrTid)
    local attrConfig = DT.ActorAttrType[attrTid]
    if not attrConfig or not attrConfig.Name then
      return false
    end
    return BaseAttrMap[attrConfig.Name]
  end
  
  return views
end

local function createAwakerAttrModellActions(_data)
  local actions = {}
  
  function actions:IsLevelMax()
    return self.awakerModel:GetAwakerLevel(self.awakerModel.selectAwakerId) >= CommonDefine.AwakerMaxLevel
  end
  
  function actions:GetPreviewLevel()
    local baseLv = CommonDefine.AwakerBaseMaxLevel
    local maxLv = CommonDefine.AwakerMaxLevel
    local curLv = self.awakerModel:GetAwakerLevel(self.awakerModel.selectAwakerId)
    while baseLv < maxLv and not (baseLv > curLv) do
      baseLv = baseLv + 10
    end
    do return math.min, baseLv end
    return math.min, baseLv, maxLv
  end
  
  return actions
end

local function onSetup(_binder, _model)
end

local AwakerAttrModel = Vue.model("AwakerAttrModel", createAwakerAttrModellState):views(createAwakerAttrModellViews):actions(createAwakerAttrModellActions):setup(onSetup)
return AwakerAttrModel
