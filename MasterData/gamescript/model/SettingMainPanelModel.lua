local SettingItemType = CommonDefine.SettingItemType
local SettingTab = CommonDefine.SettingTab
local VOICE_SLIDER_DEFAULT_VAL = 10
local settingToggleGroup = CommonDefine.SettingPanelTabSequence

local function GetRtpc(setUpUid)
  local rst
  if CommonDefine.rtpcSetName2WwiseNameMap[setUpUid] then
    rst = CommonDefine.rtpcSetName2WwiseNameMap[setUpUid]
  end
  return rst
end

local function createSettingMainPanelState()
  local state = {}
  state.settingItemTypeMap = {
    Switch = SettingItemType.BtnToggle,
    DropdownList = SettingItemType.BtnDrop,
    Slider = SettingItemType.SliderText,
    Entrance = SettingItemType.BtnSingle,
    Web = SettingItemType.BtnSingle,
    BundleShortcutKey = SettingItemType.BundleShortcutKey
  }
  state.settingTabLanguageMap = {
    [SettingTab.System] = DT.CommonID[SettingTab.System].Desc or "",
    [SettingTab.Image] = DT.CommonID[SettingTab.Image].Desc or "",
    [SettingTab.Language] = DT.CommonID[SettingTab.Language].Desc or "",
    [SettingTab.Key] = DT.CommonID[SettingTab.Key].Desc or "",
    [SettingTab.Voice] = DT.CommonID[SettingTab.Voice].Desc or "",
    [SettingTab.Account] = DT.CommonID[SettingTab.Account].Desc or ""
  }
  
  function state.toggleList()
    local rst = {}
    local publishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
    for _, tab in ipairs(settingToggleGroup) do
      if 0 == PlayerDataUtils.GetPlayerUid() and (tab == CommonDefine.SettingTab.System or tab == CommonDefine.SettingTab.Account) then
      elseif "JP" == publishRegion and tab == CommonDefine.SettingTab.Language then
      elseif state.allContentMap[tab] then
        table.insert(rst, tab)
      end
    end
    return rst
  end
  
  state.curSelectTab = SettingTab.System
  
  function state.allContentMap()
    local retList = {}
    local sortId = 1
    for _, config in ipairs(SetupDataUtils.GetSortedEnableCfgList()) do
      if not retList[config.SetupTab] then
        retList[config.SetupTab] = {}
      end
      local gourpName = "Empty"
      if config.SetupGroup then
        gourpName = config.SetupGroup
      end
      if not retList[config.SetupTab][gourpName] then
        retList[config.SetupTab][gourpName] = {
          sortId = sortId,
          key = config.SetupGroup,
          contents = {}
        }
        sortId = sortId + 1
      end
      local itemType = SettingItemType.SliderNoText
      if config.ComponenType then
        itemType = state.settingItemTypeMap[config.ComponenType]
      end
      if config.UniqueName == CommonDefine.SettingUniqueName.Outline then
      elseif config.UniqueName == CommonDefine.SettingUniqueName.UseSoftMask then
      else
        local settingContentItemData = {
          itemType = itemType,
          tipsText = config.SetupDesc or "",
          titleText = config.SetupTitle or "",
          setupTab = config.SetupTab,
          range = config.Range,
          setUpUid = config.UniqueName,
          tid = config.ID
        }
        table.insert(retList[config.SetupTab][gourpName].contents, settingContentItemData)
      end
    end
    return retList
  end
  
  return state
end

local function createSettingMainPanelViews(model)
  local views = {}
  
  function views:MergeKeyList(keyList)
    local newList = {}
    local skipIndex = 0
    local TYPE_SHORTCUT_KEY = SettingItemType.BundleShortcutKey
    for i = 1, #keyList do
      if i <= skipIndex then
      else
        local config = keyList[i]
        local nextConfig = keyList[i + 1] or {}
        if config.itemType == TYPE_SHORTCUT_KEY and nextConfig.itemType == TYPE_SHORTCUT_KEY then
          table.insert(newList, config)
          config.secondItem = keyList[i + 1]
          skipIndex = i + 1
        else
          table.insert(newList, config)
        end
      end
    end
    return newList
  end
  
  function views:HandelContentList(tabType, curContentGroupMap)
    local retList = {}
    local curContentGroupSequence = {}
    for key, contentGroup in pairs(curContentGroupMap or {}) do
      table.insert(curContentGroupSequence, contentGroup)
    end
    table.sort(curContentGroupSequence, function(a, b)
      return a.sortId < b.sortId
    end)
    local sortedContentList = {}
    for idx, contentGroup in ipairs(curContentGroupSequence) do
      if not sortedContentList[idx] then
        sortedContentList[idx] = {}
      end
      if contentGroup.key ~= "Empty" then
        local settingSpaceItemData = {
          itemType = SettingItemType.Space
        }
        table.insert(sortedContentList[idx], settingSpaceItemData)
        local settingContentItemData = {
          itemType = SettingItemType.Title,
          tipsText = "",
          titleText = DT.CommonID[contentGroup.key].Desc or ""
        }
        table.insert(sortedContentList[idx], settingContentItemData)
      end
      for _, data in pairs(contentGroup.contents) do
        if "table" == type(data) then
          data.rtpc = GetRtpc(data.setUpUid)
          if data.itemType == SettingItemType.BtnToggle then
            data.toggleState = "Open"
          end
          if data.itemType == SettingItemType.SliderText then
            data.sliderVal = VOICE_SLIDER_DEFAULT_VAL
          end
          table.insert(sortedContentList[idx], data)
        end
      end
    end
    for _, data in pairs(sortedContentList) do
      for _, val in pairs(data) do
        table.insert(retList, val)
      end
    end
    if retList[2].itemType == SettingItemType.Title then
      table.remove(retList, 1)
    end
    if tabType == cd.SettingTab.Key then
      retList = self:MergeKeyList(retList)
    end
    return retList
  end
  
  function views:GetContentList(tabType)
    local curContentGroupMap = model.allContentMap[tabType]
    do return self.HandelContentList, self, tabType end
    return self.HandelContentList, self, tabType, curContentGroupMap
  end
  
  return views
end

local function createSettingMainPanelActions(data)
  local actions = {}
  
  function actions.SetCurSelectTab(val)
    if nil == val then
      Logger.Info("Error Parameter: nil")
    end
    data.curSelectTab = val
  end
  
  function actions.SetSortedSetConfig(val)
    if nil == val then
      Logger.Info("Error Parameter: nil")
    end
    data.sortedSetConfig = val
  end
  
  return actions
end

local function onSetup(_, _)
end

local SettingMainPanelModel = Vue.model("SettingMainPanelModel", createSettingMainPanelState):views(createSettingMainPanelViews):actions(createSettingMainPanelActions):setup(onSetup)
return SettingMainPanelModel
