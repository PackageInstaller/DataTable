local PVPCollectionFilterType = CommonDefine.PVPCollectionFilterType
local PVPCollectionType = CommonDefine.PVPCollectionType

local function createPVPCollectionListPanelModelState(filterType)
  local state = {}
  
  function state.filterListMap()
    local map = {}
    local now = math.floor(TimeUtils.GetServerTime())
    for tid, _ in pairs(DataCenter.pvpCollectionData.collectionMap) do
      local cfg = PvpCollectCfgUtils.GetCfg(tid)
      if not cfg then
      elseif not PVPCollectionDataUtils.IsOpenedInTime(tid) then
      else
        local _filterType
        if cfg.Type == PVPCollectionType.Awaker then
          _filterType = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(tid)
        elseif cfg.Type == PVPCollectionType.Weapon then
          _filterType = PVPCollectionFilterType.Weapon
        elseif cfg.Type == PVPCollectionType.KeeperSkill then
          _filterType = PVPCollectionFilterType.KeeperSkill
        end
        if not _filterType then
        else
          if not map[_filterType] then
            map[_filterType] = {}
          end
          if not map[PVPCollectionFilterType.All] then
            map[PVPCollectionFilterType.All] = {}
          end
          table.insert(map[_filterType], tid)
          table.insert(map[PVPCollectionFilterType.All], tid)
        end
      end
    end
    for k, list in pairs(map) do
      map[k] = PVPCollectionDataUtils.SortCollections(list)
    end
    return map
  end
  
  state.showList = {}
  state.filterType = filterType or PVPCollectionFilterType.All
  return state
end

local function createPVPCollectionListPanelModelViews(_)
  local views = {}
  
  function views:GetFilterList()
    local list = {
      PVPCollectionFilterType.All
    }
    local positionList = PVPCollectionDataUtils.GetPvpPositionList()
    table.mergeArray(list, positionList)
    table.mergeArray(list, {
      PVPCollectionFilterType.Weapon,
      PVPCollectionFilterType.KeeperSkill
    })
    return list
  end
  
  return views
end

local function createPVPCollectionListPanelModelActions(data)
  local actions = {}
  
  function actions:SetFilterType(filterType)
    if not filterType then
      return
    end
    data.filterType = filterType
  end
  
  function actions:UpdateShowList(list)
    if not list then
      return
    end
    data.showList = list
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, list)
    if not list then
      return
    end
    model:UpdateShowList(list)
  end, function()
    return model.filterListMap[model.filterType] or {}
  end)
end

local PVPCollectionListPanelModel = Vue.model("PVPCollectionListPanelModel", createPVPCollectionListPanelModelState):views(createPVPCollectionListPanelModelViews):actions(createPVPCollectionListPanelModelActions):setup(onSetup)
return PVPCollectionListPanelModel
