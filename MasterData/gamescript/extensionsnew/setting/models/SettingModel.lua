local SettingItemType = CommonDefine.SettingItemType
local SettingTab = CommonDefine.SettingTab
local VOICE_SLIDER_DEFAULT_VAL = 10
local settingToggleGroup = CommonDefine.SettingPanelTabSequence

local function GetRtpc(setUpUid)
  if CommonDefine.rtpcSetName2WwiseNameMap[setUpUid] then
    return CommonDefine.rtpcSetName2WwiseNameMap[setUpUid]
  end
  return nil
end

local settingItemTypeMap = {
  Switch = SettingItemType.BtnToggle,
  DropdownList = SettingItemType.BtnDrop,
  Slider = SettingItemType.SliderText,
  Entrance = SettingItemType.BtnSingle,
  Web = SettingItemType.BtnSingle,
  BundleShortcutKey = SettingItemType.BundleShortcutKey
}
local SettingModel = NewClass("SettingModel", BaseModel)

function SettingModel:OnInit()
  self:OnReset()
end

function SettingModel:OnReset()
  self._curSelectTab = SettingTab.System
end

function SettingModel:GetCurSelectTab()
  return self._curSelectTab
end

function SettingModel:SetCurSelectTab(val)
  if nil == val then
    Logger.Info("SettingModel.SetCurSelectTab Error Parameter: nil")
    return
  end
  self._curSelectTab = val
end

function SettingModel:GetAllContentMap()
  local retList = {}
  local sortId = 1
  for _, config in ipairs(SetupDataUtils.GetSortedEnableCfgList()) do
    if not retList[config.SetupTab] then
      retList[config.SetupTab] = {}
    end
    local groupName = "Empty"
    if config.SetupGroup then
      groupName = config.SetupGroup
    end
    if not retList[config.SetupTab][groupName] then
      retList[config.SetupTab][groupName] = {
        sortId = sortId,
        key = config.SetupGroup,
        contents = {}
      }
      sortId = sortId + 1
    end
    local itemType = SettingItemType.SliderNoText
    if config.ComponenType then
      itemType = settingItemTypeMap[config.ComponenType]
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
      table.insert(retList[config.SetupTab][groupName].contents, settingContentItemData)
    end
  end
  return retList
end

function SettingModel:GetToggleList()
  local rst = {}
  local allContentMap = self:GetAllContentMap()
  local publishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
  for _, tab in ipairs(settingToggleGroup) do
    if 0 == PlayerDataUtils.GetPlayerUid() and (tab == CommonDefine.SettingTab.System or tab == CommonDefine.SettingTab.Account) then
    elseif "JP" == publishRegion and tab == CommonDefine.SettingTab.Language then
    elseif allContentMap[tab] then
      table.insert(rst, tab)
    end
  end
  return rst
end

function SettingModel:MergeKeyList(keyList)
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

function SettingModel:HandelContentList(tabType, curContentGroupMap)
  local retList = {}
  local curContentGroupSequence = {}
  for _, contentGroup in pairs(curContentGroupMap or {}) do
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
      local settingTitleItemData = {
        itemType = SettingItemType.Title,
        tipsText = "",
        titleText = DT.CommonID[contentGroup.key].Desc or ""
      }
      table.insert(sortedContentList[idx], settingTitleItemData)
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
  if retList[2] and retList[2].itemType == SettingItemType.Title then
    table.remove(retList, 1)
  end
  if tabType == SettingTab.Key then
    retList = self:MergeKeyList(retList)
  end
  return retList
end

function SettingModel:GetContentList(tabType)
  local curContentGroupMap = self:GetAllContentMap()[tabType]
  do return self.HandelContentList, self, tabType end
  return self.HandelContentList, self, tabType, curContentGroupMap
end

function SettingModel:GetSettingCfg(tid)
  if tid and DT.Setup[tid] then
    return DT.Setup[tid]
  end
  return {}
end

function SettingModel:GetDropList(range)
  local retList = {}
  if not range then
    return retList
  end
  while string.find(range, ",") do
    local tailIdx = string.find(range, ",")
    local subStr = string.sub(range, 1, tailIdx - 1)
    range = string.sub(range, tailIdx + 1, #range)
    table.insert(retList, subStr)
  end
  table.insert(retList, range)
  return retList
end

function SettingModel:GetSliderInitVal(data)
  if data.rtpc then
    local cacheData = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. data.rtpc .. "_val")
    if cacheData then
      do return tonumber end
      return tonumber, cacheData, data.rtpc, "_val"
    end
    return 10
  end
  return SettingManager.Instance:GetSettingData(data.setUpUid) or 10
end

function SettingModel:GetToggleInitState(data)
  if data.setUpUid == CommonDefine.SettingUniqueName.BattleSpeed then
    local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
    return 1 == gameSpeed and "Close" or "Open"
  end
  local settingVal = SettingManager.Instance:GetSettingData(data.setUpUid)
  local isOpen = 1 == settingVal or "Open" == settingVal
  return isOpen and "Open" or "Close"
end

function SettingModel:GetDropInitData(data)
  local dropValue = SettingManager.Instance:GetSettingData(data.setUpUid)
  if data.setUpUid == cd.SettingUniqueName.LanguageWord then
    dropValue = SettingManager.Instance:GetTextLanguage()
  end
  if not dropValue and data.setUpUid == cd.SettingUniqueName.WindowResolution then
    dropValue = CS.UnityEngine.Screen.width .. "x" .. CS.UnityEngine.Screen.height
  end
  if not dropValue then
    local dropList = self:GetDropList(data.range)
    dropValue = dropList and dropList[1]
  end
  if not dropValue then
    return nil
  end
  if data.setUpUid == cd.SettingUniqueName.LanguageWord then
    do return SettingManager.Instance.GetLangNameByLangCode, SettingManager.Instance end
    return SettingManager.Instance.GetLangNameByLangCode, SettingManager.Instance, dropValue
  elseif DT.CommonID[dropValue] then
    return DT.CommonID[dropValue].Desc
  end
  return dropValue
end

function SettingModel:GetLoginRewardState(loginRewardType)
  local statsType = SettingDefine.LoginRewardType2StatsTypeDict[loginRewardType]
  if not statsType then
    return CommonDefine.CommonState.Running
  end
  local isReceived = PlayerDataUtils.GetBaseStatsData(statsType)
  local isPCPlatform = ApplicationUtils.IsWindowsOrEditor()
  local isCurLoginPlatform = loginRewardType == SettingDefine.LoginRewardType.PC and isPCPlatform or loginRewardType == SettingDefine.LoginRewardType.MOBILE and not isPCPlatform
  if isCurLoginPlatform then
    return isReceived and CommonDefine.CommonState.Finish or CommonDefine.CommonState.GainPrize
  else
    return isReceived and CommonDefine.CommonState.Finish or CommonDefine.CommonState.Running
  end
end

return SettingModel
