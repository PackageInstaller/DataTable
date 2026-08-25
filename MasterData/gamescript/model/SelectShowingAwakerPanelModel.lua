local function createSelectShowingAwakerPanelState(mainPanelModel)
  local state = {}
  
  state.mainPanelModel = mainPanelModel
  state.curSelectAwakerTid = mainPanelModel.showAwakerTid
  
  function state.selectAwakerGroup()
    local rst = AwakerDataUtils.GetOwnedAwakerList()
    table.sort(rst, function(a, b)
      local aCfg = DT.AwakerConfig[a.tid]
      local bCfg = DT.AwakerConfig[b.tid]
      return aCfg.BaseSortID < bCfg.BaseSortID
    end)
    return rst
  end
  
  return state
end

local function createSelectShowingAwakerPanelViews(data)
  local views = {}
  
  function views:GetAwakerLike()
    local awakerId = data.curSelectAwakerTid
    local awaker = AwakerDataUtils.GetAwakerData(awakerId)
    if not awaker then
      return 0
    end
    local level = awaker.likeLevel or 0
    local cfg = DT.AwakerFavorability[awakerId]
    local datalist = cfg.data_list
    local totalNeed = 0
    for _, v in ipairs(datalist) do
      if level >= v.AwakerFavorabilityLevel then
        totalNeed = totalNeed + v.AwakerFavorabilityRequire
      end
    end
    local awakerLike = awaker.like or 0
    return totalNeed + awakerLike
  end
  
  function views:GetNextAwakerLike()
    local awakerId = data.curSelectAwakerTid
    local awaker = AwakerDataUtils.GetAwakerData(awakerId)
    if not awaker then
      return 0
    end
    local level = awaker.likeLevel or 0
    local cfg = DT.AwakerFavorability[awakerId]
    local datalist = cfg.data_list
    local totalNeed = 0
    for _, v in ipairs(datalist) do
      totalNeed = totalNeed + v.AwakerFavorabilityRequire
      if level < v.AwakerFavorabilityLevel then
        return totalNeed
      end
    end
    return datalist[#datalist].AwakerFavorabilityRequire
  end
  
  return views
end

local function createSelectShowingAwakerPanelActions(data)
  local actions = {}
  
  function actions:SetCurSelectAwakerTid(tid)
    if not tid then
      return
    end
    data.curSelectAwakerTid = tid
  end
  
  return actions
end

local function onSetup(binder, model)
end

local SelectShowingAwakerPanelModel = Vue.model("SelectShowingAwakerPanelModel", createSelectShowingAwakerPanelState):views(createSelectShowingAwakerPanelViews):actions(createSelectShowingAwakerPanelActions):setup(onSetup)
return SelectShowingAwakerPanelModel
