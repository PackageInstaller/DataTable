local function createSettingContentItemState(data)
  local state = {}
  
  state.data = data
  state.tid = data.tid
  state.itemType = data.itemType
  state.setupTab = data.setupTab
  state.titleText = data.titleText
  state.tipsText = data.tipsText
  state.range = data.range
  state.setUpUid = data.setUpUid
  state.rtpc = data.rtpc
  state.sliderVal = nil
  state.toggleState = data.toggleState
  
  function state.dropList()
    local retList = {}
    if not state.range then
      return retList
    end
    local range = state.range
    while string.find(range, ",") do
      local tailIdx = string.find(range, ",")
      local subStr = string.sub(range, 1, tailIdx - 1)
      range = string.sub(range, tailIdx + 1, #range)
      table.insert(retList, subStr)
    end
    table.insert(retList, range)
    return retList
  end
  
  state.curDropData = nil
  return state
end

local function createSettingContentItemViews(data)
  local views = {}
  
  function views:GetSettingCfg()
    if data.tid and DT.Setup[data.tid] then
      return DT.Setup[data.tid]
    end
    return {}
  end
  
  return views
end

local function createSettingContentItemActions(data)
  local actions = {}
  
  function actions:SetSliderVal(val)
    if not val then
      Logger.Debug("Error Parameter")
    end
    data.sliderVal = val
  end
  
  function actions:SetToggleState(val)
    if not val then
      Logger.Debug("Error Parameter")
    end
    data.toggleState = val
  end
  
  function actions:SetCurDropData(val)
    if not val then
      Logger.Debug("Error Parameter")
    end
    data.curDropData = val
  end
  
  function actions:RefreshData()
    if data.rtpc then
      local sliderInitVal = 10
      local cacheData = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. data.rtpc .. "_val")
      if cacheData then
        sliderInitVal = tonumber(cacheData)
      else
        sliderInitVal = 10
      end
      data:SetSliderVal(sliderInitVal)
    elseif data.sliderVal then
      local sliderInitVal = SettingManager.Instance:GetSettingData(data.setUpUid) or 10
      data:SetSliderVal(sliderInitVal)
    end
    if data.toggleState then
      if data.setUpUid == CommonDefine.SettingUniqueName.BattleSpeed then
        local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
        local stateData = 1 == gameSpeed and "Close" or "Open"
        data:SetToggleState(stateData)
      else
        local settingVal = SettingManager.Instance:GetSettingData(data.setUpUid)
        local isOpen = 1 == settingVal or "Open" == settingVal
        settingVal = isOpen and "Open" or "Close"
        data:SetToggleState(settingVal)
      end
    end
    if 0 ~= #data.dropList then
      local dropValue = SettingManager.Instance:GetSettingData(data.setUpUid)
      if data.setUpUid == cd.SettingUniqueName.LanguageWord then
        dropValue = SettingManager.Instance:GetTextLanguage()
      end
      if dropValue then
        if data.setUpUid == cd.SettingUniqueName.LanguageWord then
          dropValue = SettingManager.Instance:GetLangNameByLangCode(dropValue)
        elseif DT.CommonID[dropValue] then
          dropValue = DT.CommonID[dropValue].Desc
        end
        data:SetCurDropData(dropValue)
      end
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  model:RefreshData()
end

local SettingContentItemModel = Vue.model("SettingContentItemModel", createSettingContentItemState):views(createSettingContentItemViews):actions(createSettingContentItemActions):setup(onSetup)
return SettingContentItemModel
