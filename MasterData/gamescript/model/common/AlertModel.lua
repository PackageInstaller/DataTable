local function createAlertModelState(tipsData)
  local state = {}
  
  state.tipsData = tipsData
  return state
end

local function createAlertModelViews(data)
  local views = {}
  
  function views:GetTitle()
    if not data.tipsData then
      return ""
    end
    if data.tipsData.title then
      return data.tipsData.title
    end
    local config = DT.TipsType[data.tipsData.tipTid]
    return config and LT.Text(config.Title) or ""
  end
  
  function views:GetDesc()
    if not data.tipsData then
      return ""
    end
    if data.tipsData.desc then
      return data.tipsData.desc
    end
    local config = DT.TipsType[data.tipsData.tipTid]
    return config and LT.Text(config.Desc) or ""
  end
  
  function views:GetIcon()
    if not data.tipsData then
      return
    end
    if data.tipsData.iconPath then
      return data.tipsData.iconPath
    end
    local config = DT.TipsType[data.tipsData.tipTid]
    return config and config.Icon or ""
  end
  
  function views:GetOwnText()
    if not data.tipsData then
      return ""
    end
    return data.tipsData.ownText or ""
  end
  
  return views
end

local function createAlertModelActions(_)
  local actions = {}
  return actions
end

local function onSetup(_, _)
end

local AlertModel = Vue.model("AlertModel", createAlertModelState):views(createAlertModelViews):actions(createAlertModelActions):setup(onSetup)
return AlertModel
