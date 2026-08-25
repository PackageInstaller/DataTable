local PvPBuildTagType = CommonDefine.PvPBuildTagType
local ItemType = CommonDefine.ItemType
local PERLINE_MAX_SHOW_NUM = 6

local function createPvPSingleBuildPanelState(mainModel, type, buildIdx)
  local state = {}
  state.mainModel = mainModel
  state.type = type
  state.buildIdx = buildIdx
  state.curSelectTid = 0
  state.curTag = PvPBuildTagType.All
  
  function state.curSchoolId()
    local curAwakerGroup = table.clone(mainModel.awakerGroup)
    curAwakerGroup[buildIdx] = 0
    local awakerTids = PvPTeamBuildDataUtils.GetAwakerTidsByCollectTids(curAwakerGroup)
    do return AwakerDataUtils.GetAwakerTeamEffectSchool end
    return AwakerDataUtils.GetAwakerTeamEffectSchool, awakerTids
  end
  
  function state.curChosenPosTids()
    local awakerCollectTids = mainModel.awakerGroup
    local chosenPostionTids = {}
    local oriSelectTid = state:GetOriTid()
    for _, collectTid in ipairs(awakerCollectTids) do
      if 0 ~= collectTid and collectTid ~= oriSelectTid then
        local posTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(collectTid)
        table.insert(chosenPostionTids, posTid)
      end
    end
    return chosenPostionTids
  end
  
  state.contentGroup = {}
  return state
end

local function createPvPSingleBuildPanelViews(data)
  local views = {}
  
  function views:GetOriTid()
    return data.mainModel.type2GroupMap[data.type][data.buildIdx]
  end
  
  function views:GetEffectingTids()
    local rst = {}
    for idx, tid in pairs(data.mainModel.type2GroupMap[data.type]) do
      if idx ~= data.buildIdx then
        table.insert(rst, tid)
      end
    end
    return rst
  end
  
  return views
end

local function createPvPSingleBuildPanelActions(data)
  local actions = {}
  
  function actions:UpdateContentGroup()
    local rst = {}
    local cacheTbl = {}
    local collectDataMap = PVPCollectionDataUtils.GetDisplayCollection()
    for _, collectData in pairs(collectDataMap) do
      if not PVPCollectionDataUtils.IsOpenedInTime(collectData.tid) then
      else
        local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectData.tid)
        if itemCfg and itemCfg.Type == data.type then
          table.insert(cacheTbl, collectData.tid)
        end
      end
    end
    local positionSortMap = PVPCollectionDataUtils.GetPvpPostionSortMap() or {}
    local cloneTmp = {}
    if data.type == ItemType.AwakerItem then
      cloneTmp = table.clone(self.mainModel.awakerGroup)
    elseif data.type == ItemType.Weapon then
      cloneTmp = table.clone(self.mainModel.weaponGroup)
    end
    table.reverse(cloneTmp)
    local tid2IdxMap = {}
    for idx, tid in pairs(cloneTmp) do
      tid2IdxMap[tid] = idx
    end
    table.sort(cacheTbl, function(a, b)
      local aItemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(a)
      local bItemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(b)
      local aType = aItemCfg.Type
      local bType = bItemCfg.Type
      local aIsAwakerItem = aType == ItemType.AwakerItem
      local bIsAwakerItem = bType == ItemType.AwakerItem
      local aSortId = DT.PVPCollect[a].BaseSortID
      local bSortId = DT.PVPCollect[b].BaseSortID
      local aPositionSort = aIsAwakerItem and positionSortMap[PvpCollectCfgUtils.GetCollectAwakerPvpPosition(a)] or 0
      local bPositionSort = bIsAwakerItem and positionSortMap[PvpCollectCfgUtils.GetCollectAwakerPvpPosition(b)] or 0
      local aChooingSort = tid2IdxMap[a] or math.maxinteger
      local bChooingSort = tid2IdxMap[b] or math.maxinteger
      if aChooingSort ~= bChooingSort then
        return aChooingSort < bChooingSort
      end
      local ownedA = PVPCollectionDataUtils.HasOwnedCollection(a) and 0 or 1
      local ownedB = PVPCollectionDataUtils.HasOwnedCollection(b) and 0 or 1
      if ownedA ~= ownedB then
        return ownedA < ownedB
      end
      local aIsWeaponItem = aType == ItemType.Weapon
      local bIsWeaponItem = bType == ItemType.Weapon
      if aIsWeaponItem and bIsWeaponItem then
        local qualitySortA = ItemCfgUtils.GetItemQualitySort(aItemCfg.ID) or 0
        local qualitySortB = ItemCfgUtils.GetItemQualitySort(bItemCfg.ID) or 0
        if qualitySortA == qualitySortB then
          local configA = ItemDataUtils.GetItemConfig(aItemCfg.ID)
          local configB = ItemDataUtils.GetItemConfig(bItemCfg.ID)
          if qualitySortA == ItemCfgUtils.QualitySortValueTable.Orange then
            local isRecommendA = configA.RecommendedAwaker and 1 or 0
            local isRecommendB = configB.RecommendedAwaker and 1 or 0
            if isRecommendA == isRecommendB then
              if 1 == isRecommendB then
                local aSchool = CommonDefine.Schoolweight[AwakerDataUtils.GetAwakerConfig(configA.RecommendedAwaker).School]
                local bSchool = CommonDefine.Schoolweight[AwakerDataUtils.GetAwakerConfig(configB.RecommendedAwaker).School]
                if aSchool == bSchool then
                  return aItemCfg.BaseSortID < bItemCfg.BaseSortID
                end
                return aSchool > bSchool
              else
                return aItemCfg.BaseSortID < bItemCfg.BaseSortID
              end
            end
            return isRecommendA > isRecommendB
          end
        end
      end
      if aPositionSort ~= bPositionSort then
        return aPositionSort < bPositionSort
      end
      return aSortId < bSortId
    end)
    local tmp = {}
    
    local function InsertTid(tid, targetGroup)
      table.insert(targetGroup, tid)
      return targetGroup
    end
    
    for _, tid in pairs(cacheTbl) do
      if tid == data.curSelectTid then
        tmp = InsertTid(tid, tmp)
      elseif data.type == ItemType.AwakerItem and data.curTag ~= PvPBuildTagType.All then
        local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(tid)
        if positionTid == data.curTag then
          tmp = InsertTid(tid, tmp)
        end
      else
        tmp = InsertTid(tid, tmp)
      end
    end
    cacheTbl = tmp
    local line = 1
    local num = 0
    for idx, tid in ipairs(cacheTbl) do
      if not rst[line] then
        rst[line] = {}
      end
      table.insert(rst[line], tid)
      num = num + 1
      if 0 == num % PERLINE_MAX_SHOW_NUM and idx ~= #cacheTbl then
        line = line + 1
      end
    end
    data.contentGroup = rst
  end
  
  function actions:SetCurTag(val)
    if not val then
      return
    end
    data.curTag = val
  end
  
  function actions:SetCurSelectTid(tid)
    if not tid then
      return
    end
    data.curSelectTid = tid
  end
  
  return actions
end

local function onSetup(binder, model)
  model:SetCurSelectTid(model:GetOriTid())
  binder:BindToRaw(function()
    model:UpdateContentGroup()
  end, function()
    return model.curTag
  end)
end

local PvPSingleBuildPanelModel = Vue.model("PvPSingleBuildPanelModel", createPvPSingleBuildPanelState):views(createPvPSingleBuildPanelViews):actions(createPvPSingleBuildPanelActions):setup(onSetup)
return PvPSingleBuildPanelModel
