local function createGuideModelState()
  local state = {}
  
  state.guideId = DataCenter.guideData.guideId
  state.subGuideId = DataCenter.guideData.subGuideId
  return state
end

local function createGuideModelViews(data)
  local views = {}
  
  function views:GetGuideCfg()
    do return end
    return GuideUtils.GetCurGuideCfg
  end
  
  function views:GetGuideContent()
    local cfg = self:GetGuideCfg()
    return cfg.Content
  end
  
  function views:GetHeadIcon()
    local cfg = self:GetGuideCfg()
    local awaker = cfg.AwakerHead
    if tonumber(awaker) then
      do return AwakerDataUtils.GetLittleIcon, tonumber(awaker) end
      return AwakerDataUtils.GetLittleIcon, tonumber(awaker)
    end
    if type(awaker) == "string" then
      return awaker
    end
  end
  
  function views:GetGuideName()
    local cfg = self:GetGuideCfg()
    local awaker = cfg.AwakerHead
    if tonumber(awaker) then
      local awakerCfg = DT.AwakerConfig[awaker]
      return awakerCfg.Name
    end
  end
  
  return views
end

local function createGuideModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local GuideModel = Vue.model("GuideModel", createGuideModelState):views(createGuideModelViews):actions(createGuideModelActions):setup(onSetup)
return GuideModel
