local MilestoneUtil = {}
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local ColorCache = {}

function MilestoneUtil.GetSPSColor4Stage(stage)
  if ColorCache[stage] == nil then
    local stageCfg = ConfigData.milestone_mile_color[stage]
    if stageCfg == nil then
      error("milestone_mile_color is nil, with stageId:" .. tostring(stage))
      return Color.red
    end
    local color = stageCfg.color
    ColorCache[stage] = Color.New(color[1] / 255, color[2] / 255, color[3] / 255, (color[4] or 255) / 255)
  end
  return ColorCache[stage]
end

local ClassColorCache = {}

function MilestoneUtil.GetSPClassSColor4Stage(stage)
  if ClassColorCache[stage] == nil then
    local stageCfg = ConfigData.milestone_mile_color[stage]
    if stageCfg == nil then
      error("milestone_mile_color is nil, with stageId:" .. tostring(stage))
      return Color.red
    end
    local color = stageCfg.class_color
    ClassColorCache[stage] = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  end
  return ClassColorCache[stage]
end

function MilestoneUtil.GetMlstTaskType(moduleId, typeId)
  local taskType = TaskEnum.eTaskType.MilestoneTask + moduleId * 10 + typeId
  return taskType
end

function MilestoneUtil.GetSPSStageId2EngChar(stage)
  local stageCfg = ConfigData.milestone_mile_color[stage]
  if stageCfg == nil then
    error("milestone_mile_color is nil, with stageId:" .. tostring(stage))
    return "?"
  end
  return stageCfg.stage
end

function MilestoneUtil.GetMlstTaskScore(taskData, scoreItemId)
  local rewardIds, rewardNums = taskData:GetTaskCfgRewards()
  local score = 0
  for k, itemId in ipairs(rewardIds) do
    local itemNum = rewardNums[k]
    if itemId == scoreItemId then
      score = itemNum
      break
    end
  end
  if score == 0 then
    error("cant get Milestone task score, taskId:" .. tostring(taskData.id))
  end
  return score
end

local diffProcessFillAmountBefore = {
  [1] = 0,
  [2] = 0.1955,
  [3] = 0.391,
  [4] = 0.585,
  [5] = 0.781,
  [6] = 0.976
}
local diffProcessFillAmount = {
  [1] = 0.024,
  [2] = 0.2185,
  [3] = 0.414,
  [4] = 0.608,
  [5] = 0.804,
  [6] = 1
}

function MilestoneUtil.GetMilstoneFillRateWithProcessId(rate)
  if 1 <= rate then
    return 1
  end
  local processUnit = 1 / (MilestoneEnum.maxProcess - 1)
  local processNum = math.floor(rate * 10 / (processUnit * 10)) + 1
  processNum = math.clamp(processNum, 1, MilestoneEnum.maxProcess)
  local diff = diffProcessFillAmountBefore[processNum + 1] - diffProcessFillAmount[processNum]
  local fillRate = (rate - processUnit * (processNum - 1)) / processUnit * diff + diffProcessFillAmount[processNum]
  return fillRate
end

MilestoneUtil.desFuncDic = {
  [MilestoneEnum.eMilestoneInfoType.allBuildingLevel] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local totalLevel = userInfoData:GetBuildingTotalLevel()
    return "Lv." .. tostring(totalLevel)
  end,
  [MilestoneEnum.eMilestoneInfoType.levelProcess] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local epProgress = userInfoData:GetEpProgress()
    if epProgress.sectorId == nil or epProgress.stageIndex == nil then
      return "NO PASS"
    end
    return "STAGE " .. tostring(epProgress.sectorId) .. "-" .. tostring(epProgress.stageIndex)
  end,
  [MilestoneEnum.eMilestoneInfoType.blackhole] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local levelNum = userInfoData:GetDefaultTowerProgress()
    return string.format("%dC", levelNum)
  end,
  [MilestoneEnum.eMilestoneInfoType.endless] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    return tostring(userInfoData:GetInfinityLevelSum()) .. "m"
  end,
  [MilestoneEnum.eMilestoneInfoType.heroCollection] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local totalCount = ConfigData.hero_data.totalShowHeroCount
    local process = math.ceil(userInfoData:GetHasHeroNum() / (totalCount or 1) * 100)
    process = math.clamp(process, 0, 100)
    return tostring(process) .. "%"
  end,
  [MilestoneEnum.eMilestoneInfoType.furnitureCollection] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local count = userInfoData:GetFurnitureCollection()
    local totalCount = ConfigData.dorm_theme.hbFrunitureThemeCount
    local process = count / (totalCount or 1)
    process = math.clamp(process, 0, 1)
    return tostring(math.floor(process * 100)) .. "%"
  end,
  [MilestoneEnum.eMilestoneInfoType.skinCollection] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local count = userInfoData:GetSkinCollection()
    local totalCount = ConfigData.skin.hbSkinCount
    local process = count / (totalCount or 1)
    process = math.clamp(process, 0, 1)
    return tostring(math.floor(process * 100)) .. "%"
  end,
  [MilestoneEnum.eMilestoneInfoType.achievement] = function(msData)
    local userInfoData = msData:GetMSUserInfoData()
    local rate = userInfoData:GetAchievementAttachNum()
    return tostring(rate) .. "%"
  end
}
return MilestoneUtil
