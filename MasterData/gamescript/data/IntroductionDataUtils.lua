local IntroductionDataUtils = {}

function IntroductionDataUtils.ResetAll()
end

function IntroductionDataUtils.InitIntroData(serverIntroData)
  DataCenter.introductionData.introData = serverIntroData
end

function IntroductionDataUtils.Init()
  local stepCfg = DT.GetOriginalConstant("PrologueBeginPlot")
  local steps = {}
  local maxStep = 0
  for i = 1, #stepCfg, 2 do
    local key = stepCfg[i]
    local val = stepCfg[i + 1]
    table.insert(steps, {id = key, stepType = val})
    maxStep = maxStep + 1
  end
  DataCenter.introductionData.steps = steps
  DataCenter.introductionData.maxStep = maxStep
end

function IntroductionDataUtils.IsFirstBattle(_step)
  if not _step then
    _step = DataCenter.introductionData.introData.step
    _step = DataCenter.introductionData.introData.step
  end
  local stepInfo = DataCenter.introductionData.steps[_step]
  if stepInfo then
    return stepInfo.stepType == "Constant"
  else
    return false
  end
end

function IntroductionDataUtils.IsFinish(_step)
  _step = _step or IntroductionDataUtils.GetStep()
  if _step then
    return _step > DataCenter.introductionData.maxStep
  else
    return true
  end
end

function IntroductionDataUtils.IsFinishSetNameStep()
  local step = IntroductionDataUtils.GetStep()
  local setNameStep
  for i = 1, #DataCenter.introductionData.steps do
    local stepData = DataCenter.introductionData.steps[i]
    if stepData and stepData.stepType == "Name" then
      setNameStep = i
    end
  end
  return step and step > setNameStep
end

function IntroductionDataUtils.GetStep()
  local data = DataCenter.introductionData.introData
  if data then
    return data.step
  else
    return 0
  end
end

function IntroductionDataUtils.SetStep(step)
  local data = DataCenter.introductionData.introData
  if data then
    data.step = step
  else
    Logger.Error("SetStep Error")
  end
end

function IntroductionDataUtils.GetStepData(_step)
  _step = _step or IntroductionDataUtils.GetStep()
  local stepInfo = DataCenter.introductionData.steps[_step]
  return stepInfo
end

function IntroductionDataUtils.GetStageGroupId()
  if DataCenter.introductionData.groupTid then
    return DataCenter.introductionData.groupTid
  end
  local steps = DataCenter.introductionData.steps
  for k, v in pairs(steps) do
    if v.stepType == "StageGroup" then
      DataCenter.introductionData.groupTid = v.id
      return v.id
    end
  end
end

function IntroductionDataUtils.ShowPV(callback)
  local guideVideoName = DT.GetConstant("PrologueVideoFileName")
  local key = "PrologueVideoFileName"
  local lastVideoName = MobileFileDataManager.Instance:GetCommFileValue(key)
  if lastVideoName and lastVideoName == guideVideoName then
    if callback then
      callback()
    end
    return
  end
  local url = StrUtils.GetVideoUrl(guideVideoName)
  print("--------return url", url)
  
  local function OnVideoEnd()
    MobileFileDataManager.Instance:SetCommFileValue(key, guideVideoName)
    MobileFileDataManager.Instance:OnSaveCommInfo()
    if callback then
      callback()
    end
  end
  
  UIManager.Instance:Reopen(Urls.CommonVideoPanel, url, OnVideoEnd)
end

return IntroductionDataUtils
