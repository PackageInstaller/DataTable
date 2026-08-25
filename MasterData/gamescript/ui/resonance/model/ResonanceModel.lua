local function createResonanceModelState(resonanceGroupId)
  local state = {
    selectResonanceID = 0,
    
    resonancesDetailFailedTipsShow = false,
    resonancesDetailFailedTips = nil,
    resonancesDetailSuccessTipsShow = false,
    resonancesDetailSuccessTips = nil
  }
  
  function state.resonancesList()
    do return ResonanceDataUtils.GetResonanceConfigByGroupId end
    return ResonanceDataUtils.GetResonanceConfigByGroupId, resonanceGroupId
  end
  
  function state.resonanceGroupId()
    return resonanceGroupId
  end
  
  function state.resonanceLevelsConfig()
    local resonanceConfig = DT.Resonance[state.selectResonanceID]
    if not resonanceConfig then
      return
    end
    return resonanceConfig.data_list
  end
  
  return state
end

local function createResonanceModelViews(data)
  local views = {}
  
  function views:GetResonancesList()
    return data.resonancesList
  end
  
  function views:GetSelectResonanceID()
    return data.selectResonanceID
  end
  
  function views:GetResonanceGroupId()
    return data.resonanceGroupId
  end
  
  function views:GetResonanceUnlockIcon(tId)
    local resonanceConfig = DT.Resonance[tId]
    if not resonanceConfig then
      return
    end
    local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tId))
    return resonanceConfig.data_list[lv].UnlockIcon
  end
  
  function views:GetResonanceUnactionIcon(tId)
    local resonanceConfig = DT.Resonance[tId]
    if not resonanceConfig then
      return
    end
    local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tId))
    return resonanceConfig.data_list[lv].UnactIcon
  end
  
  function views:GetResonanceIcon(tId)
    local resonanceConfig = DT.Resonance[tId]
    if not resonanceConfig then
      return
    end
    local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tId))
    return resonanceConfig.data_list[lv].Icon
  end
  
  function views:GetResonanceType(tId)
    local resonanceConfig = DT.Resonance[tId]
    if not resonanceConfig then
      return
    end
    local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tId))
    return resonanceConfig.data_list[lv].Type
  end
  
  function views:GetResonanceLevelProgress(tId)
    local currLv = ResonanceDataUtils.GetResonanceLevel(tId)
    local maxLevel = ResonanceDataUtils.GetResonanceMaxLevel(tId)
    return currLv .. "/" .. maxLevel
  end
  
  function views:GetResonanceLevelDesc(_, level)
    local levelConfigs = data.resonanceLevelsConfig
    local lvCfg = levelConfigs and levelConfigs[level]
    if not lvCfg then
      return ""
    end
    do return string.format, "Lv.%d   %s", level, LT.Text(lvCfg.Desc) end
    return string.format, "Lv.%d   %s", level, LT.Text(lvCfg.Desc)
  end
  
  function views:GetResonanceLevelDescColor(tId, level)
    local currLv = ResonanceDataUtils.GetResonanceLevel(tId)
    if level < currLv then
      return DT.ColorConfig.TalentNumWhite.Light
    end
    if level == currLv then
      return DT.ColorConfig.TalentNumBlue.Light
    end
    if level > currLv then
      return DT.ColorConfig.ResonanceGray.Light
    end
  end
  
  function views:GetResonanceName(tId)
    do return ResonanceDataUtils.GetResonanceName end
    return ResonanceDataUtils.GetResonanceName, tId
  end
  
  function views:CheckResonanceMaxLevel(tId)
    do return ResonanceDataUtils.IsResonanceArriveMaxLevel end
    return ResonanceDataUtils.IsResonanceArriveMaxLevel, tId
  end
  
  function views:CheckResonanceUpgradeButtonState(tId)
    local resonance = ResonanceDataUtils.GetResonance(tId)
    if resonance.isDefaultActiveResonace and self:CheckResonanceMaxLevel(tId) then
      return CommonDefine.BtnType.Unclickable
    end
    if not ResonanceDataUtils.IsResonanceUnLocked(tId) then
      return CommonDefine.BtnType.High
    end
    if self:CheckResonanceMaxLevel(tId) then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end
  
  function views:GetResonanceUpgradeButtonStateText(tId)
    local resonance = ResonanceDataUtils.GetResonance(tId)
    if resonance.isDefaultActiveResonace and self:CheckResonanceMaxLevel(tId) then
      return "<color=#ffffff>" .. LT.Text("ResonanceActiveDefault") .. "</color>"
    end
    if not ResonanceDataUtils.IsResonanceUnLocked(tId) then
      return "<color=#ffffff>" .. LT.Text("ResonanceUnlockText") .. "</color>"
    end
    if self:CheckResonanceMaxLevel(tId) then
      return "<color=#ffffff>" .. LT.Text("ResonanceArriveMaxLevelText") .. "</color>"
    end
    if 0 == ResonanceDataUtils.GetResonanceLevel(tId) then
      do return LT.Text end
      return LT.Text, "ResonanceActiveText", "</color>"
    end
    do return LT.Text end
    return LT.Text, "ResonanceUpgradeText", "</color>"
  end
  
  function views:CheckResonanceUpgradeMaterialEnough(tId)
    do return ResonanceDataUtils.IsResonanceUpgradeMaterialEnough end
    return ResonanceDataUtils.IsResonanceUpgradeMaterialEnough, tId
  end
  
  function views:GetResonanceGroupTotalLevel(resonanceGroupId)
    do return ResonanceDataUtils.GetResonanceGroupTotalLevel end
    return ResonanceDataUtils.GetResonanceGroupTotalLevel, resonanceGroupId
  end
  
  function views:GetResonanceStory(tId)
    local levelConfigs = data.resonanceLevelsConfig
    local lvCfg = levelConfigs and levelConfigs[1]
    if not lvCfg then
      return ""
    end
    do return LT.Text end
    return LT.Text, lvCfg.Story
  end
  
  return views
end

local function createResonanceModelActions(data)
  local actions = {}
  
  function actions:SetSelectResonanceID(selectResonanceID)
    data.selectResonanceID = selectResonanceID
  end
  
  return actions
end

local function onSetup(_, _)
end

local ResonanceModel = Vue.model("ResonanceModel", createResonanceModelState):views(createResonanceModelViews):actions(createResonanceModelActions):setup(onSetup)
return ResonanceModel
