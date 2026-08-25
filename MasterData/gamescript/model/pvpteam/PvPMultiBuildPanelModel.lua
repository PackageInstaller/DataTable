local PERLINE_MAX_SHOW_NUM = 6
local PvPBuildTagType = CommonDefine.PvPBuildTagType
local ItemType = CommonDefine.ItemType

local function createPvPMultiBuildPanelState(mainModel)
  local state = {}
  state.mainModel = mainModel
  state.curTag = PvPBuildTagType.All
  state.curSelectTid = 0
  state.curAwakerGroup = {
    0,
    0,
    0,
    0
  }
  state.curWeaponGroup = {
    0,
    0,
    0,
    0
  }
  state.curKeeperSkillGroup = {0, 0}
  
  function state.curSelectPosGroup()
    local awakerCollectTids = state.curAwakerGroup
    local chosenPostionTids = {}
    for _, collectTid in ipairs(awakerCollectTids) do
      if 0 ~= collectTid then
        local posTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(collectTid)
        table.insert(chosenPostionTids, posTid)
      end
    end
    return chosenPostionTids
  end
  
  function state.curSchoolId()
    local awakerTids = PvPTeamBuildDataUtils.GetAwakerTidsByCollectTids(state.curAwakerGroup)
    do return AwakerDataUtils.GetAwakerTeamEffectSchool end
    return AwakerDataUtils.GetAwakerTeamEffectSchool, awakerTids
  end
  
  state.contentGroup = {}
  
  function state.type2GroupMap()
    return {
      [ItemType.AwakerItem] = state.curAwakerGroup,
      [ItemType.Weapon] = state.curWeaponGroup,
      [ItemType.KeeperSkill] = state.curKeeperSkillGroup
    }
  end
  
  return state
end

local function createPvPMultiBuildPanelViews(data)
  local views = {}
  
  function views:GetEffectAwakerNum()
    local rst = 0
    for _, tid in pairs(data.curAwakerGroup) do
      if 0 ~= tid then
        rst = rst + 1
      end
    end
    return rst
  end
  
  function views:IsInTeam(tid)
    if 0 == tid then
      return false
    end
    return table.contains(data.curAwakerGroup, tid) or table.contains(data.curWeaponGroup, tid) or table.contains(data.curKeeperSkillGroup, tid)
  end
  
  return views
end

local function createPvPMultiBuildPanelActions(data)
  local actions = {}
  
  function actions:UpdateContentGroup()
    local rst = {}
    local awakerTids = {}
    local weaponTids = {}
    local keeperSkillTids = {}
    local type2GroupMap = {
      [ItemType.AwakerItem] = awakerTids,
      [ItemType.Weapon] = weaponTids,
      [ItemType.KeeperSkill] = keeperSkillTids
    }
    local collectDataMap = PVPCollectionDataUtils.GetDisplayCollection()
    for _, collectData in pairs(collectDataMap) do
      if not PVPCollectionDataUtils.IsOpenedInTime(collectData.tid) then
      else
        local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectData.tid)
        if itemCfg then
          table.insert(type2GroupMap[itemCfg.Type], collectData.tid)
        end
      end
    end
    local positionSortMap = PVPCollectionDataUtils.GetPvpPostionSortMap() or {}
    for curType, group in pairs(type2GroupMap) do
      local cloneTmp = table.clone(data.type2GroupMap[curType])
      table.reverse(cloneTmp)
      local tid2IdxMap = {}
      for index, tid in ipairs(cloneTmp) do
        tid2IdxMap[tid] = index
      end
      table.sort(group, function(a, b)
        local aItemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(a)
        local bItemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(b)
        local aType = aItemCfg.Type
        local bType = bItemCfg.Type
        local aIsAwakerItem = aType == ItemType.AwakerItem
        local bIsAwakerItem = bType == ItemType.AwakerItem
        local aSequenceSort = tid2IdxMap[a] or math.maxinteger
        local bSequenceSort = tid2IdxMap[b] or math.maxinteger
        local aSortId = DT.PVPCollect[a].BaseSortID
        local bSortId = DT.PVPCollect[b].BaseSortID
        local aPositionSort = aIsAwakerItem and positionSortMap[PvpCollectCfgUtils.GetCollectAwakerPvpPosition(a)] or 0
        local bPositionSort = bIsAwakerItem and positionSortMap[PvpCollectCfgUtils.GetCollectAwakerPvpPosition(b)] or 0
        if aSequenceSort ~= bSequenceSort then
          return aSequenceSort < bSequenceSort
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
    end
    
    local function ScanTids(line, tids)
      line = line + 1
      local num = 0
      for idx, tid in ipairs(tids) do
        if not rst[line] then
          rst[line] = {}
        end
        table.insert(rst[line], tid)
        num = num + 1
        if 0 == num % PERLINE_MAX_SHOW_NUM and idx ~= #tids then
          line = line + 1
        end
      end
      return line
    end
    
    local function ScanAwakerTids(oldAwakerTids)
      local newAwakerTids = {}
      if data.curTag == PvPBuildTagType.All then
        newAwakerTids = oldAwakerTids
      else
        for _, tid in pairs(oldAwakerTids) do
          local itemType = PvpCollectCfgUtils.GetItemCfgByCollectTid(tid).Type
          if table.contains(data.type2GroupMap[itemType], tid) then
            table.insert(newAwakerTids, tid)
          else
            local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(tid)
            if positionTid == data.curTag then
              table.insert(newAwakerTids, tid)
            end
          end
        end
      end
      return newAwakerTids
    end
    
    local cacheLine = 0
    local checkTagList = {
      PvPBuildTagType.All,
      PvPBuildTagType.Chaos,
      PvPBuildTagType.Ocean,
      PvPBuildTagType.Blood,
      PvPBuildTagType.Dimension
    }
    local positionList = PVPCollectionDataUtils.GetPvpPositionList()
    table.mergeArray(checkTagList, positionList)
    if table.contains(checkTagList, data.curTag) then
      awakerTids = ScanAwakerTids(awakerTids)
      cacheLine = ScanTids(cacheLine, awakerTids)
    end
    if table.contains({
      PvPBuildTagType.All,
      PvPBuildTagType.Weapon
    }, data.curTag) then
      cacheLine = ScanTids(cacheLine, weaponTids)
    end
    if table.contains({
      PvPBuildTagType.All,
      PvPBuildTagType.KeeperSkill
    }, data.curTag) then
      ScanTids(cacheLine, keeperSkillTids)
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
  
  function actions:SetCurAwakerGroup(group)
    if not group or type(group) ~= "table" then
      return
    end
    data.curAwakerGroup = group
  end
  
  function actions:SetCurWeaponGroup(group)
    if not group or type(group) ~= "table" then
      return
    end
    data.curWeaponGroup = group
  end
  
  function actions:SetKeeperSkillGroup(group)
    if not group or type(group) ~= "table" then
      return
    end
    data.curKeeperSkillGroup = group
  end
  
  function actions:AddGroupByType(tid, type)
    if not tid or not type then
      return
    end
    for key, val in ipairs(data.type2GroupMap[type]) do
      if 0 == val then
        data.type2GroupMap[type][key] = tid
        break
      end
    end
  end
  
  function actions:RemoveGroupByType(tid, type)
    if not tid or not type then
      return
    end
    for key, val in ipairs(data.type2GroupMap[type]) do
      if tid == val then
        data.type2GroupMap[type][key] = 0
        break
      end
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  local mainModel = model.mainModel
  local awakerGroup = table.clone(mainModel.awakerGroup)
  local weaponGroup = table.clone(mainModel.weaponGroup)
  local keeperSkillGroup = table.clone(mainModel.keeperSkillGroup)
  model:SetCurAwakerGroup(awakerGroup)
  model:SetCurWeaponGroup(weaponGroup)
  model:SetKeeperSkillGroup(keeperSkillGroup)
  binder:BindToRaw(function()
    model:UpdateContentGroup()
  end, function()
    return model.curTag
  end)
end

local PvPMultiBuildPanelModel = Vue.model("PvPMultiBuildPanelModel", createPvPMultiBuildPanelState):views(createPvPMultiBuildPanelViews):actions(createPvPMultiBuildPanelActions):setup(onSetup)
return PvPMultiBuildPanelModel
