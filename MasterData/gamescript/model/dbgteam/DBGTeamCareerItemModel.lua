local function createDBGTeamCareerItemModel(schoolId, enable)
  local state = {}
  
  state.schoolId = schoolId
  state.enable = enable
  state.config = DT.SchoolConfig[state.schoolId]
  return state
end

local function createDBGTeamCareerItemModelViews(data)
  local views = {}
  
  function views:GetSchoolContentDetail(isPvp)
    local schoolCfg = DT.SchoolConfig[data.schoolId]
    if isPvp then
      local pvpTips = AwakerDataUtils.ResolveSchoolCondText(schoolCfg.PVPSchoolBattleTips)
      if pvpTips then
        do return LT.Text end
        return LT.Text, pvpTips, nil
      end
      do return LT.Text end
      return LT.Text, schoolCfg.PVPSchoolBattleTips, nil
    end
    local tips = AwakerDataUtils.GetSchoolTipsByField(data.schoolId, "Tips")
    if tips then
      return tips
    end
    do return AwakerDataUtils.ParseSchoolDescByArgs, (LT.Text(schoolCfg.Tips)) end
    return AwakerDataUtils.ParseSchoolDescByArgs, LT.Text(schoolCfg.Tips), schoolCfg.StatePara
  end
  
  function views:GetSchoolContent()
    local schoolCfg = DT.SchoolConfig[data.schoolId]
    do return LT.Text end
    return LT.Text, schoolCfg.SchoolTips
  end
  
  function views:GetSchoolTitle()
    do return LT.Text end
    return LT.Text, DT.SchoolConfig[data.schoolId].SchoolTipsName, data.schoolId
  end
  
  return views
end

local function createDBGTeamCareerItemModelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local DBGTeamCareerItemModel = Vue.model("DBGTeamCareerItemModel", createDBGTeamCareerItemModel):views(createDBGTeamCareerItemModelViews):actions(createDBGTeamCareerItemModelActions):setup(onSetup)
return DBGTeamCareerItemModel
