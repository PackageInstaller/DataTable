local base = require("Game.ActivityFrame.ActivityBase")
local ActivityDivergentData = class("ActivityDivergentData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Divergent
local ActivityDivergentEnum = require("Game.ActivityDivergent.Data.ActivityDivergentEnum")
local TaskEnum = require("Game.Task.TaskEnum")

function ActivityDivergentData:InitDivergentData(msg)
  local actId = msg.actId
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_divergent_main[actId]
  self._sectorHeroDic = {}
  for heroId, heroCfg in pairs(ConfigData.activity_divergent_hero) do
    self._sectorHeroDic[heroCfg.test_stage] = heroCfg
  end
  self._taskDatas = {}
  self._heroDataDic = {}
  self:UpdateDivergentData(msg)
end

function ActivityDivergentData:UpdateDivergentData(msg)
  self._actId = msg.actId
  self._curHeroId = msg.curHeroId
  for _, vHeroData in ipairs(msg.heroes) do
    self._heroDataDic[vHeroData.heroId] = vHeroData
  end
  self._questElem = msg.quest
  self:__UpdateDivergentTaskData(msg.quest)
  self:__RefreshDivergentRedTask()
  MsgCenter:Broadcast(eMsgEventId.ActivityDivergentChange)
end

function ActivityDivergentData:__UpdateDivergentTaskData(questElem)
  self._hasCompletedTask = false
  table.clearmap(self._taskDatas)
  self._taskDic = {}
  local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true)
  divergentCtrl:RemoveDivergentItemCheck()
  if questElem == nil then
    return
  end
  local taskIds = questElem.questIds
  for _, taskId in ipairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData ~= nil then
      table.insert(self._taskDatas, taskData)
      self._taskDic[taskId] = taskData
      for _, stepCfg in pairs(taskData.taskStepCfg) do
        if stepCfg.finish_condition[1] == 40 then
          local itemId = stepCfg.finish_condition[2]
          local itemCount = PlayerDataCenter:GetItemCount(itemId)
          divergentCtrl:AddDivergentItemCheck(itemId)
          taskData.schedule = itemCount
        end
      end
      if taskData:CheckComplete() then
        self._hasCompletedTask = true
      end
    end
  end
end

function ActivityDivergentData:ForceUpdateDivergentTaskData()
  self:__UpdateDivergentTaskData(self._questElem)
  self:__RefreshDivergentRedTask()
  MsgCenter:Broadcast(eMsgEventId.ActivityDivergentChange)
end

function ActivityDivergentData:__RefreshDivergentRedTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityDivergentEnum.EReddotType.TaskReward)
  local blockTaskRed = true
  for heroId, _ in pairs(self._heroDataDic) do
    if not self:GetDivergentHeroFragAllGet(heroId) then
      blockTaskRed = false
      break
    end
  end
  local flag = self._hasCompletedTask and not blockTaskRed
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityDivergentData:GetDivergentCurrentHeroId()
  return self._curHeroId
end

function ActivityDivergentData:GetIsSelectedDivergentHero()
  return self._curHeroId ~= 0
end

function ActivityDivergentData:GetDivergentHeroIds()
  return self._mainCfg.heroid_group
end

function ActivityDivergentData:GetDivergentDefaultHeroId()
  return self._mainCfg.heroid_group[1]
end

function ActivityDivergentData:GetDivergentHeroData(heroId)
  return self._heroDataDic[heroId]
end

function ActivityDivergentData:GetDivergentHeroSectorChecked(heroId)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetDivergentHeroSectorLooked(self:GetActId(), heroId)
end

function ActivityDivergentData:GetDivergentHeroFragAllGet(heroId)
  local heroData = self._heroDataDic[heroId]
  if heroData == nil then
    return false
  end
  local itemId, getLimit = self:GetDivergentHeroFragIdAndMaxNum(heroId)
  local heroFragDic = heroData.chipGet
  for _, fragGetNum in pairs(heroFragDic) do
    return fragGetNum >= getLimit
  end
  return false
end

function ActivityDivergentData:GetDivergentHeroFragIdAndMaxNum(heroId)
  for itemId, numLimit in pairs(self:GetDivergentHeroCfg(heroId).chip_num) do
    return itemId, numLimit
  end
  error("Cant get activity_divergent_hero.chip_num, heroId:" .. tostring(heroId))
  return 0, 0
end

function ActivityDivergentData:GetDivergentHeroFragCurNumAndMaxNum(heroId)
  local itemId, getLimit = self:GetDivergentHeroFragIdAndMaxNum(heroId)
  local curNum = 0
  local heroData = self._heroDataDic[heroId]
  if heroData ~= nil then
    curNum = heroData.chipGet[itemId] or 0
  end
  return curNum, getLimit
end

function ActivityDivergentData:GetDivergentHeroRewardLevelInStage(heroId, stageId)
  local rewardGroupCfgs = self:GetDivergentHeroRewardGroupCfg(heroId)
  local progressData = self:GetDivergentHeroData(heroId)
  local stepGoodDatas = rewardGroupCfgs[stageId]
  local stepGoodData = stepGoodDatas[#stepGoodDatas]
  local currentLevelGoodData = stepGoodData
  if stageId < progressData.rewardStage then
    return currentLevelGoodData
  end
  for _, levelGoodData in ipairs(stepGoodDatas) do
    if progressData.rewardExp < levelGoodData.reward_experience then
      currentLevelGoodData = levelGoodData
      break
    end
  end
  return currentLevelGoodData
end

function ActivityDivergentData:GetDivergentTaskProgress()
  return self._questElem
end

function ActivityDivergentData:GetDivergentTaskDatas()
  return self._taskDatas
end

function ActivityDivergentData:GetDivergentTokenId()
  return self._mainCfg.task_item
end

function ActivityDivergentData:GetDivergentHeroIdBySectorId(sectorId)
  local heroCfg = self._sectorHeroDic[sectorId]
  return heroCfg and heroCfg.hero_id or 0
end

function ActivityDivergentData:GetDivergentTaskById(taskId)
  return self._taskDic[taskId]
end

function ActivityDivergentData:GetDivergentMainCfg()
  return self._mainCfg
end

function ActivityDivergentData:GetDivergentUiCfg(heroId)
  return ConfigData.activity_divergent_ui_config[heroId]
end

function ActivityDivergentData:GetDivergentTaskGroupCfg(taskId)
  return ConfigData.activity_divergent_task_group[taskId]
end

function ActivityDivergentData:GetDivergentHeroCfg(heroId)
  return ConfigData.activity_divergent_hero[heroId]
end

function ActivityDivergentData:GetDivergentHeroRewardGroupCfg(heroId)
  return ConfigData.activity_divergent_reward_group[heroId]
end

function ActivityDivergentData:SetDivergentHeroSectorChecked(heroId)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:SetDivergentHeroSectorLooked(self:GetActId(), heroId)
end

return ActivityDivergentData
