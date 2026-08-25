local PVPCollectionDetailTab = CommonDefine.PVPCollectionDetailTab

local function createPVPCollectionMainPanelModelState(data)
  local state = {}
  state.tab = data and data.targetTab or PVPCollectionDetailTab.Detail
  state.showList = data and data.showList or {}
  state.selectTid = 0
  if data and data.targetIndex and data and data.showList and data.targetIndex <= #data.showList then
    state.selectTid = data.showList[data.targetIndex]
  end
  return state
end

local function createPVPCollectionMainPanelModelViews(data)
  local views = {}
  
  function views:GetCollectTid(index)
    if not index or index > #data.showList then
      return
    end
    return data.showList[index]
  end
  
  function views:GetCollectionType(tid)
    if not tid then
      return
    end
    do return PvpCollectCfgUtils.GetCollectionType end
    return PvpCollectCfgUtils.GetCollectionType, tid
  end
  
  function views:GetCollectionName(tid)
    if not tid then
      return
    end
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, tid
  end
  
  function views:GetAwakerCollectionSchoolIcon(tid)
    do return PVPCollectionDataUtils.GetAwakerSchoolIcon end
    return PVPCollectionDataUtils.GetAwakerSchoolIcon, tid
  end
  
  return views
end

local function createPVPCollectionMainPanelModelActions(data)
  local actions = {}
  
  function actions:SetTab(tab)
    if not tab then
      return
    end
    data.tab = tab
  end
  
  function actions:SetSelectTid(tid)
    if not tid then
      return
    end
    data.selectTid = tid
  end
  
  return actions
end

local function onSetup(_, _)
end

local PVPCollectionMainPanelModel = Vue.model("PVPCollectionMainPanelModel", createPVPCollectionMainPanelModelState):views(createPVPCollectionMainPanelModelViews):actions(createPVPCollectionMainPanelModelActions):setup(onSetup)
return PVPCollectionMainPanelModel
