local function Launch()
  _G.CLIENT = true
  
  print("lua launch start,", debug.traceback())
  dofile("start")
end

local HotUpdateVersionCheckResult = HotUpdate.HotUpdateVersionCheckResult
local UpdateResCallbackType = HotUpdate.UpdateResCallbackType
local versionCheckRes = HotUpdateLuaProxy.GetVersionCheckRes()
if versionCheckRes == HotUpdateVersionCheckResult.CloseHotUpdate then
  Launch()
  return
end
if HotUpdateLuaProxy.IsHotUpdateFinish() then
  print("没有普通资源更新,直接launch,", debug.traceback())
  Launch()
  return
end
local _, t_str_hot_update = dofile("str_hotupdate")
local HotUpdateStringTable = {}
for id, tb in pairs(t_str_hot_update) do
  HotUpdateStringTable[id] = tb
end
local TitleKey = "str_hotupdate_title"
local QuitKey = "str_hotupdate_quit"
local RetryKey = "str_hotupdate_retry"
local CheckUpdateKey = "str_hotupdate_check"
local UpdatePatchCompleteKey = "str_hotupdate_patch_complete"
local NetErrorKey = "str_hotupdate_net_err"
local progressInfoConfig = {
  {
    progress = 20,
    info = "str_hotupdate_progress_info_20"
  },
  {
    progress = 40,
    info = "str_hotupdate_progress_info_40"
  },
  {
    progress = 60,
    info = "str_hotupdate_progress_info_60"
  },
  {
    progress = 80,
    info = "str_hotupdate_progress_info_80"
  },
  {
    progress = 100,
    info = "str_hotupdate_progress_info_100"
  }
}
local launchRoot, updateInfoPanel, progressPanel, progressBar, percentLabel, launchLabel, downloadedSizeLabel, totalSizeLabel, progressInfoLabel, speedLabel, checkTipsLabel, leftBrackets, rightBrackets, SpliteBrackets, messageBoxPanel, leftButtonGo, leftButtonNameLabel, rightButtonGo, rightButtonNameLabel, mesTitleLabel, mesContentLabel, showTips, nLastUAReportProgress

local function InitUIComponent()
  launchRoot = UnityEngine.GameObject.Find("LaunchUI").transform
  updateInfoPanel = launchRoot:Find("UI").gameObject
  progressPanel = launchRoot:Find("UI/Progress").gameObject
  progressBar = launchRoot:Find("UI/Progress/Bar"):GetComponent("Image")
  percentLabel = launchRoot:Find("UI/txtProgress"):GetComponent("UILocalizationText")
  launchLabel = launchRoot:Find("UI/InfoPanel/txtLaunch"):GetComponent("UILocalizationText")
  downloadedSizeLabel = launchRoot:Find("UI/InfoPanel/DownloadSize"):GetComponent("UILocalizationText")
  totalSizeLabel = launchRoot:Find("UI/InfoPanel/TotalSize"):GetComponent("UILocalizationText")
  checkTipsLabel = launchRoot:Find("UI/CheckTips"):GetComponent("UILocalizationText")
  speedLabel = launchRoot:Find("UI/InfoPanel/Speed"):GetComponent("UILocalizationText")
  leftBrackets = launchRoot:Find("UI/InfoPanel/LeftBrackets").gameObject
  rightBrackets = launchRoot:Find("UI/InfoPanel/RightBrackets").gameObject
  SpliteBrackets = launchRoot:Find("UI/InfoPanel/Splite").gameObject
  messageBoxPanel = launchRoot:Find("MessageBox").gameObject
  mesTitleLabel = launchRoot:Find("MessageBox/Title"):GetComponent("UILocalizationText")
  mesContentLabel = launchRoot:Find("MessageBox/Content"):GetComponent("UILocalizationText")
  leftButtonGo = launchRoot:Find("MessageBox/ButtonGroup/LeftButton").gameObject
  rightButtonGo = launchRoot:Find("MessageBox/ButtonGroup/RightButton").gameObject
  leftButtonNameLabel = launchRoot:Find("MessageBox/ButtonGroup/LeftButton/ButtonName"):GetComponent("UILocalizationText")
  rightButtonNameLabel = launchRoot:Find("MessageBox/ButtonGroup/RightButton/ButtonName"):GetComponent("UILocalizationText")
  nLastUAReportProgress = nil
end

local function ClearUIRef()
  launchRoot = nil
  updateInfoPanel = nil
  progressPanel = nil
  progressBar = nil
  percentLabel = nil
  launchLabel = nil
  downloadedSizeLabel = nil
  totalSizeLabel = nil
  speedLabel = nil
  checkTipsLabel = nil
  leftBrackets = nil
  rightBrackets = nil
  SpliteBrackets = nil
  messageBoxPanel = nil
  leftButtonGo = nil
  leftButtonNameLabel = nil
  rightButtonGo = nil
  rightButtonNameLabel = nil
  mesTitleLabel = nil
  mesContentLabel = nil
  nLastUAReportProgress = nil
end

local function SetProgressInfoVisible(visible)
  downloadedSizeLabel.gameObject:SetActive(visible)
  totalSizeLabel.gameObject:SetActive(visible)
  leftBrackets:SetActive(visible)
  rightBrackets:SetActive(visible)
  SpliteBrackets:SetActive(visible)
end

local function _ReportCustomEvent(strEventName, strCustomEventName, paramsList, extraJson)
  local l_paramList = UAReportHelper.GetParamsList()
  l_paramList:Clear()
  if paramsList ~= nil then
    for index, value in ipairs(paramsList) do
      l_paramList:Add(value)
    end
  end
  UAReportHelper.ReportCustomEvent(strEventName, strCustomEventName, l_paramList, extraJson or "")
end

local function _UAReportEvent(uaEventName, paramsDic, extraJson, isRealTime)
  if isRealTime == nil then
    isRealTime = true
  end
  local l_paramDic = UAReportHelper.GetParamsDic()
  l_paramDic:Clear()
  if paramsDic ~= nil then
    for key, value in pairs(paramsDic) do
      l_paramDic:Add(key, value)
    end
  end
  UAReportHelper.UAReportEvent(uaEventName, l_paramDic, extraJson or "", isRealTime)
end

local function UpdateUIProgress(value, downloadSize, totalSize, progressInfo)
  if showTips then
    checkTipsLabel.gameObject:SetActive(false)
    progressPanel:SetActive(true)
    SetProgressInfoVisible(true)
    showTips = false
  end
  progressBar.fillAmount = value
  local l_strProgress = math.floor(value * 100) .. "%"
  percentLabel.text = l_strProgress
  downloadedSizeLabel.text = downloadSize
  totalSizeLabel.text = totalSize
  launchLabel.text = progressInfo
  local l_nCurProgress = math.floor(value * 10)
  if l_nCurProgress ~= nLastUAReportProgress then
    nLastUAReportProgress = l_nCurProgress
    _ReportCustomEvent("HotUpdate", "HotUpdateProgress", {Progress = l_strProgress})
  end
end

local function ShowCheckUpdateUI(info)
  showTips = true
  updateInfoPanel:SetActive(true)
  SetProgressInfoVisible(false)
  progressPanel:SetActive(false)
  checkTipsLabel.gameObject:SetActive(true)
  checkTipsLabel.text = info
  launchLabel.text = ""
  speedLabel.text = ""
end

local function ShowMessageBox(titleInfo, contentInfo, leftButtonCallback, leftButtonName, rightButtonCallback, rightButtonName)
  messageBoxPanel:SetActive(true)
  mesTitleLabel.text = titleInfo
  mesContentLabel.text = contentInfo
  if leftButtonCallback then
    leftButtonGo:SetActive(true)
    leftButtonNameLabel.text = leftButtonName
    UIEventTriggerListener.Get(leftButtonGo).onClick = function()
      leftButtonCallback()
      messageBoxPanel:SetActive(false)
    end
  else
    leftButtonGo:SetActive(false)
  end
  if rightButtonCallback then
    rightButtonGo:SetActive(true)
    rightButtonNameLabel.text = rightButtonName
    UIEventTriggerListener.Get(rightButtonGo).onClick = function()
      rightButtonCallback()
      messageBoxPanel:SetActive(false)
    end
  else
    rightButtonGo:SetActive(false)
  end
end

local function GetProgressInfo(progress)
  if #progressInfoConfig < 0 then
    return ""
  end
  local index = #progressInfoConfig
  for i = 1, #progressInfoConfig do
    local info = progressInfoConfig[i]
    if progress * 100 < info.progress then
      if i == 1 then
        index = 1
        break
      end
      index = i - 1
      break
    end
  end
  return HotUpdateStringTable[progressInfoConfig[index].info]
end

InitUIComponent()
ShowCheckUpdateUI(HotUpdateStringTable[CheckUpdateKey])
if versionCheckRes == HotUpdateVersionCheckResult.UpdatePatch then
  ShowMessageBox(HotUpdateStringTable[TitleKey], HotUpdateStringTable[UpdatePatchCompleteKey], function()
    UnityEngine.Application.Quit()
  end, HotUpdateStringTable[QuitKey])
elseif versionCheckRes == HotUpdateVersionCheckResult.UpdateRes then
  local hotUpdateType = false
  
  local function OnHotUpdateCallback(type, ...)
    hotUpdateType = type
    print("OnHotUpdateCallback ", tostring(type))
    if type == UpdateResCallbackType.Finish then
      local totalSize = HotUpdateLuaProxy.GetTotalSize()
      local progress = HotUpdateLuaProxy.GetProgress()
      local downloadSize = HotUpdateLuaProxy.GetDownloadedSize()
      UpdateUIProgress(progress, downloadSize, totalSize, GetProgressInfo(progress))
      ClearUIRef()
      Launch()
    elseif type == UpdateResCallbackType.Downloading then
      launchLabel.text = GetProgressInfo(HotUpdateLuaProxy.GetProgress())
      if checkTipsLabel then
        checkTipsLabel.gameObject:SetActive(false)
      end
    end
  end
  
  AppLuaProxy.OnUpdate(function(e, unscaled, curTimeMS)
    if hotUpdateType == UpdateResCallbackType.Downloading then
      local totalSize = HotUpdateLuaProxy.GetTotalSize()
      local progress = HotUpdateLuaProxy.GetProgress()
      local downloadSize = HotUpdateLuaProxy.GetDownloadedSize()
      UpdateUIProgress(progress, downloadSize, totalSize, GetProgressInfo(progress))
    end
  end)
  HotUpdateLuaProxy.AddListener(OnHotUpdateCallback)
end
