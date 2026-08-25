local INTERVAL = 20

local function createAnnouncementModelState(annMap)
  local state = {}
  state.page = nil
  state.curLoadAnnCnt = INTERVAL
  state.annMap = annMap
  
  function state.annListMap()
    if not state.page or not annMap then
      return {}
    end
    local map = {}
    for _, data in pairs(annMap) do
      if data and data.page then
        if not map[data.page] then
          map[data.page] = {}
        end
        table.insert(map[data.page], data)
      end
    end
    for _, list in pairs(map) do
      if list and #list > 1 then
        table.sort(list, function(a, b)
          if a.important == b.important then
            return a.order < b.order
          end
          return a.important > b.important
        end)
        for idx, _ in ipairs(list) do
          state:SetAnnDataIndex(list[idx], idx)
        end
      end
    end
    return map
  end
  
  function state.curAnns()
    if not state.page or not state.annListMap then
      return {}
    end
    local annListMap = state.annListMap[state.page]
    if annListMap and #annListMap > state.curLoadAnnCnt then
      local map = {}
      for i = 1, #state.annListMap[state.page] do
        table.insert(map, state.annListMap[state.page][i])
      end
      return map
    else
      return state.annListMap[state.page] or {}
    end
  end
  
  function state.showAnns()
    if not state.page or not state.annListMap then
      return {}
    end
    local annListMap = state.annListMap[state.page]
    if annListMap and #annListMap > state.curLoadAnnCnt then
      local map = {}
      for i = 1, state.curLoadAnnCnt do
        table.insert(map, state.annListMap[state.page][i])
      end
      return map
    else
      return state.annListMap[state.page] or {}
    end
  end
  
  state.currUid = nil
  return state
end

local function createAnnouncementModelViews(data)
  local views = {}
  
  function views:GetAnnData(uid)
    if not uid or not data.annMap then
      return
    end
    return data.annMap[uid]
  end
  
  return views
end

local function createAnnouncementModelActions(data)
  local actions = {}
  
  function actions:SetPage(page)
    if not page or "" == page then
      return
    end
    data.page = page
  end
  
  function actions:ResetCurUid()
    data.currUid = nil
  end
  
  function actions:SetCurUid(uid, scrollToTop)
    if not uid or "" == uid then
      return
    end
    data.currUid = uid
    EventMgr.Instance.SelectAnnouncementEvent:Dispatch(uid, scrollToTop)
  end
  
  function actions:SetAnnDataIndex(annData, index)
    if not annData or not index then
      return
    end
    annData.index = index
  end
  
  function actions:AddLoadAnnCnt()
    data.curLoadAnnCnt = math.min(data.curLoadAnnCnt + INTERVAL, #data.annListMap[data.page])
  end
  
  function actions:ResetLoadAnnCnt()
    data.curLoadAnnCnt = INTERVAL
  end
  
  return actions
end

local function onSetup(binder, model)
  if model.showAnns and #model.showAnns > 0 then
    local data = model.showAnns[1]
    for _, annData in ipairs(model.showAnns) do
      if annData and annData.isForcePopup and annData.new then
        data = annData
        break
      end
    end
    if data then
      model:SetCurUid(data.uid, true)
    end
  end
  binder:BindToRaw(function(_, currPage)
    if not currPage then
      return
    end
    local data = model.showAnns and model.showAnns[1]
    for _, annData in ipairs(model.showAnns) do
      if annData and annData.isForcePopup and annData.new then
        data = annData
        break
      end
    end
    if data then
      model:SetCurUid(data.uid, true)
    else
      model:ResetCurUid()
    end
  end, function()
    return model.page
  end)
end

local AnnouncementModel = Vue.model("AnnouncementModel", createAnnouncementModelState):views(createAnnouncementModelViews):actions(createAnnouncementModelActions):setup(onSetup)
return AnnouncementModel
