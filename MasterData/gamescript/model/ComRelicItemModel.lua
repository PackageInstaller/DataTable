local function createComRelicItemModelState(relicData, callback)
  local state = {}
  
  state.relicData = relicData
  state.relicTid = relicData.tid
  state.callback = callback
  state.textName = ""
  state.createTypeName = ""
  state.imageIcon = ""
  state.imageCreate = ""
  state.imageQuality = ""
  state.relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  return state
end

local function createComRelicItemModelViews(data)
  local views = {}
  return views
end

local function createComRelicItemModelActions(data)
  local actions = {}
  
  function actions:SetTid(tid)
    data.relicTid = tid
    local cfg = DT.RelicConfig[tid]
    data.textName = cfg and (cfg.Name or "") or ""
    data.imageIcon = cfg and (cfg.SmallIcon or "") or ""
    data.createTypeName = cfg and data.relicTypeMap[cfg.Quality] or ""
    data.imageCreate = cfg and DT.ItemQuality[cfg.Quality].RelicFrame
    data.imageQuality = cfg and DT.ItemQuality[cfg.Quality].ItemQualityFrame or ""
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, nVal, _)
    model:SetTid(nVal)
  end, function()
    return model.relicData.tid
  end)
end

local ComRelicItemModel = Vue.model("ComRelicItemModel", createComRelicItemModelState):views(createComRelicItemModelViews):actions(createComRelicItemModelActions):setup(onSetup)
return ComRelicItemModel
